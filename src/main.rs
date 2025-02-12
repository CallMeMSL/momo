use crate::torrent::Torrent;
use serde_bencode::de;
use std::fs::File;
use std::io::Read;
use anyhow::Result;

pub mod torrent;

fn main() -> Result<()> {
    let mut file = File::open("res/shan.torrent")?;
    let mut buffer = Vec::new();
    file.read_to_end(&mut buffer)?;
    let td = de::from_bytes::<Torrent>(&buffer)?;
    println!("{:?}", td);
    let magnet = td.create_magnet_link()?;
    println!("{}", magnet);

    Ok(())
}
