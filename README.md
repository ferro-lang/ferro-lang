# Ferro Programming Language

## Language Guide

### 1. Module System and Imports

```rust
open std::io::{println, math::sqrt}
```

- `open` keyword: This opens a module and imports specific functions or structs.
- Destructuring: Inside the curly braces, specific functions or structs are imported. For example, `math::sqrt` is imported from the `std::io` module, showing how nested functions/structs can be brought into scope.

### 2. Structs and Methods

```rust
struct vec3(x: float, y: float, z: float)
```

- Structs: Here, you define a struct `vec3` with three properties: `x`, `y`, and `z` of type `float`.

### 3. Method Definition Inside Struct

```rust
fn magnitude() := float {
  return sqrt((self.x * self.x) + (self.y * self.y) + (self.z * self.z));
}
```

- Method: The `magnitude` method is added to `vec3` and calculates the length (or magnitude) of the vector.
- The method uses fields of the struct (`self.x`, `self.y`, `self.z`) directly, and the `sqrt` function was imported from the `std::math` module.

### 4. Method Implementation Across Structs

```rust
struct vec2(x: float, y: float) {
  impl vec3::magnitude::{x, y, 0} -> clone := float
}
```

- `impl` keyword: Shows how a method from one struct (`vec3`) can be implemented across another struct (`vec2`).
- Transformation logic: It replaces the `z` component of `vec3` with `0` to make it a 2D vector, and uses the `clone` function.
- Return type (`:=`): The `:= float` shows that the result will be converted into a `float` type.

### 5. Functions with Specific Return Types

```rust
fn clone(magnitude: float) := float {
  return magnitude;
}
```

- Return type declaration: The `:=` operator specifies that this function returns a `float` type.
- This function takes a `float` as input and returns a `float` type.

### 6. The `::` Operator for Binding

```rust
fn unit_vector() :: vec3 := vec3 {
  let mag = self.magnitude();
  return vec3((self.x / mag), (self.y / mag), (self.z / mag));
}
```

- Method binding: The `::` operator binds the `unit_vector` function to the `vec3` struct. Unlike `magnitude`, this method can't be implemented by other structs since it's explicitly tied to `vec3`.
- Method functionality: It calculates a unit vector by normalizing the original vector's magnitude.

### 7. Entrypoint (main function)

```rust
fn main() {
  let v2 = vec2(1, 2);
  let v3_1 = vec3(1, 2, 3);
  let v3_2 = vec3(4, 5, 6);

  let sample_list = {1, 2, 3};
  let list_with_different_keys = {"A": 1, "B": 2, "C": 3};

  let grater_vector = grater(unit_vector_1, unit_vector_2);

  println(v2.magnitude());
  println(v3.magnitude());
}

```

- Variable declaration: `let` is used to declare variables. For example, `v2` and `v3` represent vectors.
- Inline collections: Lists and key-value pairs (like dictionaries) can be created using `{}`.
- Calling methods: The `println` function prints results of methods like `magnitude()`.

### 8. If-Else Statements and Mutable Variables

```rust
fn grater(v1: vec3, v2: vec3) := int {
  let mut indicator = 0;

  if v1.magnitude() > v2.magnitude() {
    indicator = 1;
  } else if v2.magnitude() > v1.magnitude() {
    indicator = -1;
  }

  return indicator;
}
```

- Conditionals: `if-else` is used to compare the magnitudes of vectors.
- Mutable variables: `let mut` declares a variable that can be changed later in the function.

### 9. Recursion Instead of Loops

- No loops: The language doesn't allow loops; only recursion is permitted.

### 10. No Multiline Comments

- Comments are single-line (`//`). There are no multiline comments (`/* ... */`), which means comments need to stay concise.
