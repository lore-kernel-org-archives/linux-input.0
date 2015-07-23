From: duson <dusonlin@emc.com.tw>
Subject: [PATCH 2/2] Input - elantech: Add special check for fw_version 0x470f01 touchpad
Date: Thu, 23 Jul 2015 08:54:32 +0800
Message-ID: <93F83051-8AD8-41EA-9A43-CB1D32DA09E9@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:57197 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbGWAyi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2015 20:54:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dusonlin@emc.com.tw

It is no need to check the packet[0] for sanity check when doing
elantech_packet_check_v4() function for fw_version = 0x470f01 touchpad.

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elantech.c |   26 +++++++++++++++++++++++---
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ce3d400..6c6c2bb 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -784,6 +784,8 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 	unsigned char packet_type = packet[3] & 0x03;
 	bool sanity_check;
+	/* This represents the version of IC body. */
+	int ver = (etd->fw_version & 0x0f0000) >> 16;
 
 	if (etd->tp_dev && (packet[3] & 0x0f) == 0x06)
 		return PACKET_TRACKPOINT;
@@ -796,9 +798,17 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	 */
 	if (etd->crc_enabled)
 		sanity_check = ((packet[3] & 0x08) == 0x00);
-	else
-		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
-				(packet[3] & 0x1c) == 0x10);
+	else {
+		/* 
+		 * The sanity check only need to check packet[3]
+		 * when IC_body = 7 and PID = 0x2A  
+		 */
+		if (ver == 7 && etd->samples[1] == 0x2A)
+			sanity_check = ((packet[3] & 0x1c) == 0x10);
+		else
+			sanity_check = ((packet[0] & 0x0c) == 0x04 &&
+					(packet[3] & 0x1c) == 0x10);
+	}
 
 	if (!sanity_check)
 		return PACKET_UNKNOWN;
@@ -1117,6 +1127,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
  * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
+ * Fujitsu T725	           0x470f01        05, 12, 09      2 hw buttons
  * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
  * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
  * Lenovo L530             0x350f02        b9, 15, 0c      2 hw buttons (*)
@@ -1648,6 +1659,15 @@ int elantech_init(struct psmouse *psmouse)
 		     etd->capabilities[0], etd->capabilities[1],
 		     etd->capabilities[2]);
 
+	if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY,
+	    etd->samples)) {
+		psmouse_err(psmouse, "failed to query sample data.\n");
+		goto init_fail;
+	}
+	psmouse_info(psmouse,
+		     "Elan sample query result 0x%02x, 0x%02x, 0x%02x.\n",
+		     etd->samples[0], etd->samples[1], etd->samples[2]);
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index f965d15..e1cbf40 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -129,6 +129,7 @@ struct elantech_data {
 	unsigned char reg_26;
 	unsigned char debug;
 	unsigned char capabilities[3];
+	unsigned char samples[3];
 	bool paritycheck;
 	bool jumpy_cursor;
 	bool reports_pressure;






