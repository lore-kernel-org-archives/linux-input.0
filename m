From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 08/23] Input - wacom: split out the pad device for the wireless receiver
Date: Tue, 15 Jul 2014 14:45:31 -0400
Message-ID: <1405449946-11515-9-git-send-email-benjamin.tissoires@redhat.com>
References: <1405449946-11515-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405449946-11515-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Wireless Receiver should also behave in the same way than regular
USB devices.

To simplify the unregistering of the different devices,
wacom_unregister_inputs() is introduced.
For consistency, the function wacom_register_input() is renamed into
wacom_register_inputs().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <killertofu@gmail.com>
---

no changes in v2

 drivers/input/tablet/wacom_sys.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b258485..dd0dbc2 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1142,7 +1142,17 @@ static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 	return input_dev;
 }
 
-static int wacom_register_input(struct wacom *wacom)
+static void wacom_unregister_inputs(struct wacom *wacom)
+{
+	if (wacom->wacom_wac.input)
+		input_unregister_device(wacom->wacom_wac.input);
+	if (wacom->wacom_wac.pad_input)
+		input_unregister_device(wacom->wacom_wac.pad_input);
+	wacom->wacom_wac.input = NULL;
+	wacom->wacom_wac.pad_input = NULL;
+}
+
+static int wacom_register_inputs(struct wacom *wacom)
 {
 	struct input_dev *input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
@@ -1214,16 +1224,12 @@ static void wacom_wireless_work(struct work_struct *work)
 	/* Stylus interface */
 	wacom1 = usb_get_intfdata(usbdev->config->interface[1]);
 	wacom_wac1 = &(wacom1->wacom_wac);
-	if (wacom_wac1->input)
-		input_unregister_device(wacom_wac1->input);
-	wacom_wac1->input = NULL;
+	wacom_unregister_inputs(wacom1);
 
 	/* Touch interface */
 	wacom2 = usb_get_intfdata(usbdev->config->interface[2]);
 	wacom_wac2 = &(wacom2->wacom_wac);
-	if (wacom_wac2->input)
-		input_unregister_device(wacom_wac2->input);
-	wacom_wac2->input = NULL;
+	wacom_unregister_inputs(wacom2);
 
 	if (wacom_wac->pid == 0) {
 		dev_info(&wacom->intf->dev, "wireless tablet disconnected\n");
@@ -1253,9 +1259,11 @@ static void wacom_wireless_work(struct work_struct *work)
 		wacom_wac1->features.device_type = BTN_TOOL_PEN;
 		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
 			 wacom_wac1->features.name);
+		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
+			 wacom_wac1->features.name);
 		wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
 		wacom_wac1->shared->type = wacom_wac1->features.type;
-		error = wacom_register_input(wacom1);
+		error = wacom_register_inputs(wacom1);
 		if (error)
 			goto fail;
 
@@ -1273,7 +1281,9 @@ static void wacom_wireless_work(struct work_struct *work)
 			else
 				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
 					 "%s (WL) Pad",wacom_wac2->features.name);
-			error = wacom_register_input(wacom2);
+			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
+				 "%s (WL) Pad", wacom_wac2->features.name);
+			error = wacom_register_inputs(wacom2);
 			if (error)
 				goto fail;
 
@@ -1290,15 +1300,8 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 
 fail:
-	if (wacom_wac2->input) {
-		input_unregister_device(wacom_wac2->input);
-		wacom_wac2->input = NULL;
-	}
-
-	if (wacom_wac1->input) {
-		input_unregister_device(wacom_wac1->input);
-		wacom_wac1->input = NULL;
-	}
+	wacom_unregister_inputs(wacom1);
+	wacom_unregister_inputs(wacom2);
 	return;
 }
 
@@ -1444,7 +1447,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 		goto fail4;
 
 	if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
-		error = wacom_register_input(wacom);
+		error = wacom_register_inputs(wacom);
 		if (error)
 			goto fail5;
 	}
@@ -1484,10 +1487,7 @@ static void wacom_disconnect(struct usb_interface *intf)
 
 	usb_kill_urb(wacom->irq);
 	cancel_work_sync(&wacom->work);
-	if (wacom->wacom_wac.input)
-		input_unregister_device(wacom->wacom_wac.input);
-	if (wacom->wacom_wac.pad_input)
-		input_unregister_device(wacom->wacom_wac.pad_input);
+	wacom_unregister_inputs(wacom);
 	wacom_destroy_battery(wacom);
 	wacom_destroy_leds(wacom);
 	usb_free_urb(wacom->irq);
-- 
2.0.0
