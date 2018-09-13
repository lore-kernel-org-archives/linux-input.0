From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH v2] HID: logitech: fix a used uninitialized GCC warning
Date: Thu, 13 Sep 2018 15:41:10 +0800
Message-ID: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Fix the following compile warning:

drivers/hid/hid-logitech-hidpp.c: In function 'hi_res_scroll_enable':
drivers/hid/hid-logitech-hidpp.c:2714:54: warning: 'multiplier' may be used uninitialized in this function [-Wmaybe-uninitialized]
  hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
     According to Benjamin's suggestion, To initialize the value
and remove the duplicated assignement. 

 drivers/hid/hid-logitech-hidpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f0c080..f012808 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1231,7 +1231,6 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	*multiplier = response.fap.params[0];
 	return 0;
 return_default:
-	*multiplier = 8;
 	hid_warn(hidpp->hid_dev,
 		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
 		 ret, *multiplier);
@@ -2696,7 +2695,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
 static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
-	u8 multiplier;
+	u8 multiplier = 8;
 
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
 		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
@@ -2704,10 +2703,9 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
 							   &multiplier);
-	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
+	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */
 		ret = hidpp10_enable_scrolling_acceleration(hidpp);
-		multiplier = 8;
-	}
+
 	if (ret)
 		return ret;
 
-- 
1.7.12.4
