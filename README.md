# Fist of Vim
Fast, simple and super awesome Gist-ing for Vim.

<sub>If there were any more superlatives, I would be charging for this!</sub>

## Dependencies
- [gist](https://github.com/defunkt/gist.git)


## Install
If you don't have a preferred installation method, I recommend installing
[pathogen.vim](https://github.com/tpope/vim-pathogen), and then simply copy and
paste:

    cd ~/.vim/bundle
    git clone git://github.com/ajh17/vim-fist.git

Once the helptags have been generated, see `:h vim-fist` for usage.


## Setup
First, you want to make sure you have the gist command line tool setup and
happy:

    [sudo] gem install gist
    gist --login

And you're done! Why are you still reading this? Go try out the Fist of Vim™!


## Usage
Only breathing is easier than using Fist of Vim. Nevertheless:

Fist of Vim defines two mappings:

`<leader>p` - Create a new gist

`<leader>u` - Update an existing gist (See `:h vim-fist` for usage)

You can use Fist of Vim with a visual selection, or in normal mode, in which
case, it is motion based.

For example `<leader>pG` will create a new gist from the cursor to the end of
file. See `:h motion.txt` for more motions.

## Configuration
Fist of Vim offers these variables so it can be configured to your exacting
standards:

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
