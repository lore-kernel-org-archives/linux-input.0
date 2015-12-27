From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 4/5] HID: wiimote: use dev_to_wii()
Date: Sun, 27 Dec 2015 17:25:23 +0800
Message-ID: <aa8060c2f9e42359a9b1fc402f8d48ce9045e840.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
In-Reply-To: <1f3f9887783a36170a5972e6819c7841db95d888.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com> <3c9a720e58ea32c5df098cbe744c6b5821a756a6.1451206516.git.geliangtang@163.com> <1f3f9887783a36170a5972e6819c7841db95d888.1451206516.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use dev_to_wii() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/hid/hid-wiimote-modules.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 05e23c4..4390eee 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -296,14 +296,12 @@ static const struct wiimod_ops wiimod_battery = {
 
 static enum led_brightness wiimod_led_get(struct led_classdev *led_dev)
 {
-	struct wiimote_data *wdata;
 	struct device *dev = led_dev->dev->parent;
+	struct wiimote_data *wdata = dev_to_wii(dev);
 	int i;
 	unsigned long flags;
 	bool value = false;
 
-	wdata = hid_get_drvdata(container_of(dev, struct hid_device, dev));
-
 	for (i = 0; i < 4; ++i) {
 		if (wdata->leds[i] == led_dev) {
 			spin_lock_irqsave(&wdata->state.lock, flags);
@@ -319,14 +317,12 @@ static enum led_brightness wiimod_led_get(struct led_classdev *led_dev)
 static void wiimod_led_set(struct led_classdev *led_dev,
 			   enum led_brightness value)
 {
-	struct wiimote_data *wdata;
 	struct device *dev = led_dev->dev->parent;
+	struct wiimote_data *wdata = dev_to_wii(dev);
 	int i;
 	unsigned long flags;
 	__u8 state, flag;
 
-	wdata = hid_get_drvdata(container_of(dev, struct hid_device, dev));
-
 	for (i = 0; i < 4; ++i) {
 		if (wdata->leds[i] == led_dev) {
 			flag = WIIPROTO_FLAG_LED(i + 1);
-- 
2.5.0
