From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Mon, 3 Mar 2008 23:53:12 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803032349140.18589@twin.jikos.cz>
References: <200802161622.43223.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:36718 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbYCCWyU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Mar 2008 17:54:20 -0500
In-Reply-To: <200802161622.43223.linux@dadeos.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stokes <linux@dadeos.co.uk>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

On Sat, 16 Feb 2008, Peter Stokes wrote:

> As this device is exposed as a combined keyboard and mouse, this change 
> somewhat depends upon the suggested modification to the core 
> soft-autorepeat functionality as outlined in my previous post to the 
> linux-input mailing list (on 12th Feb 2008 entitled "Soft-autorepeat 
> functionality"), without that modification, the mouse buttons are 
> autorepeated :-(

I don't think that the solution you proposed in that mail, i.e.

--- linux-2.6.24-orig/drivers/input/input.c	2008-01-24 22:58:37.000000000 +0000
+++ linux-2.6.24/drivers/input/input.c	2008-02-11 20:02:03.000000000 +0000
@@ -123,6 +123,7 @@
 static void input_start_autorepeat(struct input_dev *dev, int code)
 {
 	if (test_bit(EV_REP, dev->evbit) &&
+	    code < KEY_MIN_INTERESTING &&
 	    dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] &&
 	    dev->timer.data) {
 		dev->repeat_key = code;

should be used. We really can't generally assume that there is no key 
above KEY_MIN_INTERESTING that shouldn't be autorepeated. The 
KEY_MIN_INTERESTING is, if I remember correctly, just a hack that 
modaliases don't grow excessively.

What about changing the 
ati_remote2-autorepeat-and-loadable-keymap-support.patch (as it is now in 
-mm) so that it registers two independent input devices, one for keyboard 
and one for mouse, and depedning on the type of arriving event, you decide 
which input device to use?

You can then easily set autorepeat only for one of them, right?

Thanks,

-- 
Jiri Kosina
SUSE Labs

