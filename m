From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/2] [hidp] Use the control socket for raw messages
Date: Wed, 20 Jan 2010 12:00:42 +0000
Message-ID: <1263988842.1735.2519.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35681 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab0ATMBD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 07:01:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>

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


