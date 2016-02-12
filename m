From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/6] HID: wacom: break out parsing of device and registering of input
Date: Fri, 12 Feb 2016 17:27:41 +0100
Message-ID: <1455294465-13694-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Simplifies the .probe() and will allow to reuse this path in the future.
Few things are reshuffled in .probe():
- init wacom struct earlier
- then retrieve the report descriptor
- then parse it and allocate/register inputs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 136 ++++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 61 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 5cb21dd..92a2c81 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1685,61 +1685,21 @@ static void wacom_update_name(struct wacom *wacom)
 		"%s Pad", name);
 }
 
-static int wacom_probe(struct hid_device *hdev,
-		const struct hid_device_id *id)
+static int wacom_parse_and_register(struct wacom *wacom)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
-	struct usb_device *dev = interface_to_usbdev(intf);
-	struct wacom *wacom;
-	struct wacom_wac *wacom_wac;
-	struct wacom_features *features;
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
+	struct hid_device *hdev = wacom->hdev;
 	int error;
 	unsigned int connect_mask = HID_CONNECT_HIDRAW;
 
-	if (!id->driver_data)
-		return -EINVAL;
-
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
-	/* hid-core sets this quirk for the boot interface */
-	hdev->quirks &= ~HID_QUIRK_NOGET;
-
-	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
-	if (!wacom)
-		return -ENOMEM;
-
-	hid_set_drvdata(hdev, wacom);
-	wacom->hdev = hdev;
-
-	/* ask for the report descriptor to be loaded by HID */
-	error = hid_parse(hdev);
-	if (error) {
-		hid_err(hdev, "parse failed\n");
-		goto fail_parse;
-	}
-
-	wacom_wac = &wacom->wacom_wac;
-	wacom_wac->features = *((struct wacom_features *)id->driver_data);
-	features = &wacom_wac->features;
 	features->pktlen = wacom_compute_pktlen(hdev);
-	if (features->pktlen > WACOM_PKGLEN_MAX) {
-		error = -EINVAL;
-		goto fail_pktlen;
-	}
-
-	if (features->check_for_hid_type && features->hid_type != hdev->type) {
-		error = -ENODEV;
-		goto fail_type;
-	}
-
-	wacom->usbdev = dev;
-	wacom->intf = intf;
-	mutex_init(&wacom->lock);
-	INIT_WORK(&wacom->work, wacom_wireless_work);
+	if (features->pktlen > WACOM_PKGLEN_MAX)
+		return -EINVAL;
 
 	error = wacom_allocate_inputs(wacom);
 	if (error)
-		goto fail_allocate_inputs;
+		return error;
 
 	/*
 	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
@@ -1752,7 +1712,7 @@ static int wacom_probe(struct hid_device *hdev,
 		} else if ((features->pktlen != WACOM_PKGLEN_BPAD_TOUCH) &&
 			   (features->pktlen != WACOM_PKGLEN_BPAD_TOUCH_USB)) {
 			error = -ENODEV;
-			goto fail_shared_data;
+			goto fail_allocate_inputs;
 		}
 	}
 
@@ -1772,7 +1732,7 @@ static int wacom_probe(struct hid_device *hdev,
 			 error ? "Ignoring" : "Assuming pen");
 
 		if (error)
-			goto fail_shared_data;
+			goto fail_parsed;
 
 		features->device_type |= WACOM_DEVICETYPE_PEN;
 	}
@@ -1796,14 +1756,6 @@ static int wacom_probe(struct hid_device *hdev,
 	if (error)
 		goto fail_register_inputs;
 
-	if (hdev->bus == BUS_BLUETOOTH) {
-		error = device_create_file(&hdev->dev, &dev_attr_speed);
-		if (error)
-			hid_warn(hdev,
-				 "can't create sysfs speed attribute err: %d\n",
-				 error);
-	}
-
 	if (features->type == HID_GENERIC)
 		connect_mask |= HID_CONNECT_DRIVER;
 
@@ -1844,18 +1796,80 @@ static int wacom_probe(struct hid_device *hdev,
 	return 0;
 
 fail_hw_start:
-	if (hdev->bus == BUS_BLUETOOTH)
-		device_remove_file(&hdev->dev, &dev_attr_speed);
+	hid_hw_stop(hdev);
 fail_register_inputs:
 	wacom_clean_inputs(wacom);
 	wacom_destroy_battery(wacom);
 fail_battery:
 	wacom_remove_shared_data(wacom);
 fail_shared_data:
-	wacom_clean_inputs(wacom);
+fail_parsed:
 fail_allocate_inputs:
+	wacom_clean_inputs(wacom);
+	return error;
+}
+
+static int wacom_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct wacom *wacom;
+	struct wacom_wac *wacom_wac;
+	struct wacom_features *features;
+	int error;
+
+	if (!id->driver_data)
+		return -EINVAL;
+
+	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+
+	/* hid-core sets this quirk for the boot interface */
+	hdev->quirks &= ~HID_QUIRK_NOGET;
+
+	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
+	if (!wacom)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, wacom);
+	wacom->hdev = hdev;
+
+	wacom_wac = &wacom->wacom_wac;
+	wacom_wac->features = *((struct wacom_features *)id->driver_data);
+	features = &wacom_wac->features;
+
+	if (features->check_for_hid_type && features->hid_type != hdev->type) {
+		error = -ENODEV;
+		goto fail_type;
+	}
+
+	wacom->usbdev = dev;
+	wacom->intf = intf;
+	mutex_init(&wacom->lock);
+	INIT_WORK(&wacom->work, wacom_wireless_work);
+
+	/* ask for the report descriptor to be loaded by HID */
+	error = hid_parse(hdev);
+	if (error) {
+		hid_err(hdev, "parse failed\n");
+		goto fail_parse;
+	}
+
+	error = wacom_parse_and_register(wacom);
+	if (error)
+		goto fail_parse;
+
+	if (hdev->bus == BUS_BLUETOOTH) {
+		error = device_create_file(&hdev->dev, &dev_attr_speed);
+		if (error)
+			hid_warn(hdev,
+				 "can't create sysfs speed attribute err: %d\n",
+				 error);
+	}
+
+	return 0;
+
 fail_type:
-fail_pktlen:
 fail_parse:
 	kfree(wacom);
 	hid_set_drvdata(hdev, NULL);
-- 
2.5.0
