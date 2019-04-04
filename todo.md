Write everything in Haxe for now and then rewrite bits and pieces as needed can be compiled to other langs eg Java etc and run on  Graalvm if we need to share between languages

each part should be a seperate repo?? work out later how to break it up

eg folder for face, memory etc??? ears?

logo generated from http://www.patorjk.com/software/taag/#p=testall&f=Doh&t=Monica
Font ANSI Shadow


Alpha version don't use this for anything yet!


Consider compiling this to a electron app??

Means we can do cool gui stuff with file explorer etc 
Charts avatar etc, web speak. Could be hosted on a web server
or compiled to app using Ionic maybe

Default it is just the banner with input and output

Also means that hot reloading could possibly work

Invest in getting this to work somehow think its the only feasible way to have it be cross platform

TODO Seams how to handle classes, how ot do tests on private functs

            // todo make the app folder configurable


            // todo setup autocomplete for commands and argument values eg app image names

            // todo find a way to create the memory file on startup if not present

            // todo path expansion

            // todo environment setup based on config and versions

            // todo make a Github need to decide if public or private might make public to show off



            // support pip packages global npm packages maybe profiles common tools etc
            // multiple os es


<!-- place inside speak -->
        // todo on setup install espeak find a way to make it work for windows etc
        // todo fix speech so that it doesn't talk over itself and actually says good bye
        // todo fix it so that it doesn't print trash to terminal
        // todo make the voice sound nicer and less like a low quality Steven Hawking, preferrably female voice

        // to fix talking over self just lock execution somehow until first speech done
        // maybe process has a way to handle it????

        // espeak-ng provides more osses so might be a good cross platform way still sounds really robotic though
        // new sys.io.Process('espeak "$message"');
        // FREE TTS isn't much better not sure about Googles option maybe use Google if there is internet else fall back to local



Add in error handling for things like missing template values etc

<!-- colors? -->