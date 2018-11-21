From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/7] Revert "HID: logitech: fix a used uninitialized GCC warning"
Date: Wed, 21 Nov 2018 16:27:07 +0100
Message-ID: <20181121152712.6770-3-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, torvalds@linux-foundation.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit 5fe2ccbef9d7aecf5c4402c753444f1a12096cfd.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f01280898b24..5f0c080059c6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1231,6 +1231,7 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	*multiplier = response.fap.params[0];
 	return 0;
 return_default:
+	*multiplier = 8;
 	hid_warn(hidpp->hid_dev,
 		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
 		 ret, *multiplier);
@@ -2695,7 +2696,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
 static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
-	u8 multiplier = 8;
+	u8 multiplier;
 
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
 		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
@@ -2703,9 +2704,10 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
 							   &multiplier);
-	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */
+	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
 		ret = hidpp10_enable_scrolling_acceleration(hidpp);
-
+		multiplier = 8;
+	}
 	if (ret)
 		return ret;
 
-- 
2.19.1
