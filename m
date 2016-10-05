From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 3/5] HID: sony: Perform CRC check on bluetooth input packets
Date: Tue,  4 Oct 2016 19:58:56 -0700
Message-ID: <1475636338-3779-4-git-send-email-roderick@gaikai.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38789 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754534AbcJEDAc (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2016 23:00:32 -0400
Received: by mail-it0-f52.google.com with SMTP id o19so149292185ito.1
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2016 20:00:32 -0700 (PDT)
In-Reply-To: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 43bb24c..34988ce 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -36,6 +36,8 @@
 #include <linux/list.h>
 #include <linux/idr.h>
 #include <linux/input/mt.h>
+#include <linux/crc32.h>
+#include <asm/unaligned.h>
 
 #include "hid-ids.h"
 
@@ -1021,6 +1023,7 @@ struct motion_output_report_02 {
 
 #define DS4_FEATURE_REPORT_0x02_SIZE 37
 #define DS4_FEATURE_REPORT_0x81_SIZE 7
+#define DS4_INPUT_REPORT_0x11_SIZE 78
 #define DS4_OUTPUT_REPORT_0x05_SIZE 32
 #define DS4_OUTPUT_REPORT_0x11_SIZE 78
 #define SIXAXIS_REPORT_0xF2_SIZE 17
@@ -1324,6 +1327,21 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
 			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 			&& rd[0] == 0x11 && size == 78)) {
+		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
+			/* CRC check */
+			u8 bthdr = 0xA1;
+			u32 crc;
+			u32 report_crc;
+
+			crc = crc32_le(0xFFFFFFFF, &bthdr, 1);
+			crc = ~crc32_le(crc, rd, DS4_INPUT_REPORT_0x11_SIZE-4);
+			report_crc = get_unaligned_le32(&rd[DS4_INPUT_REPORT_0x11_SIZE-4]);
+			if (crc != report_crc) {
+				hid_dbg(sc->hdev, "DualShock 4 input report's CRC check failed, received crc 0x%0x != 0x%0x\n",
+					report_crc, crc);
+				return -EILSEQ;
+			}
+		}
 		dualshock4_parse_report(sc, rd, size);
 	}
 
-- 
2.7.4

