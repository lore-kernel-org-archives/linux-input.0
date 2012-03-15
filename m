From: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Thu, 15 Mar 2012 18:56:35 +0100
Message-ID: <20120315175635.GA23155@stud.informatik.uni-erlangen.de>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
 <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55340 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031966Ab2COR4i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 13:56:38 -0400
Content-Disposition: inline
In-Reply-To: <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Maximilian =?iso-8859-1?Q?Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

Thank You for your quick answer!

On Thu, Mar 15, 2012 at 12:27:22PM -0500, Chris Bagwell wrote:
> 2012/3/15 Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>:
> > we are working on already existing multitouch driver for a Promethean
> > ActivBoard, which supports both multiple fingers and pens. The pens
> > behave Wacom-like, i.e. the device actually can tell a cursor position
> > without a button action.
> >
> > Because of the (up to 4) fingers, we use the input_mt_* functions. Is it
> > possible to just update the cursor position without a button action? (As
> > it is can be done with plain input_* functions?) Or do we have to create
> > two input devices? (one with multitouch input_mt_* and one for the pens?)
> 
> I'm not quite sure what you mean by updating cursor position without a
> button action.  By button action, do you mean BTN_TOOL_*?  It is true
> you need to set correct BTN_TOOL_* before updating any X/Y coordinates
> so user land knows that X/Y maps to.

With "updating cursor position without a button action" we meant
something like moving a "normal" mouse without pressing any button.
(Which generates just mouse motion events for X applications)

> Its also true that sharing ABS_X/Y events between both a BTN_TOOL_PEN
> and a BTN_TOOL_FINGER will confuse most user land apps (they think
> only touchpads can declare BTN_TOOL_FINGER's but this is a
> touchscreen) and it also has bad side affects to the kernel's MT
> pointer emulation functions.
> 
> You can look at kernel drivers/input/touchscreen/wacom_w8001.c for an
> example touchscreen that supports pen and at least 2 MT touches on a
> single /dev/input device (because HW packets come over single serial
> interface).  It does not declare a BTN_TOOL_FINGER nor use pointer
> emulation to overcome issues I mentioned and xf86-input-wacom
> understands how to handle this device.
> 
> If you want to work with other unmodified user land apps (perhaps
> xf86-input-evdev for touches) then its probably easiest to split pen
> and touch to separate input devices.  drivers/input/tablet/wacom_wac.c
> shows some examples of that approach but that driver doesn't have to
> work to hard to split in to 2 input devices because the USB device
> already puts the events on separate USB  interfaces.

OK. We want the device to work with the xf86-input-evdev driver. So we
will split it into two devices.

    Thorsten
