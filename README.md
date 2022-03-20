# Marketplace - CSI 5112 #Group number 13
This repository contains our project for CSI 5112 - Software Engineering course taught at uOttawa. The codebase contains our experiments with Flutter, .NET core and MongoDB Atlas database for a marketplace application where merchants can post their listings and user's can purchase them.

# Setup

1. Flutter env: Please follow the latest instructions from: https://docs.flutter.dev/get-started/install
2. Coding env: We use VS Code and Android Studio, detailed instructions can be found at: https://docs.flutter.dev/get-started/editor
3. Recommend extensions for VSCode: https://docs.flutter.dev/development/tools/vs-code

# Quickstart

1. After installing flutter and an editor (above section), clone the repository using `git clone https://github.com/vasu5235/marketplace_CSI_5112.git`
2. Open VS code/Android Studio, import the project folder in your workspace
3. Open file `api_url.dart` (present inside `lib/constants/` folder) and edit the `envUrl` variable to point to the correct IP address where services are hosted, example: https://localhost:7136/api (setup instructions: [Marketplace_Services](https://github.com/vasu5235/marketplace_services_CSI5112)) or http://3.93.177.49/api (hosted on EC2 instance), save the file
5. Run `flutter run -d chrome` from terminal or Click on **Run** icon on the top right command palette
6. You can run on other devices using `flutter run -d DEVICE_NAME` where DEVICE_NAME can be [chrome, macos]
7. For running on a simulator, launch the simulator and then run `flutter run` from terminal

# Default credentials

1. Customer email: `test@uottawa.ca` and password: `123456`
2. Merchant email: `merchant@marketplace.ca` and password: `123456

# Deployment

1. Cloudfront URL: https://marketplace.vlearnings.net
2. S3 URL: http://marketplace-s3bucket.s3-website-us-east-1.amazonaws.com
3. We do not have Cloudfront invalidations setup, so the release is cached for 24 hrs [Reference](https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-serving-outdated-content-s3/), hence please directly use our S3 IP to view latest code: http://marketplace-s3bucket.s3-website-us-east-1.amazonaws.com. Please note that this may result in an unstable user experience 
4. Also, since we would be developing part-3 of the project, the environment may be unstable, hence we recommend to run the UI locally and connect to our EC2 hosted services (defined in Quickstart step)
