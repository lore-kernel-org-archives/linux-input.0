From: "Phil Endecott" <spam_from_linux_input@chezphil.org>
Subject: Re: Apple bluetooth keyboard
Date: Sun, 25 May 2008 14:24:24 +0100
Message-ID: <1211721864274@dmwebmail.dmwebmail.chezphil.org>
References: <1211399801133@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:4828 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYEYNY2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 25 May 2008 09:24:28 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.67)
	(envelope-from <spam_from_linux_input@chezphil.org>)
	id 1K0GD4-0008Ib-BU
	for linux-input@vger.kernel.org; Sun, 25 May 2008 14:24:26 +0100
In-Reply-To: <1211399801133@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux-input <linux-input@vger.kernel.org>

Phil Endecott wrote:
> I have the bluetooth version of the Apple aluminium keyboard and I'm 
> having trouble getting it to work right.
>
> I'm running 2.6.25 and I can see that it has some quirks for these 
> keyboards that should do some of the things that I want.  
> (Specifically, HID_QUIRK_APPLE_ISO_KEYBOARD and 
> HID_QUIRK_APPLE_HAS_FN.)  But it looks as if they're keyed on the USB 
> vendor/product IDs, which presumably don't match my bluetooth device.
>
> Can someone please explain how input quirks should be applied to 
> bluetooth devices?

I believe I've worked this out now.  In summary, this entry:

/* Apple Bluetooth alu ISO keyboard */
{ 0x05ac, 0x022d, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },

and presumably these untested ones:

/* Apple bluetooth alu ANSI keyboard */
{ 0x05ac, 0x022c, HID_QUIRK_APPLE_HAS_FN },
/* Apple bluetooth alu JIS keyboard */
{ 0x05ac, 0x022e, HID_QUIRK_APPLE_HAS_FN },

need to be added to hidp_blacklist in net/bluetooth/hidp/core.c; but I 
note that this moved to drivers/hid/hid-apple.c in Jiri Slaby's patch 
"HID: move apple quirks" posted here on 2008-05-16.  (I'm not posting 
this as a proper patch because of this move; I haven't applied Jiri's 
patches to my 2.6.25 tree and I don't think it would be useful to post 
a patch that would conflict with them.  Jiri, presumably you'll have no 
trouble adding those entries to your tree, right?)

I'm still unsure how all of this works though.  Those are USB vendor 
and product IDs.  Does bluetooth "borrow" the same scheme of 
vendor/product IDs that USB uses?  I got the IDs from the table in 
drivers/hid/usbhid/hid-quirks.c, but I can't see any way to get find 
them from my hardware; "hcitool info" doesn't report them.  Were the 
entries in drivers/hid/usbhid/hid-quirks.c actually useful before?  
Perhaps they would be applied if you had a bluetooth dongle in "HID 
proxy" mode.  If bluetooth devices do all use USB vendor/product IDs, 
maye the better solution is to look them up in a single table rather 
than splitting it into separate parts for "real" USB devices and 
bluetooth devices.  Hmm, maybe that's what Jiri's patches from 
2008-05-16 are doing....

Anyway, I now have things like home/end/pgup/pgdown and the keys to the 
left of 1 and Z doing the right thing, which is great.  There are a 
couple more things I'd like to change though; does anyone have any 
opinions on either of these:

- I have no delete key, so I can't type ctrl-alt-del!  (I have to keep 
another keyboard plugged in just for this!)  I'd like to use the eject 
key, which is immediately above the backspace key, for this.  (What do 
Mac users do?)

- The FN key and the left Ctrl key are the same size and the keycaps 
can easily be exchanged.  The order of these keys is often something 
that people complain about, e.g. if they're used to pressing the 
bottom-left key on their desktop keyboard for ctrl but now find that it 
isn't.  Often there is nothing that can be done about this because the 
logic for the FN key is inside the keyboard and not fixable in 
software, but in the case of this keyboard I believe it could be 
changed in the kernel.  Actually I'm not too bothered about it because 
I use caps lock as ctrl, but maybe other people would consider it a 
useful feature.


Cheers,  Phil.




