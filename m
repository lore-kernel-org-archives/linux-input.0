From: Mark Furneaux <mark@furneaux.ca> (by way of Mark Furneaux
        <mark@furneaux.ca>)
Subject: [PATCH v2] Input: Add support for PDP Xbox One controllers
Date: Sun, 10 Dec 2017 18:52:08 -0500
Message-ID: <20171210185208.08d7e52c@volta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound214.reliablemail.org ([173.236.5.214]:60531 "EHLO
        outbound214.reliablemail.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751137AbdLKAZU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 10 Dec 2017 19:25:20 -0500
Received: from [184.154.46.16] (helo=pcluster12.stablehost.com)
        by filter02.reliabledns.org with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mark@furneaux.ca>)
        id 1eOBV2-00048W-DW
        for linux-input@vger.kernel.org; Sun, 10 Dec 2017 16:59:14 -0700
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mark@furneaux.ca

Input: Add support for PDP Xbox One controllers

Adds support for the current lineup of Xbox One controllers from PDP
(Performance Designed Products). These controllers are very picky with
their initialization sequence and require an additional 2 packets before
they send any input reports.

Signed-off-by: Mark Furneaux <mark@furneaux.ca>

---
Changes in v2:

- Zeroed the sequence numbers and removed the redundant quirk entry.
- Corrected mangled formatting from my email client.

 drivers/input/joystick/xpad.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d86e595..d88d3e0 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -229,6 +229,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
@@ -476,6 +477,22 @@ static const u8 xboxone_hori_init[] = {
 };
 
 /*
+ * This packet is required for some of the PDP pads to start
+ * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ */
+static const u8 xboxone_pdp_init1[] = {
+	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
+};
+
+/*
+ * This packet is required for some of the PDP pads to start
+ * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ */
+static const u8 xboxone_pdp_init2[] = {
+	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
+};
+
+/*
  * A specific rumble packet is required for some PowerA pads to start
  * sending input reports. One of those pads is (0x24c6:0x543a).
  */
@@ -505,6 +522,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
