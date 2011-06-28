From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Linux joystick driver bugreport
Date: Tue, 28 Jun 2011 15:25:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106281524480.11049@pobox.suse.cz>
References: <20110625011015.6f397f6f@Giskard>    <20110627193814.GB13829@core.coreip.homeip.net> <563e944385d52f20d80a72176e57d611.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48006 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410Ab1F1N0B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 09:26:01 -0400
In-Reply-To: <563e944385d52f20d80a72176e57d611.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Pablo Cabrera <binchmod777@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Mon, 27 Jun 2011, simon@mungewell.org wrote:

> Hi Pablo,
> 
> >> For device 0079:0011 DragonRise Inc. arrows buttons are mapped to axes 3
> >> and 4.
> >> For device 0e8f: 0002 GreenAsia Motion Inc. arrows buttons are mapped
> >> to axes 2 and 3
> 
> This sounds like the arrows are on a D-Pad and that the D-Pad is described
> as a 'HAT' in the HID descriptor, which is like a n-position dial with a
> NULL state.
> 
> I have a Logitech game pad which does the same, the HID descriptor contains
> --
> Logical Maximum (7),
> Physical Maximum (315),
> Report Size (4),
> Report Count (1),
> Unit (Degrees),
> Usage (Hat Switch), ; Hat switch (39h, dynamic value)
> Input (Variable, Null State),
> Unit,
> --
> 
> Linux converts these '8 buttons' to a 'vector' to the edge of a circle,
> hence the two extra axis.
> 
> You can use an application from DigiMend
> (http://digimend.sourceforge.net/) to read the HID descriptor for your
> device.

Or you can obtain in from debugfs (/sys/kernel/debug/hid/<device>/rdesc on 
most distributions) in human-readable form as well.

> A possible work around (if you just want the use the joystick to play) 
> is described here: 
> http://hans.fugal.net/blog/2007/06/02/joystick-hat-in-x-plane-in-linux/

Or write a kernel patch/driver that will fix up the report descriptor.

-- 
Jiri Kosina
SUSE Labs
