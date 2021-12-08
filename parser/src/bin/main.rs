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

struct PatternInfo {
    year: u16,
    day: u8,
    month: u8,
    seed: u32,
    pattern: String
}

// fn main(){
//     let json_str = r#"
//         {
//             "year": 2020,
//             "day": 4,
//             "month": 4,
//             "pattern": "Fine00"
//         }
//
//         "#;
//     getWeather(json_str);
// }
//
// pub fn getWeather(str: &str){
//     let json_str = str;
//     let res = serde_json::from_str(json_str);
//     if res.is_ok(){
//     let p: PatternInfo = res.unwrap();
//     println!("The year is {}", p.year);
//     println!("The day is {}", p.day);
//     println!("The month is {}", p.month);
//     println!("The seed is {}", p.seed);
//     let pattern = get_pattern(Northern, p.seed, p.year, p.month, p.day);
//     println!("{}", pattern.kind())
//     } else {
//     println!("Sorry, could not parse JSON")
//     }
// }

// #[no_mangle]
// pub extern fn rust_parse(to: *const c_char) -> *mut c_char {
//     let c_str = unsafe {CStr::from_ptr(to)};
//     let printed = match c_str.to_str(){
//         Err(_) => "there",
//         Ok(string) => string,
//     };
//     CString::new(printed).unwrap().into_raw()
// }
//
// #[no_mangle]
// pub extern fn rust_parse_free(s: *mut c_char) {
//     unsafe {
//         if s.is_null() { return }
//         CString::from_raw(s)
//     };
// }
//
// fn main(){
// 	// use Pattern::*;
//
//     let json_str = r#"
//     {
//         "year": 2020,
//         "day": 4,
//         "month": 4,
//         "pattern": "Fine00"
//     }
//
//     "#;
//
//     let res = serde_json::from_str(json_str);
//
//     if res.is_ok(){
//         let p: PatternInfo = res.unwrap();
//         println!("The year is{}", p.year);
//     } else {
//         println!("Sorry, could not parse JSON")
//     }
// }
