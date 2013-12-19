From: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Bluetooth: hidp: make sure input buffers are big enough
Date: Thu, 19 Dec 2013 12:09:32 +0100
Message-ID: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

HID core expects the input buffers to be at least of size 4096
(HID_MAX_BUFFER_SIZE). Other sizes will result in buffer-overflows if an
input-report is smaller than advertised. We could, like i2c, compute the
biggest report-size instead of using HID_MAX_BUFFER_SIZE, but this will
blow up if report-descriptors are changed after ->start() has been called.
So lets be safe and just use the biggest buffer we have.

Note that this adds an additional copy to the HIDP input path. If there is
a way to make sure the skb-buf is big enough, we should use that instead.

The best way would be to make hid-core honor the @size argument, though,
that sounds easier than it is. So lets just fix the buffer-overflows for
now and afterwards look for a faster way for all transport drivers.

Signed-off-by: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Hi

Any ideas how to improve this patch? I'd like to avoid the extra copy but I have
no clue how the skb stuff works exactly.

I also haven't figured out a nice way to make HID-core honor the "size"
parameter. hid-input depends on getting the whole input-report.

Comments welcome!
David

 net/bluetooth/hidp/core.c | 16 ++++++++++++++--
 net/bluetooth/hidp/hidp.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 292e619..d9fb934 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -430,6 +430,16 @@ static void hidp_del_timer(struct hidp_session *session)
 		del_timer(&session->timer);
 }
 
+static void hidp_process_report(struct hidp_session *session,
+				int type, const u8 *data, int len, int intr)
+{
+	if (len > HID_MAX_BUFFER_SIZE)
+		len = HID_MAX_BUFFER_SIZE;
+
+	memcpy(session->input_buf, data, len);
+	hid_input_report(session->hid, type, session->input_buf, len, intr);
+}
+
 static void hidp_process_handshake(struct hidp_session *session,
 					unsigned char param)
 {
@@ -502,7 +512,8 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 			hidp_input_report(session, skb);
 
 		if (session->hid)
-			hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 0);
+			hidp_process_report(session, HID_INPUT_REPORT,
+					    skb->data, skb->len, 0);
 		break;
 
 	case HIDP_DATA_RTYPE_OTHER:
@@ -584,7 +595,8 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 			hidp_input_report(session, skb);
 
 		if (session->hid) {
-			hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 1);
+			hidp_process_report(session, HID_INPUT_REPORT,
+					    skb->data, skb->len, 1);
 			BT_DBG("report len %d", skb->len);
 		}
 	} else {
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index ab52414..8798492 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -24,6 +24,7 @@
 #define __HIDP_H
 
 #include <linux/types.h>
+#include <linux/hid.h>
 #include <linux/kref.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/l2cap.h>
@@ -179,6 +180,9 @@ struct hidp_session {
 
 	/* Used in hidp_output_raw_report() */
 	int output_report_success; /* boolean */
+
+	/* temporary input buffer */
+	u8 input_buf[HID_MAX_BUFFER_SIZE];
 };
 
 /* HIDP init defines */
-- 
1.8.5.1
