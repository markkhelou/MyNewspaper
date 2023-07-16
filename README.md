# MyNewspaper

## Project Summary:
MyNewspaper is an iOS app implemented using SwiftUI and follows the MVVM + Clean Architecture design pattern. The primary focus of the project was on implementing the application logic rather than prioritizing the design aspects.

In terms of architectural design, I adopted Clean Architecture to ensure a clear separation between different layers of the application. This approach facilitates easier testing, maintenance, and scalability. The use of MVVM (Model-View-ViewModel) pattern within the Clean Architecture further enhanced the separation of concerns and enabled better code organization.

One notable aspect of my implementation is the utilization of the new asynchronous programming paradigm – async/await. By embracing async/await, I was able to write more readable and concise asynchronous code, improving the overall efficiency and maintainability of the project.

## If given more time, here are a few things I would have done differently:

- Design: Although design is crucial, I did not allocate much time to it in this code challenge. Given more time, I would have paid more attention to creating a visually appealing and intuitive user interface.

- Testing: It is essential to have thorough test coverage for all layers of the application. However, due to time constraints, I only included tests for the timeline feature. Given more time, I would have implemented unit tests for all layers to ensure code reliability and maintainability.

- Integration of SwiftLint: SwiftLint is a powerful tool for enforcing code style and best practices in Swift projects. If I had more time, I would have integrated SwiftLint into the project to ensure consistent code formatting, naming conventions, and adherence to Swift coding guidelines.

## Frameworks used and their justifications:

- SwiftGen: I chose SwiftGen to eliminate type mistakes and remove hard-coded strings from the project. It provides strong type-safety by generating Swift code for resources like images, fonts, and localized strings. You can find more information about SwiftGen on its GitHub repository: https://github.com/SwiftGen/SwiftGen

- KeychainSwift: To ensure the security and safe storage of critical data, I utilized KeychainSwift. KeychainSwift is a convenient wrapper around the iOS Keychain API, offering a simple and reliable way to interact with the keychain. For more details, you can refer to the GitHub repository: https://github.com/evgenyneu/keychain-swift

- Resolver: Resolver is a dependency injection framework that I chose for this project. It helps remove the burden of manually creating instances and managing dependencies. By utilizing Resolver, the code becomes more modular, testable, and easier to maintain. You can learn more about Resolver on its GitHub repository: https://github.com/hmlongco/Resolver

## Thoughts on API responses:

- Renaming Properties: Some of the properties in the API responses needed to be renamed correctly. To handle this, I used a custom decoder during the parsing process to map the response data accurately.

- Article API: In regards to the Get article API, it is worth noting that the API response includes a comprehensive set of data fields, but not all of them are necessary for displaying the articles in the frontend. In terms of performance optimization, it is more efficient to only send the data that is required by the frontend, reducing the payload size and improving network performance.
By selectively sending only the necessary data for the initial display of articles, we can minimize the amount of data transferred over the network, resulting in faster load times and improved performance.
 When a user selects a specific article to view its details, Get Article By ID API is called to retrieve the complete set of data for that article.  

- Active Subscriptions: In the user API, the "active_subscriptions" field is represented as an array. This initially confused me, as I assumed that a “full” subscription would provide access to all articles. However, I realized that the array signifies specific subscription categories, such as ["full", "sport"]. Based on this understanding, I adjusted the logic accordingly in the app.

- It is important to consider the case sensitivity of the email field in the request. To provide a seamless and user-friendly experience, it is generally recommended to treat email addresses as case-insensitive
