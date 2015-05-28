From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 2/9] input: goodix: fix variable length array warning
Date: Thu, 28 May 2015 15:47:38 +0300
Message-ID: <1432817265-23891-3-git-send-email-irina.tirdea@intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9326 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577AbbE1MsQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 08:48:16 -0400
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

Fix sparse warning:
drivers/input/touchscreen/goodix.c:182:26: warning:
Variable length array is used.

Replace the variable length array with fixed length.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index c2e785c..dac1b3c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -147,7 +147,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
  */
 static void goodix_process_events(struct goodix_ts_data *ts)
 {
-	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
+	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
 	int touch_num;
 	int i;
 
-- 
1.9.1

