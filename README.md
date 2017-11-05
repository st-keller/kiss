<img src="/images/lips.png?raw=true">

## The KISS Principle

> KISS - "Keep it simple stupid."

> -- a design principle noted by the U.S. Navy in 1960

### Why Do We Care?

Well, if Dijkstra was right (and who dares to object that), simplicity seems to be a "crucial matter" in programming:

> Simplicity is prerequisite for reliability.

> -- Dijkstra (1975) [How do we tell truths that might hurt?](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD04xx/EWD498.html) (EWD498)

> How do we convince people that in programming simplicity and clarity —in short: what mathematicians call "elegance"— are not a
> dispensable luxury, but a crucial matter that decides between success and failure?

> -- Dijkstra [Why is software so expensive?](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD06xx/EWD648.html) (EWD648).

> Simplicity is a great virtue but it requires hard work to achieve it and education to appreciate it. And to make matters worse:
> complexity sells better.

> -- Dijkstra (1984) [On the nature of Computing Science](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD896.html) (EWD896).

Simplicity is at the heart of the KISS Principle (every known version of the KISS-Acronym contains the word "simple").
So maybe, KISS is the most important programming principle out there.

### Simplicity ain't easy

Contrary to intuition, the meaning of the word "simple" is astoundingliy difficult to nail down.
Fortunately there are two talks that help a lot to guide us out of this mess:

1. [Simplicity Ain't Easy - Stuart Halloway](https://www.youtube.com/watch?v=cidchWg74Y4)

2. [Simple Made Easy - Rich Hickey](https://www.infoq.com/presentations/Simple-Made-Easy)

These talks state that "simple" does mean "not compound" or - as Rich puts it - "not complected".
If we follow that, than maybe the KISS Principle is not only the most important, but also the most misunderstood principle out there. So let's take it seriously!

> Stay consistent and you will start a revolution.

> -- unknown


## The Journey

Equipped with trusted knowledge, we can start a journey now. Wherever it will lead us, according to Dijkstra we will face a lot of work and nearly no appreciation.
But if simplicity is such a great thing, we should be able to accomplish things we couldn't achieve before, and boldly go where no man has gone before.
And if we go astray, we can always step back or start anew.

What I ever wanted to do, is writing my own super-cool IDE. So why not?
What I certainly need for an IDE is a code editor. A code editor is quite complex so maybe I should start with a simple text-editor first.
But layouting text isn't simple either. So a lot more humble thing (even if embarrassingly unimpressive) has to come first.

For every step I'll try to do three things:
1. Write a program that shows something.
2. Extend the program so that a user may change what we show (remeber? We want build an editor!)
3. The KISS (refactor the program to ensure that everything is done in a "simple way").

Every journey starts with the ...

### First Step

What can our first very simple program look like?
Maybe one, that does only one thing?

Well that's not so easy:  Even if you try to build a program that does "nothing", most IDEs will create one with lot's of stuff around.

I will use Xcode 9 and Swift 4 (i never programmed something in Swift before - so i havn't got any habits doing it) and if you create a program for macOS it will have at least a menu and a window. Instead of trying to get rid of those, we'll just ignore the window and the menu and focus on the content of the window:
The most simple thing we can do is giving the window a certain background-color and provide means to change it.

So that's what will do as an impressive first step:

1.1: Creating a program that shows a window and set's it's background-color:

(Screencast "kiss_1_1" - coming soon)

1.2: Extending the program so that a user can chnage the background color!

(Screencast "kiss_1_2" - coming soon)

1.3: KISS it!

(Screencast "kiss_1_3" - coming soon)

For this kiss we take [re-frame](https://github.com/Day8/re-frame)'s approach of "Derived Values, Flowing" as an inspiration.
If you don't already know [re-frame](https://github.com/Day8/re-frame), take some time and take a deep dive into it's README - it's a long read but definitely worth every word!


### 2. Step

2.1 Display a shape

2.2 Let a user change the shape's properties

2.3 KISS it




