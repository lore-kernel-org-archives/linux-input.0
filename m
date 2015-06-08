From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 2/8] input: goodix: fix variable length array warning
Date: Mon,  8 Jun 2015 17:37:47 +0300
Message-ID: <1433774273-23103-3-git-send-email-irina.tirdea@intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52563 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbbFHOjx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jun 2015 10:39:53 -0400
In-Reply-To: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>

Fix sparse warning:
drivers/input/touchscreen/goodix.c:182:26: warning:
Variable length array is used.

Replace the variable length array with fixed length.

Some Goodix devices have maximum 5 touch points, while
others have 10 touch points. Using the maximum length
(80 bytes) for all devices will lead to wasting 40 bytes
when using devices with maximum 5 touch points. However,
that is prefferable to using kmalloc which will use even
more resources.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index a65e4d9..18557e4 100644
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

