{
  config,
  lib,
  ...
}:

let
  normalMode = {
    "'" = "repeat_last_motion";
    "\"" = "select_register";
    "%" = "select_all";
    "(" = "rotate_selections_backward";
    ")" = "rotate_selections_forward";
    "minus" = "decrement";
    "_" = "trim_selections";
    "+" = "increment";
    "y" = "yank";
    "h" = "move_char_left";
    "j" = "move_visual_line_down";
    "k" = "move_visual_line_up";
    "l" = "move_char_right";
    "\\" = "flip_selections";
    "x" = "extend_line_below";
    "S-x" = "extend_line_above";
    "A-x" = [
      "ensure_selections_forward"
      "select_line_above"
    ];
    "A-S-x" = [
      "ensure_selections_forward"
      "flip_selections"
      "select_line_below"
    ];
    "v" = "select_mode";
    "," = "keep_primary_selection";
    "<" = "unindent";
    ">" = "indent";
    ";" = "collapse_selection";
    ":" = "command_mode";
    "ret" = [
      "move_line_down"
      "goto_first_nonwhitespace"
    ];
    "A-ret" = [
      "move_line_up"
      "goto_first_nonwhitespace"
    ];
    "down" = "scroll_down";
    "up" = "scroll_up";
  };
  languageMinorMode = {
    "r" = "rename_symbol";
    "f" = "format_selections";
    "x" = "completion";
    "c" = "toggle_line_comments";
    "/" = [
      "align_view_top"
      "hover"
    ];
    "?" = "signature_help";
    "ret" = "code_action";
  };
  languageMinorModeExpansion = {
    "c" = "toggle_block_comments";
  };
  bufferMinorMode = {
    "'" = "goto_last_accessed_file";
    "q" = ":buffer-close";
    "w" = ":write";
    "r" = ":reload";
    "o" = ":buffer-close-others";
    "[" = "goto_previous_buffer";
    "s" = "goto_file";
    "]" = "goto_next_buffer";
    "z" = "suspend";
    "n" = ":new";
    "." = "goto_last_modified_file";
    "space" = "buffer_picker";
  };
  bufferMinorModeExpansion = {
    "q" = ":buffer-close!";
    "w" = ":write!";
    "o" = ":buffer-close-others!";
  };
  bufferMinorModeSticky = [
    "q"
    "w"
    "["
    "]"
  ];
  longWordMinorMode = {
    "[" = "move_prev_long_word_start";
    "{" = "move_prev_long_word_end";
    "]" = "move_next_long_word_end";
    "}" = "move_next_long_word_start";
  };
  longWordMinorModeSticky = [
    "["
    "{"
    "]"
    "}"
  ];
  wordMinorMode = {
    "[" = "move_prev_word_start";
    "{" = "move_prev_word_end";
    "]" = "move_next_word_end";
    "}" = "move_next_word_start";
  };
  wordMinorModeSticky = [
    "["
    "{"
    "]"
    "}"
  ];
  subWordMinorMode = {
    "[" = "move_prev_sub_word_start";
    "{" = "move_prev_sub_word_end";
    "]" = "move_next_sub_word_end";
    "}" = "move_next_sub_word_start";
  };
  subWordMinorModeSticky = [
    "["
    "{"
    "]"
    "}"
  ];
  replaceMinorMode = {
    "q" = "@s}<S-w>rr";
    "w" = "@s}wrr";
    "r" = "change_selection_noyank";
    "y" = "change_selection";
    "p" = "replace_with_yanked";
    "s" = "surround_replace";
    "h" = [
      "collapse_selection"
      "extend_to_first_nonwhitespace"
      "change_selection_noyank"
    ];
    "l" = [
      "collapse_selection"
      "extend_to_line_end"
      "change_selection_noyank"
    ];
    "x" = [
      "collapse_selection"
      "extend_to_line_bounds"
      "change_selection_noyank"
    ];
    "c" = "replace";
  };
  treeMinorMode = {
    "[" = "select_prev_sibling";
    "]" = "select_next_sibling";
    "{" = "expand_selection";
    "}" = "shrink_selection";
    "h" = "move_parent_node_start";
    "l" = "move_parent_node_end";
  };
  treeMinorModeSticky = [
    "["
    "]"
    "{"
    "}"
    "h"
    "l"
  ];
  undoMinorMode = {
    "[" = "undo";
    "{" = "earlier";
    "]" = "redo";
    "}" = "later";
  };
  undoMinorModeSticky = [
    "["
    "{"
    "]"
    "}"
  ];
  insertMinorMode = {
    "[" = "insert_mode";
    "{" = "open_above";
    "s" = "surround_add";
    "h" = "insert_at_line_start";
    "l" = "insert_at_line_end";
    "]" = "append_mode";
    "}" = "open_below";
    "down" = "add_newline_below";
    "up" = "add_newline_above";
  };
  pasteMinorMode = {
    "[" = "paste_before";
    "h" = [
      "goto_first_nonwhitespace"
      "paste_before"
    ];
    "l" = [
      "goto_line_end"
      "paste_after"
    ];
    "]" = "paste_after";
  };
  pasteMinorModeSticky = [
    "["
    "h"
    "l"
    "]"
  ];
  prevImpairMinorMode = {
    "tab" = "goto_prev_tabstop";
    "e" = "goto_prev_entry";
    "t" = "goto_prev_class";
    "S-t" = "goto_prev_test";
    "p" = "goto_prev_paragraph";
    "a" = "goto_prev_parameter";
    "d" = "goto_prev_diag";
    "f" = "goto_prev_function";
    "g" = "goto_prev_change";
    "c" = "goto_prev_comment";
  };
  prevImpairMinorModeExpansion = {
    "d" = "goto_first_diag";
    "g" = "goto_first_change";
  };
  selectionMinorMode = {
    "q" = "@s}<S-w>";
    "w" = "@s}w";
    "{" = "select_textobject_around";
    "}" = "select_textobject_inner";
    "x" = "extend_to_line_bounds";
    "h" = [
      "ensure_selections_forward"
      "flip_selections"
      "extend_to_first_nonwhitespace"
    ];
    "j" = "join_selections";
    "l" = [
      "ensure_selections_forward"
      "extend_to_line_end"
    ];
    "\\" = "ensure_selections_forward";
  };
  selectionMinorModeExpansion = {
    "h" = "extend_to_line_start";
    "l" = "extend_to_line_end_newline";
    "x" = "shrink_to_line_bounds";
  };
  deleteMinorMode = {
    "q" = "@s}<S-w>dd";
    "w" = "@s}wdd";
    "y" = "delete_selection";
    "s" = "surround_delete";
    "d" = "delete_selection_noyank";
    "h" = "kill_to_line_start";
    "l" = "kill_to_line_end";
    "x" = [
      "collapse_selection"
      "extend_to_line_bounds"
      "delete_selection_noyank"
    ];
    "backspace" = "delete_word_backward";
    "del" = "delete_word_forward";
  };
  findMinorMode = {
    "[" = "till_prev_char";
    "{" = "find_prev_char";
    "]" = "find_till_char";
    "}" = "find_next_char";
  };
  gotoMinorMode = {
    "w" = "goto_word";
    "r" = "goto_reference";
    "t" = "goto_type_definition";
    "i" = "goto_implementation";
    "s" = "match_brackets";
    "d" = "goto_definition";
    "h" = "goto_first_nonwhitespace";
    "j" = "move_line_down";
    "k" = "move_line_up";
    "l" = "goto_line_end";
    "x" = "goto_window_center";
    "." = "goto_last_modification";
    "ret" = "goto_line";
    "down" = "goto_window_bottom";
    "up" = "goto_window_top";
  };
  gotoMinorModeExpansion = {
    "d" = "goto_declaration";
    "h" = "goto_line_start";
    "j" = "goto_last_line";
    "k" = "goto_file_start";
    "l" = "goto_line_end_newline";
  };
  nextImpairMinorMode = {
    "tab" = "goto_next_tabstop";
    "e" = "goto_next_entry";
    "t" = "goto_next_class";
    "S-t" = "goto_next_test";
    "p" = "goto_next_paragraph";
    "a" = "goto_next_parameter";
    "d" = "goto_next_diag";
    "f" = "goto_next_function";
    "g" = "goto_next_change";
    "c" = "goto_next_comment";
  };
  nextImpairMinorModeExpansion = {
    "d" = "goto_last_diag";
    "g" = "goto_last_change";
  };
  viewMinorMode = {
    "y" = "align_view_middle";
    "j" = "page_cursor_half_down";
    "k" = "page_cursor_half_up";
    "x" = "align_view_center";
    "up" = "align_view_bottom";
    "down" = "align_view_top";
  };
  viewMinorModeSticky = [
    "j"
    "k"
  ];
  cursorMinorMode = {
    "(" = "rotate_selection_contents_backward";
    ")" = "rotate_selection_contents_forward";
    "y" = "yank_joined";
    "{" = "select_all_siblings";
    "f" = "keep_selections";
    "j" = "join_selections_space";
    "}" = "select_all_children";
    "\\" = "reverse_selection_contents";
    "|" = "align_selections";
    "x" = "split_selection_on_newline";
    "m" = "merge_selections";
    "," = "remove_primary_selection";
    "space" = "split_selection";
    "ret" = "select_regex";
    "down" = "copy_selection_on_next_line";
    "up" = "copy_selection_on_prev_line";
  };
  cursorMinorModeExpansion = {
    "f" = "remove_selections";
    "m" = "merge_consecutive_selections";
  };
  cursorMinorModeSticky = [
    "("
    ")"
    "down"
    "up"
  ];
  windowMinorMode = {
    "q" = "wclose";
    "t" = "transpose_view";
    "y" = "vsplit";
    "o" = "wonly";
    "[" = "rotate_view_reverse";
    "]" = "rotate_view";
    "h" = "jump_view_left";
    "S-h" = "swap_view_left";
    "j" = "jump_view_down";
    "S-j" = "swap_view_down";
    "k" = "jump_view_up";
    "S-k" = "swap_view_up";
    "l" = "jump_view_right";
    "S-l" = "swap_view_right";
    "x" = "hsplit";
  };
  windowMinorModeSticky = [
    "q"
    "y"
    "["
    "]"
    "h"
    "S-h"
    "j"
    "S-j"
    "k"
    "S-k"
    "l"
    "S-l"
    "x"
  ];
  jumpMinorMode = {
    "w" = "save_selection";
    "[" = "jump_backward";
    "]" = "jump_forward";
  };
  jumpMinorModeSticky = [
    "["
    "]"
  ];
  macroMinorMode = {
    "w" = "record_macro";
    "m" = "replay_macro";
  };
  searchMinorMode = {
    "w" = "make_search_word_bounded";
    "y" = "search_selection";
    "[" = "search_prev";
    "j" = "search";
    "k" = "rsearch";
    "]" = "search_next";
  };
  searchMinorModeSticky = [
    "["
    "]"
  ];
  caseMinorMode = {
    "minus" = "switch_to_lowercase";
    "+" = "switch_to_uppercase";
    "\\" = "switch_case";
  };
  spaceMinorMode = {
    "'" = "last_picker";
    "tab" = "file_picker_in_current_buffer_directory";
    "q" = ":quit";
    "w" = ":write-all";
    "r" = ":reload-all";
    "n" = "jumplist_picker";
    "s" = "symbol_picker";
    "d" = "diagnostics_picker";
    "g" = "changed_file_picker";
    "," = "file_picker";
    "." = "file_picker_in_current_directory";
    "/" = "global_search";
    "?" = "command_palette";
  };
  spaceMinorModeCommand = {
    "r" = "@:sh rm -r <C-r>%";
    "o" = "@:open <C-r>%";
    "s" = "@:sh ln -s <C-r>% <C-r>%";
    "g" = "@:cd <C-r>%";
    "c" = "@:sh cp <C-r>% <C-r>%";
    "m" = "@:mv <C-r>%";
  };
  spaceMinorModeExpansion = {
    "q" = ":quit!";
    "w" = ":write-all!";
    "s" = "workspace_symbol_picker";
    "d" = "workspace_diagnostics_picker";
  };
  configMinorMode = {
    "i" = ":toggle-option lsp.display-inlay-hints";
    "s" = ":toggle-option auto-pairs";
    "d" = [
      ":toggle-option inline-diagnostics.other-lines disable hint"
      ":toggle-option inline-diagnostics.cursor-line disable hint"
    ];
    "x" = ":toggle-option soft-wrap.enable";
    "/" = ":toggle-option search.smart-case";
    "ret" = ":open ~/nix/";
  };

  setStickyMinorModes =
    let
      buildStickyBindings =
        stickyMinorModeKey: minorModeKey: bindings:
        bindings
        |> builtins.attrNames
        |> map (name: {
          inherit name;
          value = "@<${minorModeKey}><${name}><${stickyMinorModeKey}>";
        })
        |> lib.listToAttrs;
    in
    stickyMinorModes: baseBindings:
    stickyMinorModes
    |> lib.mapAttrs (
      stickyMinorModeKey:
      { minorModeKey, setSticky }:
      buildStickyBindings stickyMinorModeKey minorModeKey setSticky
    )
    |> lib.recursiveUpdate baseBindings;

  convertMovementToSelect =
    string:
    let
      commandMap = {
        "move_char_left" = "extend_char_left";
        "move_visual_line_down" = "extend_visual_line_down";
        "move_visual_line_up" = "extend_visual_line_up";
        "move_char_right" = "extend_char_right";
        "move_line_down" = "extend_line_down";
        "move_line_up" = "extend_line_up";
        "move_prev_long_word_start" = "extend_prev_long_word_start";
        "move_next_long_word_start" = "extend_next_long_word_start";
        "move_prev_long_word_end" = "extend_prev_long_word_end";
        "move_next_long_word_end" = "extend_next_long_word_end";
        "move_prev_sub_word_start" = "extend_prev_sub_word_start";
        "move_next_sub_word_start" = "extend_next_sub_word_start";
        "move_prev_sub_word_end" = "extend_prev_sub_word_end";
        "move_next_sub_word_end" = "extend_next_sub_word_end";
        "move_prev_word_start" = "extend_prev_word_start";
        "move_next_word_start" = "extend_next_word_start";
        "move_prev_word_end" = "extend_prev_word_end";
        "move_next_word_end" = "extend_next_word_end";
        "move_parent_node_start" = "extend_parent_node_start";
        "move_parent_node_end" = "extend_parent_node_end";
        "goto_first_nonwhitespace" = "extend_to_first_nonwhitespace";
        "goto_line_end" = "extend_to_line_end";
        "find_next_char" = "extend_next_char";
        "find_prev_char" = "extend_prev_char";
        "find_till_char" = "extend_till_char";
        "till_prev_char" = "extend_till_prev_char";
        "goto_word" = "extend_to_word";
        "goto_line_start" = "extend_to_line_start";
        "goto_line_end_newline" = "extend_to_line_end_newline";
        "search_next" = "extend_search_next";
        "search_prev" = "extend_search_prev";
      };
    in
    commandMap.${string} or string;

  convertBindingsToSelect =
    value:
    if builtins.isString value then
      convertMovementToSelect value
    else if builtins.isList value then
      map convertMovementToSelect value
    else if builtins.isAttrs value then
      lib.mapAttrs (_: convertBindingsToSelect) value
    else
      value;

  normal =
    normalMode
    // {
      "=" = languageMinorMode // {
        "=" = languageMinorModeExpansion;
      };
      "tab" = bufferMinorMode // {
        "tab" = bufferMinorModeExpansion;
      };
      "q" = longWordMinorMode;
      "w" = wordMinorMode;
      "e" = subWordMinorMode;
      "r" = replaceMinorMode;
      "t" = treeMinorMode;
      "u" = undoMinorMode;
      "o" = insertMinorMode;
      "p" = pasteMinorMode;
      "[" = prevImpairMinorMode // {
        "[" = prevImpairMinorModeExpansion;
      };
      "s" = selectionMinorMode // {
        "s" = selectionMinorModeExpansion;
      };
      "d" = deleteMinorMode;
      "f" = findMinorMode;
      "g" = gotoMinorMode // {
        "g" = gotoMinorModeExpansion;
      };
      "ç" = insertMinorMode;
      "]" = nextImpairMinorMode // {
        "]" = nextImpairMinorModeExpansion;
      };
      "z" = viewMinorMode;
      "c" = cursorMinorMode // {
        "c" = cursorMinorModeExpansion;
      };
      "b" = windowMinorMode;
      "n" = jumpMinorMode;
      "m" = macroMinorMode;
      "/" = searchMinorMode;
      "°" = caseMinorMode;
      "space" = spaceMinorMode // {
        ":" = spaceMinorModeCommand;
        "space" = spaceMinorModeExpansion;
      };
      "end" = configMinorMode;
    }
    |> setStickyMinorModes (
      let
        listToNullAttrs =
          list:
          list
          |> map (string: {
            name = string;
            value = null;
          })
          |> lib.listToAttrs;
      in
      {
        "S-tab" = {
          minorModeKey = "tab";
          setSticky = listToNullAttrs bufferMinorModeSticky;
        };
        "S-q" = {
          minorModeKey = "q";
          setSticky = listToNullAttrs longWordMinorModeSticky;
        };
        "S-w" = {
          minorModeKey = "w";
          setSticky = listToNullAttrs wordMinorModeSticky;
        };
        "S-e" = {
          minorModeKey = "e";
          setSticky = listToNullAttrs subWordMinorModeSticky;
        };
        "S-t" = {
          minorModeKey = "t";
          setSticky = listToNullAttrs treeMinorModeSticky;
        };
        "S-u" = {
          minorModeKey = "u";
          setSticky = listToNullAttrs undoMinorModeSticky;
        };
        "S-p" = {
          minorModeKey = "p";
          setSticky = listToNullAttrs pasteMinorModeSticky;
        };
        "S-z" = {
          minorModeKey = "z";
          setSticky = listToNullAttrs viewMinorModeSticky;
        };
        "S-c" = {
          minorModeKey = "c";
          setSticky = listToNullAttrs cursorMinorModeSticky;
        };
        "S-b" = {
          minorModeKey = "b";
          setSticky = listToNullAttrs windowMinorModeSticky;
        };
        "S-n" = {
          minorModeKey = "n";
          setSticky = listToNullAttrs jumpMinorModeSticky;
        };
        "?" = {
          minorModeKey = "/";
          setSticky = listToNullAttrs searchMinorModeSticky;
        };
      }
    );
  insert = {
    "esc" = "normal_mode";
    "tab" = "smart_tab";
    "S-tab" = "insert_tab";
    "A-u" = "commit_undo_checkpoint";
    "A-o" = "normal_mode";
    "A-p" = "insert_register";
    "A-h" = "move_char_left";
    "A-j" = "move_visual_line_down";
    "A-k" = "move_visual_line_up";
    "A-l" = "move_char_right";
    "A-ç" = "normal_mode";
    "A-x" = "completion";
    "A-m" = "record_macro";
    "A-/" = [
      "align_view_top"
      "hover"
    ];
    "ret" = "insert_newline";
    "A-?" = "signature_help";
    "backspace" = "delete_char_backward";
    "S-backspace" = "delete_char_backward";
    "A-backspace" = "delete_word_backward";
    "del" = "delete_char_forward";
    "S-del" = "delete_char_forward";
    "A-del" = "delete_word_forward";
    "down" = "scroll_down";
    "up" = "scroll_up";
  };
  select = convertBindingsToSelect normal // {
    "v" = "exit_select_mode";
  };

  cleared-default-bindings = import "${config.home.homeDirectory}/nix/assets/helix/cleared-default-bindings.nix";
in
{
  config = lib.mkIf config.mods.helix.enable {
    programs.helix.settings.keys = lib.recursiveUpdate cleared-default-bindings {
      inherit normal insert select;
    };
  };
}
