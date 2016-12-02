From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elantech - Add a special mode for a specific FW The touchapd which sample ver is 0x74 and hw_version is 0x03 have a fw bug which will cause crush sometimes, I add some work-around for it and our customer ask us to upstream the patch Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Fri,  2 Dec 2016 13:59:17 +0800
Message-ID: <1480658357-18320-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:30728 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbcLBF5x (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2016 00:57:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw

---
 drivers/input/mouse/elantech.c | 152 +++++++++++++++++++++++++++++++++++------
 1 file changed, 131 insertions(+), 21 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index db7d1d6..acfe7f2 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -539,6 +539,30 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 	input_sync(dev);
 }
 
+static psmouse_ret_t elantech_report_relative_v3(struct psmouse *psmouse)
+{
+	struct input_dev *dev = psmouse->dev;
+	unsigned char *packet = psmouse->packet;
+	int rel_x = 0, rel_y = 0;
+
+	if (psmouse->pktcnt < psmouse->pktsize)
+		return PSMOUSE_GOOD_DATA;
+
+	input_report_rel(dev, REL_WHEEL, -(signed char)packet[3]);
+
+	rel_x = (int) packet[1] - (int) ((packet[0] << 4) & 0x100);
+	rel_y = (int) ((packet[0] << 3) & 0x100) - (int) packet[2];
+
+	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
+	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
+	input_report_rel(dev, REL_X, rel_x);
+	input_report_rel(dev, REL_Y, rel_y);
+
+	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
+}
+
 static void elantech_input_sync_v4(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
@@ -696,14 +720,14 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
 
 static int elantech_debounce_check_v2(struct psmouse *psmouse)
 {
-        /*
-         * When we encounter packet that matches this exactly, it means the
-         * hardware is in debounce status. Just ignore the whole packet.
-         */
-        const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
-        unsigned char *packet = psmouse->packet;
-
-        return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
+	/*
+	 * When we encounter packet that matches this exactly, it means the
+	 * hardware is in debounce status. Just ignore the whole packet.
+	 */
+	const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
+	unsigned char *packet = psmouse->packet;
+
+	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
 }
 
 static int elantech_packet_check_v2(struct psmouse *psmouse)
@@ -995,6 +1019,29 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 	return rc;
 }
 
+/* it's the work around mode for some touchpad which has FW bug, but dont' support IAP funciton */
+static int elantech_set_special_mode(struct psmouse *psmouse)
+{
+	unsigned char param[3];
+	int rc = 0;
+
+	param[0] = 0xc8;
+	param[1] = 0x64;
+	param[2] = 0x50;
+
+	if (elantech_ps2_command(psmouse, &param[0], PSMOUSE_CMD_SETRATE) ||
+	   elantech_ps2_command(psmouse, &param[1], PSMOUSE_CMD_SETRATE) ||
+	   elantech_ps2_command(psmouse, &param[2], PSMOUSE_CMD_SETRATE) ||
+	   elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETID)) {
+		rc = -1;
+	}
+
+	psmouse->set_rate(psmouse, 0x64);
+	psmouse->set_resolution(psmouse, 200);
+
+	return rc;
+}
+
 static int elantech_set_range(struct psmouse *psmouse,
 			      unsigned int *x_min, unsigned int *y_min,
 			      unsigned int *x_max, unsigned int *y_max,
@@ -1279,6 +1326,32 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	return 0;
 }
 
+static int elantech_set_input_params_special(struct psmouse *psmouse)
+{
+	struct input_dev *dev = psmouse->dev;
+	struct elantech_data *etd = psmouse->private;
+	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
+
+	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
+		return -1;
+
+	__set_bit(INPUT_PROP_POINTER, dev->propbit);
+	__set_bit(EV_KEY, dev->evbit);
+
+	__set_bit(BTN_LEFT, dev->keybit);
+	__set_bit(BTN_RIGHT, dev->keybit);
+
+	__set_bit(EV_REL, dev->evbit);
+	__set_bit(REL_X, dev->relbit);
+	__set_bit(REL_Y, dev->relbit);
+	__set_bit(REL_WHEEL, dev->relbit);
+
+	etd->y_max = y_max;
+	etd->width = width;
+
+	return 0;
+}
+
 struct elantech_attr_data {
 	size_t		field_offset;
 	unsigned char	reg;
@@ -1483,15 +1556,28 @@ static void elantech_disconnect(struct psmouse *psmouse)
  */
 static int elantech_reconnect(struct psmouse *psmouse)
 {
+
+	struct elantech_data *etd = psmouse->private;
+
 	psmouse_reset(psmouse);
 
 	if (elantech_detect(psmouse, 0))
 		return -1;
 
-	if (elantech_set_absolute_mode(psmouse)) {
-		psmouse_err(psmouse,
-			    "failed to put touchpad back into absolute mode.\n");
-		return -1;
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		/* handle specail FW issue */
+		psmouse_info(psmouse, "ELANTECH special OTP FW detected and call special handle\n");
+		if (elantech_set_special_mode(psmouse)) {
+			psmouse_err(psmouse,
+				    "failed to put touchpad back into special mode.\n");
+			return -1;
+		}
+	} else {
+		if (elantech_set_absolute_mode(psmouse)) {
+			psmouse_err(psmouse,
+				    "failed to put touchpad back into absolute mode.\n");
+			return -1;
+		}
 	}
 
 	return 0;
@@ -1687,10 +1773,20 @@ int elantech_init(struct psmouse *psmouse)
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
 
-	if (elantech_set_absolute_mode(psmouse)) {
-		psmouse_err(psmouse,
-			    "failed to put touchpad into absolute mode.\n");
-		goto init_fail;
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		/* handle specail FW issue */
+		psmouse_info(psmouse, "ELANTECH special OTP FW detected and call special handle\n");
+		if (elantech_set_special_mode(psmouse)) {
+			psmouse_err(psmouse,
+				    "failed to put touchpad back into special mode.\n");
+			return -1;
+		}
+	} else {
+		if (elantech_set_absolute_mode(psmouse)) {
+			psmouse_err(psmouse,
+				    "failed to put touchpad back into absolute mode.\n");
+			return -1;
+		}
 	}
 
 	if (etd->fw_version == 0x381f17) {
@@ -1698,9 +1794,17 @@ int elantech_init(struct psmouse *psmouse)
 		psmouse->set_rate = elantech_set_rate_restore_reg_07;
 	}
 
-	if (elantech_set_input_params(psmouse)) {
-		psmouse_err(psmouse, "failed to query touchpad range.\n");
-		goto init_fail;
+
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		if (elantech_set_input_params_special(psmouse)) {
+			psmouse_err(psmouse, "failed to query touchpad range for special FW.\n");
+			goto init_fail;
+		}
+	} else {
+		if (elantech_set_input_params(psmouse)) {
+			psmouse_err(psmouse, "failed to query touchpad range.\n");
+			goto init_fail;
+		}
 	}
 
 	error = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
@@ -1746,10 +1850,16 @@ int elantech_init(struct psmouse *psmouse)
 			goto init_fail_tp_reg;
 	}
 
-	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
-	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
+
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		psmouse->protocol_handler = elantech_report_relative_v3;
+		psmouse->pktsize = 4;
+	} else {
+		psmouse->protocol_handler = elantech_process_byte;
+		psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
+	}
 
 	return 0;
  init_fail_tp_reg:
-- 
2.7.4

