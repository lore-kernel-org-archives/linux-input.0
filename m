From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] HID: remove initial reading of reports at connect
Date: Wed,  8 Mar 2017 15:11:14 +0100
Message-ID: <20170308141114.9200-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Oliver Neukum <oneukum@suse.de>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It looks like a bunch of devices do not like to be polled
for their reports at init time. When you look into the details,
it seems that for those that are requiring the quirk
HID_QUIRK_NO_INIT_REPORTS, the driver fails to retrieve part
of the features/inputs while others (more generic) work.

IMO, it should be acceptable to remove the need for the quirk
in the general case. On the small amount of cases where
we actually need to read the current values, the driver
in charge (hid-mt or wacom) already retrieves the features
manually.

There are 2 cases where we might need to retrieve the reports at
init:
1. hiddev devices with specific use-space tool
2. a device that would require the driver to fetch a specific
   feature/input at plug

For case 2, I have seen this a few time on hid-multitouch. It
is solved in hid-multitouch directly by fetching the feature.
I hope it won't be too common and this can be solved on a per-case
basis (crossing fingers).

For case 1, we moved the implementation of HID_QUIRK_NO_INIT_REPORTS
in hiddev. When somebody starts calling ioctls that needs an initial
update, the hiddev device will fetch the initial state of the reports
to mimic the current behavior. This adds a small amount of time during
the first HIDIOCGUSAGE(S), but it should be acceptable in
most cases. To keep the currently known broken devices, we have to
keep around HID_QUIRK_NO_INIT_REPORTS, but the scope will only be
for hiddev.

Note that I don't think hidraw would be affected and I checked that
the FF drivers that need to interact with the report fields are all
using output reports, which are not initialized by
usbhid_init_reports().

NO_INIT_INPUT_REPORTS is then replaced by HID_QUIRK_NO_INIT_REPORTS:
there is no point keeping it for just one device.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- amended subject (was: HID: get rid of HID_QUIRK_NO_INIT_REPORTS)
- kept around HID_QUIRK_NO_INIT_REPORTS
- force retrieval of reports at HIDIOCGUSAGE(S) in hiddev
---
 drivers/hid/i2c-hid/i2c-hid.c   | 63 -----------------------------------------
 drivers/hid/usbhid/hid-core.c   | 11 ++-----
 drivers/hid/usbhid/hid-quirks.c |  2 +-
 drivers/hid/usbhid/hiddev.c     | 13 +++++++++
 include/linux/hid.h             |  2 +-
 5 files changed, 18 insertions(+), 73 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 40f0acc..52f1776 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -508,66 +508,6 @@ static int i2c_hid_get_report_length(struct hid_report *report)
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
@@ -789,9 +729,6 @@ static int i2c_hid_start(struct hid_device *hid)
 			return ret;
 	}
 
-	if (!(hid->quirks & HID_QUIRK_NO_INIT_REPORTS))
-		i2c_hid_init_reports(hid);
-
 	return 0;
 }
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 9ef9c08..83772fa 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -757,11 +757,9 @@ void usbhid_init_reports(struct hid_device *hid)
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
@@ -1131,9 +1129,6 @@ static int usbhid_start(struct hid_device *hid)
 	usbhid->urbctrl->transfer_dma = usbhid->ctrlbuf_dma;
 	usbhid->urbctrl->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	if (!(hid->quirks & HID_QUIRK_NO_INIT_REPORTS))
-		usbhid_init_reports(hid);
-
 	set_bit(HID_STARTED, &usbhid->iofl);
 
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b810de3..70c943b 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -158,7 +158,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_HD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096, HID_QUIRK_NO_INIT_INPUT_REPORTS },
+	{ USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 774bd70..1396e3d 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -55,6 +55,7 @@ struct hiddev {
 	struct hid_device *hid;
 	struct list_head list;
 	spinlock_t list_lock;
+	bool initialized;
 };
 
 struct hiddev_list {
@@ -690,6 +691,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case HIDIOCINITREPORT:
 		usbhid_init_reports(hid);
+		hiddev->initialized = true;
 		r = 0;
 		break;
 
@@ -791,6 +793,10 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case HIDIOCGUSAGES:
 	case HIDIOCSUSAGES:
 	case HIDIOCGCOLLECTIONINDEX:
+		if (!hiddev->initialized) {
+			usbhid_init_reports(hid);
+			hiddev->initialized = true;
+		}
 		r = hiddev_ioctl_usage(hiddev, cmd, user_arg);
 		break;
 
@@ -911,6 +917,13 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 		kfree(hiddev);
 		return -1;
 	}
+
+	/*
+	 * If HID_QUIRK_NO_INIT_REPORTS is set, make sure we don't initialize
+	 * the reports.
+	 */
+	hiddev->initialized = hid->quirks & HID_QUIRK_NO_INIT_REPORTS;
+
 	return 0;
 }
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 28f38e2b8..b2e472c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -322,7 +322,7 @@ struct hid_item {
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
-#define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
+/* 0x00000200 reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
 #define HID_QUIRK_ALWAYS_POLL			0x00000400
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
-- 
2.9.3
