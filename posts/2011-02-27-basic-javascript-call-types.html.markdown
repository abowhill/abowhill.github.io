---
layout: single
title: 'Basic Javascript call types'
tags: Javascript
---
Some of the hardest-to-understand things about Javascript are also some of the most basic concepts to any programming language. Take simple function declarations. Just input-output, parameters and an algorithm, right? Well, not quite. It's actually a bit more complicated.

Javascript is a dual-style language. You can program it procedurally, like C, or in an object-oriented manner, somewhat like Ruby or Perl. The basic function/class declaration takes the form:

~~~
function Name (parameter_list) { code_block }
~~~~~
<p/>

The form above is really just syntactic sugar for function pointer assignment syntax:

~~~ javascript
var Name = function (parameter_list) { code_block }
~~~~~
<p/>

Name is an alias for an anonymous function pointer. Furthermore, every object instance in Javascript is more or less equivalent to assignment of a simple anonymous hash table:

~~~ javascript
var Name = { code_block }
~~~~~
<p/>

Above, we create an object called Name. There is no prototype (ancestral shadow object) attached to Name, as you would normally get if you used new() (which you can't with a hash), but member methods and properties assigned inline or posthumously will function just as if they were part of an object.

Similarly, a function declaration also doubles as a class declaration in Javascript:

~~~ javascript
// namespace collision wrapper START
(function () {

/* this is our dual class/function */

function Klass(param) 
   {
   this.inline_property = "I'm an inline_property.";
   this.inline_method   = function () 
      { 
      return "I'm an inline_method."; 
      }
   return "I'm a return value.";
   };

/*********************************/
/* add some members posthumously */
/*********************************/

/* Add static members to Klass */

Klass.static_property = "I'm a static_property."; 

Klass.static_method   = function ()
   { 
   return "I'm a static_method."; 
   } 

/* Add instance members to all objects created from Klass */

Klass.prototype.instance_property = "I'm an instance_property."; 

Klass.prototype.instance_method = function foo()
   { 
   return "I'm an instance_method."; 
   }

/**********************************************************/
/* Now let's see the different types of calls we can make */
/**********************************************************/

var d = document;

/* call as a plain old function */
d.write ("[Call as a function]<p>");

// prints "I'm a return value."
d.write ( Klass("parameter") + "<p>");

/* call as a static Class */
d.write ("[Call as a static class]<p>");

// prints "I'm a static_property."
d.write ( Klass.static_property + "<p>");

// prints "I'm a static_method."
d.write ( Klass.static_method() + "<p>");

/* call as an instance of Klass (an object) */
d.write ("[Call as an Object]<p>");

K = new Klass();

// prints "I'm an inline_property"
d.write ( K.inline_property + "<p>");

// prints "I'm an inline_method"
d.write ( K.inline_method() + "<p>");

// prints "I'm an instance_property"
d.write ( K.instance_property + "<p>");

// prints "I'm an instance_method"
d.write ( K.instance_method() + "<p>");

}) (); // namespace collision wrapper END
~~~~~
<p/>

The point of the code above is to show that a function declaration can double as a class declaration. If the function Name (or Class Name) is new()-ed, it has nearly the full capability of an object. So not only is an object mostly interchangeable with a hash, but a class is mostly interchangeable with a function.

~~~
Class <=> Function and Object <=> Hash
~~~~~~
<p/>


How's that for confusing? Little old Javascript is not as simple as it seems!
