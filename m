From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 15:42:23 -0800
Message-ID: <20100309234223.GB29942@core.coreip.homeip.net>
References: <4B75E14A.2050602@seas.upenn.edu>
 <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>
 <4B760D60.6020907@seas.upenn.edu>
 <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
 <4B96B740.7020208@euromail.se>
 <4B96BAF1.5070209@seas.upenn.edu>
 <4B96C4A8.3060005@euromail.se>
 <4B96CB41.9040804@seas.upenn.edu>
 <4B96D85A.4060604@euromail.se>
 <4B96DBEE.4060605@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:55684 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab0CIXmf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 18:42:35 -0500
Received: by fxm27 with SMTP id 27so3450979fxm.28
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 15:42:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B96DBEE.4060605@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, chatty@enac.fr

On Tue, Mar 09, 2010 at 06:38:22PM -0500, Rafi Rubin wrote:
> On 03/09/2010 06:23 PM, Henrik Rydberg wrote:
> >Rafi Rubin wrote:
> >>>Single touch should be goverened by one of BTN_TOUCH or ABS_PRESSURE.
> >>>BTN_TOOL_DOUBLETAP is a two-finger event.
> >>
> >>That definitely makes sense to me.  I really don't know why wacom uses
> >>double tap there.
> >>
> >>Is there any harm in letting through the BTN_0 events?  Is the "rdesc"
> >>mapping defined by the hardware or hid?
> >
> >I cannot imagine BTN_0 will do any harm. In synaptics, the BTN_X buttons are
> >mapped to multibuttons without clear-cut usage. The button events that carry
> >well-defined semantic meaning with regard to touch screens are BTN_TOUCH (any
> >finger), BTN_TOOL_FINGER (one finger), BTN_TOOL_PEN (pen), BTN_TOOL_DOUBLETAP
> >(two fingers) and BTN_TOOL_TRIPLETAP (three fingers or more).
> >
> >Henrik
> >
> 
> Perhaps we should have a general touch device document.
> 
> I looked at the evdev code.  And as you say for single touch
> devices, BTN_TOUCH is the bit that matters.  It only broken because
> I pulled the TOUCH <- 0 when I removed BTN_0.
> 
> So why does evdev associate BTN_TOOL_FINGER with touchpads
> (resulting in the wrong set of assumptions and a poorly calibrated
> touch screen)?  I suppose that's really a discussion for another
> list.
> 

Historic reasons. When Synaptics driver was in works we needed an event
that is different from BTN_TOUCH to differentiate from touchscreens.

-- 
Dmitry
