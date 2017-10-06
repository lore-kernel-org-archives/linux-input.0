From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/1] Input: joydev - blacklist ds3/ds4/udraw motion sensors
Date: Thu,  5 Oct 2017 18:03:33 -0700
Message-ID: <20171006010333.61496-2-roderick@gaikai.com>
References: <20171006010333.61496-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:50178 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdJFBDk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 21:03:40 -0400
Received: by mail-qk0-f179.google.com with SMTP id o187so14298477qke.7
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 18:03:40 -0700 (PDT)
In-Reply-To: <20171006010333.61496-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>, stable@vger.kernel.org

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Introduce a device table used for blacklisting devices. We currently
blacklist the motion sensor subdevice of THQ Udraw and Sony ds3/ds4.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: stable@vger.kernel.org
---
 drivers/input/joydev.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 29d677c714d2..e2a0f63d5656 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -70,6 +70,40 @@ struct joydev_client {
 	struct list_head node;
 };
 
+/* These codes are copied from from hid-ids.h, unfortunately there is no common
+ * usb_ids/bt_ids.h header.
+ */
+#define USB_VENDOR_ID_SONY 0x54c
+#define USB_VENDOR_ID_THQ		0x20d6
+#define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2	0x09cc
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE	0x0ba0
+#define USB_DEVICE_ID_THQ_PS3_UDRAW	0xcb17
+
+/* List of devices blacklisted from joydev. A reason for blacklisting a
+ * device is to support (legacy) software supporting joydev, but which will
+ * never get updated to support these devices or features. An example would
+ * be handling of motion sensors, which these applications could not handle
+ * resulting in undefined behavior.
+ */
+static const struct joydev_blacklist {
+	__u16 bustype;
+	__u16 vendor;
+	__u16 product;
+	unsigned long propbit; /* Allow for filtering based on device properties. */
+} joydev_blacklist[] = {
+	{ BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ BUS_USB, USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW, BIT(INPUT_PROP_ACCELEROMETER) },
+	{ 0, 0, 0, 0}
+};
+
 static int joydev_correct(int value, struct js_corr *corr)
 {
 	switch (corr->type) {
@@ -805,6 +839,25 @@ static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
 	return true;
 }
 
+
+static bool joydev_dev_is_blacklisted(struct input_dev *dev)
+{
+	int i;
+
+	for (i = 0; joydev_blacklist[i].vendor; i++) {
+		if (dev->id.bustype == joydev_blacklist[i].bustype &&
+		    dev->id.vendor == joydev_blacklist[i].vendor &&
+		    dev->id.product == joydev_blacklist[i].product &&
+		    dev->propbit[0] == joydev_blacklist[i].propbit)
+		{
+			dev_info(&dev->dev, "joydev: Blacklisting '%s'\n", dev->name);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 {
 	/* Avoid touchpads and touchscreens */
@@ -819,6 +872,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 	if (joydev_dev_is_absolute_mouse(dev))
 		return false;
 
+	/* Disable blacklisted devices */
+	if (joydev_dev_is_blacklisted(dev))
+		return false;
+
 	return true;
 }
 
-- 
2.13.6

