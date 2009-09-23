From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 16:05:43 -0700
Message-ID: <200909231605.43733.david-b@pacbell.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <200909231229.07403.david-b@pacbell.net> <20090923195113.GA16265@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n19.bullet.mail.mud.yahoo.com ([68.142.206.146]:48797 "HELO
	n19.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751053AbZIWXFl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 19:05:41 -0400
In-Reply-To: <20090923195113.GA16265@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Greg KH <gregkh@suse.de>

On Wednesday 23 September 2009, Dmitry Torokhov wrote:
> This is one possible design... however you are not talking about the
> current Linux kernel but some other OS.

What other OS might it be then, which has carried around
that exit section scrubbing mechanism for quite a few years
now, and is distributed through www.kernel.org with labels
such as "Linux 2.6.31" ???


> > And thus, if any code is presuming that *every* driver
> > can be unbound, it's wrong.
> > 
> > As I said:  bug in other code.
> 
> Not an implementation bug, the system behaves as designed.

Yes, absolutely an implementation bug.

At best you can say that there are two "designs" that
are in conflict with each other.  And argue, for some
reason, that the relatively-recently-introduced oops
(OK, mid-2005, so it's been lurking for quite a while)
is "more intended" than the previous safe-no-oops one
(predating mid-2005 by many years).


> > Looking at this a bit more, it seems like there will need
> > to be some "can this bus remove this driver" check, since
> > the struct device.remove method is now managed at the bus
> > level.  Easy enough to do instead of the null check that
> > I mentioned below.  Provide it for platform bus, and the
> > main potential trouble spots will be resolved.
> 
> 		... deletia ...
> 

> I am talking about current design of the Linux driver code, as it is
> present in mainline and in this particular instance probe() and remove()
> do not do what you think they do. 

You're arguing about what it "should" do, and ignoring
all the evidence I've provided.  So I guess "talking"
is right, not "listening" or better yet "discussing".


> Look, this is all great, you are coming with wonderful new design that
> will surely fix all issues embedded developers have here. But until it
> is in mainline here is my perspective:

No, I'm just pointing out how the system has been intended
to behave *FOR MANY YEARS NOW* and you are objecting because
of a bug in some unrelated and newer code.


> > > > 		That's why the __exit_p() -- or for
> > > > hotpluggable drivers, __devexit_p() -- macros exist:
> > > > for that particular case.
> > > 
> > > Huh? They are here so that the linker/module loader can discard them if
> > > they only referenced via driver pointers and we know they not going to
> > > be called.
> > 
> > Finish that thought.  What "exit" section code fits those
> > categories?  Driver remove() methods ... and not much else.
> > And for that matter, what else goes into exit sections,
> > other than such code and module hooks to call it?
> > 
> > That discarding of exit sections has been around in Linux
> > for an extremely long time, at least on architectures which
> > lean more towards embedded systems than bloat-is-OK servers.
> > It's applied to driver remove methods, and to the code which
> > invokes them via rmmod.
> > 
> > Note that your comments all seem to presume that such
> > discarding is either useless or should be phased out for
> > some reason ... but you're not quite making *that*
> > argument.
> >
> 
> Umm, no, I did not say that.

As I said, your comments *presumed* that.  As in,
they don't seem to make a lot of sense otherwise.

If that "discard exit sections" is a longstanding
part of Linux (as it is), then using it in normal
ways wouldn't be the problem ... instead of saying
that it *is* the problem, you'd be digging deeper.


> You implied that __exit_p and __devexit_p 
> have something to do with setting remove to NULL but that is not their
> main purpose. 

It's what they have *done* since quite a few years
before the driver model existed.  Saying that what
they *do* is somehow not their main purpose ... isn't
very useful, as arguments go.


> They are needed so that references are gone, but we could 
> just as easily be using (void *)1 instead of NULL as substitute value.

Except that NULL function pointers are valid for
purposes other than calling through them, and at
least one universal idiom relies on them:  test
pointer against NULL before using.

Where in Linux is there code checking against
indirection through "(void *)1)" instead of NULL??

- Dave

