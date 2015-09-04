From: "james.chen" <james.chen@emc.com.tw>
Subject: [PATCH] MAINLINE: Input: elants_i2c: Extend the calibration timeout to 12 second.
Date: Fri,  4 Sep 2015 11:26:57 +0800
Message-ID: <1441337217-1351-1-git-send-email-james.chen@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:56529 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbbIDDpa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 23:45:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Herman Lin <herman.lin@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Charlie Mooney <charliemooney@chromium.org>, "james.chen" <james.chen@emc.com.tw>

From: "james.chen" <james.chen@emc.com.tw>

As the test result of chrome project buddy(23 inch),
the calibration time is about 9.2~10.5 second.
So, this patch extend the calibration timeout to 12 second.

BUG= none
TEST= Build and test on buddy project.

Signed-off-by: James Chen <james.chen@emc.com.tw>
---
 drivers/input/touchscreen/elants_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index ddac134..17cc20e 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -102,7 +102,7 @@
 #define ELAN_FW_PAGESIZE	132
 
 /* calibration timeout definition */
-#define ELAN_CALI_TIMEOUT_MSEC	10000
+#define ELAN_CALI_TIMEOUT_MSEC	12000
 
 #define ELAN_POWERON_DELAY_USEC	500
 #define ELAN_RESET_DELAY_MSEC	20
-- 
1.8.3.2

