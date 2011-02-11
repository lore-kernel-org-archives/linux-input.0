From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] input - wacom : support one finger touch the
 touchscreen way
Date: Fri, 11 Feb 2011 22:49:48 +0100
Message-ID: <20110211214948.GA7375@polaris.bitmath.org>
References: <1297387962-13723-1-git-send-email-pinglinux@gmail.com>
 <20110211195656.GA2287@polaris.bitmath.org>
 <AANLkTin0PWuMaB1T9sXj-VF9JUST3U=fHszR0RXG=ih4@mail.gmail.com>
 <AANLkTimBwdRE1xqpD0gRzp7+Q-ML1HyJmn6szo_Soz0s@mail.gmail.com>
 <AANLkTimsRQF7cpUWXS3VfvFUm3NpB=0yuRccbc+FfvKV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:49736 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932421Ab1BKVtY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 16:49:24 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimsRQF7cpUWXS3VfvFUm3NpB=0yuRccbc+FfvKV@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org

Hi Chis,

> Extra clarification on whats going on here:
> 
> Patch #1 removes BTN_TOOL_TRIPLETAP; among other supporting 2 finger
> touch code.  In that context, it was used as an awkward indication to
> xf86-input-wacom that device supported 2 finger touch.

Which is great, no argument there.

> In this patch #3, it removes BTN_TOOL_DOUBLETAP; which was an awkward
> indication to xf86-input-wacom that device supports 1 finger touch.
> Once this patch is applied, applications must deduce touchscreen input
> supports 1 finger touch same way as they do for other touchscreens
> (not seeing BTN_TOOL_FINGER and no stylus related BTN_'s as well).

Also makes sense - I only noticed that it was gone without
replacement, and Ping's and your answer gives ample rationale for its
removal.

> Patch #4 adds BTN_TOOL_DOUBLETAP back but using normal meaning that
> the device supports 2 finger touch.

Right, thanks.

> I had reviewed this patch series in context of some related changes
> from Ping to xf86-input-wacom.  I wanted to document doubletap part of
> that review on this list though.
> 
> Ping originally didn't want to add that back in.  At least one of the
> reasons was that there were no known applications that supported both
> "touchscreens" (absolute mode) and the BTN_TOOL_DOUBLETAP at same
> time.

Given the current state of userland, a touchscreen should not emit
doubletaps, true.

> I did look around quite a bit after Ping's comment and I couldn't come
> up with anything (mtdev, xf86-input-evdev, etc).  So its a good point.
>  When something supports ABS_MT_*, thats given much more weight then
> BTN_TOOL_DOUPLETAP would; which is the case here.

Yes - unless the device is of the SEMI_MT kind, the finger-counting
BTN_TOOL_* events really have no meaning.
 
> Anyways, I requested if Ping would add BTN_TOOL_DOUBLETAP in to align
> with current hid-ntrig and since it didn't seem to hurt and could
> possibly help some future app.  Please double check me here if it is
> in fact a good idea to add DOUBLETAP in for touchscreens.

In fact, I think it hurts a bit, so removing it is a good idea.

Thanks,
Henrik
