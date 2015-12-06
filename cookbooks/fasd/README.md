# fasd Cookbook

Install [fasd](https://github.com/clvv/fasd) and add it to the path.

## Requirements

This cookbook has been tested on Ubuntu 12.04 and 14.04. It will likely work with other
versions/debian boxes.

If you know of a version that this works for, please let me know (or update this file).

#### packages

- `ark` - <https://github.com/burtlo/ark>

Attributes
----------

There are two attributes that can be configured: `version` and `checksum`.

#### fasd::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["fasd"]["version"]</tt></td>
    <td>String</td>
    <td>The version to install. See <a href="https://github.com/clvv/fasd/releases">releases</a> for options.</td>
    <td><tt>1.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>["fasd"]["checksum"]</tt></td>
    <td>String</td>
    <td>The 256-bit checksum for the tar file</td>
    <td><tt>...</tt></td>
  </tr>
</table>

## Usage

#### fasd::default

Just include `fasd` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fasd]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors:

* [pseudomuto] (David Muto)

[pseudomuto]: https://github.com/pseudomuto
