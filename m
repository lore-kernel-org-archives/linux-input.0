From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sat, 06 Nov 2010 16:38:51 -0400
Message-ID: <4CD5BCDB.8070806@seas.upenn.edu>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com> <AANLkTin+S_jJAdw6gLH1RnbyD1EB6ChHCo9yNheLb_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from talbot.seas.upenn.edu ([158.130.67.217]:40686 "EHLO
	talbot.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab0KFUsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 16:48:39 -0400
In-Reply-To: <AANLkTin+S_jJAdw6gLH1RnbyD1EB6ChHCo9yNheLb_sg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On 11/06/10 11:53, Michal Suchanek wrote:
> On 5 November 2010 19:47, Ping Cheng <pinglinux@gmail.com> wrote:
>> Recent changes and discussion about MT support at LKML, UDS, and
>> xorg-devel encouraged me to migrate Wacom MT devices to the slot-based
>> MT protocol (introduced in kernel 2.6.36). Since Wacom supports both
>> digitizer and touch devices, I need to decide how to report touch data
>> when the pen is in proximity.
>>
>> My goal is to understand how X server would like the MT data to be
>> reported from the kernel. I hope to keep kernel and X server driver MT
>> support in sync so we can avoid unnecessary confusion or extra work in
>> the userland.
>>
>> The existing solution for single touch events is to arbitrate touch
>> when pen is in prox. This is based on the assumption that we do not
>> want to have two cursors competing on the screen.
> 
> As a tablet user, not X developer I don't think it is desirable and
> expected to register pen touch and finger touch together as a
> multitouch. That is, if I wanted to trigger a multitouch feature I
> would use fingers, not pen and finger. While it would be technically
> possible to use the pen touch and finger touch together to trigger
> multitouch I don't think it makes much sense.

Actually, a finger is a far more clumsy than a pen and beyond the biomechanics
in my experience pen sensors are also a lot more accurate and stable.  As such,
I could see people using one finger as an anchor while using a pen for better
control during a two tool manipulation.

This is merely a hypothetical usage, realistically, I don't think that
pen+finger actions are likely to be all that popular.



Some of the earlier single touch n-trig firmwares supported simultaneous
reporting of pen and finger.  Newer firmwares all send the touch device a
special event to indicate the pen is in range and then report no further touch
activity until after both sensors go idle.

The kernel driver still lets simultaneous events through to the two separate
event device nodes.  Given that was my only option at the time, I used that with
mpx to play with multitouch.  I did not really find it useful, and the only
feedback I got from users was questions asking how to disable touch when they
wanted to use the pen.

> Also it is a good idea to turn off (single) touch when pen is in
> proximity because it is quite easy to accidentally touch the surface
> while moving the pen.

Definitely simplifies using things like Xournal, where sometimes a finger is
fine, but when you're writing with the pen you don't want to have to worry about
accidentally making skin contact with the screen.

> This means that the protocol that sends abs events from pen when in
> proximity and from finger otherwise would work well.
> 
> However, there is one feature that makes sort of sense and does not
> work when touch is completely off. It might be possible to use touch
> for button and pen for moving the cursor. I tried to use the pad
> button on my Bamboo together with pen motion for right drags and it
> seems somewhat easier than using the pen button.
> 
> So I would say that protocol that allows events from both pen and
> touch at the same time is desirable in the long run but with some
> options to filter the events when both pen and touch are used
> together.
> 
> This gives basically three options
> 
> 1) leave as is, turn off touch when pen is in proximity

This would be simplest.  Furthermore, if you want to block touch when the pen is
in range, it would be easiest to catch that in firmware or the kernel, before
the events are split off into separate streams.

> 2) report everything by kernel, put some filter on the touch events in
> the  X driver (which defaults to killing most touch stuff when pen is
> in proximity)

Hard to coordinate when the events come in from separate device nodes, and may
even use different drivers for pen and touch.

> 3) the same as above but put the filter in the kernel driver
> 
> 
> 2 or 3 is more flexible as people with some special uses can just turn
> off the filter and get all events.
> 
> WRT X ease of development I would suggest that the same device should
> never report different events based on pen proximity. Either the
> device is in some "compatibility mode" and reports only one pointer as
> per 1 or there are two separate pointers and they are just reported
> out of proximity when the pointer positioning is not desirable (ie
> when pen is out or when touch is off due to pen being in).
> 
> If somebody wants to have multitouch combining two different pointers
> there is nothing stopping them, either with P&T pen and touch pointers
> or completely unrelated devices.

Multiplexing pen and finger events as separate MT tracks where each specifies
the current tool at the start of the stream should work, but it might get a
little messy.  Downstream applications would be responsible for deciding if they
care about the tool type and respond accordingly.  Also pen and touch have
different characteristics (resolution, physical dimensions, pressure) and an
application would have to adjust behavior specially for every track.


I have seen one really positive example where a machine had a number different
of tools, all simultaneously active.  However, that was a custom setup created
by an artist/computer scientist for his own use and even then only for a single
purpose machine.

Trying to support the mixed tool streams for the general case seems tricky and
prone to many mistakes.


Rafi
