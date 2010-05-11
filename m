From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: elantech - use all 3 bytes when checking version
Date: Tue, 11 May 2010 01:18:48 -0700
Message-ID: <20100511081848.10546.95545.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42276 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0EKISw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 04:18:52 -0400
Received: by pvb32 with SMTP id 32so410917pvb.19
        for <linux-input@vger.kernel.org>; Tue, 11 May 2010 01:18:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>, =?utf-8?b?w4lyaWM=?= Piel <E.A.B.Piel@tudelft.nl>, Arjan Opmeer <arjan@opmeer.net>

Apparently all 3 bytes returned by ETP_FW_VERSION_QUERY are significant
and shoudl be taken into account when matching hardware version/features.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/elantech.c |   24 ++++++++++++------------
 drivers/input/mouse/elantech.h |    5 ++---
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 0520c2e..112b4ee 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -185,7 +185,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 	int fingers;
 	static int old_fingers;
 
-	if (etd->fw_version_maj == 0x01) {
+	if (etd->fw_version < 0x020000) {
 		/*
 		 * byte 0:  D   U  p1  p2   1  p3   R   L
 		 * byte 1:  f   0  th  tw  x9  x8  y9  y8
@@ -227,7 +227,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
 
-	if ((etd->fw_version_maj == 0x01) &&
+	if (etd->fw_version < 0x020000 &&
 	    (etd->capabilities & ETP_CAP_HAS_ROCKER)) {
 		/* rocker up */
 		input_report_key(dev, BTN_FORWARD, packet[0] & 0x40);
@@ -321,7 +321,7 @@ static int elantech_check_parity_v1(struct psmouse *psmouse)
 	unsigned char p1, p2, p3;
 
 	/* Parity bits are placed differently */
-	if (etd->fw_version_maj == 0x01) {
+	if (etd->fw_version < 0x020000) {
 		/* byte 0:  D   U  p1  p2   1  p3   R   L */
 		p1 = (packet[0] & 0x20) >> 5;
 		p2 = (packet[0] & 0x10) >> 4;
@@ -457,7 +457,7 @@ static void elantech_set_input_params(struct psmouse *psmouse)
 	switch (etd->hw_version) {
 	case 1:
 		/* Rocker button */
-		if ((etd->fw_version_maj == 0x01) &&
+		if (etd->fw_version < 0x020000 &&
 		    (etd->capabilities & ETP_CAP_HAS_ROCKER)) {
 			__set_bit(BTN_FORWARD, dev->keybit);
 			__set_bit(BTN_BACK, dev->keybit);
@@ -686,15 +686,14 @@ int elantech_init(struct psmouse *psmouse)
 		pr_err("elantech.c: failed to query firmware version.\n");
 		goto init_fail;
 	}
-	etd->fw_version_maj = param[0];
-	etd->fw_version_min = param[2];
+
+	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
 
 	/*
 	 * Assume every version greater than this is new EeePC style
 	 * hardware with 6 byte packets
 	 */
-	if ((etd->fw_version_maj == 0x02 && etd->fw_version_min >= 0x30) ||
-	    etd->fw_version_maj > 0x02) {
+	if (etd->fw_version >= 0x020030) {
 		etd->hw_version = 2;
 		/* For now show extra debug information */
 		etd->debug = 1;
@@ -704,8 +703,9 @@ int elantech_init(struct psmouse *psmouse)
 		etd->hw_version = 1;
 		etd->paritycheck = 1;
 	}
-	pr_info("elantech.c: assuming hardware version %d, firmware version %d.%d\n",
-		etd->hw_version, etd->fw_version_maj, etd->fw_version_min);
+
+	pr_info("elantech.c: assuming hardware version %d, firmware version %d.%d.%d\n",
+		etd->hw_version, param[0], param[1], param[2]);
 
 	if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY, param)) {
 		pr_err("elantech.c: failed to query capabilities.\n");
@@ -720,8 +720,8 @@ int elantech_init(struct psmouse *psmouse)
 	 * a touch action starts causing the mouse cursor or scrolled page
 	 * to jump. Enable a workaround.
 	 */
-	if (etd->fw_version_maj == 0x02 && etd->fw_version_min == 0x22) {
-		pr_info("elantech.c: firmware version 2.34 detected, "
+	if (etd->fw_version == 0x020022) {
+		pr_info("elantech.c: firmware version 2.0.34 detected, "
 			"enabling jumpy cursor workaround\n");
 		etd->jumpy_cursor = 1;
 	}
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index feac5f7..ac57bde 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -100,11 +100,10 @@ struct elantech_data {
 	unsigned char reg_26;
 	unsigned char debug;
 	unsigned char capabilities;
-	unsigned char fw_version_maj;
-	unsigned char fw_version_min;
-	unsigned char hw_version;
 	unsigned char paritycheck;
 	unsigned char jumpy_cursor;
+	unsigned char hw_version;
+	unsigned int  fw_version;
 	unsigned char parity[256];
 };
 

