From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/7] input: atmel_mxt_ts: check mxt224 family before writing touchscreen voltage
Date: Thu,  7 Feb 2013 15:17:44 +0100
Message-ID: <1360246668-2291-4-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47047 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758426Ab3BGOSA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:00 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

only the mxt224 has a SPT_CTECONFIG_T28 object, the mxt224e doesn't

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 63a82bb..17cc15a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -41,6 +41,10 @@
 #define MXT_OBJECT_NUM		0x06
 #define MXT_OBJECT_START	0x07
 
+/* Family IDs */
+#define MXT224_ID	0x80
+#define MXT224E_ID	0x81
+
 #define MXT_OBJECT_SIZE		6
 
 /* Object types */
@@ -687,7 +691,7 @@ static void mxt_handle_pdata(struct mxt_data *data)
 			MXT_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
 
 	/* Set touchscreen voltage */
-	if (pdata->voltage) {
+	if (pdata->voltage && data->info.family_id == MXT224_ID) {
 		if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
 			voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
 				MXT_VOLTAGE_STEP;
-- 
1.7.9.5

