# Colorscheme Preview

## 🦀 Rust
```rust
use std::collections::HashMap;

// Estructura de datos para almacenar información de usuarios
struct User {
    id: u32,
    name: String,
    email: String,
    active: bool,
}

// Implementación de métodos para la estructura User
impl User {
    fn new(id: u32, name: &str, email: &str) -> Self {
        User {
            id,
            name: name.to_string(),
            email: email.to_string(),
            active: true,
        }
    }

    fn deactivate(&mut self) {
        self.active = false;
    }

    fn is_active(&self) -> bool {
        self.active
    }
}

// Función para mostrar información del usuario
fn display_user_info(user: &User) {
    println!(
        "ID: {}, Name: {}, Email: {}, Active: {}",
        user.id, user.name, user.email, user.active
    );
}

fn main() {
    // Crear un nuevo usuario
    let mut user1 = User::new(1, "Alice", "alice@example.com");
    display_user_info(&user1);

    // Crear un mapa para almacenar varios usuarios
    let mut user_map: HashMap<u32, User> = HashMap::new();
    user_map.insert(user1.id, user1);

    // Agregar más usuarios
    user_map.insert(2, User::new(2, "Bob", "bob@example.com"));
    user_map.insert(3, User::new(3, "Charlie", "charlie@example.com"));

    // Mostrar información de todos los usuarios
    for (id, user) in &user_map {
        println!("Usuario {}:", id);
        display_user_info(user);
    }

    // Desactivar un usuario
    if let Some(user) = user_map.get_mut(&1) {
        user.deactivate();
    }

    // Verificar el estado de los usuarios después de la desactivación
    println!("\nEstado después de la desactivación:");
    for (id, user) in &user_map {
        println!("Usuario {}:", id);
        display_user_info(user);
    }
}
```
