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

> How do we convince people that in programming simplicity and clarity — in short: what mathematicians call "elegance"— are not a
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

**In short: Ensure true combineabiltity to create meaningful abstractions!**

For technical progress as a whole this promise seems to hold true.
But up to today i think this didn't work out for programming environments: Neither did I ever get this "ever increasing speed' nor did i ever find an environment truly made for it. Perhaps such a thing is just impossible or to  hard to do and there is nothing to hope for.

Another explanation may be, that combineability wasn't assessed at its true worth and never taken seriously enough. Maybe the YAGNI-principle ("You Ain't Gonna Need It") worked too well and a huge amount of work towards simplicity deemed not appropriate.

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
