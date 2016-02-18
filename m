From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Question about ABS_DISTANCE's intended usage.
Date: Thu, 18 Feb 2016 10:19:30 -0800
Message-ID: <20160218181930.GA34407@dtor-ws>
References: <CAJ34Pp7OM7DAiA1gZqQ0dtgXZ=z6p+LEVD5aeMiYOecHCbcfLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36101 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426632AbcBRSTd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2016 13:19:33 -0500
Received: by mail-pf0-f178.google.com with SMTP id e127so35573201pfe.3
        for <linux-input@vger.kernel.org>; Thu, 18 Feb 2016 10:19:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJ34Pp7OM7DAiA1gZqQ0dtgXZ=z6p+LEVD5aeMiYOecHCbcfLw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Charles Mooney <charliemooney@google.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Linux Input <linux-input@vger.kernel.org>

On Tue, Feb 09, 2016 at 01:56:05PM -0800, Charles Mooney wrote:
> Hello all,
> 
> I'm currently working with a touchpad vendor with a new device that
> supports a limited form of hover detection.  Their sensor is able to
> detect the presence or absence of a finger/hand/palm hovering over the
> sensor without touching it, but is unable to report any more details
> about it.  This is a more limited form of hover detection than some
> devices which attach a hover state to each finger they see, and can
> even report x/y coordinates to hovering finger.
> 
> Instead of using ABS_MT_DISTANCE, it appears that the correct event to
> use would be ABS_DISTANCE, since the value is not tied to a specific
> finger.  I would like to check with you all about how this value is
> intended to be used, because it's not quite as obvious to me as I
> first thought.
> 
> We need to handle three basic states:
>   1. At least one finger is touching the pad.
>   2. Something is hovering, but nothing is actually touching.
>   3. Nothing is touching the pad and nothing is detected hovering over it either
> 
> It's seems clear to me that an ABS_DISTANCE of zero should indicate
> state #1 and that any other legal positive value should indicate state
> #2, but I'm less clear on what the best way to handle state #3 is.
> Currently, I think the best strategy would be to use a value of
> ABS_DISTANCE = -1 to indicate that there are no fingers seen (hovering
> or otherwise), does that make sense?
> 
> If not this, how else would you suggest that this ought to be done?

As we discussed in person, I believe that reporting an "out of bounds"
value for ABS_DISTANCE when we have to use single-touch mode and thus do
not have a good way to invalidate a contact, is the easiest option.
Alternative would be to invent another SYN event, which I'd rather not.

So for devices that support hovering but can not report individual
hovering contacts we should declare 0..N as ABS_DISTANCE range and report
following values:

 - 0 when a finger is actually touching
 - 1..N for hovering fingers
 - return X < 0 or X > N when no fingers are detected at all; in
   practice I think we should simply report -1 in this case.

Benjamin, Peter, Henrik, any concerns?

Thanks.

-- 
Dmitry
