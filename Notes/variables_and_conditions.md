## Variables + String interpolation

```
$some_name     = 'Bob'
$some_greeting = "Hello ${some_name}" 
```
Double quotes allow string interpolation using the dollar sign followed by the variable name between curly braces. The convention is to only use double quotes when you need to use the interpolation, and to use single quotes for all other strings.

## Other Data Types
```
$some_boolean = true
$some_number  = 3
$some_array   = [1, 2, $some_number, 4, 5]
$some_hash    = {
  $name            = 'Bob',
  $employee_number = 5
}
```
You can assign array to define resources:
```
$userlist = ['alice', 'bob', 'carol']

user { $userlist:
  ensure => present
}
```

## If/Else
```
if $some_boolean {
  include example_class
} else {
  include another_class
}
```
If/else is a conditional that uses the truthiness of a variable to make a decision. I say "truthiness" because any non-empty variable in Puppet will evaluate as true. This is fairly convenient, because you can easily do things like check if a parameter has been set. But it has one major gotcha to watch out for. The string "false," surrounded by quotes, is a truthy value. This example is an if/else block, and the example code is a pretty good model for how you would try to use these in your Puppet code.

## Unless
```
unless $some_number > 10 {
  include small_number_class
} else {
  include large_number_class
}
```
It's just an inverted "If," so it only triggers if the condition evaluates to False.

$case
```
case $employee_name {
  'bob': { include easy_mode_tools }
  'carol', 'ben': { include expert_tools }
  'sue': { include regular_tools }
}
```
Lots of if statements checking the same variables can be confusing. Instead, you can just use the Case conditional. Case will match among multiple options. This example is a bit contrived, but imagine Bob is a sales rep, Sue is a junior engineer, and Carol and Ben are the senior engineers. This lets us install the right software for each user, without a lot of redundant if statements. If you have multiple matches for one of the code blocks, as in Carol and Ben, you can just use a comma separated list.

## Selectors
```
$default_editor = $facts['os']['family'] ? {
  'Linux'   => 'vim',
  'Windows' => 'notepad',
  default   => 'nano',
}
```
Selectors are similar to case statements, but are specifically for assigning variables. Of course, you could just use a case statement, where the variables are assigned to different values in each block, but that would have a lot of extra typing. The selector syntax is a bit unusual, so let's walk through it. First you have the variable you're assigning. Then an equal sign. After that, you have the condition that you're using. In this example, we're using the operating system family fact. After the condition, there's a question mark, and the curly braces around a list of key value pairs that specify what to assign the variable based on the condition you're checking. We've also included a default case here. You can use default in case statements as well. It will match whatever isn't caught further up in the selector or case statement.