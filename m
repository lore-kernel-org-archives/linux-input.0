From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v5 7/7] HID: hid-sony - allow 3rd party INTEC controller to turn off all leds
Date: Mon, 14 Apr 2014 10:11:37 -0400
Message-ID: <1397484697-2389-8-git-send-email-frank.praznik@oh.rr.com>
References: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:41069 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751058AbaDNOLv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 10:11:51 -0400
In-Reply-To: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

From: Simon Wood <simon@mungewell.org>

Without this patch the 3rd party INTEC (PS3) controller will blink all
leds when user turns them off, it appears to require an extra flag set.

Signed-off-by: Simon Wood <simon@mungewell.org>
Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 54a04ba..bc3c6ee 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1420,6 +1420,10 @@ static void sixaxis_state_worker(struct work_struct *work)
 	report.data.leds_bitmap |= sc->led_state[2] << 3;
 	report.data.leds_bitmap |= sc->led_state[3] << 4;
 
+	/* Set flag for all leds off, required for 3rd party INTEC controller */
+	if ((report.data.leds_bitmap & 0x1E) == 0)
+		report.data.leds_bitmap |= 0x20;
+
 	/*
 	 * The LEDs in the report are indexed in reverse order to their
 	 * corresponding light on the controller.
-- 
1.8.5.3

