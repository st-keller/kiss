<img src="/images/lips.png?raw=true">

## The KISS Principle

> KISS - "Keep it simple stupid."
>
> -- a design principle noted by the U.S. Navy in 1960

### What does Dijkstra say?

If Dijkstra was right (and who dares to object that), simplicity seems to be a "crucial matter" in programming:

> Simplicity is prerequisite for reliability.
>
> -- Dijkstra (1975) [How do we tell truths that might hurt?](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD04xx/EWD498.html) (EWD498)

> Simplicity is a great virtue but it requires hard work to achieve it and education to appreciate it. And to make matters worse:
> complexity sells better.
>
> -- Dijkstra (1984) [On the nature of Computing Science](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD896.html) (EWD896).

> How do we convince people that in programming simplicity and clarity —in short: what mathematicians call "elegance"— are not a
> dispensable luxury, but a crucial matter that decides between success and failure?
>
> -- Dijkstra [Why is software so expensive?](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD06xx/EWD648.html) (EWD648).

Simplicity is at the heart of the KISS Principle (every known version of the KISS-Acronym contains the word "simple").
So maybe, KISS is the most important programming principle out there.

### Why Shoud I Care?

If you've read your SICP ("Structure and Interpretation of Computer Programs") book (and if you haven't you definitly [should](https://mitpress.mit.edu/sicp/)), then you already know, that there are [three elements of programming](https://mitpress.mit.edu/sicp/full-text/sicp/book/node5.html): 

- **primitive expressions**, which represent the simplest entities the language is concerned with,
- **means of combination**, by which compound elements are built from simpler ones, and
- **means of abstraction**, by which compound elements can be named and manipulated as units.

The most important part without any doubt is the "abstraction". An abstraction is essential for higher level concepts, which in turn let us talk about things without  considering every single component they are made out of. The other two elements are those, you need to from an abstraction. And beacuse the primitve expressions are mostly already given, you have to put he most work and attentiveness into "combineability"!

If applied in the right way (read "not [leaky](https://en.wikipedia.org/wiki/Leaky_abstraction)"), abstractions should enable you to **"program exponentially"**: In an environment where everything you create can easily be combined with every other thing already existing (given the same abstraction-level) and where you can build a higher abstraction-Level without loosing combinability, every step you do take should help to the next step more effectivly. So it should give you an ever increasing development-speed.

In short: Ensure true combineabiltity to create meaningful abstractions!

For technical progress as a whole this promise seems to hold true. But up to today this didn't work out for programming environments: Neither did I ever get this "ever increasing speed' nor did i ever find such an environment.

Perhaps such a thing is just impossible and there is nothing to hope for.

An other explanation may be, that combineability wasn't assessed at its true worth and never taken seriously enough. Maybe the YAGNI-principle ("You Ain't Gonna Need It") worked too well and a huge amount of work towards simplicity deemed not appropriate.

But after all you can combine things freely if and only if you have truly simple building blocks at hand. That's exactly why we should care about simplicity!

> BTW: If you don't like to read SICP, you can watch the lessons on youtube instead. You can start with that one:
>
> [<img src="/images/sicp_lesson_1a.jpeg?raw=true">](https://www.youtube.com/watch?v=2Op3QLzMgSY)
>
> (Hal Abelson explains the three elements of programming (at [28:08](https://youtu.be/2Op3QLzMgSY?t=28m8s)) introducing them as "the most important thing in this course".)

### Simplicity ain't easy

Contrary to intuition, the meaning of the word "simple" is astoundingly difficult to nail down.
Fortunately there are two talks that can help a lot, to guide out of this mess:

1. [Simplicity Ain't Easy - Stuart Halloway](https://www.youtube.com/watch?v=cidchWg74Y4)

2. [Simple Made Easy - Rich Hickey](https://www.infoq.com/presentations/Simple-Made-Easy)

Both talks state that the true meaning of "simple" is **"not compound"** or - as Rich puts it - **"not complected"**.
This is clearly not how "simplicity" is usually understood: The KISS principle is often taken as a justification for "making things comprehensible ("easy to read") or to reduce the amount of constructs." 
But this is not what simplicity is about! If you try not to complect things, you should expect to need more things! And if you're not familiar to that kind of architecture, it will be more difficult to understand and to get right.

So probably the KISS Principle is not only the most important, but also the most misunderstood principle out there!

> Stay consistent and you will start a revolution.
>
> -- unknown


## The Journey

Equipped with trusted knowledge, we can start a journey. Wherever it will lead us - according to Dijkstra - we will face a lot of work and nearly no appreciation.
But if simplicity is such a great thing, we should be able to accomplish things we couldn't achieve before, and boldly go where no man has gone before.
And if we go astray, we can always step back or start anew.

What I ever wanted to do, is writing my own super-cool IDE. So why not?
What I certainly need for an IDE is a code editor. A code editor is quite complex so maybe I should start with a simple text-editor first.
But layouting text isn't simple either. So a lot more humble thing (even if embarrassingly unimpressive) has to come first.

For every step I'll try to do three things:
1. Write a program that shows something.
2. Extend the program so that a user may change what we created (remeber? We want build an editor!)
3. The KISS (refactor the program to ensure that everything is done in a "simple way").

Every journey starts with the ...

### First Step

What can our first very simple program look like?
Maybe one, that does only one thing?

Well that's not so easy:  Even if you try to build a program that does "nothing", most IDEs will create one with lot's of stuff around.

I will use Xcode 9 and Swift 4 (i never programmed something in Swift before - so i havn't got any habits doing it) and if you create a program for macOS it will have at least a menu and a window. Instead of trying to get rid of those, we'll just ignore the window and the menu and focus on the content of the window!

~~The most simple thing we can do is giving the window a certain background-color and provide means to change it.~~
Turns out that color is a complicated thing. And the already started second step ("displaying a symbol") is not a "second" but more a "tenth" step, because dealing with fonts and glyphs ain't easy either!

So we start anew.

And because we are on macOS, we already have CG ("CoreGraphics"), which defines our given "primitives" and the means of combination.
So the first thing we have to do is: Getting rid of all things starting with "CG". It's not that I don't like CoreGraphics (i think it's great, and what it does it does very well). But CG is a vendor-specific library, essentially made to draw things on a screen. It's not made to support higher-order concepts like the **lenght of a path**, **square angles** or a **bisectrix**.

First, we have define new "primitive elements". which we may call **drawables** (didn't find a better term).
These elements have no properties besides beeing drawables.

Then there may be a **stride**, which introduces properties like a "start", "end" and "length".

Then we'll be able to form a **path** ("paths are made by walking").
At this level we will start to talk about "colors", "path-width" and "filling".

And after that we will build **shapes** out of paths.
Shapes will introduce a  projection-matrix - a kind of a "geometry".
Additionaly it may be used as a host for something called an "anchor-point" and path-arrangement-rules.

That will be a lot of work - so let's see how this will turn out!

