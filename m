From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 1/2] Emit TOUCH with DOUBLETAP for single touch
Date: Fri,  9 Apr 2010 17:58:25 -0400
Message-ID: <1270850306-4949-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:36567 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0DIV7P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Apr 2010 17:59:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz
Cc: micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr, Rafi Rubin <rafi@seas.upenn.edu>

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---

I squelched TipSwitch in a recent patch which resulted in the loss
of Touch events for single touch firmwares.  This patch just puts Touch back
in for single touch, and bundles it with DoubleTap (like the multitouch code).
The two events are used to convey the same message to different drivers.

I still would like to remove DoubleTap, though I think that should wait until
after users have a more motivation to migrate away from the wacom driver for
touch.

 drivers/hid/hid-ntrig.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index a418f9e..58ba0d3 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -173,6 +173,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			if (!nd->reading_mt) {
 				input_report_key(input, BTN_TOOL_DOUBLETAP,
 						 (nd->confidence != 0));
+				input_report_key(input, BTN_TOUCH,
+						 (nd->confidence != 0));
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
-- 
1.7.0.4

