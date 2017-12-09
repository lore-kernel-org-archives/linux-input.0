From: Mark Furneaux <mark@furneaux.ca>
Subject: [PATCH] Input: Add support for PDP Xbox One controllers
Date: Sat, 09 Dec 2017 17:26:15 -0500
Message-ID: <1a12e3c57f22f67a63d26f45fd4d997f@furneaux.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound21.reliablemail.org ([173.236.90.21]:41825 "EHLO
        outbound21.reliablemail.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751263AbdLIXBQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 9 Dec 2017 18:01:16 -0500
Received: from [184.154.46.16] (helo=pcluster12.stablehost.com)
        by filter03.reliabledns.org with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mark@furneaux.ca>)
        id 1eNnZZ-0005fH-CB
        for linux-input@vger.kernel.org; Sat, 09 Dec 2017 15:26:18 -0700
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

[PATCH] Input: Add support for PDP Xbox One controllers

Adds support for the current lineup of Xbox One controllers from PDP
(Performance Designed Products). These controllers are very picky with
their initialisation sequence and require an additional 2 packets before
they send any input reports.

Signed-off-by: mark@furneaux.ca

---
  drivers/input/joystick/xpad.c | 20 ++++++++++++++++++++
  1 file changed, 20 insertions(+)

diff --git a/drivers/input/joystick/xpad.c 
b/drivers/input/joystick/xpad.c
index d86e595..5e76be2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -229,6 +229,7 @@ static const struct xpad_device {
  	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 
},
  	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 
},
  	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, 
XTYPE_XBOXONE },
+	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
  	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
  	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, 
XTYPE_XBOXONE },
  	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
@@ -476,6 +477,22 @@ static const u8 xboxone_hori_init[] = {
  };

  /*
+ * This packet is required for some of the PDP pads to start
+ * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ */
+static const u8 xboxone_pdp_init1[] = {
+    0x0a, 0x20, 0x04, 0x03, 0x00, 0x01, 0x14
+};
+
+/*
+ * This packet is required for some of the PDP pads to start
+ * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ */
+static const u8 xboxone_pdp_init2[] = {
+    0x06, 0x20, 0x01, 0x02, 0x01, 0x00
+};
+
+/*
   * A specific rumble packet is required for some PowerA pads to start
   * sending input reports. One of those pads is (0x24c6:0x543a).
   */
@@ -504,7 +521,10 @@ static const u8 xboxone_rumbleend_init[] = {
  static const struct xboxone_init_packet xboxone_init_packets[] = {
  	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
  	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_fw2015_init),
  	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
  	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
  	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
  	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
