Backend Setup: 
To run the backend code, Java version 17 is required. The main method is located in backend/bookmark/src/main/java/com/browser/bookmark folder. The class named BookmarkApplication.java needs to be run. 

Important Note: PostgreSQL should be installed in the computer. Also, username and password of a local PostgreSQL user should be written to line 25 of backend/bookmark/src/main/java/com/browser/bookmark/BookmarkApplication.java. "postgres" should be replaced with the username and "admin" should be replaced with password. The same change should be done in backend/bookmark/src/main/resources/application.properties file as well for lines 2 and 3.

Frontend Setup:
To run the client side of the application, latest version of Flutter should be installed. You can follow this link https://docs.flutter.dev/get-started/install to install Flutter. Make sure Visual Studio for developing C++ is also installed as mentioned in the documentation. After that, one can run our application by running main class found in the frontentd/lib/main.dart file.

Test Codes: 
Test codes can be found under the backend/bookmark/src/test/java/com/browser/bookmark directory. It contains 4 test files consisting of unit tests written for each controller and functionality.

