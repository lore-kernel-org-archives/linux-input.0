From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] hid: microsoft: Add rumble support for Xbox One S controller
Date: Thu,  9 Aug 2018 17:17:14 -0700
Message-ID: <20180810001714.14659-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Juha Kuikka <juha.kuikka@gmail.com>
List-Id: linux-input@vger.kernel.org

Add HID quirk driver for Xbox One S controller over bluetooth.

This driver only adds support for rumble. Standard controller
functionality is exposed by default HID driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/Kconfig         |   8 ++
 drivers/hid/hid-ids.h       |   1 +
 drivers/hid/hid-microsoft.c | 142 ++++++++++++++++++++++++++++++++++--
 drivers/hid/hid-quirks.c    |   1 +
 4 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a49a10437c40..b2e983cb32f0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -589,6 +589,14 @@ config HID_MICROSOFT
 	---help---
 	Support for Microsoft devices that are not fully compliant with HID standard.
 
+config MICROSOFT_FF
+	bool "Microsoft Xbox One S controller force feedback support"
+	depends on HID_MICROSOFT
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you have a Microsoft Xbox One S controller and want to enable
+	force feedback support for it.
+
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard"
 	depends on HID
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c7981ddd8776..c8b4bc7fe053 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -798,6 +798,7 @@
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
+#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
 
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 96e7d3231d2f..e2bd31d54e62 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -29,10 +29,29 @@
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
 
+struct ms_data {
+	unsigned long quirks;
+	struct hid_device *hdev;
+	struct work_struct ff_worker;
+	__u8 strong;
+	__u8 weak;
+	__u8 *output_report_dmabuf;
+};
+
+struct xb1s_ff_report {
+	__u8	report_id;
+	__u8	enable;
+	__u8	magnitude[4];
+	__u8	duration_10ms;
+	__u8	start_delay_10ms;
+	__u8	loop_count;
+};
+
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	/*
 	 * Microsoft Wireless Desktop Receiver (Model 1028) has
@@ -134,7 +153,8 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_ERGONOMY) {
 		int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
@@ -153,7 +173,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_DUPLICATE_USAGES)
 		clear_bit(usage->code, *bit);
@@ -164,7 +185,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 	struct input_dev *input;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
@@ -219,12 +241,96 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+#ifdef CONFIG_MICROSOFT_FF
+
+#define XB1S_FF_REPORT		3
+#define ENABLE_WEAK		BIT(0)
+#define ENABLE_STRONG		BIT(1)
+#define MAGNITUDE_WEAK		3
+#define MAGNITUDE_STRONG	2
+
+static void ms_ff_worker(struct work_struct *work)
+{
+	struct ms_data *ms = container_of(work, struct ms_data, ff_worker);
+	struct hid_device *hdev = ms->hdev;
+	struct xb1s_ff_report *r =
+		(struct xb1s_ff_report *) ms->output_report_dmabuf;
+	int ret;
+
+	memset(r, 0, sizeof(*r));
+
+	r->report_id = XB1S_FF_REPORT;
+	r->enable = ENABLE_WEAK | ENABLE_STRONG;
+	/*
+	 * Specifying maximum duration and maximum loop count should
+	 * cover maximum duration of a single effect: 65536 ms
+	 */
+	r->duration_10ms = U8_MAX;
+	r->loop_count = U8_MAX;
+	r->magnitude[MAGNITUDE_STRONG] = ms->strong; /* left actuator */
+	r->magnitude[MAGNITUDE_WEAK] = ms->weak;     /* right actuator */
+
+	ret = hid_hw_output_report(hdev, (__u8 *)r, sizeof(*r));
+	if (ret)
+		hid_warn(hdev, "failed to send FF report\n");
+}
+
+static int ms_play_effect(struct input_dev *dev, void *data,
+			  struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct ms_data *ms = hid_get_drvdata(hid);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	/* Magnitude is 0..100 so scale the 16-bit input here */
+	ms->strong = ((u32) effect->u.rumble.strong_magnitude * 100) / U16_MAX;
+	ms->weak = ((u32) effect->u.rumble.weak_magnitude * 100) / U16_MAX;
+
+	schedule_work(&ms->ff_worker);
+	return 0;
+}
+
+static int ms_init_ff(struct hid_device *hdev, struct ms_data *ms)
+{
+	struct hid_input *hidinput = list_entry(hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
+
+	ms->hdev = hdev;
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
+
+	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
+						sizeof(struct xb1s_ff_report),
+						GFP_KERNEL);
+	if (ms->output_report_dmabuf == NULL)
+		return -ENOMEM;
+
+	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
+	return input_ff_create_memless(input_dev, NULL, ms_play_effect);
+}
+
+#else
+static int ms_init_ff(struct hid_device *hdev, struct ms_data *ms)
+{
+	return 0;
+}
+#endif
+
 static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
+	struct ms_data *ms;
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	ms = devm_kzalloc(&hdev->dev, sizeof(*ms), GFP_KERNEL);
+	if (ms == NULL)
+		return -ENOMEM;
+
+	ms->quirks = quirks;
+
+	hid_set_drvdata(hdev, ms);
 
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
@@ -242,11 +348,32 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
+	if (IS_ENABLED(CONFIG_MICROSOFT_FF) &&
+	    hdev->product == USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) {
+		ret = ms_init_ff(hdev, ms);
+		if (ret) {
+			hid_err(hdev,
+				"could not initialize ff, continuing anyway");
+		}
+	}
+
 	return 0;
 err_free:
 	return ret;
 }
 
+static void ms_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+
+	if (IS_ENABLED(CONFIG_MICROSOFT_FF) &&
+	    hdev->product == USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) {
+		struct ms_data *ms = hid_get_drvdata(hdev);
+
+		cancel_work_sync(&ms->ff_worker);
+	}
+}
+
 static const struct hid_device_id ms_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV),
 		.driver_data = MS_HIDINPUT },
@@ -281,6 +408,10 @@ static const struct hid_device_id ms_devices[] = {
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
+#ifdef CONFIG_MICROSOFT_FF
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
+		.driver_data = 0 },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ms_devices);
@@ -293,6 +424,7 @@ static struct hid_driver ms_driver = {
 	.input_mapped = ms_input_mapped,
 	.event = ms_event,
 	.probe = ms_probe,
+	.remove = ms_remove,
 };
 module_hid_driver(ms_driver);
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..10fefd0ed43c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -496,6 +496,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) },
 #endif
 #if IS_ENABLED(CONFIG_HID_MONTEREY)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
-- 
2.17.1
