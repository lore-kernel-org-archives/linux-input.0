From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 5/7] input: atmel_mxt_ts: only apply mxt_platform_data blen and threshold on mxt224, not mxt224e
Date: Thu,  7 Feb 2013 15:17:46 +0100
Message-ID: <1360246668-2291-6-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47054 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758631Ab3BGOSB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:01 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

on the mxt224e, the upper 4 bits of blen are gain and the threshold should probably be set in CTECONFIG

mxt_handle_pdata() is problematic as there is no way to NOT apply settings

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7fdd439..313b201 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -673,14 +673,6 @@ static void mxt_handle_pdata(struct mxt_data *data)
 	mxt_write_object(data, MXT_TOUCH_MULTI_T9, MXT_TOUCH_ORIENT,
 			pdata->orient);
 
-	/* Set touchscreen burst length */
-	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
-			MXT_TOUCH_BLEN, pdata->blen);
-
-	/* Set touchscreen threshold */
-	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
-			MXT_TOUCH_TCHTHR, pdata->threshold);
-
 	/* Set touchscreen resolution */
 	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_XRANGE_LSB, (pdata->x_size - 1) & 0xff);
@@ -693,6 +685,14 @@ static void mxt_handle_pdata(struct mxt_data *data)
 
 	/* Set touchscreen voltage */
 	if (pdata->voltage && data->info.family_id == MXT224_ID) {
+		/* Set touchscreen burst length */
+		mxt_write_object(data, MXT_TOUCH_MULTI_T9,
+				MXT_TOUCH_BLEN, pdata->blen);
+
+		/* Set touchscreen threshold */
+		mxt_write_object(data, MXT_TOUCH_MULTI_T9,
+				MXT_TOUCH_TCHTHR, pdata->threshold);
+
 		if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
 			voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
 				MXT_VOLTAGE_STEP;
-- 
1.7.9.5

