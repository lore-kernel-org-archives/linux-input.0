From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Wed, 20 Jan 2010 11:47:31 +0000
Message-ID: <1263988051.1735.2474.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LSZR9Vtesxz+JaCW9vtG"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130Ab0ATLrm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 06:47:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>


--=-LSZR9Vtesxz+JaCW9vtG
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
kernel. In the past, it was done in a patch in bluetootd.

- 0001-hidp-Use-the-control-socket-for-raw-messages.patch

As discussed, now uses the ctrl channel for sending raw reports to the device.

- 0002-hid-wacom-Implement-Wacom-quirk-in-the-kernel.patch

Uses the above to poke at the device and turn it into mode2

- 0001-hid-sony-Fix-typo-in-error-message.patch

Small typo, for the input tree

- 0001-hid-Enable-Sixaxis-controller-over-Bluetooth-as-well.patch

Use the hidp patch above to enable the sixaxis controller

Cheers


--=-LSZR9Vtesxz+JaCW9vtG
Content-Disposition: attachment; filename*0=0001-hid-Enable-Sixaxis-controller-over-Bluetooth-as-well.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-hid-Enable-Sixaxis-controller-over-Bluetooth-as-well.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 54d987380685cf69d3f9037ef007c73861bf5eff Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 20 Jan 2010 11:31:04 +0000
Subject: [PATCH] [hid] Enable Sixaxis controller over Bluetooth as well

Now that hid_output_raw_report works, port the PS3 Sixaxis
Bluetooth quirk from user-space, into kernel-space.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-sony.c |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3773f69..d88bebf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1337,6 +1337,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 96d723e..d69ac22 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -73,6 +73,12 @@ static int sony_set_operational(struct hid_device *hdev)
 	return ret;
 }
 
+static int sony_set_operational_bt(struct hid_device *hdev)
+{
+	unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
+	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf));
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -101,7 +107,13 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	ret = sony_set_operational(hdev);
+	if (hdev->bus == BUS_USB)
+		ret = sony_set_operational(hdev);
+	else if (hdev->bus == BUS_BLUETOOTH)
+		ret = sony_set_operational_bt(hdev);
+	else
+		ret = 0;
+
 	if (ret < 0)
 		goto err_stop;
 
@@ -121,6 +133,7 @@ static void sony_remove(struct hid_device *hdev)
 
 static const struct hid_device_id sony_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
 		.driver_data = VAIO_RDESC_CONSTANT },
 	{ }
-- 
1.6.5.2


--=-LSZR9Vtesxz+JaCW9vtG
Content-Disposition: attachment; filename="0001-hidp-Use-the-control-socket-for-raw-messages.patch"
Content-Type: text/x-patch; name="0001-hidp-Use-the-control-socket-for-raw-messages.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From e7438e866e4281806393ab6de276d31cb955bfe6 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 18 Jan 2010 16:11:33 +0000
Subject: [PATCH 1/2] [hidp] Use the control socket for raw messages

In commit 2da31939a42f7a676a0bc5155d6a0a39ed8451f2, support
for Bluetooth hid_output_raw_report was added, but it pushes
the data to the intr socket instead of the ctrl one.

This patch makes hid_output_raw_report use the control socket
instead.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 net/bluetooth/hidp/core.c |   70 +++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 5697500..40879ed 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -243,6 +243,39 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 	input_sync(dev);
 }
 
+static int __hidp_send_ctrl_message(struct hidp_session *session,
+			unsigned char hdr, unsigned char *data, int size)
+{
+	struct sk_buff *skb;
+
+	BT_DBG("session %p data %p size %d", session, data, size);
+
+	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
+		BT_ERR("Can't allocate memory for new frame");
+		return -ENOMEM;
+	}
+
+	*skb_put(skb, 1) = hdr;
+	if (data && size > 0)
+		memcpy(skb_put(skb, size), data, size);
+
+	skb_queue_tail(&session->ctrl_transmit, skb);
+
+	return 0;
+}
+
+static inline int hidp_send_ctrl_message(struct hidp_session *session,
+			unsigned char hdr, unsigned char *data, int size)
+{
+	int err;
+
+	err = __hidp_send_ctrl_message(session, hdr, data, size);
+
+	hidp_schedule(session);
+
+	return err;
+}
+
 static int hidp_queue_report(struct hidp_session *session,
 				unsigned char *data, int size)
 {
@@ -282,7 +315,9 @@ static int hidp_send_report(struct hidp_session *session, struct hid_report *rep
 
 static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count)
 {
-	if (hidp_queue_report(hid->driver_data, data, count))
+	if (hidp_send_ctrl_message(hid->driver_data,
+			HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE,
+			data, count))
 		return -ENOMEM;
 	return count;
 }
@@ -307,39 +342,6 @@ static inline void hidp_del_timer(struct hidp_session *session)
 		del_timer(&session->timer);
 }
 
-static int __hidp_send_ctrl_message(struct hidp_session *session,
-			unsigned char hdr, unsigned char *data, int size)
-{
-	struct sk_buff *skb;
-
-	BT_DBG("session %p data %p size %d", session, data, size);
-
-	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
-		BT_ERR("Can't allocate memory for new frame");
-		return -ENOMEM;
-	}
-
-	*skb_put(skb, 1) = hdr;
-	if (data && size > 0)
-		memcpy(skb_put(skb, size), data, size);
-
-	skb_queue_tail(&session->ctrl_transmit, skb);
-
-	return 0;
-}
-
-static inline int hidp_send_ctrl_message(struct hidp_session *session,
-			unsigned char hdr, unsigned char *data, int size)
-{
-	int err;
-
-	err = __hidp_send_ctrl_message(session, hdr, data, size);
-
-	hidp_schedule(session);
-
-	return err;
-}
-
 static void hidp_process_handshake(struct hidp_session *session,
 					unsigned char param)
 {
-- 
1.6.5.2


--=-LSZR9Vtesxz+JaCW9vtG
Content-Disposition: attachment; filename="0001-hid-sony-Fix-typo-in-error-message.patch"
Content-Type: text/x-patch; name="0001-hid-sony-Fix-typo-in-error-message.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 3b7f54ec73ca8966934100e136ebfe0749882e03 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 20 Jan 2010 01:16:22 +0000
Subject: [PATCH 1/2] [hid-sony] Fix typo in error message

---
 drivers/hid/hid-sony.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4e84502..96d723e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -81,7 +81,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	sc = kzalloc(sizeof(*sc), GFP_KERNEL);
 	if (sc == NULL) {
-		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
+		dev_err(&hdev->dev, "can't alloc sony descriptor\n");
 		return -ENOMEM;
 	}
 
-- 
1.6.5.2


--=-LSZR9Vtesxz+JaCW9vtG
Content-Disposition: attachment; filename="0002-hid-wacom-Implement-Wacom-quirk-in-the-kernel.patch"
Content-Type: text/x-patch; name="0002-hid-wacom-Implement-Wacom-quirk-in-the-kernel.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From cebe11030bd6b26d92f4f541d3f109f54be4ad70 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 18 Jan 2010 16:13:41 +0000
Subject: [PATCH 2/2] [hid-wacom] Implement Wacom quirk in the kernel

The hid-wacom driver required user-space to poke at the tablet
to make it send data about the cursor location.

This patch makes it do the same thing but in the kernel.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-wacom.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 7475421..e55ed3f 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -155,7 +155,9 @@ static int wacom_probe(struct hid_device *hdev,
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct wacom_data *wdata;
+	char rep_data[2];
 	int ret;
+	int limit;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (wdata == NULL) {
@@ -165,6 +167,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	hid_set_drvdata(hdev, wdata);
 
+	/* Parse the HID report now */
 	ret = hid_parse(hdev);
 	if (ret) {
 		dev_err(&hdev->dev, "parse failed\n");
@@ -177,6 +180,28 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	/* Set Wacom mode2 */
+	rep_data[0] = 0x03; rep_data[1] = 0x00;
+	limit =3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 2);
+	} while (ret < 0 && limit-- > 0);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to poke device #1, %d\n", ret);
+		goto err_free;
+	}
+
+	/* 0x06 - high reporting speed, 0x05 - low speed */
+	rep_data[0] = 0x06; rep_data[1] = 0x00;
+	limit = 3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 2);
+	} while (ret < 0 && limit-- > 0);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to poke device #2, %d\n", ret);
+		goto err_free;
+	}
+
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
-- 
1.6.5.2


--=-LSZR9Vtesxz+JaCW9vtG--

