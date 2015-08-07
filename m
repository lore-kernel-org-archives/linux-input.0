From: duson <dusonlin@emc.com.tw>
Subject: [PATCH 4/4] Input - elantech: Add special check for fw_version  0x470f01 touchpad
Date: Fri, 7 Aug 2015 17:38:45 +0800
Message-ID: <4478D504-18DD-463D-9CC3-2697A215B9B7@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:58424 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbbHGJiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 05:38:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

It is no need to check the packet[0] for sanity check when doing
elantech_packet_check_v4() function for fw_version = 0x470f01 touchpad.

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elantech.c |   20 ++++++++++++++++++++
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 22b9ca9..2a0f883 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -785,6 +785,9 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	unsigned char packet_type = packet[3] & 0x03;
 	bool sanity_check;
 
+	/* This represents the version of IC body. */
+	int ver = (etd->fw_version & 0x0f0000) >> 16;
+
 	if (etd->tp_dev && (packet[3] & 0x0f) == 0x06)
 		return PACKET_TRACKPOINT;
 
@@ -796,6 +799,12 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	 */
 	if (etd->crc_enabled)
 		sanity_check = ((packet[3] & 0x08) == 0x00);
+	/*
+	 * The sanity check only need to check packet[3]
+	 * when IC_body = 7 and PID = 0x2A
+	 */
+	else if (ver == 7 && etd->samples[1] == 0x2A)
+		sanity_check = ((packet[3] & 0x1c) == 0x10);
 	else
 		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
 				(packet[3] & 0x1c) == 0x10);
@@ -1116,6 +1125,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
  * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
+ * Fujitsu T725	           0x470f01        05, 12, 09      2 hw buttons
  * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
  * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
  * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
@@ -1651,6 +1661,16 @@ int elantech_init(struct psmouse *psmouse)
 		     etd->capabilities[0], etd->capabilities[1],
 		     etd->capabilities[2]);
 
+	if (etd->hw_version != 1) {
+		if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY, etd->samples)) {
+			psmouse_err(psmouse, "failed to query sample data\n");
+			goto init_fail;
+		}
+		psmouse_info(psmouse,
+			    "Elan sample query result %02x, %02x, %02x\n",
+			    etd->samples[0], etd->samples[1], etd->samples[2]);
+	}
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






