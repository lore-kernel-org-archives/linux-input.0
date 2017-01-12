From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] HID: corsair: fix control-transfer error handling
Date: Thu, 12 Jan 2017 18:17:43 +0100
Message-ID: <20170112171743.5972-3-johan@kernel.org>
References: <20170112171743.5972-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170112171743.5972-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Make sure to check for short control transfers in order to avoid parsing
uninitialised buffer data and leaking it to user space.

Note that the backlight and macro-mode buffer constraints are kept as
loose as possible in order to avoid any regressions should the current
buffer sizes be larger than necessary.

Fixes: 6f78193ee9ea ("HID: corsair: Add Corsair Vengeance K90 driver")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/hid/hid-corsair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 5971907a23b1..c0303f61c26a 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -159,7 +159,7 @@ static enum led_brightness k90_backlight_get(struct led_classdev *led_cdev)
 			      USB_DIR_IN | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE, 0, 0, data, 8,
 			      USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
+	if (ret < 5) {
 		dev_warn(dev, "Failed to get K90 initial state (error %d).\n",
 			 ret);
 		ret = -EIO;
@@ -274,7 +274,7 @@ static ssize_t k90_show_macro_mode(struct device *dev,
 			      USB_DIR_IN | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE, 0, 0, data, 2,
 			      USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
+	if (ret < 1) {
 		dev_warn(dev, "Failed to get K90 initial mode (error %d).\n",
 			 ret);
 		ret = -EIO;
@@ -351,7 +351,7 @@ static ssize_t k90_show_current_profile(struct device *dev,
 			      USB_DIR_IN | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE, 0, 0, data, 8,
 			      USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
+	if (ret < 8) {
 		dev_warn(dev, "Failed to get K90 initial state (error %d).\n",
 			 ret);
 		ret = -EIO;
-- 
2.10.2
