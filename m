From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Thu, 15 Mar 2012 12:27:22 -0500
Message-ID: <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61801 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932396Ab2COR1X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 13:27:23 -0400
Received: by lahj13 with SMTP id j13so2583189lah.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 10:27:22 -0700 (PDT)
In-Reply-To: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Maximilian_Kr=FCger?= <maxfragg@gmail.com>

2012/3/15 Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>:
> Hi,
>
> we are working on already existing multitouch driver for a Promethean
> ActivBoard, which supports both multiple fingers and pens. The pens
> behave Wacom-like, i.e. the device actually can tell a cursor position
> without a button action.
>
> Because of the (up to 4) fingers, we use the input_mt_* functions. Is it
> possible to just update the cursor position without a button action? (As
> it is can be done with plain input_* functions?) Or do we have to create
> two input devices? (one with multitouch input_mt_* and one for the pens?)
>
> Information about our context: We took the partial working and GPL
> licensed driver code out of /usr/src/ of [3] and enabled the multitouch
> parts of it.
>

I'm not quite sure what you mean by updating cursor position without a
button action.  By button action, do you mean BTN_TOOL_*?  It is true
you need to set correct BTN_TOOL_* before updating any X/Y coordinates
so user land knows that X/Y maps to.

Its also true that sharing ABS_X/Y events between both a BTN_TOOL_PEN
and a BTN_TOOL_FINGER will confuse most user land apps (they think
only touchpads can declare BTN_TOOL_FINGER's but this is a
touchscreen) and it also has bad side affects to the kernel's MT
pointer emulation functions.

You can look at kernel drivers/input/touchscreen/wacom_w8001.c for an
example touchscreen that supports pen and at least 2 MT touches on a
single /dev/input device (because HW packets come over single serial
interface).  It does not declare a BTN_TOOL_FINGER nor use pointer
emulation to overcome issues I mentioned and xf86-input-wacom
understands how to handle this device.

If you want to work with other unmodified user land apps (perhaps
xf86-input-evdev for touches) then its probably easiest to split pen
and touch to separate input devices.  drivers/input/tablet/wacom_wac.c
shows some examples of that approach but that driver doesn't have to
work to hard to split in to 2 input devices because the USB device
already puts the events on separate USB  interfaces.

Chris
