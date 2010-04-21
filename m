From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: RFC: touch event clarification
Date: Tue, 20 Apr 2010 23:23:50 -0700
Message-ID: <20100421062350.GG4364@core.coreip.homeip.net>
References: <4BCC1792.1020901@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41411 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab0DUGX7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 02:23:59 -0400
Received: by gwj19 with SMTP id 19so1255676gwj.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 23:23:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BCC1792.1020901@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, Ping <pinglinux@gmail.com>

Hi Rafi,

> Dmitry: would you care to clarify the meaning of the basic touch events?  It
> might also be helpful to add more comments to input.h or add something to the
> Documents directory.
> 
> 
> My current understanding:
> BTN_TOOL_FINGER: touch pad single finger

Correct.

> BTN_TOOL_(DOUBLE|TRIPLE|QUAD)TAP: touch pad 2,3 and 4 fingers

Tapping with more than one finger, These events are tailored to
touchpads that can only report numberf or contacts but not discrete
coordinates for every contact,

> BTN_TOUCH: touch screen single finger

Right.

> BTN_[0-N]: not really for fingers.
> 

Right, these are miscellaneous buttons.

> 
> Are the taps at all appropriate for touch screens?

I do not think tap makes sense for touchscreens, the act of touching
should cause "select" or "action" event. Unlike other devices with
touchscreens you do not need to track movement of a pointer, your finger
ios a pointer and when you touch you mena to perform an action. At least
this is the model I'd operate with.

>  How should the wacom
> non-screen tablets be treated, should they act like touch pads both for absolute
> and relative modes?

Yes, since they are physically separate from treh screem tracking
pointer makes sense for tablets.

> Should there be any difference between pad and screen devices with respect to
> multitouch events (currently, I'm assuming not)?
>

Umm... if you are referring to gestures then I think they should exibit
similar behavior.

-- 
Dmitry
