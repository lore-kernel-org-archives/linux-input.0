From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2] HID: asus: support backlight on USB keyboards
Date: Wed,  5 Apr 2017 16:40:49 +0200
Message-ID: <20170405144049.19876-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: linux-input@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

The latest USB keyboards shipped on several ASUS laptop models
(including ROG laptop models such as GL702VMK) have the keyboards
backlight controlled by the keyboard firmware.

The firmware implements at least 3 different commands:
- Init command (to use when the system starts)
- Configuration command (to get keyboard status/information)
- Backlight level control (to change the level of the keyboard light)

With this patch we create the usual 'asus::kbd_backlight' led class
entry to control the keyboard backlight.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
Changelog:

v2:
 - Code refactoring
 - s/sysfs/led class
 - No error messages on kzalloc/kmemdup failing
 - Fixed race condition when removing device
 - Used devm_* when possible
 - Added LEDS_CLASS dependency
---
 drivers/hid/Kconfig    |   1 +
 drivers/hid/hid-asus.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index eb1846a..dec5f3e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -136,6 +136,7 @@ config HID_APPLEIR
 
 config HID_ASUS
 	tristate "Asus"
+	depends on LEDS_CLASS
 	---help---
 	Support for Asus notebook built-in keyboard and touchpad via i2c, and
 	the Asus Republic of Gamers laptop keyboard special keys.
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bacba97..845e68a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -40,8 +40,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define FEATURE_REPORT_ID 0x0d
 #define INPUT_REPORT_ID 0x5d
+#define FEATURE_KBD_REPORT_ID 0x5a
 
 #define INPUT_REPORT_SIZE 28
+#define FEATURE_KBD_REPORT_SIZE 16
+
+#define SUPPORT_KBD_BACKLIGHT BIT(0)
 
 #define MAX_CONTACTS 5
 
@@ -64,6 +68,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
 #define QUIRK_IS_MULTITOUCH		BIT(3)
 #define QUIRK_NO_CONSUMER_USAGES	BIT(4)
+#define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -74,9 +79,19 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
 
+struct asus_kbd_leds {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+	struct work_struct work;
+	unsigned int brightness;
+	bool removed;
+};
+
 struct asus_drvdata {
 	unsigned long quirks;
 	struct input_dev *input;
+	struct asus_kbd_leds *kbd_backlight;
+	bool enable_backlight;
 };
 
 static void asus_report_contact_down(struct input_dev *input,
@@ -171,6 +186,139 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
+static int asus_kbd_get_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
+{
+	unsigned char *dmabuf;
+	int ret;
+
+	dmabuf = kmemdup(buf, buf_size, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, FEATURE_KBD_REPORT_ID, dmabuf,
+				 buf_size, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	kfree(dmabuf);
+
+	return ret;
+}
+
+static int asus_kbd_init(struct hid_device *hdev)
+{
+	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
+	int ret;
+
+	ret = asus_kbd_get_report(hdev, buf, sizeof(buf));
+	if (ret < 0)
+		hid_err(hdev, "Asus failed to send init command: %d\n", ret);
+
+	return ret;
+}
+
+static int asus_kbd_get_functions(struct hid_device *hdev,
+				  unsigned char *kbd_func)
+{
+	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	u8 *readbuf;
+	int ret;
+
+	ret = asus_kbd_get_report(hdev, buf, sizeof(buf));
+	if (ret < 0) {
+		hid_err(hdev, "Asus failed to send configuration command: %d\n", ret);
+		return ret;
+	}
+
+	readbuf = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
+	if (!readbuf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, FEATURE_KBD_REPORT_ID, readbuf,
+				 FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_err(hdev, "Asus failed to request functions: %d\n", ret);
+		kfree(readbuf);
+		return ret;
+	}
+
+	*kbd_func = readbuf[6];
+
+	kfree(readbuf);
+	return ret;
+}
+
+static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
+				   enum led_brightness brightness)
+{
+	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
+						 cdev);
+	if (led->brightness == brightness)
+		return;
+
+	led->brightness = brightness;
+	schedule_work(&led->work);
+}
+
+static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
+{
+	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
+						 cdev);
+
+	return led->brightness;
+}
+
+static void asus_kbd_backlight_work(struct work_struct *work)
+{
+	struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
+	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
+	int ret;
+
+	if (led->removed)
+		return;
+
+	buf[4] = led->brightness;
+
+	ret = asus_kbd_get_report(led->hdev, buf, sizeof(buf));
+	if (ret < 0)
+		hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
+}
+
+static int asus_kbd_register_leds(struct hid_device *hdev)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	unsigned char kbd_func;
+
+	/* Initialize keyboard */
+	if (asus_kbd_init(hdev) < 0)
+		return -ENODEV;
+
+	/* Get keyboard functions */
+	if (asus_kbd_get_functions(hdev, &kbd_func) < 0)
+		return -ENODEV;
+
+	/* Check for backlight support */
+	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
+		return -ENODEV;
+
+	drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
+					      sizeof(struct asus_kbd_leds),
+					      GFP_KERNEL);
+	if (!drvdata->kbd_backlight)
+		return -ENOMEM;
+
+	drvdata->kbd_backlight->removed = false;
+	drvdata->kbd_backlight->brightness = 0;
+	drvdata->kbd_backlight->hdev = hdev;
+	drvdata->kbd_backlight->cdev.name = "asus::kbd_backlight";
+	drvdata->kbd_backlight->cdev.max_brightness = 3;
+	drvdata->kbd_backlight->cdev.brightness_set = asus_kbd_backlight_set;
+	drvdata->kbd_backlight->cdev.brightness_get = asus_kbd_backlight_get;
+	INIT_WORK(&drvdata->kbd_backlight->work, asus_kbd_backlight_work);
+
+	return devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
+}
+
 static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct input_dev *input = hi->input;
@@ -178,7 +326,6 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
 		int ret;
-
 		input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, MAX_Y, 0, 0);
 		input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
@@ -198,6 +345,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	drvdata->input = input;
 
+	if (drvdata->enable_backlight)
+		if (asus_kbd_register_leds(hdev))
+			hid_warn(hdev, "Failed to initialize backlight.\n");
+
 	return 0;
 }
 
@@ -248,6 +399,16 @@ static int asus_input_mapping(struct hid_device *hdev,
 			 * as some make the keyboard appear as a pointer device. */
 			return -1;
 		}
+
+		/*
+		 * Check and enable backlight only on devices with UsagePage ==
+		 * 0xff31 to avoid initializing the keyboard firmware multiple
+		 * times on devices with multiple HID descriptors but same
+		 * PID/VID.
+		 */
+		if (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT)
+			drvdata->enable_backlight = true;
+
 		return 1;
 	}
 
@@ -358,6 +519,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 }
 
+static void asus_remove(struct hid_device *hdev)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->kbd_backlight)
+		drvdata->kbd_backlight->removed = true;
+}
+
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -379,7 +548,7 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
@@ -389,6 +558,7 @@ static struct hid_driver asus_driver = {
 	.id_table		= asus_devices,
 	.report_fixup		= asus_report_fixup,
 	.probe                  = asus_probe,
+	.remove			= asus_remove,
 	.input_mapping          = asus_input_mapping,
 	.input_configured       = asus_input_configured,
 #ifdef CONFIG_PM
-- 
2.9.3
