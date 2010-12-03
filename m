From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 22:27:45 +0000
Message-ID: <20101203222744.GA15995@opensource.wolfsonmicro.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
 <20101203124240.GH3182@sirena.org.uk>
 <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
 <20101203135346.GI3182@sirena.org.uk>
 <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
 <20101203185250.GA730@opensource.wolfsonmicro.com>
 <AANLkTimG0t-1e1s+t-ytXf7e-ZpXFq32C_XVZY6vh59n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45439 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752527Ab0LCW1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Dec 2010 17:27:35 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimG0t-1e1s+t-ytXf7e-ZpXFq32C_XVZY6vh59n@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 01:41:37PM -0600, Bill Gatliff wrote:
> On Fri, Dec 3, 2010 at 12:52 PM, Mark Brown

I'm only going to reply to a couple of specific things that weren't
covered in what Dimitry said here:

> It isn't a hypothetical situation: as far as I can tell right now,
> most Android ports are already pacing their input device sampling in
> userspace already.  That in itself doesn't justify implementing the
> read callback, but it does suggest that there are situations (ok, at
> least one) where users can truly benefit from that control.

When looking at Android phones it's important to remember how these
things are typically made: Android devices are put together by teams
that frequently have little prior Linux experience, and are often
produced under great time pressure.  They're a great source of data
about problems people are experiencing but you do have to really look
to make sure you're addressing the root problem.

For example, in this case I would imagine that the thought process of
people implementing the code you're looking at is something like "The
data is coming in too quickly.  How can I slow it down?  Oh, I can't.
Well, I'll just slow down my reading and worry about it later if that
turns out to be a problem.".  It's most likely to be the lack of any
current way to manage the data flow that is the underlying problem here,
the implementations are just a convenient way for applications to bodge
around the problem with the limited tools available to them.

> > Right, and what I'm saying is that userspace should just say what rate
> > it wants and then get that.

> We're mostly in violent agreement here.  :)  We just differ in how the
> application communicates the desired rate to the interface.  I'm not
> sure that the two approaches are mutually-exclusive.

I think they are; as Dimitry said in much more detail than me your
approach alters the blocking behaviour of the API for drivers using it
in a way that breaks expected behviour.

> > For a devices like touchscreens driving the reads from the application
> > would typically be a 50-100% overhead on the I/O costs and involves
> > blocking the application while the conversion happens, neither of which
> > seems desirable.

> So a touch controller driver probably isn't going to bother with the
> read callback.

On the other hand a touch controller really can use rate control - the
data rate required for handwriting recognition of Asian languages is
much greater than that required for pushing buttons.

> > Assuming the applications are behaving as you describe and not blocking
> > waiting for data - I'd expect that if they block waiting for data they'd
> > also end up seeing data delievered much faster.

> Even in my read callback implementation, the application still always
> gets blocked until a sample shows up in the event FIFO.  The read
> callback just gives a driver a chance to know when the application is
> desiring another sample.

Consider an application written like evtest: it sits and blocks waiting
for data by calling read() (realistically in a thread).  With the
current model drivers that can generate a continuous data stream will
rate limit it to something tasteful.  If read() is a trigger for
generating a new sample then the application will instead cause data to
be generated as fast as the hardware is capable of doing so.  This is
before you get to the issues with buffer sizes that Dimitry mentioned.

Consider also what happens when an application that blocks waiting for
data gets woken up and does a read().

> > Perhaps I'm missing something here but my experience has always been
> > that having to worry about time periods adds rather than removes
> > complexity in applications

> True.  But in this case, the code on the application side is already
> there: a pthread running a while(1) loop with an msleep.  Ugly to
> some, but it works.

As someone working in embedded systems I'm sure you're aware of the
unfortunate space between "makes the system behave" and "good design
idea" - the ugly to some bit's a really issue here.
