From: akpm@linux-foundation.org
Subject: [patch 2/3] input: bcm5974: retract efi-broken suspend_resume
Date: Tue, 17 Nov 2009 14:44:56 -0800
Message-ID: <200911172244.nAHMiutB032282@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48015 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756457AbZKQWps (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2009 17:45:48 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, rydberg@euromail.se

From: "Henrik Rydberg" <rydberg@euromail.se>

With the recent system-wide improvements on suspend/resume and EFI booting
the suspend_resume method of the bcm5974 has broken.  When waking up from
the S3 state on the MacBookAir, the trackpad is found in a yet unknown
state, unable to switch to the proper multitouch mode.  The result is a
frozen touchpad, and a flood of errors of the kind

bcm5974: bad trackpad package, length: 8.

This patch retracts the reset_resume method altogether, falling back on
the generic unbind/rebind functionality of the usb layer until further
investigations can be made as how to reset the device when booting from
efi.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/mouse/bcm5974.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN drivers/input/mouse/bcm5974.c~input-bcm5974-retract-efi-broken-suspend_resume drivers/input/mouse/bcm5974.c
--- a/drivers/input/mouse/bcm5974.c~input-bcm5974-retract-efi-broken-suspend_resume
+++ a/drivers/input/mouse/bcm5974.c
@@ -761,7 +761,6 @@ static struct usb_driver bcm5974_driver 
 	.disconnect		= bcm5974_disconnect,
 	.suspend		= bcm5974_suspend,
 	.resume			= bcm5974_resume,
-	.reset_resume		= bcm5974_resume,
 	.id_table		= bcm5974_table,
 	.supports_autosuspend	= 1,
 };
_
