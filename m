From: chris@cnpbagwell.com
Subject: [PATCH v4 3/4] Input: wacom - create inputs when wireless connect
Date: Tue, 13 Mar 2012 19:52:01 -0500
Message-ID: <1331686322-4914-4-git-send-email-chris@cnpbagwell.com>
References: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39663 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508Ab2CNAwV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 20:52:21 -0400
Received: by yhmm54 with SMTP id m54so1230762yhm.19
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 17:52:20 -0700 (PDT)
In-Reply-To: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, killertofu@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

When a tablet connect or disconnect is detected, schedule
work queue to register or unregister related input devices.

When a wireless tablet connects, it reports same USB PID
used if tablet is connected with USB cable. Use this to
update features values, set input capabilities, and then
register device.  From there, the Pen and Touch interfaces
will reuse the existing tablet's IRQ routines.

Its possible that 1 receiver is shared with 2 tablets with
different PID (small and medium Bamboo for example) so the
input is unregister at disconnect to better support this case.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom.h     |    7 +++
 drivers/input/tablet/wacom_sys.c |   91 ++++++++++++++++++++++++++++++++++----
 drivers/input/tablet/wacom_wac.c |   20 ++++++++-
 drivers/input/tablet/wacom_wac.h |    1 +
 4 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 0783864..febbfd9 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -112,6 +112,7 @@ struct wacom {
 	struct urb *irq;
 	struct wacom_wac wacom_wac;
 	struct mutex lock;
+	struct work_struct work;
 	bool open;
 	char phys[32];
 	struct wacom_led {
@@ -122,6 +123,12 @@ struct wacom {
 	} led;
 };
 
+static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
+{
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	schedule_work(&wacom->work);
+}
+
 extern const struct usb_device_id wacom_ids[];
 
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index d8cc9ce..2fc7705 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -167,6 +167,19 @@ static void wacom_close(struct input_dev *dev)
 		usb_autopm_put_interface(wacom->intf);
 }
 
+/*
+ * Static values for max X/Y and resolution of Pen interface is stored in
+ * features. This mean physical size of active area can be computed.
+ * This is useful to do when Pen and Touch have same active area of tablet.
+ * This means for Touch device, we only need to find max X/Y value and we
+ * have enough information to compute resolution of touch.
+ */
+static void wacom_set_phy_from_res(struct wacom_features *features)
+{
+	features->x_phy = (features->x_max * 100) / features->x_resolution;
+	features->y_phy = (features->y_max * 100) / features->y_resolution;
+}
+
 static int wacom_parse_logical_collection(unsigned char *report,
 					  struct wacom_features *features)
 {
@@ -178,15 +191,7 @@ static int wacom_parse_logical_collection(unsigned char *report,
 		features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 		features->device_type = BTN_TOOL_FINGER;
 
-		/*
-		 * Stylus and Touch have same active area
-		 * so compute physical size based on stylus
-		 * data before its overwritten.
-		 */
-		features->x_phy =
-			(features->x_max * features->x_resolution) / 100;
-		features->y_phy =
-			(features->y_max * features->y_resolution) / 100;
+		wacom_set_phy_from_res(features);
 
 		features->x_max = features->y_max =
 			get_unaligned_le16(&report[10]);
@@ -869,6 +874,72 @@ static int wacom_register_input(struct wacom *wacom)
 	return error;
 }
 
+static void wacom_wireless_work(struct work_struct *work)
+{
+	struct wacom *wacom = container_of(work, struct wacom, work);
+	struct usb_device *usbdev = wacom->usbdev;
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+
+	/*
+	 * Regardless if this is a disconnect or a new tablet,
+	 * remove any existing input devices.
+	 */
+
+	/* Stylus interface */
+	wacom = usb_get_intfdata(usbdev->config->interface[1]);
+	if (wacom->wacom_wac.input)
+		input_unregister_device(wacom->wacom_wac.input);
+	wacom->wacom_wac.input = 0;
+
+	/* Touch interface */
+	wacom = usb_get_intfdata(usbdev->config->interface[2]);
+	if (wacom->wacom_wac.input)
+		input_unregister_device(wacom->wacom_wac.input);
+	wacom->wacom_wac.input = 0;
+
+	if (wacom_wac->pid == 0) {
+		printk(KERN_INFO "wacom: wireless tablet disconnected\n");
+	} else {
+		const struct usb_device_id *id = wacom_ids;
+
+		printk(KERN_INFO
+		       "wacom: wireless tablet connected with PID %x\n",
+		       wacom_wac->pid);
+
+		while (id->match_flags) {
+			if (id->idVendor == USB_VENDOR_ID_WACOM &&
+			    id->idProduct == wacom_wac->pid)
+				break;
+			id++;
+		}
+
+		if (!id->match_flags) {
+			printk(KERN_INFO
+			       "wacom: ignorning unknown PID.\n");
+			return;
+		}
+
+		/* Stylus interface */
+		wacom = usb_get_intfdata(usbdev->config->interface[1]);
+		wacom_wac = &wacom->wacom_wac;
+		wacom_wac->features =
+			*((struct wacom_features *)id->driver_info);
+		wacom_wac->features.device_type = BTN_TOOL_PEN;
+		wacom_register_input(wacom);
+
+		/* Touch interface */
+		wacom = usb_get_intfdata(usbdev->config->interface[2]);
+		wacom_wac = &wacom->wacom_wac;
+		wacom_wac->features =
+			*((struct wacom_features *)id->driver_info);
+		wacom_wac->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
+		wacom_wac->features.device_type = BTN_TOOL_FINGER;
+		wacom_set_phy_from_res(&wacom_wac->features);
+		wacom_wac->features.x_max = wacom_wac->features.y_max = 4096;
+		wacom_register_input(wacom);
+	}
+}
+
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -907,6 +978,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	wacom->usbdev = dev;
 	wacom->intf = intf;
 	mutex_init(&wacom->lock);
+	INIT_WORK(&wacom->work, wacom_wireless_work);
 	usb_make_path(dev, wacom->phys, sizeof(wacom->phys));
 	strlcat(wacom->phys, "/input0", sizeof(wacom->phys));
 
@@ -977,6 +1049,7 @@ static void wacom_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 
 	usb_kill_urb(wacom->irq);
+	cancel_work_sync(&wacom->work);
 	if (wacom->wacom_wac.input)
 		input_unregister_device(wacom->wacom_wac.input);
 	wacom_destroy_leds(wacom);
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 6264e6a..fce7a09 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1046,9 +1046,27 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 
 static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 {
-	if (len != WACOM_PKGLEN_WIRELESS)
+	unsigned char *data = wacom->data;
+	int connected;
+
+	if (len != WACOM_PKGLEN_WIRELESS || data[0] != 0x80)
 		return 0;
 
+	connected = data[1] & 0x01;
+	if (connected) {
+		int pid;
+
+		pid = get_unaligned_be16(&data[6]);
+		if (wacom->pid != pid) {
+			wacom->pid = pid;
+			wacom_schedule_work(wacom);
+		}
+	} else if (wacom->pid != 0) {
+		/* disconnected while previously connected */
+		wacom->pid = 0;
+		wacom_schedule_work(wacom);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 2c04b62..cffaf6b 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -111,6 +111,7 @@ struct wacom_wac {
 	struct wacom_features features;
 	struct wacom_shared *shared;
 	struct input_dev *input;
+	int pid;
 };
 
 #endif
-- 
1.7.7.6

