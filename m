From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: bcm5974: retract efi-broken suspend_resume
Date: Tue, 13 Oct 2009 00:23:42 +0200
Message-ID: <1255386223-4109-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758578AbZJLW0L@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

With the recent system-wide improvements on suspend/resume and EFI
booting the suspend_resume method of the bcm5974 has broken. When
waking up from the S3 state on the MacBookAir, the trackpad is found
in a yet unknown state, unable to switch to the proper multitouch
mode.  The result is a frozen touchpad, and a flood of errors of the
kind

bcm5974: bad trackpad package, length: 8.

This patch retracts the reset_resume method altogether, falling back
on the generic unbind/rebind functionality of the usb layer until
further investigations can be made as how to reset the device when
booting from efi.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 2d8fc0b..79e182a 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -760,7 +760,6 @@ static struct usb_driver bcm5974_driver = {
 	.disconnect		= bcm5974_disconnect,
 	.suspend		= bcm5974_suspend,
 	.resume			= bcm5974_resume,
-	.reset_resume		= bcm5974_resume,
 	.id_table		= bcm5974_table,
 	.supports_autosuspend	= 1,
 };
-- 
1.6.3.3
