From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 3/4] HID: hid-sony: PS3 Move enable LEDs and Rumble via BT
Date: Tue,  9 Jun 2015 21:27:06 -0600
Message-ID: <1433906827-11146-3-git-send-email-simon@mungewell.org>
References: <1433906827-11146-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:49072 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbFJD1W (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 23:27:22 -0400
In-Reply-To: <1433906827-11146-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>

The LED and Rumble control only function via BT if the full output report
is sent. The large report still functions via USB.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d9fa804..51cb1ac 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -902,6 +902,7 @@ struct motion_output_report_02 {
 #define DS4_REPORT_0x81_SIZE 7
 #define SIXAXIS_REPORT_0xF2_SIZE 17
 #define SIXAXIS_REPORT_0xF5_SIZE 8
+#define MOTION_REPORT_0x02_SIZE 49
 
 static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
@@ -1746,7 +1747,7 @@ static void motion_state_worker(struct work_struct *work)
 	struct motion_output_report_02 *report =
 		(struct motion_output_report_02 *)sc->output_report_dmabuf;
 
-	memset(report, 0, sizeof(struct motion_output_report_02));
+	memset(report, 0, MOTION_REPORT_0x02_SIZE);
 
 	report->type = 0x02; /* set leds */
 	report->r = sc->led_state[0];
@@ -1757,8 +1758,7 @@ static void motion_state_worker(struct work_struct *work)
 	report->rumble = max(sc->right, sc->left);
 #endif
 
-	hid_hw_output_report(hdev, (__u8 *)report,
-			sizeof(struct motion_output_report_02));
+	hid_hw_output_report(hdev, (__u8 *)report, MOTION_REPORT_0x02_SIZE);
 }
 
 static int sony_allocate_output_report(struct sony_sc *sc)
@@ -1774,9 +1774,8 @@ static int sony_allocate_output_report(struct sony_sc *sc)
 		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x05_SIZE,
 						GFP_KERNEL);
 	else if (sc->quirks & MOTION_CONTROLLER)
-		sc->output_report_dmabuf =
-				kmalloc(sizeof(struct motion_output_report_02),
-				GFP_KERNEL);
+		sc->output_report_dmabuf = kmalloc(MOTION_REPORT_0x02_SIZE,
+						GFP_KERNEL);
 	else
 		return 0;
 
-- 
2.1.4

