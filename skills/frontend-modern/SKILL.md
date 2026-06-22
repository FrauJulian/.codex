---
name: frontend-modern
description: Use for implementing or reviewing modern WPF/XAML, HTML, and CSS with focus on maintainable component structure, MVVM, accessibility, responsive layouts, rendering performance, resource cleanup, and readable styling.
---

# Modern frontend implementation

Use this skill for WPF/XAML and standards-based HTML/CSS implementation.

## Shared workflow

1. Inspect existing components, styles, tokens, architecture, platform targets, accessibility rules, and tests.
2. Identify user tasks and all UI states.
3. Reuse existing components and resources.
4. Implement the smallest coherent change.
5. Validate keyboard, focus, content growth, scaling, responsive behavior, error states, and performance.
6. Document assumptions and validation.

## WPF and XAML

- Follow the repository's MVVM pattern.
- Keep business logic out of views and code-behind.
- Use binding, commands, validation, styles, templates, resource dictionaries, and dependency properties appropriately.
- Keep binding paths and data contexts understandable.
- Use compiled binding features when available and compatible with the project.
- Avoid expensive converters and deep visual trees in hot paths.
- Enable virtualization for large item collections and do not accidentally disable it with layout choices.
- Do not block the UI thread.
- Marshal UI updates correctly and cancel obsolete work.
- Clean up events, timers, subscriptions, weak-event patterns, and disposable view models.
- Support DPI scaling, localization, keyboard navigation, access keys, focus visibility, screen readers, and high-contrast themes.
- Keep theme resources centralized and avoid duplicated magic values.
- Handle validation, loading, empty, failure, and disabled states.

## HTML

- Use semantic elements and correct heading structure.
- Use native controls before custom widgets.
- Keep labels associated with inputs.
- Use buttons for actions and links for navigation.
- Preserve safe text rendering.
- Add ARIA only when native semantics are insufficient.
- Keep DOM depth and repeated wrappers reasonable.
- Support keyboard and assistive technology.

## CSS

- Prefer Grid and Flexbox for layout.
- Use CSS custom properties and existing design tokens.
- Use logical properties when layout may be localized.
- Keep selectors local, shallow, and low-specificity.
- Avoid !important except for narrowly documented overrides.
- Avoid brittle absolute positioning and fixed dimensions for dynamic content.
- Keep component states explicit.
- Respect prefers-reduced-motion.
- Use transforms and opacity for necessary animation when practical.
- Avoid layout thrashing, oversized paint areas, and unnecessary effects.
- Ensure responsive behavior follows content constraints.

## Maintainability

- Separate structure, presentation, and behavior without creating artificial layers.
- Keep components cohesive and APIs small.
- Avoid global style leakage.
- Avoid creating a parallel design system.
- Prefer existing dependencies and platform capabilities.
- Comments should explain unusual browser/platform constraints or design rationale.

## Validation checklist

- Primary user flow.
- Keyboard-only operation.
- Visible focus and accessible names.
- Loading, empty, error, success, disabled, and validation states.
- Narrow and wide layouts.
- Long text and localization.
- DPI/zoom/high contrast where relevant.
- Large lists and repeated rendering.
- Listener, timer, and subscription cleanup.
