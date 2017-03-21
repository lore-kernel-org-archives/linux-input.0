From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] Documentation: Input: Add uinput documentation
Date: Tue, 21 Mar 2017 12:28:09 -0300
Message-ID: <20170321152808.GA22262@builder>
References: <20170322025820.4108-1-marcos.souza.org@gmail.com>
 <20170322025820.4108-2-marcos.souza.org@gmail.com>
 <20170322040331.GA7293@jelly>
 <20170323025446.GA10447@xfiles>
 <20170323032356.GA10860@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323032356.GA10860@jelly>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 23, 2017 at 01:23:56PM +1000, Peter Hutterer wrote:
> On Wed, Mar 22, 2017 at 11:54:48PM -0300, Marcos Paulo de Souza wrote:
> > Hi Peter,
> > 
> > first of all, thanks a lot for reading this patch so quickly and to
> > point a lot of things to make this doc way better.
> > 
> > See some notes below.
> 
> thanks for all the fixes, much appreciated.
> just two comments below:
> 
> > On Wed, Mar 22, 2017 at 02:03:31PM +1000, Peter Hutterer wrote:
> [...]
> > > > +        memset(&ie, 0, sizeof(ie));
> > > > +        ie.type = type;
> > > > +        ie.code = code;
> > > > +        ie.value = val;
> > > > +
> > > 
> > > memset followed by three out of five filled in seems strange. Just add
> > >       ie.time.tv_sec = 0;
> > >       ie.time.tv_usec = 0;
> > > 
> > > ideally, with a comment that states that the timestamp is ignored :)
> > 
> > All the code in this doc is the result of my tests using uinput, so
> > somethings were set in my code some time ago and were never touched
> > again. Yes, this makes things a way better :)
> 
> note that if we ship this as documentation, these become the official
> examples so they *have* to be correct. How many times have you copied
> something from the examples of a library? Not ideal if there's a bug or just
> messy code to begin with :)

I think there is a misunderstanding :)

I didn't just copied the code, I built it using other's code as
reference, and it's working. What I meant was, once the initialization
code worked, I just took it and used and other samples.

I do hope this code can help others like me who would like to test
uinput :)

> > I fixed a lot of things today, the things that are still missing are the
> > libevdev example, and the version check. I do think that I can send a
> > new version tomorrow.
> 
> As for libevdev: just add a link to the documentation, don't add a libevdev
> example. libevdev should (and does) provide the examples and you don't want
> to ship example code that relies on some other library' API.

OK, good enough. Will work on itand send a new version with the
suggested changes.

Thanks,
	Marcos

> 
> Cheers,
>    Peter
