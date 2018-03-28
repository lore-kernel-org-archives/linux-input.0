From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] HID: google: Enable PM Full On mode when adjusting backlight
Date: Wed, 28 Mar 2018 14:16:10 +0800
Message-ID: <20180328061610.206090-1-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, groeck@chromium.org, dtor@chromium.org, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-input@vger.kernel.org

From: Haridhar Kalvala <haridhar.kalvala@intel.com>

hammer LED backlight brightness is not getting set when USB
device is in suspend state.

This patch fixes the issue by requesting USB HID device to be
in FULLON mode, so that sending hardware output report and
hardware raw request won't fail to set brightness, and set
device back to NORMAL mode once this call returns.

Signed-off-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

Changes from version on Chromium OS gerrit
(https://chromium-review.googlesource.com/735259):
 - Reworded and reflowed commit message, as well as comment in code.

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 6486469ce0f64..7b8e17b03cb86 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -41,6 +41,16 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 	led->buf[0] = 0;
 	led->buf[1] = br;
 
+	/*
+	 * Request USB HID device to be in Full On mode, so that sending
+	 * hardware output report and hardware raw request won't fail.
+	 */
+	ret = hid_hw_power(led->hdev, PM_HINT_FULLON);
+	if (ret < 0) {
+		hid_err(led->hdev, "failed: device not resumed %d\n", ret);
+		return ret;
+	}
+
 	ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
 	if (ret == -ENOSYS)
 		ret = hid_hw_raw_request(led->hdev, 0, led->buf,
@@ -50,6 +60,10 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 	if (ret < 0)
 		hid_err(led->hdev, "failed to set keyboard backlight: %d\n",
 			ret);
+
+	/* Request USB HID device back to Normal Mode. */
+	hid_hw_power(led->hdev, PM_HINT_NORMAL);
+
 	return ret;
 }
 
-- 
2.17.0.rc1.321.gba9d0f2565-goog
