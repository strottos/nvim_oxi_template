use nvim_oxi::{Dictionary, Function};

#[nvim_oxi::plugin]
fn nvim_oxi_template_rs() -> nvim_oxi::Result<Dictionary> {
    let example = Function::from_fn(|_args: Dictionary| {
        nvim_oxi::print!("Hello from oxi template!");
    });

    Ok(Dictionary::from_iter([("example", example)]))
}
