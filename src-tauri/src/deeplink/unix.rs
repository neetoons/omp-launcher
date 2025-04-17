use std::io::Result;

pub fn register<F: FnMut(String) + Send + 'static>(_scheme: &str, _handler: F) -> Result<()> {
    // Implementación vacía para Linux (podrías usar DBus o similar)
    Ok(())
}

pub fn prepare(_identifier: &str) {
    // No-op en Linux
}