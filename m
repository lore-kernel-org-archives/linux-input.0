From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: egalax_ts - remove unused definitions
Date: Fri,  4 Mar 2016 19:07:58 -0300
Message-ID: <1457129278-9165-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36484 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759277AbcCDWIR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2016 17:08:17 -0500
Received: by mail-yw0-f169.google.com with SMTP id i131so42201377ywc.3
        for <linux-input@vger.kernel.org>; Fri, 04 Mar 2016 14:08:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

REPORT_MODE_MOUSE and REPORT_MODE_VENDOR are never used in the driver,
so let's just remove them.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/input/touchscreen/egalax_ts.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 1afc08b..a260476 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -29,18 +29,6 @@
 #include <linux/input/mt.h>
 #include <linux/of_gpio.h>
 
-/*
- * Mouse Mode: some panel may configure the controller to mouse mode,
- * which can only report one point at a given time.
- * This driver will ignore events in this mode.
- */
-#define REPORT_MODE_MOUSE		0x1
-/*
- * Vendor Mode: this mode is used to transfer some vendor specific
- * messages.
- * This driver will ignore events in this mode.
- */
-#define REPORT_MODE_VENDOR		0x3
 /* Multiple Touch Mode */
 #define REPORT_MODE_MTTOUCH		0x4
 
-- 
1.9.1

