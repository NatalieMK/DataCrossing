// extern crate meteonook;
extern crate serde_json;
extern crate serde;
use std::os::raw::{c_char};
use std::ffi::{CString, CStr};
use crate::Hemisphere::Northern;

#[macro_use]
extern crate serde_derive;

// use meteonook::*;

use serde_json::Value as JsonValue;

#[derive(Serialize, Deserialize)]

struct SwiftInput {
    year: u16,
    day: u8,
    month: u8,
    seed: u32,
    pattern: String
}
