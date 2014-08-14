## Shopping Receipts - A Ruby Console Application

Generate your shopping receipts for your shop with taxes applied as follows. 

* Sales Tax : 10% on all goods except books, food, and medical products. 
* Import Duty : 5% with no exemptions

Sales tax amount is rounded to the nearest 0.05.

Created in Ruby 2.1.2. 

Depends on the Active Support and Prawn gems. 

Displays the output in the terminal.

Gives you the option of generating text or PDF files as receipts. 

## Running the code

```shell
$ git clone https://github.com/santumahapatra/shopping-receipts-ruby
$ gem install activesupport
$ gem install prawn
$ ruby main.rb
```
## You can write plugins for more extension types

* Write a new file with 'format_' prefix.
* Initialise the extension type and display text in the @@extension hash.
* Rewrite the export method for the specific file type.