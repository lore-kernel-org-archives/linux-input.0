From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Wed, 10 Jun 2009 10:23:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906101020400.7457@wotan.suse.de>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com> <49E4E7E1.7040109@gmail.com> <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de> <4A2ED39B.30100@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59381 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbZFJIX0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2009 04:23:26 -0400
In-Reply-To: <4A2ED39B.30100@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "J.R. Mauro" <jrm8005@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org, locoxella@gmail.com

On Tue, 9 Jun 2009, Jiri Slaby wrote:

> I have an Apple Mighty Mouse. This is how it looks with 'cat
> /proc/bus/input/devices'
> 
> I: Bus=0005 Vendor=05ac Product=030c Version=0200
> N: Name="Mighty Mouse"
> 
> And the trackball on it has it x axis inverted.

OK, so the 0x030c quirk is apparently bogus, as we have multiple 
complaints about it, and the original reporter doesn't respond anymore. I 
will just remove the wrong quirk now. Thanks to everyone for letting me 
know.

> Ive searched about this problem and found a Linux kernel mailing list 
> conversation where this error maybe had raised. A guy but a similar 
> mouse (also a mightymouse), but different ID (0x1000 instead of 0x030c), 
> was told to invert the x axis in order to have his 0x1000 mighty mouse 
> working with the wrong ID: 0x030c instead of adding a while new device. 
> Probably, inverting the trackball for the rest of us with the right id.
> 
> I will quote the mailing list post to you:
> 
> > As a newbie, I just saw your email in the source-file when I was looking
> > into the sources of hid-apple.c to find my mighty mouse somewhere:
> >
> > /* Apple wireless Mighty Mouse */
> > { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c),
> > .driver_data = APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
> >
> > According to hid-ids.h, the ID 0x030c is a TDK mighty mouse. On my
> > Alu-iMac (last year edition), it's a Apple's owned mighty mouse (vendor
> > 0x05ac, ID 0x1000), which is not currently listed in hid-ids.h. My
> > mighty mouse anyway runs o.k. with the "wrong" ID, but since the start
> > withouth the mouse-wheel.
> > It did not help when I changed the ID's accordingly. So my question is:
> > Is there anything to be done in bluetooth driver area too to get this
> > mighty mouse fully supported (some quirks needed)?

Yes, 0x1000 is a different problem, the scrollwheel doesn't work there at 
all (it isn't even described in the report descriptor).

I currently have 0x05ac/0x1000 on my desk, I will look into it.

-- 
Jiri Kosina
SUSE Labs
