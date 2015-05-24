# space-man.vim

SpaceMan manages whitespace in a file

## Introduction

SpaceMan introduces ten functions for maniputing whitespace in a file.

| Function            | Description                                             |
| ------------------- | ------------------------------------------------------- |
| Blank Lines Top     | Remove empty lines at the beginning of the file         |
| Blank Lines Bottom  | Remove empty lines at the end of the file               |
| Empty Lines Delete  | Delete all empty lines                                  |
| Empty Lines Squeeze | Merge adjacent empty lines                              |
| Space Error         | Remove any space characters that precede tab characters |
| Space Leading       | Remove any whitespace at the beginning of a line        |
| Space Trailing      | Remove any whitespace at the end of a line              |
| Spaces Tabs         | Convert leading spaces to tabs                          |
| Tabs Spaces         | Convert leading tabs to spaces                          |
| Space Surround      | Add whitespace around a word, line or block             |

Whitespace: Space, Tab or Carriage Return
Empty line: No characters, or only whitespace

## Mappings

Each function creates a set of &lt;Plug&gt; mappings.
The local mappings work on a Line, Motion or Visual region
The file mappings work on the entire File, all Args, all Buffers or all Windows.

List of all &lt;Plug&gt; mappings:

| Line               | Motion             | Visual             | Args               | Buffers            | File               | Window             |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
|                    |                    |                    | BlankLinesTopA     | BlankLinesTopB     | BlankLinesTopF     | BlankLinesTopW     |
|                    |                    |                    | BlankLinesBottomA  | BlankLinesBottomB  | BlankLinesBottomF  | BlankLinesBottomW  |
| EmptyLinesDeleteL  | EmptyLinesDeleteM  | EmptyLinesDeleteV  | EmptyLinesDeleteA  | EmptyLinesDeleteB  | EmptyLinesDeleteF  | EmptyLinesDeleteW  |
| EmptyLinesSqueezeL | EmptyLinesSqueezeM | EmptyLinesSqueezeV | EmptyLinesSqueezeA | EmptyLinesSqueezeB | EmptyLinesSqueezeF | EmptyLinesSqueezeW |
| SpaceErrorL        | SpaceErrorM        | SpaceErrorV        | SpaceErrorA        | SpaceErrorB        | SpaceErrorF        | SpaceErrorW        |
| SpaceLeadingL      | SpaceLeadingM      | SpaceLeadingV      | SpaceLeadingA      | SpaceLeadingB      | SpaceLeadingF      | SpaceLeadingW      |
| SpacesTabsL        | SpacesTabsM        | SpacesTabsV        | SpacesTabsA        | SpacesTabsB        | SpacesTabsF        | SpacesTabsW        |
| SpaceTrailingL     | SpaceTrailingM     | SpaceTrailingV     | SpaceTrailingA     | SpaceTrailingB     | SpaceTrailingF     | SpaceTrailingW     |
| TabsSpacesL        | TabsSpacesM        | TabsSpacesV        | TabsSpacesA        | TabsSpacesB        | TabsSpacesF        | TabsSpacesW        |
| SpaceSurroundL     | SpaceSurroundM     | SpaceSurroundV     |                    |                    |                    |                    |

The keyboard mappings begin with &lt;Leader&gt;
The args mappings begin with &lt;Leader&gt;a
The buffer mappings begin with &lt;Leader&gt;b
The file mappings begin with &lt;Leader&gt;f
The window mappings begin with &lt;Leader&gt;w

| Function            | Line                                  | Motion                   | Visual                   | Args                      | Buffers                   | File                      | Window                    |
| ------------------- | ------------------------------------- | ------------------------ | ------------------------ | ------------------------- | ------------------------- | ------------------------- | ------------------------- |
| Blank Lines Top     |                                       |                          |                          | a&lt;enter&gt;gg          | b&lt;enter&gt;gg          | f&lt;enter&gt;gg          | w&lt;enter&gt;gg          |
| Blank Lines Bottom  |                                       |                          |                          | a&lt;enter&gt;G           | b&lt;enter&gt;G           | f&lt;enter&gt;G           | w&lt;enter&gt;G           |
| Empty Lines Delete  | &lt;enter&gt;dd                       | &lt;enter&gt;d           | &lt;enter&gt;d           | a&lt;enter&gt;d           | b&lt;enter&gt;d           | f&lt;enter&gt;d           | w&lt;enter&gt;d           |
| Empty Lines Squeeze | &lt;enter&gt;zz                       | &lt;enter&gt;z           | &lt;enter&gt;z           | a&lt;enter&gt;z           | b&lt;enter&gt;z           | f&lt;enter&gt;z           | w&lt;enter&gt;z           |
| Space Error         | &lt;space&gt;ee                       | &lt;space&gt;e           | &lt;space&gt;e           | a&lt;space&gt;e           | b&lt;space&gt;e           | f&lt;space&gt;e           | w&lt;space&gt;e           |
| Space Leading       | &lt;space&gt;ll                       | &lt;space&gt;l           | &lt;space&gt;l           | a&lt;space&gt;l           | b&lt;space&gt;l           | f&lt;space&gt;l           | w&lt;space&gt;l           |
| Space Trailing      | &lt;space&gt;tt                       | &lt;space&gt;t           | &lt;space&gt;t           | a&lt;space&gt;t           | b&lt;space&gt;t           | f&lt;space&gt;t           | w&lt;space&gt;t           |
| Spaces Tabs         | &lt;space&gt;&lt;tab&gt;&lt;tab&gt;   | &lt;space&gt;&lt;tab&gt; | &lt;space&gt;&lt;tab&gt; | a&lt;space&gt;&lt;tab&gt; | b&lt;space&gt;&lt;tab&gt; | f&lt;space&gt;&lt;tab&gt; | w&lt;space&gt;&lt;tab&gt; |
| Tabs Spaces         | &lt;tab&gt;&lt;space&gt;&lt;space&gt; | &lt;tab&gt;&lt;space&gt; | &lt;tab&gt;&lt;space&gt; | a&lt;tab&gt;&lt;space&gt; | b&lt;tab&gt;&lt;space&gt; | f&lt;tab&gt;&lt;space&gt; | w&lt;tab&gt;&lt;space&gt; |
| Space Surround      | &lt;space&gt;ss                       | &lt;space&gt;s           | &lt;space&gt;s           |                           |                           |                           |                           |

## Examples

These examples assume the &lt;Leader&gt; is set to its default value of \ (backslash)
and the plugin is using its default user mappings.

| Function            | Type this...                 | Acts on                                                |
| ------------------- | ---------------------------- | ------------------------------------------------------ |
| Blank Lines Top     | \f&lt;enter&gt;gg            | This file                                              |
| Blank Lines Top     | \w&lt;enter&gt;gg            | All windows                                            |
| Blank Lines Bottom  | \b&lt;enter&gt;G             | All buffers                                            |
| Blank Lines Bottom  | \a&lt;anter&gt;G             | All args                                               |
| Empty Lines Delete  | V10j\&lt;enter&gt;d          | Visual - 10 lines down                                 |
| Empty Lines Delete  | \&lt;enter&gt;d10j           | Motion - 10 lines down                                 |
| Empty Lines Squeeze | \&lt;enter&gt;zG             | Motion - from cursor to end of file                    |
| Empty Lines Squeeze | \f&lt;enter&gt;z             | This file                                              |
| Space Error         | \&lt;space&gt;ee             | Line                                                   |
| Space Error         | \a&lt;space&gt;e             | All args                                               |
| Space Leading       | \b&lt;space&gt;l             | All buffers                                            |
| Space Leading       | \&lt;space&gt;lip            | Motion - this paragraph                                |
| Space Trailing      | \&lt;space&gt;tt             | Line                                                   |
| Space Trailing      | \w&lt;space&gt;t             | All windows                                            |
| Spaces Tabs         | 4\f&lt;space&gt;&lt;tab&gt;  | This file - convert this file - 4 spaces to tabs       |
| Spaces Tabs         | 8\&lt;space&gt;&lt;tab&gt;ip | Motion - convert this paragraph - 8 space to tab       |
| Tabs Spaces         | 2\a&lt;tab&gt;&lt;space&gt;  | All args - convert all args - tabs to 2 spaces         |
| Tabs Spaces         | 4\&lt;tab&gt;&lt;space&gt;gg | Motion - from cursor to top of file - tabs to 4 spaces |
| Space Surround      | 2\&lt;space&gt;ss            | Line - wrap 2 empty lines around this one              |
| Space Surround      | vee\&lt;space&gt;s           | Visual - wrap space around 2 words                     |
| Space Surround      | ^V3j4l\&lt;space&gt;s        | Visual - wrap space around 5x4 block of characters     |

## Configuration

To completely disable this plugin, add the following to your `.vimrc`

```viml
let g:loaded_space_man = 1
```

Each function is controlled by two global variables which both default to 1 (true).
The first to enable the function, the second to create default user mappings.
e.g.  For EmptyLinesDelete,

```viml
let g:space_man_enable_empty_lines_delete          = 1
let g:space_man_create_mappings_empty_lines_delete = 1
```

Here's the full list

| Function            | Enable                                 | User mappings                                   |
| ------------------- | -------------------------------------- | ----------------------------------------------- |
| Blank Lines Top     | g:space_man_enable_blank_lines_top     | g:space_man_create_mappings_blank_lines_top     |
| Blank Lines Bottom  | g:space_man_enable_blank_lines_bottom  | g:space_man_create_mappings_blank_lines_bottom  |
| Empty Lines Delete  | g:space_man_enable_empty_lines_delete  | g:space_man_create_mappings_empty_lines_delete  |
| Empty Lines Squeeze | g:space_man_enable_empty_lines_squeeze | g:space_man_create_mappings_empty_lines_squeeze |
| Space Error         | g:space_man_enable_space_error         | g:space_man_create_mappings_space_error         |
| Space Leading       | g:space_man_enable_space_leading       | g:space_man_create_mappings_space_leading       |
| Space Trailing      | g:space_man_enable_space_trailing      | g:space_man_create_mappings_space_trailing      |
| Spaces Tabs         | g:space_man_enable_spaces_tabs         | g:space_man_create_mappings_spaces_tabs         |
| Tabs Spaces         | g:space_man_enable_tabs_spaces         | g:space_man_create_mappings_tabs_spaces         |
| Space Surround      | g:space_man_enable_space_surround      | g:space_man_create_mappings_space_surround      |

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 <http://fsf.org/>

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-space-man)

