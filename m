From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Mon, 8 Nov 2010 13:51:21 +1000
Message-ID: <20101108035121.GA4630@barra.bne.redhat.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:23149 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab0KHDva (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 22:51:30 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

fwiw, I'm not sure "arbitrate" is the right word here, filtering seems
easier to understand in this context. I guess "arbitrate" would apply more
if we emit the events across multiple devices like in the bamboo case.
that's mostly bikeshedding though, my points below apply regardless of what
word we choose :)

note that we also have two different approaches - single kernel device or
multiple kernel devices and depending on the approach the device uses the
options below have different advantages and disadvantages.

the tablets I've dealt with so far exposed a single event device, so that's
what I'm focusing on in this email.

On Fri, Nov 05, 2010 at 11:47:28AM -0700, Ping Cheng wrote:
> Recent changes and discussion about MT support at LKML, UDS, and
> xorg-devel encouraged me to migrate Wacom MT devices to the slot-based
> MT protocol (introduced in kernel 2.6.36). Since Wacom supports both
> digitizer and touch devices, I need to decide how to report touch data
> when the pen is in proximity.
> 
> My goal is to understand how X server would like the MT data to be
> reported from the kernel. I hope to keep kernel and X server driver MT
> support in sync so we can avoid unnecessary confusion or extra work in
> the userland.
> 
> The existing solution for single touch events is to arbitrate touch
> when pen is in prox. This is based on the assumption that we do not
> want to have two cursors competing on the screen.
> 
> With the introduction of MT, the touch data are most likely translated
> into something other than pointer events. So, reporting both pen and
> touch data makes sense now. However, I want to assure a smooth
> tansition from single touch to MT for end users so they still get the
> single touch behavior as they used to be. I gathered the following
> approaches:
> 
> 1.     Arbitrate all touch data in the kernel.
> 
> This is the simplest solution for device driver developers. But I do
> not feel it is end user and userland client friendly.

I'm strongly opposed to this. kernel filtering of these devices is hard to
circumvent and there _will_ be use-cases where we need more than one tool to
work simultaneously. right now we're worrying about pen + touch, but what
stops tablets from becoming large enough to be used by 2+ users with 2+
pens simultaneously?

from a purely event-stream focused viewpoint: why do we even care whether
something is a pen or a touch? both are just tools and how these should be
used is mostly up to the clients anyway.  IMO, the whole point of
MT_TOOL_TYPE is that we don't have to assume use-cases for the tools but
just forward the information to someone who knows how to deal with this.

> 2.     Report first finger touch as ABS_X/Y events when pen is not in
> prox.  Arbitrating single touch data when pen is in prox. Pen data is
> reported as ABS_X/Y events. Both ABS_X/Y for pen or the first finger
> and ABS_MT_* for MT data are reported.
> 
> This approach reduces the overhead in dealing with two cursors in userland.
> 
> 3.    Report first finger touch as ABS_X/Y events when pen is not in prox;
>        Report pen data as ABS_X/Y events when there is no finger touch;
>        Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_PEN
> events when both pen and touch data are received. No ABS_X/Y are
> reported when pen and tocuh or multi-touch data are received.
> 
> I feel this one makes sense to userland since pen can be considered as
> another touch.
> 
> 4.    Report first finger touch as ABS_X/Y events when pen is not in prox;
>        Report pen data as ABS_X/Y events when there is no finger touch;
>        Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_PEN
> events when both pen and touch data are received. ABS_X/Y are also
> reported for pen when both pen and tocuh data are received.

I'd vote for this one. It provides all the data necessary for MT clients
(and all the data the device can support) but has a reasonable single-touch
strategy. Given that wacom tablets are still primarily pen-centric tablets,
the emphasis on pen overriding touch makes sense to me.

Cheers,
  Peter

> This one makes sense to userland too. It eases the backward
> compatibility support for those clients that don't support MT at all.
> 
> Which approach do you like? Or do you have other suggestions share?

