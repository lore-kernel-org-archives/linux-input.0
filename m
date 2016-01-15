From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Fri, 15 Jan 2016 09:50:40 -0800
Message-ID: <20160115175040.GA5664@dtor-ws>
References: <20160115123928.d06e1fed.cand@gmx.com>
 <5698D343.3000606@vmware.com>
 <20160115132312.654ad5aa.cand@gmx.com>
 <56991418.1070701@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33037 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbcAORun (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 12:50:43 -0500
Received: by mail-pf0-f175.google.com with SMTP id e65so121288047pfe.0
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 09:50:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56991418.1070701@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org

On Fri, Jan 15, 2016 at 04:45:28PM +0100, Thomas Hellstrom wrote:
> On 01/15/2016 12:23 PM, Lauri Kasanen wrote:
> > On Fri, 15 Jan 2016 12:08:51 +0100
> > Thomas Hellstrom <thellstrom@vmware.com> wrote:
> >
> >>> Seems the new and shiny VMWare mouse driver does not pass events
> >>> to /dev/input/mice, rudely breaking userspace that doesn't
> >>> support absolute input devices.
> >>>
> >>> Can this be changed? Would there be any downside to passing those
> >>> events?
> >> Hi, Lauri.
> >> What particular use-case is broken?
> > VMWare + 4.2 kernel + Xvesa. This was reported for the current TinyCore
> > beta, which has that kernel.

Although we will make vmmouse work with /dev/input/mice, could you
please tell TinyCore that 90s are calling and they want their mouse
technology back? And tell them to switch to switch to evdev X driver.

> >
> >> I'm assuming what's happening is that only the relative device gets
> >> recognized as a mouse, and by default we don't send events through that
> >> device.

No, this is not correct, mousedev (the one that provides
/dev/input/mouseX and /dev/input/mice) should bind to absolute device
exported by vmmouse on this rule:

	{
		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
			INPUT_DEVICE_ID_MATCH_KEYBIT |
			INPUT_DEVICE_ID_MATCH_ABSBIT,
		.evbit = { BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) },
		.keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
		.absbit = { BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
	},	/* Mouse-like device with absolute X and Y but ordinary
		   clicks, like hp ILO2 High Performance mouse */

and it should convert absolute events to relative motion.

Lauri, can you please check your /proc/bus/input/devices and see if
"mouse" handlers are attached to vmmouse devices (could you also post
output of cat /proc/bus/input/devices here?).

By the way, could it be that we do have events, but the deltas are too
small since the declared axis sizes are too big. Do you see garbage
coming if you do "cat /dev/input/mice" and try moving pointer?

Thanks.

-- 
Dmitry
