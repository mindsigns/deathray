# Deathray.tv 

Code for my personal [webmachine](https://github.com/basho/webmachine) based blog site, http://deathray.tv

## Setup

Requires Erlang 18.x or less.  You might need to use [Kerl](https://github.com/kerl/kerl).

**1. run it:**
```
make
./start.sh
```

**2. initialize the database:**
```erlang
db_tools:reset().
```

**3. posting entries:**
```
There is no web interface, instead it uses ssh/scp to upload files which get 
picked up by watchman.erl.
You scp or edit the priv/www/images/deathray.dat file to add posts to the blog.

example : deathray.dat
%% First line is the entry title
%% Second line is the post text
%% Third line is the optional image file name
{
"Welcome to deathray.tv",
"sample post",
"tv.jpg"
}.

Everytime this file gets updated, watchman will scan it and load it into the 
database.  You will need to add the corresponding image file to priv/www/images/ as well.
```

## License

[BSD](https://raw.githubusercontent.com/mindsigns/deathray/master/LICENSE)
