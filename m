From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 6/6] hid: sony: Correct a typo in a HID descriptor comment and explain the odd Sixaxis axis mapping
Date: Tue,  5 May 2015 20:47:33 -0400
Message-ID: <1430873253-11765-7-git-send-email-frank.praznik@oh.rr.com>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:51661 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755784AbbEFAwO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 20:52:14 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

Correct a spelling mistake in the Sixaxis HID descriptor comment.

Add an explanation as to why the Sixaxis has so many analog axes and why
some of them are seen as multi-touch axes.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9370509..aeb8b41 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -59,9 +59,16 @@
 
 #define MAX_LEDS 4
 
+/*
+ * The Sixaxis reports both digital and analog values for each button on the
+ * controller except for Start, Select and the PS button.  The controller ends
+ * up reporting 27 axes which causes them to spill over into the multi-touch
+ * axis values.  Additionally, the controller only has 20 actual, physical axes
+ * so there are several unused axes in between the used ones.
+ */
 static __u8 sixaxis_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x04,         /*  Usage (Joystik),                    */
+	0x09, 0x04,         /*  Usage (Joystick),                   */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0xA1, 0x02,         /*      Collection (Logical),           */
 	0x85, 0x01,         /*          Report ID (1),              */
-- 
2.1.0

