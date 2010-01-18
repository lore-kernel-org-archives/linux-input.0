From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Mon, 18 Jan 2010 16:49:59 +0000
Message-ID: <1263833399.20565.2905.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OIT4h28Og8BvJnndCxBY"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: bgunn-2XggCk4BHTRBDgjK7y7TUQ@public.gmane.org, Ping <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--=-OIT4h28Og8BvJnndCxBY
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
kernel. In the past, it was done in a patch in bluetootd.

The first patch is probably completely wrong. Right now,
hid_output_raw_report is done on the intr socket, instead of the ctrl
socket. If it's correct to do it on the intr socket, we'd need to add
some API as a way to select the ctrl socket instead for use in that
driver.

I still have the exact same problems as with the user-space patch in
that an error occurs sending the second blob of data to the tablet, the
first time the driver is initialised. Ping, any ideas about that?

Cheers

--=-OIT4h28Og8BvJnndCxBY
Content-Disposition: attachment; filename="0001-hidp-Use-the-control-socket-for-raw-messages.patch"
Content-Type: text/x-patch; name="0001-hidp-Use-the-control-socket-for-raw-messages.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 024b4ebd722ddb18f5f455c4db4a3f5ff41caa38 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Date: Mon, 18 Jan 2010 16:11:33 +0000
Subject: [PATCH 1/2] [hidp] Use the control socket for raw messages

In commit 2da31939a42f7a676a0bc5155d6a0a39ed8451f2, support
for Bluetooth hid_output_raw_report was added, but it pushes
the data to the intr socket instead of the ctrl one.

This patch makes hid_output_raw_report use the control socket
instead.

Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
---
 net/bluetooth/hidp/core.c |   70 +++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 5697500..8866582 100644
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
+	if (count <= 1)
+		return -EINVAL;
+	if (hidp_send_ctrl_message(hid->driver_data, data[0], data + 1, count - 1))
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


--=-OIT4h28Og8BvJnndCxBY
Content-Disposition: attachment; filename="0002-hid-Implement-Wacom-quirk-in-the-kernel.patch"
Content-Type: text/x-patch; name="0002-hid-Implement-Wacom-quirk-in-the-kernel.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 6f83c0d084631033db9cb9b9452f5cf2e2bf67c2 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Date: Mon, 18 Jan 2010 16:13:41 +0000
Subject: [PATCH 2/2] [hid] Implement Wacom quirk in the kernel

The hid-wacom driver required user-space to poke at the tablet
to make it send data about the cursor location.

This patch makes it do the same thing but in the kernel.

Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
---
 drivers/hid/hid-wacom.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 7475421..4030824 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -155,6 +155,7 @@ static int wacom_probe(struct hid_device *hdev,
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct wacom_data *wdata;
+	char rep_data[3];
 	int ret;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
@@ -177,6 +178,18 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	rep_data[0] = 0x53; /* HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE */
+	rep_data[1] = 0x03; rep_data[2] = 0x00;
+	ret = hdev->hid_output_raw_report (hdev, rep_data, 3);
+	if (ret < 0)
+		dev_err(&hdev->dev, "failed to poke device #1, %d\n", ret);
+
+	rep_data[0] = 0x71; /* HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE */
+	/* 0x06 - high reporting speed, 0x05 - low speed */
+	rep_data[1] = 0x06; rep_data[2] = 0x00;
+	ret = hdev->hid_output_raw_report (hdev, rep_data, 3);
+		dev_err(&hdev->dev, "failed to poke device #2, %d\n", ret);
+
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
-- 
1.6.5.2


--=-OIT4h28Og8BvJnndCxBY--
