# SauceDemo Robot Framework Test Suite

This project contains a comprehensive test automation suite for the [SauceDemo](https://www.saucedemo.com/) website using Robot Framework with Browser (Playwright) Library.

## Project Structure

```
saucedemo-robot-tests/
├── resources/
│   ├── common.resource         # Common keywords and settings
│   ├── pages/                  # Page object models
│   │   ├── login_page.resource
│   │   ├── inventory_page.resource
│   │   ├── cart_page.resource
│   │   └── checkout_page.resource
│   └── variables/              # Test data and variables
│       └── users.resource
├── tests/                      # Test suites
│   ├── login_tests.robot
│   ├── inventory_tests.robot
│   ├── cart_tests.robot
│   └── checkout_tests.robot
└── results/                    # Test reports (generated)
```

## Setup & Installation

1. Install Node.js dependencies:

```bash
npm install
```

2. Initialize the Browser library:

```bash
npm run setup
```

## Running Tests

Run all tests:

```bash
npm test
```

Run specific test suites:

```bash
npm run test:login
npm run test:inventory
npm run test:cart
npm run test:checkout
```

Run tests in parallel:

```bash
npm run test:parallel
```

Clean test results:

```bash
npm run clean
```

## Test Reports

Test reports are generated in the `results` directory after each test run. Open `report.html` in a browser to view the test results.

## Features

- **Page Object Model**: Separates page elements and actions for better maintainability
- **Common Keywords**: Reusable keywords for common actions
- **Data-driven Testing**: Test data separation for easy maintenance
- **Parallel Execution**: Support for parallel test execution
- **Detailed Reporting**: Comprehensive test reports with screenshots on failures
- **Cross-browser Testing**: Ability to run tests across different browsers

## Environment Configuration

You can modify the browser settings in `resources/common.resource`:

```robotframework
*** Variables ***
${BROWSER}        chromium    # Change to 'firefox' or 'webkit' as needed
${HEADLESS}       True        # Set to False for visible browser
```

## Best Practices

1. Keep each test case focused on a single functionality
2. Maintain test independence - each test should be able to run on its own
3. Use descriptive names for test cases and keywords
4. Add proper documentation for test cases and keywords
5. Separate test data from test logic
6. Take screenshots on test failures
7. Implement proper waiting strategies