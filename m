From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] HID: logitech: fix a used uninitialized GCC warning
Date: Thu, 13 Sep 2018 11:52:19 +0800
Message-ID: <1536810739-27342-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Fix the following compile warning:

drivers/hid/hid-logitech-hidpp.c: In function hi_res_scroll_enable:
drivers/hid/hid-logitech-hidpp.c:2714:54: warning: multiplier may be used uninitialized in this function [-Wmaybe-uninitialized]
  hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f0c080..83c43dd 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2696,7 +2696,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
 static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
-	u8 multiplier;
+	u8 uninitialized_var(multiplier);
 
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
 		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
-- 
1.7.12.4
