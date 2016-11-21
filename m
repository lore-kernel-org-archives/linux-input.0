From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] HID: cp2112: make transfer buffers DMA capable
Date: Mon, 21 Nov 2016 11:48:39 +0100
Message-ID: <1479725322-30863-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Kernel v4.9 strictly enforces DMA capable buffers, so we need to remove
buffers allocated on the stack.

Use a spinlock to prevent concurrent accesses to the buffer.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-cp2112.c | 115 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 086d8a5..60d3020 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -32,6 +32,11 @@
 #include <linux/usb/ch9.h>
 #include "hid-ids.h"
 
+#define CP2112_REPORT_MAX_LENGTH		64
+#define CP2112_GPIO_CONFIG_LENGTH		5
+#define CP2112_GPIO_GET_LENGTH			2
+#define CP2112_GPIO_SET_LENGTH			3
+
 enum {
 	CP2112_GPIO_CONFIG		= 0x02,
 	CP2112_GPIO_GET			= 0x03,
@@ -161,6 +166,8 @@ struct cp2112_device {
 	atomic_t read_avail;
 	atomic_t xfer_avail;
 	struct gpio_chip gc;
+	u8 *in_out_buffer;
+	spinlock_t lock;
 };
 
 static int gpio_push_pull = 0xFF;
@@ -171,62 +178,86 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
-	u8 buf[5];
+	u8 *buf = dev->in_out_buffer;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&dev->lock, flags);
+
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
-				       sizeof(buf), HID_FEATURE_REPORT,
-				       HID_REQ_GET_REPORT);
-	if (ret != sizeof(buf)) {
+				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret != CP2112_GPIO_CONFIG_LENGTH) {
 		hid_err(hdev, "error requesting GPIO config: %d\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	buf[1] &= ~(1 << offset);
 	buf[2] = gpio_push_pull;
 
-	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf, sizeof(buf),
-				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
+				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
 	if (ret < 0) {
 		hid_err(hdev, "error setting GPIO config: %d\n", ret);
-		return ret;
+		goto exit;
 	}
 
-	return 0;
+	ret = 0;
+
+exit:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret <= 0 ? ret : -EIO;
 }
 
 static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
-	u8 buf[3];
+	u8 *buf = dev->in_out_buffer;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&dev->lock, flags);
+
 	buf[0] = CP2112_GPIO_SET;
 	buf[1] = value ? 0xff : 0;
 	buf[2] = 1 << offset;
 
-	ret = hid_hw_raw_request(hdev, CP2112_GPIO_SET, buf, sizeof(buf),
-				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_SET, buf,
+				 CP2112_GPIO_SET_LENGTH, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
 	if (ret < 0)
 		hid_err(hdev, "error setting GPIO values: %d\n", ret);
+
+	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
-	u8 buf[2];
+	u8 *buf = dev->in_out_buffer;
+	unsigned long flags;
 	int ret;
 
-	ret = hid_hw_raw_request(hdev, CP2112_GPIO_GET, buf, sizeof(buf),
-				       HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
-	if (ret != sizeof(buf)) {
+	spin_lock_irqsave(&dev->lock, flags);
+
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_GET, buf,
+				 CP2112_GPIO_GET_LENGTH, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret != CP2112_GPIO_GET_LENGTH) {
 		hid_err(hdev, "error requesting GPIO values: %d\n", ret);
-		return ret;
+		ret = ret < 0 ? ret : -EIO;
+		goto exit;
 	}
 
-	return (buf[1] >> offset) & 1;
+	ret = (buf[1] >> offset) & 1;
+
+exit:
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return ret;
 }
 
 static int cp2112_gpio_direction_output(struct gpio_chip *chip,
@@ -234,27 +265,33 @@ static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
-	u8 buf[5];
+	u8 *buf = dev->in_out_buffer;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&dev->lock, flags);
+
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
-				       sizeof(buf), HID_FEATURE_REPORT,
-				       HID_REQ_GET_REPORT);
-	if (ret != sizeof(buf)) {
+				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret != CP2112_GPIO_CONFIG_LENGTH) {
 		hid_err(hdev, "error requesting GPIO config: %d\n", ret);
-		return ret;
+		goto fail;
 	}
 
 	buf[1] |= 1 << offset;
 	buf[2] = gpio_push_pull;
 
-	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf, sizeof(buf),
-				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
+				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
 	if (ret < 0) {
 		hid_err(hdev, "error setting GPIO config: %d\n", ret);
-		return ret;
+		goto fail;
 	}
 
+	spin_unlock_irqrestore(&dev->lock, flags);
+
 	/*
 	 * Set gpio value when output direction is already set,
 	 * as specified in AN495, Rev. 0.2, cpt. 4.4
@@ -262,6 +299,10 @@ static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 	cp2112_gpio_set(chip, offset, value);
 
 	return 0;
+
+fail:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret < 0 ? ret : -EIO;
 }
 
 static int cp2112_hid_get(struct hid_device *hdev, unsigned char report_number,
@@ -1007,6 +1048,17 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct cp2112_smbus_config_report config;
 	int ret;
 
+	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->in_out_buffer = devm_kzalloc(&hdev->dev, CP2112_REPORT_MAX_LENGTH,
+					  GFP_KERNEL);
+	if (!dev->in_out_buffer)
+		return -ENOMEM;
+
+	spin_lock_init(&dev->lock);
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
@@ -1063,12 +1115,6 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_power_normal;
 	}
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto err_power_normal;
-	}
-
 	hid_set_drvdata(hdev, (void *)dev);
 	dev->hdev		= hdev;
 	dev->adap.owner		= THIS_MODULE;
@@ -1087,7 +1133,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (ret) {
 		hid_err(hdev, "error registering i2c adapter\n");
-		goto err_free_dev;
+		goto err_power_normal;
 	}
 
 	hid_dbg(hdev, "adapter registered\n");
@@ -1123,8 +1169,6 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	gpiochip_remove(&dev->gc);
 err_free_i2c:
 	i2c_del_adapter(&dev->adap);
-err_free_dev:
-	kfree(dev);
 err_power_normal:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
 err_hid_close:
@@ -1149,7 +1193,6 @@ static void cp2112_remove(struct hid_device *hdev)
 	 */
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-	kfree(dev);
 }
 
 static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
-- 
2.7.4
