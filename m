From: Paul Richards <paulrichards321@gmail.com>
Subject: [PATCH] input: microsoft: fix vertical scrolling issue with Microsoft
 Wireless Mobile Mouse 3500 and Microsoft Wireless Mouse 5000
Date: Fri, 23 Mar 2012 01:11:04 -0400
Message-ID: <CABTjZCgNkUU7E91ZYHSpBZxbt=mvjy44ThPbqngyTQPTG4VR_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52375 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab2CWFLF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Mar 2012 01:11:05 -0400
Received: by iagz16 with SMTP id z16so4133307iag.19
        for <linux-input@vger.kernel.org>; Thu, 22 Mar 2012 22:11:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org

The below patch fixes a vertical scroll wheel issue when you dual boot
between Microsoft Windows and at least two of the following models:

Microsoft Wireless Mobile Mouse 3500
Microsoft Wireless Mouse 5000

After doing a warm reboot into linux these mice report a multiple of
the regular values for the vertical scroll wheel events, which I
viewed by using the following command:

cat /sys/kernel/debug/hid/0003\:045E\:0745.0004/events

Under normal operation you get a vertical scroll wheel change of
+1,0,-1 however after being booted into Microsoft Windows and rebooted
into linux these values can go up to +3 or -3, or +10 or -10 for a
*single* scroll wheel movement up or down. This makes scrolling
through documents annoying as it does 3x or 10x times the regular
amount of scrolling. I found by reseting feature "23" I was able to
restore the normal behavior of the mouse. I believe this is some sort
of smooth scrolling setting that gets enabled on the mouse and doesn't
get reset during a warm boot. I did some research on the internet and
found other people experience this behavior and that they usually just
do a full power down or unplug the usb radio receiver and then plug it
back in.

Signed-off-by: Paul Richards <paulrichards321@gmail.com>
---
 drivers/hid/hid-core.c      |    1 +
 drivers/hid/hid-ids.h       |    1 +
 drivers/hid/hid-microsoft.c |   53 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 990fe19..8356ef7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1485,6 +1485,7 @@ static const struct hid_device_id
hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_WIRELESS_MOUSE_KSERIES) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eb0090..1ba69c8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -531,6 +531,7 @@
 #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713
 #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K	0x0730
 #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
+#define USB_DEVICE_ID_MS_WIRELESS_MOUSE_KSERIES 0x0745

 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index e5c699b..19d5dca 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -29,6 +29,7 @@
 #define MS_RDESC		0x08
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
+#define MS_VSCROLL		0x40

 /*
  * Microsoft Wireless Desktop Receiver (Model 1028) has
@@ -155,6 +156,51 @@ static int ms_event(struct hid_device *hdev,
struct hid_field *field,
 	return 0;
 }

+static bool check_vscroll_settings(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	int ret;
+	__u8 feature_in[] = { 0x17, 0x00 };
+
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0x17];
+	if (!report)
+		return false;
+
+	ret = hdev->hid_get_raw_report(hdev, 0x17, feature_in,
+		sizeof(feature_in), HID_FEATURE_REPORT);
+	if (ret <= 0) {
+		hid_dbg(hdev, "Mouse unknown vertical scroll wheel mode, return
value: %i\n", ret);
+	} else if (ret == 2 && feature_in[0] == 0x17 && feature_in[1] == 0x00) {
+		hid_info(hdev, "Mouse vertical scroll wheel setting is compatible
with linux applications.\n");
+	} else if (ret == 2 && feature_in[0] == 0x17) {
+		hid_info(hdev, "Mouse vertical scroll wheel mode needs to be reset
to work normally with linux applications.\n");
+		return true;
+	} else {
+		hid_dbg(hdev, "Mouse unknown vertical scroll wheel mode, return
values: %i %X %X\n", ret, (int) feature_in[0], (int) feature_in[1]);
+	}
+	return false;
+}
+
+static bool reset_vscroll_settings(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	int ret;
+	__u8 feature_out[] = { 0x17, 0x00 };
+
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0x17];
+	if (!report)
+		return false;
+
+	ret = hdev->hid_output_raw_report(hdev, feature_out,
sizeof(feature_out), HID_FEATURE_REPORT);
+	if (ret == 2) {
+		hid_info(hdev, "Seem to have successfully reset mouse vertical
scroll wheel settings.\n");
+		return true;
+	} else {
+		hid_dbg(hdev, "Unknown response from reseting vertical scroll wheel
settings with mouse, value returned: %i\n", ret);
+	}
+	return false;
+}
+
 static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
@@ -178,6 +224,11 @@ static int ms_probe(struct hid_device *hdev,
const struct hid_device_id *id)
 		goto err_free;
 	}

+	if (quirks & MS_VSCROLL) {
+		if (check_vscroll_settings(hdev))
+			reset_vscroll_settings(hdev);
+	}
+
 	return 0;
 err_free:
 	return ret;
@@ -199,6 +250,8 @@ static const struct hid_device_id ms_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
 		.driver_data = MS_DUPLICATE_USAGES },

+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_WIRELESS_MOUSE_KSERIES),
+		.driver_data = MS_VSCROLL },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
 	{ }
