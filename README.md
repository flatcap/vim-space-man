# space-man.vim

SpaceMan manages whitespace in a file

## Introduction

SpaceMan introduces ten functions for manipulating whitespace in a file.

Function                  | Description
------------------------- | ------------------------------------------------
delete_leading_space      | Remove any whitespace at the beginning of a line
delete_trailing_space     | Remove any whitespace at the end of a line
delete_space_error        | Remove any space chars that precede tab chars
delete_empty_lines        | Delete all empty lines
squeeze_empty_lines       | Merge adjacent empty lines
delete_top_blank_lines    | Remove empty lines at the beginning of the file
delete_bottom_blank_lines | Remove empty lines at the end of the file
convert_tabs_to_spaces    | Convert leading tabs to spaces
convert_spaces_to_tabs    | Convert leading spaces to tabs
surround_with_space       | Add whitespace around a word, line or block

## Mappings

Each function creates a set of <Plug> mappings and a set of user key mappings.

Function                  | &lt;Plug&gt; prefix          | User key mapping          
------------------------- | -----------------------| --------------------- 
delete_leading_space      | DeleteLeadingSpace     | &lt;leader&gt;&lt;space&gt;l      
delete_trailing_space     | DeleteTrailingSpace    | &lt;leader&gt;&lt;space&gt;t      
delete_space_error        | DeleteSpaceError       | &lt;leader&gt;&lt;space&gt;e      
delete_empty_lines        | DeleteEmptyLines       | &lt;leader&gt;&lt;enter&gt;d      
squeeze_empty_lines       | SqueezeEmptyLines      | &lt;leader&gt;&lt;enter&gt;z      
delete_top_blank_lines    | DeleteTopBlankLines    | &lt;leader&gt;&lt;enter&gt;gg     
delete_bottom_blank_lines | DeleteBottomBlankLines | &lt;leader&gt;&lt;enter&gt;G      
convert_tabs_to_spaces    | ConvertTabsToSpaces    | &lt;leader&gt;&lt;tab&gt;&lt;space&gt;  
convert_spaces_to_tabs    | ConvertSpacesToTabs    | &lt;leader&gt;&lt;space&gt;&lt;tab&gt;  
surround_with_space       | SurroundWithSpace      | &lt;leader&gt;&lt;space&gt;s      

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 <http://fsf.org/>

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-space-man)

