From: Lauri Kasanen <cand@gmx.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Sat, 16 Jan 2016 10:57:35 +0200
Message-ID: <20160116105735.5c659e05.cand@gmx.com>
References: <20160115123928.d06e1fed.cand@gmx.com>
	<5698D343.3000606@vmware.com>
	<20160115132312.654ad5aa.cand@gmx.com>
	<56991418.1070701@vmware.com>
	<20160115175040.GA5664@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:58737 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbcAPI5n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 03:57:43 -0500
In-Reply-To: <20160115175040.GA5664@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Fri, 15 Jan 2016 09:50:40 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Although we will make vmmouse work with /dev/input/mice, could you
> please tell TinyCore that 90s are calling and they want their mouse
> technology back? And tell them to switch to switch to evdev X driver.

TinyCore sends their regards, and tells they will consider evdev when
Xorg + evdev + paraphelia can total less than 650kb.

> > >> I'm assuming what's happening is that only the relative device gets
> > >> recognized as a mouse, and by default we don't send events through that
> > >> device.
> 
> No, this is not correct, mousedev (the one that provides
> /dev/input/mouseX and /dev/input/mice) should bind to absolute device
> exported by vmmouse on this rule:
> 
> 	{
> 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
> 			INPUT_DEVICE_ID_MATCH_KEYBIT |
> 			INPUT_DEVICE_ID_MATCH_ABSBIT,
> 		.evbit = { BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) },
> 		.keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
> 		.absbit = { BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
> 	},	/* Mouse-like device with absolute X and Y but ordinary
> 		   clicks, like hp ILO2 High Performance mouse */
> 
> and it should convert absolute events to relative motion.
> 
> Lauri, can you please check your /proc/bus/input/devices and see if
> "mouse" handlers are attached to vmmouse devices (could you also post
> output of cat /proc/bus/input/devices here?).
> 
> By the way, could it be that we do have events, but the deltas are too
> small since the declared axis sizes are too big. Do you see garbage
> coming if you do "cat /dev/input/mice" and try moving pointer?

The reporter said there was no output at all when
catting /dev/input/mice. I'll forward the /proc/bus/input/devices
question.

- Lauri
