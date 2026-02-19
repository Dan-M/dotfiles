# Global Agentic Coding Guidelines

This file defines the **global** coding standards, architectural rules, and preferences for this codebase. Agents must adhere to these rules for all tasks, ensuring consistency and maintainability.

## 1. Code Organization & Architecture

### 1.1 Domain-Driven Structure
Organize code by **Domain/Feature** first, not by technical layer.
*   **Good:** `src/contracts/`, `src/products/`, `src/payments/`
*   **Bad:** `src/controllers/`, `src/services/`, `src/models/`

Each domain folder should contain all layers required for that feature:
```text
src/my-feature/
├── model.ts          # Data Access (DB)
├── service.ts        # Business Logic
├── graphql.ts        # API/Transport
├── types.ts          # Shared types
└── service.test.ts   # Tests
```

### 1.2 Layer Responsibilities
*   **Data Access (`model.ts`)**:
    *   **Sole responsibility:** Direct interaction with the database (MongoDB).
    *   **Exports:** `type` definitions for data shapes and **pure functions** for queries/mutations.
    *   **Prohibited:** Business logic, calling other services.
*   **Service Layer (`service.ts`)**:
    *   **Sole responsibility:** Business logic, orchestration, and logging.
    *   **Exports:** **Pure functions**.
    *   **Prohibited:** Direct database queries (must call `model.ts` functions).
*   **API Layer (`graphql.ts`, `api.ts`)**:
    *   **Sole responsibility:** Request handling, validation, and response formatting.
    *   **Action:** calls `service.ts` functions.

### 1.3 Client/Adapter Pattern
Use `src/clients/` for all external communication (REST, SOAP, Queues, other services).
*   Do not make direct `fetch` calls in service logic.
*   Wrap external calls in a typed client function.

## 2. Functional TypeScript Standards

### 2.1 Functional over Object-Oriented
*   **No Classes:** Avoid classes for Services, Models, or Controllers. Use modules with exported functions.
*   **Exception:** Use classes only where required by a framework (e.g., custom Errors, extending framework base classes) or for stateful utilities that require instantiation.
*   **Pure Functions:** Prefer pure functions. Isolate side effects.

### 2.2 Type Definitions
*   **Types > Interfaces:** Always use `type` aliases. **Never** use `interface`.
    ```typescript
    // Good
    type User = { id: string; name: string };

    // Bad
    interface User { id: string; name: string; }
    ```
*   **Zod Schemas:** Define runtime validation schemas using `zod` and infer types from them using `z.infer<typeof schema>`.
    ```typescript
    import { z } from 'zod';
    const UserSchema = z.object({ id: z.string(), name: z.string() });
    type User = z.infer<typeof UserSchema>;
    ```
*   **Named Exports:** Use named exports (`export const foo = ...`) instead of default exports (`export default ...`), except for specific framework requirements.

### 2.3 Immutability & Safety
*   **Read-Only:** Prefer `ReadonlyArray<T>` and `readonly` properties.
*   **Const Assertions:** Use `as const` for literals and fixed arrays to narrow types.
    ```typescript
    const STATUSES = ['PENDING', 'ACTIVE'] as const;
    type Status = typeof STATUSES[number]; // 'PENDING' | 'ACTIVE'
    ```
*   **No Any:** Avoid `any`. Use `unknown` with type narrowing or Zod validation.

### 2.4 Discriminated Unions
Use discriminated unions for state and complex logic branching.
```typescript
type Result<T> =
  | { success: true; value: T }
  | { success: false; error: Error };
```

## 3. Testing Standards

*   **Co-location:** Place tests next to the file they test (e.g., `service.test.ts` next to `service.ts`).
*   **Mocking:**
    *   Avoid `as any` for mocks.
    *   Use the spread pattern for partial mocks: `const mock = { ...({} as FullType), requiredProp: 'val' };`

## 4. Error Handling

### 4.1 Strategy
*   **Bubble Up:** In general, do **not** catch errors in the Service or API layers unless you can recover from them or need to add specific context. Let the global `errorHandler` middleware handle logging and response formatting.
*   **Throw Early:** Validate inputs and invariants early. Throw immediately if a check fails.

### 4.2 Error Types
*   **Standard Errors:** Use the standard `Error` class for most operational errors.
    ```typescript
    if (!user) {
      throw new Error(`User with id ${id} not found`);
    }
    ```
*   **Contextual Exceptions:** Only create custom error classes (e.g., `ContractServiceError`) if the error type drives specific control flow or needs distinct handling by the consumer.

## 5. Modern JavaScript & Node.js Patterns

### 5.1 Syntax & Modules
*   **Node Protocol:** Use the `node:` prefix for all built-in module imports.
    ```typescript
    import fs from 'node:fs';
    import path from 'node:path';
    ```
*   **Async/Await:** Use `async/await` exclusively. Avoid `.then()` chains.
*   **Configuration:** Do **not** access `process.env` directly in business logic. Use a typed configuration object (e.g., `src/config.ts`) that validates environment variables on startup.

### 5.2 Logging
*   **Structured Logging:** Use the application logger (e.g., `log.info()`, `log.error()`). **Never** use `console.log`.

### 5.3 Naming Conventions
*   **Files:** `kebab-case.ts` (e.g., `user-service.ts`)
*   **Variables/Functions:** `camelCase` (e.g., `getUserById`)
*   **Types/Classes:** `PascalCase` (e.g., `User`, `ProposalNotFoundError`)

## 6. Interaction Preferences
- **Succinctness**: Provide direct answers first. Avoid long conversational fillers and disclaimers.
- **Proactivity**: If a task is ambiguous, list 2-3 possible interpretations and ask for clarification before executing.
- **Feedback Loop**: After completing a complex task, provide a brief summary of the changes made and any side effects identified.
* **Concise:** Be brief. Focus on the code and the plan.
* **Evidence-Based:** When analyzing, provide file paths and code snippets to back up findings.

## 7. Tool Interaction Rules
- **Approval Required**: Always ask for confirmation before:
  - Deleting any files.
  - Running `rm -rf` or heavy cleanup scripts.
  - Installing new dependencies.
- **NEVER** read or commit .env files.
- **NEVER** read or commit secret files.
- Check on startup which skills are skills to you. Use them when appropriate.
- Check on startup which MCP server tools are available to you. Use them when appropriate.
