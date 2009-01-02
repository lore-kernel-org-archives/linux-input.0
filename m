From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: 2.6.28 thinks that my PS/2 mouse is a touchpad
Date: Fri, 2 Jan 2009 01:07:54 +0100
Message-ID: <200901020107.54740.vda.linux@googlemail.com>
References: <gj4r8h$okm$1@ger.gmane.org> <20081229185619.GA18394@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:41403 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbZABAIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jan 2009 19:08:04 -0500
In-Reply-To: <20081229185619.GA18394@adopmeer.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Monday 29 December 2008 19:56, Arjan Opmeer wrote:
> On Sat, Dec 27, 2008 at 02:06:29PM +0500, Alexander E. Patrakov wrote:
> > 
> > Linux-2.6.28, as compiled by Arch Linux developers, thinks that my PS/2
> > mouse (a cheap M-BT58 optical wheel mouse by Logitech) is actually a
> > touchpad.  This makes it unusable.  Adding the "proto=imps" parameter to
> > the psmouse module helps.
> 
> > CONFIG_MOUSE_PS2_ELANTECH=y
> 
> Oh dear. The first victim of this driver... :(
> 
> As we can see below the mouse gets detected as an Elantech touchpad. This
> means that it reacts to the Elantech magic knock with the exact same
> response we expect from a real Elantech touchpad.

I am affected too. I am getting:

2009-01-01_23:15:29.11109 kern.info: input: AT Translated Set 2 keyboard as /class/input/input2
2009-01-01_23:15:29.11113 kern.info: elantech.c: Elantech version query result 0x00, 0x01, 0x64.
2009-01-01_23:15:29.11118 kern.info: elantech.c: assuming hardware version 1, firmware version 0.100
2009-01-01_23:15:29.11123 kern.info: elantech.c: Synaptics capabilities query result 0x00, 0x02, 0x64.
2009-01-01_23:15:29.11128 kern.info: input: ETPS/2 Elantech Touchpad as /class/input/input3

and then on attempts to use the mouse:

...
2009-01-01_23:16:08.68831 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.70630 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.71730 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.72918 kern.notice: psmouse.c: Touchpad at isa0060/serio1/input0 - driver resynched.
2009-01-01_23:16:08.74732 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.75832 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.76932 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.78732 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.79832 kern.warn: psmouse.c: Touchpad at isa0060/serio1/input0 lost sync at byte 4
2009-01-01_23:16:08.79844 kern.notice: psmouse.c: issuing reconnect request
...

On old kernel it was:

2008-10-30_07:37:01.41484 kern.info: input: ImExPS/2 Logitech Wheel Mouse as /class/input/input3

--
vda
