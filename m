From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 08:43:32 -0700
Message-ID: <20101006154331.GA28913@core.coreip.homeip.net>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
 <20101005174106.GA21399@core.coreip.homeip.net>
 <4CAC340B.90207@codeaurora.org>
 <33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
 <1286358518.26914.23.camel@4fid08082>
 <4CAC6053.5020000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56187 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab0JFPnm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 11:43:42 -0400
Received: by pwj5 with SMTP id 5so1748413pwj.19
        for <linux-input@vger.kernel.org>; Wed, 06 Oct 2010 08:43:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CAC6053.5020000@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: samu.p.onkalo@nokia.com, ext Sundar R IYER <sundar.iyer@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>

On Wed, Oct 06, 2010 at 05:11:07PM +0530, Trilok Soni wrote:
> Hi Samu,
> 
> On 10/6/2010 3:18 PM, Onkalo Samu wrote:
> > On Wed, 2010-10-06 at 10:56 +0200, ext Sundar R IYER wrote:
> >> Hi,
> >>
> >>> -----Original Message-----
> >>> From: Trilok Soni [mailto:tsoni@codeaurora.org]
> >>> Sent: Wednesday, October 06, 2010 2:02 PM
> >>>
> >>> I agree with Dmitry. Meego people or you should explain the real end-to-end
> >>> usecase first. Why it can't fit anywhere else?
> >>
> >> I don't know the full details; but what I can think of (or did I read it somewhere?)
> >> is events like phones with slider keypad; you can power save keypad controller
> >> when the keypad is not active. And these events are probably issued from the user
> >> space to the kernel and that's why the requirement probably. And I do remember
> >> Samu mentioning about unwanted wakeup events which were avoided via these switches.
> >>
> >> Adding Samu who can explain more on this.
> > 
> > This is how I see this issue
> > 
> > I tried to push enable / disable entries to generic input layer to avoid
> > driver specific controls. That was not accepted.
> > 
> > The need for keypad locking is not following any global PM transition.
> > In phones (like N900), global suspend / resume is not used at all. Phone
> > is running all the time. For example phone must be able to handle
> > incoming calls all the time. Instead suspend / resume, system is in deep
> > idle state as much as possible. Wake up from that takes couple of
> > milliseconds and everything is running again. Powers, clocks and any
> > extra activity must be turned off when ever possile depending on the
> > overall system state.
> > 
> > For input devices this means that keypad, touch controller etc. are
> > turned off or partially disabled for example when the screen is blanked.
> > Meanwhile system may still have other activity ongoing like mp3
> > playback. When the screen is off, there must be some way to tell to
> > touch controller that please turn off and save some power.

So exactly like I was saying it is all about the PM and thus input layer
is really the wrong place to solve this.

> >  This not
> > following pm transitions.

What do you mean? It may not follow system-whide PM transtitions but it
is per-device PM transition that I believe everyone wants to have
support for. You shut off devices individually and in subtrees when they
are not in use/needed.

> >  On the other hand, disable entry may trig
> > pm_runtime suspend transifion for that device.
> > 
> 
> I think what you are referring is similar to Android specific early suspend/resume
> framework. For example, what is the use of TS (if not used as wakeup) resources
> when the screen goes blank, so better to early suspend it rather than waiting
> upto the platform suspend to happen.
> 
> I think this can be solved with pm_runtime, isn't it? Though I am not expert
> at pm_runtime, but this framework can be explored to enable these features.

I think last time Rafael mentioned that runtime PM did not allow for
forcing power state from userspace but I wonder if it would be possible
for userspace to signal and "accelerate" the idle state for a device and
then standard runtime PM framework would kick in...

-- 
Dmitry
