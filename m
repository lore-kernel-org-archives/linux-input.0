From: Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH] Input: cap1106 - fix register definition
Date: Tue,  2 Sep 2014 08:32:24 +0200
Message-ID: <1409639544-30420-1-git-send-email-klaus.goger@theobroma-systems.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:48049 "EHLO
	mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751AbaIBGrd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 02:47:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Klaus Goger <klaus.goger@theobroma-systems.com>

Use the correct register address for Calibration Active and Interrupt
Enable

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---
 drivers/input/keyboard/cap1106.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/cap1106.c b/drivers/input/keyboard/cap1106.c
index 180b184..d70b65a 100644
--- a/drivers/input/keyboard/cap1106.c
+++ b/drivers/input/keyboard/cap1106.c
@@ -33,8 +33,8 @@
 #define CAP1106_REG_SENSOR_CONFIG	0x22
 #define CAP1106_REG_SENSOR_CONFIG2	0x23
 #define CAP1106_REG_SAMPLING_CONFIG	0x24
-#define CAP1106_REG_CALIBRATION		0x25
-#define CAP1106_REG_INT_ENABLE		0x26
+#define CAP1106_REG_CALIBRATION		0x26
+#define CAP1106_REG_INT_ENABLE		0x27
 #define CAP1106_REG_REPEAT_RATE		0x28
 #define CAP1106_REG_MT_CONFIG		0x2a
 #define CAP1106_REG_MT_PATTERN_CONFIG	0x2b
-- 
1.9.0

