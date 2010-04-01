From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: joystick with large number of buttons
Date: Thu, 1 Apr 2010 11:23:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004011121240.8345@pobox.suse.cz>
References: <6121ee741003271645i2f091b9bq566edaa12b4b3561@mail.gmail.com>  <alpine.LNX.2.00.1003301411070.24576@pobox.suse.cz>  <6121ee741003300520r25a1d46dm189ee034272fa514@mail.gmail.com>  <x2y6121ee741003310400sf3f36c09g2fad909fd11166a3@mail.gmail.com>
 <s2t6121ee741004010116nf1c9ba7et4aff02c48ccf9f63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40125 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab0DAJXS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Apr 2010 05:23:18 -0400
In-Reply-To: <s2t6121ee741004010116nf1c9ba7et4aff02c48ccf9f63@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Attila Nagy <nagy.attila.gabor@gmail.com>
Cc: stefan.bader@canonical.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, 1 Apr 2010, Attila Nagy wrote:

> >>>> I've just found this thread:
> >>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/492056 and the
> >>>> following patch:
> >>>> http://launchpadlibrarian.net/38497329/0001-HID-handle-joysticks-with-large-number-of-buttons.patch
> >>>>
> >>>> If I understand, this pushes the limit on the number of the buttons
> >>>> per joystick to 56?
> >>>>
> >>>> Shouldn't this limit be raised to some more? In fact if I understand
> >>>> the HID specification one could define 65K buttons per device. Well
> >>>> that's a bit silly, but I found this bug when I was about to build a
> >>>> hid device that has 64 buttons (or maybe more).
> >>>>
> >>>> I wonder if there's a possibility to push this limit a bit further? I
> >>>> guess 256 could be a reasonable limit for a while.
> >>>
> >>> Is this still a joystick though? Wouldn't it better to have those be KEY_*
> >>> events?
> >>
> >> Thanks for your reply.
> >>
> >> This is a bit philosophical question. In the practical side people
> >> like me choose to implement joystick hardware, because games have a
> >> decent support for joys with many buttons. If I have an interface,
> >> that has 64 buttons, I can map them in a game to functions as I want,
> >> without interferencing with the keyboard events.
> >>
> >> In the terms of the HID usage tables, one might should define these
> >> things as a game pad, or a "simulation control device", but support
> >> for such devices in current operating systems isn't that self
> >> understanding like support for a joystick.
> > I'll test it with 128 buttons today.
> 
> I've tried 128 buttons. Currently the mapping space goes until 0x2ff,
> thus leaving room for 64 effective buttons per device. Over that only
> the lower 64 is reported and working, buttons over that are silently
> ignored.
> 
> The attached patch raises this limit to 128 per device. Only two
> constants need to be modified, and after that everything did work fine
> for me.
> 
> Could this hurt something, I didn't notice?
> 
> 
> [if I'm knocking on the wrong door, then please redirect me to the
> appropriate people]

This should definitely go through Dmitry. Adding him, and linux-input@, to 
CC.

(for reference, the patch is below)

diff -ru linux-2.6.33.1.clean/include/linux/input.h linux-2.6.33.1/include/linux/input.h
--- linux-2.6.33.1.clean/include/linux/input.h	Wed Mar 31 22:02:17 2010
+++ linux-2.6.33.1/include/linux/input.h	Wed Mar 31 21:37:54 2010
@@ -642,7 +642,7 @@
 
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
-#define KEY_MAX			0x2ff
+#define KEY_MAX			0x34f
 #define KEY_CNT			(KEY_MAX+1)
 
 /*
diff -ru linux-2.6.33.1.clean/include/linux/mod_devicetable.h linux-2.6.33.1/include/linux/mod_devicetable.h
--- linux-2.6.33.1.clean/include/linux/mod_devicetable.h	Mon Mar 15 17:09:39 2010
+++ linux-2.6.33.1/include/linux/mod_devicetable.h	Wed Mar 31 21:39:40 2010
@@ -285,7 +285,7 @@
 /* Input */
 #define INPUT_DEVICE_ID_EV_MAX		0x1f
 #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
-#define INPUT_DEVICE_ID_KEY_MAX		0x2ff
+#define INPUT_DEVICE_ID_KEY_MAX		0x34f
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
 #define INPUT_DEVICE_ID_ABS_MAX		0x3f
 #define INPUT_DEVICE_ID_MSC_MAX		0x07

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
