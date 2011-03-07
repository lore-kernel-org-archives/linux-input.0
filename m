From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 1/4] Input: atmel_mxt_ts - Remove firmware version check
Date: Mon, 07 Mar 2011 17:42:13 +0900
Message-ID: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43442 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab1CGJNO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 04:13:14 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHO00LL4IS6WQ80@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Mar 2011 17:40:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHO005D8IS6Z4@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Mar 2011 17:40:54 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

Atmel touchscreen chips have different firmware version with each chip,
so we cannot distinguish attribute of chip by firmware version.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6264ba8..0986fa4 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -60,11 +60,11 @@
 #define MXT_PROCG_NOISE		22
 #define MXT_PROCI_ONETOUCH	24
 #define MXT_PROCI_TWOTOUCH	27
-#define MXT_SPT_COMMSCONFIG	18	/* firmware ver 21 over */
+#define MXT_SPT_COMMSCONFIG	18
 #define MXT_SPT_GPIOPWM		19
 #define MXT_SPT_SELFTEST	25
 #define MXT_SPT_CTECONFIG	28
-#define MXT_SPT_USERDATA	38	/* firmware ver 21 over */
+#define MXT_SPT_USERDATA	38
 
 /* MXT_GEN_COMMAND field */
 #define MXT_COMMAND_RESET	0
@@ -115,7 +115,7 @@
 #define MXT_TOUCH_XEDGEDIST	27
 #define MXT_TOUCH_YEDGECTRL	28
 #define MXT_TOUCH_YEDGEDIST	29
-#define MXT_TOUCH_JUMPLIMIT	30	/* firmware ver 22 over */
+#define MXT_TOUCH_JUMPLIMIT	30
 
 /* MXT_PROCI_GRIPFACE field */
 #define MXT_GRIPFACE_CTRL	0
@@ -157,7 +157,7 @@
 #define MXT_CTE_MODE		2
 #define MXT_CTE_IDLEGCAFDEPTH	3
 #define MXT_CTE_ACTVGCAFDEPTH	4
-#define MXT_CTE_VOLTAGE		5	/* firmware ver 21 over */
+#define MXT_CTE_VOLTAGE		5
 
 #define MXT_VOLTAGE_DEFAULT	2700000
 #define MXT_VOLTAGE_STEP	10000
@@ -686,7 +686,7 @@ static void mxt_handle_pdata(struct mxt_data *data)
 			MXT_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
 
 	/* Set touchscreen voltage */
-	if (data->info.version >= MXT_VER_21 && pdata->voltage) {
+	if (pdata->voltage) {
 		if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
 			voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
 				MXT_VOLTAGE_STEP;
@@ -951,19 +951,8 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 					const char *buf, size_t count)
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
-	unsigned int version;
 	int error;
 
-	if (sscanf(buf, "%u", &version) != 1) {
-		dev_err(dev, "Invalid values\n");
-		return -EINVAL;
-	}
-
-	if (data->info.version < MXT_VER_21 || version < MXT_VER_21) {
-		dev_err(dev, "FW update supported starting with version 21\n");
-		return -EINVAL;
-	}
-
 	disable_irq(data->irq);
 
 	error = mxt_load_fw(dev, MXT_FW_NAME);
-- 
1.7.0.4

