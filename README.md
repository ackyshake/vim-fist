# Fist of Vim
Fast, simple and super awesome Gist-ing for Vim.

<sub>If there were any more superlatives, I would be charging for this!</sub>

## Dependencies
- [gist command line tool](https://github.com/defunkt/gist.git)

Install and configure it by running:

    [sudo] gem install gist && gist --login

## Install
If you don't have a preferred installation method, I recommend installing
[pathogen.vim](https://github.com/tpope/vim-pathogen), and then simply copy and
paste:

    cd ~/.vim/bundle && git clone git://github.com/ajh17/vim-fist.git

Once the helptags have been generated, see `:h vim-fist` for usage.

## Usage
Only breathing is easier than using Fist of Vim. Nevertheless:

Fist of Vim defines two mappings:

`<leader>p` - Create a new gist

`<leader>u` - Update an existing gist

Fist of Vim also sets the filetype and syntax completely automatically without
you having to set it! Impressive, huh?

You can use Fist of Vim with a visual selection, or in normal mode, in which
case, it is motion based.

For example, in normal mode, `<leader>pG` will create a new gist from the
cursor to the end of file. In visual mode, simply visually select what you want
gisted and then hit `<leader>p` to create a new gist.

### Custom maps
To define your own set of mappings, simply create mappings for these functions:

`<plug>fov_new`           - Create a new gist

`<plug>fov_update`        - Update a gist

`<plug>fov_visual_new`    - Create a new gist (visual mode)

`<plug>fov_visual_update` - Update a gist (visual mode)

Example: `nmap <leader>f <plug>fov_new`


### Configuration
Fist of Vim offers these hilariously named variables so it can be configured to
your exacting standards:

`g:fist_anonymously`   - Creates a new anonymous gist.

`g:fist_opens_browser` - Open the gist in the browser automatically.

`g:fist_in_private`    - Create a secret gist


## FAQ
> What is the deal with the name "Fist"?

Taken from <i>"<b>F</b>ast G<b>ist</b> for Vim that is simply the bee's
knees"</i>. Or because "Gisty" was too good and was already taken. Or because
the Author racked his brain and couldn't think of anything else. You get to
decide! Either way, Fist of Vim was born!


## License
Copyright (c) Akshay Hegde. Distributed under the same terms as Vim itself. See
`:help license`
