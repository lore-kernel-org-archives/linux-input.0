From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: get rid of HID_QUIRK_NO_INIT_REPORTS
Date: Thu,  5 Jan 2017 10:21:44 +0100
Message-ID: <20170105092144.17120-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Oliver Neukum <oneukum@suse.de>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It looks like a bunch of devices do not like to be polled
for their reports at init time. When you look into the details,
it seems that on those that are requiring the quirk
HID_QUIRK_NO_INIT_REPORTS, the driveris fail to retrieve part
of the features/inputs while others (more generic) work.

IMO, it should be acceptable to remove the need for the quirk
by applying it by default. On the small amount of cases where
we actually need to read the current values, the drivers
in charge (hid-mt and wacom) already retrieve the features
manually.

There are 2 cases where we might need to retrieve the reports at
init:
1. hiddev devices with specific use-space tool
2. a device that would require the driver to fetch a specific
   feature/input at plug

For case 2, I have seen this a few time on hid-multitouch but it
is solved in hid-multitouch directly by fetching the feature.
I hope it won't be too common and this can be solved on a per-case
basis (crossing fingers).

For case 1, the hiddev documentation provides an ioctl to do the
init manually. A solution could be to retrieve the requested report
when EVIOCGUSAGE is called, in the same way hidraw does. I would be
tempted to not change the behavior and hope that we won't break any
userspace tool.

Note that I don't think hidraw would be affected and I checked that
the FF drivers that need to interact with the report fields are all
using output reports, which are not initialized by
usbhid_init_reports().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

Sending this partly as an RFC, partly as an actual patch :)

I think it would be good to have such a removal, but I am not so sure
about the implications. I think Windows does not retrieve the features/input
by default, so I think this would help us for future devices.

I don't know what to do about hiddev too. I don't know if we have actual
users besides some debugging tools. And hidraw is much better than hiddev,
so ideally, I'd like to remove it some way.

Anyway, what do you think about it?

Cheers,
Benjamin

 drivers/hid/hid-alps.c          |  2 --
 drivers/hid/hid-asus.c          | 11 ++-----
 drivers/hid/hid-multitouch.c    | 23 ---------------
 drivers/hid/hid-ntrig.c         |  3 +-
 drivers/hid/hid-rmi.c           |  2 --
 drivers/hid/hid-wiimote-core.c  |  2 --
 drivers/hid/i2c-hid/i2c-hid.c   | 63 -----------------------------------------
 drivers/hid/usbhid/hid-core.c   | 11 ++-----
 drivers/hid/usbhid/hid-quirks.c | 45 ++---------------------------
 drivers/hid/wacom_sys.c         |  2 --
 include/linux/hid.h             |  4 +--
 11 files changed, 11 insertions(+), 157 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index ed9c0ea..a24dddb 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -458,8 +458,6 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	data->hdev = hdev;
 	hid_set_drvdata(hdev, data);
 
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 70b12f8..bc89591 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -60,14 +60,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define CONTACT_PRESSURE_MASK 0x7f
 
 #define QUIRK_FIX_NOTEBOOK_REPORT	BIT(0)
-#define QUIRK_NO_INIT_REPORTS		BIT(1)
+/* BIT(1) reserved for backward compatibility, was QUIRK_NO_INIT_REPORTS */
 #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
 #define QUIRK_IS_MULTITOUCH		BIT(3)
 
-#define KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
-						 QUIRK_NO_INIT_REPORTS)
-#define TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
-						 QUIRK_SKIP_INPUT_MAPPING | \
+#define KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT)
+#define TOUCHPAD_QUIRKS			(QUIRK_SKIP_INPUT_MAPPING | \
 						 QUIRK_IS_MULTITOUCH)
 
 #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
@@ -266,9 +264,6 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	drvdata->quirks = id->driver_data;
 
-	if (drvdata->quirks & QUIRK_NO_INIT_REPORTS)
-		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "Asus hid parse failed: %d\n", ret);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f9be3f8..e5c5f83 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -314,17 +314,9 @@ static struct attribute_group mt_attribute_group = {
 
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
-	struct mt_device *td = hid_get_drvdata(hdev);
 	int ret, size = hid_report_len(report);
 	u8 *buf;
 
-	/*
-	 * Do not fetch the feature report if the device has been explicitly
-	 * marked as non-capable.
-	 */
-	if (td->initial_quirks & HID_QUIRK_NO_INIT_REPORTS)
-		return;
-
 	if (hdev->type == HID_TYPE_UHID)
 		return;
 
@@ -1141,21 +1133,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
 
-	/*
-	 * Some multitouch screens do not like to be polled for input
-	 * reports. Fortunately, the Win8 spec says that all touches
-	 * should be sent during each report, making the initialization
-	 * of input reports unnecessary. For Win7 devices, well, let's hope
-	 * they will still be happy (this is only be a problem if a touch
-	 * was already there while probing the device).
-	 *
-	 * In addition some touchpads do not behave well if we read
-	 * all feature reports from them. Instead we prevent
-	 * initial report fetching and then selectively fetch each
-	 * report we are interested in.
-	 */
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	ret = hid_parse(hdev);
 	if (ret != 0)
 		return ret;
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1b0084d..d61ffb3 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -901,8 +901,7 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct hid_report *report;
 
 	if (id->driver_data)
-		hdev->quirks |= HID_QUIRK_MULTI_INPUT
-				| HID_QUIRK_NO_INIT_REPORTS;
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
 	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
 	if (!nd) {
diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 5b40c26..046e774 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -624,8 +624,6 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hid_set_drvdata(hdev, data);
 
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index d003914..dea52df 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1778,8 +1778,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	struct wiimote_data *wdata;
 	int ret;
 
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	wdata = wiimote_create(hdev);
 	if (!wdata) {
 		hid_err(hdev, "Can't alloc device\n");
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 844662c..266a630 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -499,66 +499,6 @@ static int i2c_hid_get_report_length(struct hid_report *report)
 		report->device->report_enum[report->type].numbered + 2;
 }
 
-static void i2c_hid_init_report(struct hid_report *report, u8 *buffer,
-	size_t bufsize)
-{
-	struct hid_device *hid = report->device;
-	struct i2c_client *client = hid->driver_data;
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
-	unsigned int size, ret_size;
-
-	size = i2c_hid_get_report_length(report);
-	if (i2c_hid_get_report(client,
-			report->type == HID_FEATURE_REPORT ? 0x03 : 0x01,
-			report->id, buffer, size))
-		return;
-
-	i2c_hid_dbg(ihid, "report (len=%d): %*ph\n", size, size, buffer);
-
-	ret_size = buffer[0] | (buffer[1] << 8);
-
-	if (ret_size != size) {
-		dev_err(&client->dev, "error in %s size:%d / ret_size:%d\n",
-			__func__, size, ret_size);
-		return;
-	}
-
-	/* hid->driver_lock is held as we are in probe function,
-	 * we just need to setup the input fields, so using
-	 * hid_report_raw_event is safe. */
-	hid_report_raw_event(hid, report->type, buffer + 2, size - 2, 1);
-}
-
-/*
- * Initialize all reports
- */
-static void i2c_hid_init_reports(struct hid_device *hid)
-{
-	struct hid_report *report;
-	struct i2c_client *client = hid->driver_data;
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
-	u8 *inbuf = kzalloc(ihid->bufsize, GFP_KERNEL);
-
-	if (!inbuf) {
-		dev_err(&client->dev, "can not retrieve initial reports\n");
-		return;
-	}
-
-	/*
-	 * The device must be powered on while we fetch initial reports
-	 * from it.
-	 */
-	pm_runtime_get_sync(&client->dev);
-
-	list_for_each_entry(report,
-		&hid->report_enum[HID_FEATURE_REPORT].report_list, list)
-		i2c_hid_init_report(report, inbuf, ihid->bufsize);
-
-	pm_runtime_put(&client->dev);
-
-	kfree(inbuf);
-}
-
 /*
  * Traverse the supplied list of reports and find the longest
  */
@@ -780,9 +720,6 @@ static int i2c_hid_start(struct hid_device *hid)
 			return ret;
 	}
 
-	if (!(hid->quirks & HID_QUIRK_NO_INIT_REPORTS))
-		i2c_hid_init_reports(hid);
-
 	return 0;
 }
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 333108e..a0d5564 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -754,11 +754,9 @@ void usbhid_init_reports(struct hid_device *hid)
 	struct hid_report_enum *report_enum;
 	int err, ret;
 
-	if (!(hid->quirks & HID_QUIRK_NO_INIT_INPUT_REPORTS)) {
-		report_enum = &hid->report_enum[HID_INPUT_REPORT];
-		list_for_each_entry(report, &report_enum->report_list, list)
-			usbhid_submit_report(hid, report, USB_DIR_IN);
-	}
+	report_enum = &hid->report_enum[HID_INPUT_REPORT];
+	list_for_each_entry(report, &report_enum->report_list, list)
+		usbhid_submit_report(hid, report, USB_DIR_IN);
 
 	report_enum = &hid->report_enum[HID_FEATURE_REPORT];
 	list_for_each_entry(report, &report_enum->report_list, list)
@@ -1121,9 +1119,6 @@ static int usbhid_start(struct hid_device *hid)
 	usbhid->urbctrl->transfer_dma = usbhid->ctrlbuf_dma;
 	usbhid->urbctrl->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	if (!(hid->quirks & HID_QUIRK_NO_INIT_REPORTS))
-		usbhid_init_reports(hid);
-
 	set_bit(HID_STARTED, &usbhid->iofl);
 
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 7eccbf8..6540505 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -55,8 +55,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
@@ -73,12 +71,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70R, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_M65RGB, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K95RGB, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70RGB, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K65RGB, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K95RGB, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
@@ -87,9 +81,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_FUTABA, USB_DEVICE_ID_LED_DISPLAY, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
@@ -99,36 +91,19 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS_TS, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1, HID_QUIRK_NOGET },
@@ -149,20 +124,10 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS1, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_HD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096, HID_QUIRK_NO_INIT_INPUT_REPORTS },
 	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
@@ -380,12 +345,6 @@ u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct)
 	u32 quirks = 0;
 	const struct hid_blacklist *bl_entry = NULL;
 
-	/* NCR devices must not be queried for reports */
-	if (idVendor == USB_VENDOR_ID_NCR &&
-			idProduct >= USB_DEVICE_ID_NCR_FIRST &&
-			idProduct <= USB_DEVICE_ID_NCR_LAST)
-			return HID_QUIRK_NO_INIT_REPORTS;
-
 	down_read(&dquirks_rwsem);
 	bl_entry = usbhid_exists_dquirk(idVendor, idProduct);
 	if (!bl_entry)
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index bd08de1..145bce2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2440,8 +2440,6 @@ static int wacom_probe(struct hid_device *hdev,
 	if (!id->driver_data)
 		return -EINVAL;
 
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	/* hid-core sets this quirk for the boot interface */
 	hdev->quirks &= ~HID_QUIRK_NOGET;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7f7b769..92b4ca1 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -322,13 +322,13 @@ struct hid_item {
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
-#define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
+/* 0x00000200 reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
 #define HID_QUIRK_ALWAYS_POLL			0x00000400
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
-#define HID_QUIRK_NO_INIT_REPORTS		0x20000000
+/* 0x20000000 reserved for backward compatibility, was NO_INIT_REPORTS */
 #define HID_QUIRK_NO_IGNORE			0x40000000
 #define HID_QUIRK_NO_INPUT_SYNC			0x80000000
 
-- 
2.9.3
