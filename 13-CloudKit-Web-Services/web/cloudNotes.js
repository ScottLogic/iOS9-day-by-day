window.addEventListener('cloudkitloaded', function() {
	CloudKit.configure({
		containers: [{
			containerIdentifier: 'iCloud.com.shinobicontrols.CloudNotes',
			apiToken: 'REPLACE_WITH_YOUR_API_KEY',
			environment: 'development'
		}]
	});

	function CloudNotesViewModel() {
		var self = this;
		var container = CloudKit.getDefaultContainer();
		var publicDB = container.publicCloudDatabase;

		self.notes = ko.observableArray();
		self.displayUserName = ko.observable('Unauthenticated User');

		self.newNoteVisible = ko.observable(false);
		self.newNoteTitle = ko.observable('');
		self.newNoteContent = ko.observable('');

		self.saveButtonEnabled = ko.observable(true);

		self.saveNewNote = function() {

			if (self.newNoteTitle().length > 0 && self.newNoteContent().length > 0) {
				self.saveButtonEnabled(false);

				var record = {
					recordType: "CloudNote",
					fields: {
						title: {
							value: self.newNoteTitle()
						},
						content: {
							value: self.newNoteContent()
						}
					}
				};

				publicDB.saveRecord(record).then(
					function(response) {
						if (response.hasErrors) {
							console.error(response.errors[0]);
							self.saveButtonEnabled(true);
							return;
						}
						var createdRecord = response.records[0];
						self.notes.push(createdRecord);

						self.newNoteTitle("");
						self.newNoteContent("");
						self.saveButtonEnabled(true);
					}
				);

			}
			else {
				alert('Note must have a title and some content');
			}
		};

		self.fetchRecords = function() {
			var query = { recordType: 'CloudNote' };

			// Execute the query.
			return publicDB.performQuery(query).then(function (response) {
				if(response.hasErrors) {
					console.error(response.errors[0]);
					return;
				}
				var records = response.records;
				var numberOfRecords = records.length;
				if (numberOfRecords === 0) {
					console.error('No matching items');
					return;
				}

				self.notes(records);
			});
		};

		self.gotoAuthenticatedState = function(userInfo) {
			if(userInfo.isDiscoverable) {
				self.displayUserName(userInfo.firstName + ' ' + userInfo.lastName);
			} else {
				self.displayUserName('User record name: ' + userInfo.userRecordName);
			}
			self.newNoteVisible(true);

			container
			.whenUserSignsOut()
			.then(self.gotoUnauthenticatedState);
		};

		self.gotoUnauthenticatedState = function(error) {
			if(error && error.ckErrorCode === 'AUTH_PERSIST_ERROR') {
				console.log(error);
			}
			self.newNoteVisible(false);

			self.displayUserName('Unauthenticated User');

			container
			.whenUserSignsIn()
			.then(self.gotoAuthenticatedState)
			.catch(self.gotoUnauthenticatedState);
		};

		container.setUpAuth().then(function(userInfo) {
			// Either a sign-in or a sign-out button will be added to the DOM here.
			if(userInfo) {
				self.gotoAuthenticatedState(userInfo);
			} else {
				self.gotoUnauthenticatedState();
			}
			self.fetchRecords();  // Records are public so we can fetch them regardless.
		});

	}

	ko.applyBindings(new CloudNotesViewModel());

});
