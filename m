From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH 1/2] Input: elantech - better support all those v2 variants
Date: Tue, 13 Sep 2011 14:15:48 +0800
Message-ID: <1315894549-24504-2-git-send-email-jj_ding@emc.com.tw>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:38687 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab1IMGNX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 02:13:23 -0400
In-Reply-To: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Richard=20Sch=C3=BCtz?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>

V2 hardware has many variants. This patch adddresses two issues:

 - some model also has debounce packets, but with a different signature
   than v3. Now we just check debounce for all v2 hardware.

 - due to different scanning methods the hardware uses, x and y ranges have
   to be calculated differently. And for some specific versions, we can just
   see them as custom-made, so set {x, y} the same values as Windows driver
   does.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
---
 drivers/input/mouse/elantech.c |   46 +++++++++++++++++++++++++++++++++++----
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 38fb155..63a0ce7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -613,6 +613,18 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
 	       etd->parity[packet[3]] == p3;
 }
 
+static int elantech_debounce_check_v2(struct psmouse *psmouse)
+{
+        /*
+         * When we encounter packet that matches this exactly, it means the
+         * hardware is in debounce status. Just ignore the whole packet.
+         */
+        const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
+        unsigned char *packet = psmouse->packet;
+
+        return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
+}
+
 static int elantech_packet_check_v2(struct psmouse *psmouse)
 {
 	struct elantech_data *etd = psmouse->private;
@@ -708,6 +720,10 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 		break;
 
 	case 2:
+		/* ignore debounce */
+		if (elantech_debounce_check_v2(psmouse))
+			return PSMOUSE_FULL_PACKET;
+
 		if (etd->paritycheck && !elantech_packet_check_v2(psmouse))
 			return PSMOUSE_BAD_DATA;
 
@@ -824,7 +840,6 @@ static int set_range(struct psmouse *psmouse, unsigned int *x_min,
 	struct elantech_data *etd = psmouse->private;
 	unsigned char param[3];
 	unsigned char traces;
-	int i;
 
 	switch (etd->hw_version) {
 	case 1:
@@ -843,12 +858,33 @@ static int set_range(struct psmouse *psmouse, unsigned int *x_min,
 			*x_max = ETP_XMAX_V2;
 			*y_max = ETP_YMAX_V2;
 		} else {
+			int i;
+			int fixed_dpi;
+
 			i = (etd->fw_version > 0x020800 &&
 			     etd->fw_version < 0x020900) ? 1 : 2;
-			*x_min = 0;
-			*y_min = 0;
-			*x_max = (etd->capabilities[1] - i) * 64;
-			*y_max = (etd->capabilities[2] - i) * 64;
+
+			if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+				return -1;
+
+			fixed_dpi = param[1] & 0x10;
+
+			if (((etd->fw_version >> 16) == 0x14) && fixed_dpi) {
+				if (synaptics_send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
+					return -1;
+
+				*x_max = (etd->capabilities[1] - i) * param[1] / 2;
+				*y_max = (etd->capabilities[2] - i) * param[2] / 2;
+			} else if (etd->fw_version == 0x040216) {
+				*x_max = 819;
+				*y_max = 405;
+			} else if (etd->fw_version == 0x040219 || etd->fw_version == 0x040215) {
+				*x_max = 900;
+				*y_max = 500;
+			} else {
+				*x_max = (etd->capabilities[1] - i) * 64;
+				*y_max = (etd->capabilities[2] - i) * 64;
+			}
 		}
 		break;
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 7ecaef0..9e5f1aa 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -19,6 +19,7 @@
 #define ETP_FW_ID_QUERY			0x00
 #define ETP_FW_VERSION_QUERY		0x01
 #define ETP_CAPABILITIES_QUERY		0x02
+#define ETP_SAMPLE_QUERY		0x03
 
 /*
  * Command values for register reading or writing
-- 
1.7.4.1

