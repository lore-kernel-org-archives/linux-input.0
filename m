From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 4/4] HID: Add the transport-driver functions to the HIDP driver.
Date: Wed, 22 Jan 2014 13:49:44 -0500
Message-ID: <1390416584-3667-5-git-send-email-frank.praznik@oh.rr.com>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:51501 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbaAVSuU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 13:50:20 -0500
In-Reply-To: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add raw_request, set_raw_report and output_report transport-driver functions to
the HIDP driver.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 net/bluetooth/hidp/core.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 292e619..b062cee 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -353,6 +353,71 @@ err:
 	return ret;
 }
 
+static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
+			       unsigned char *data, size_t count,
+			       unsigned char report_type)
+{
+	struct hidp_session *session = hid->driver_data;
+	int ret;
+
+	switch (report_type) {
+	case HID_FEATURE_REPORT:
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
+		break;
+	case HID_INPUT_REPORT:
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_INPUT;
+		break;
+	case HID_OUTPUT_REPORT:
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&session->report_mutex))
+		return -ERESTARTSYS;
+
+	/* Set up our wait, and send the report request to the device. */
+	data[0] = reportnum;
+	set_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
+	ret = hidp_send_ctrl_message(session, report_type, data, count);
+	if (ret)
+		goto err;
+
+	/* Wait for the ACK from the device. */
+	while (test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags) &&
+	       !atomic_read(&session->terminate)) {
+		int res;
+
+		res = wait_event_interruptible_timeout(session->report_queue,
+			!test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags)
+				|| atomic_read(&session->terminate),
+			10*HZ);
+		if (res == 0) {
+			/* timeout */
+			ret = -EIO;
+			goto err;
+		}
+		if (res < 0) {
+			/* signal */
+			ret = -ERESTARTSYS;
+			goto err;
+		}
+	}
+
+	if (!session->output_report_success) {
+		ret = -EIO;
+		goto err;
+	}
+
+	ret = count;
+
+err:
+	clear_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
+	mutex_unlock(&session->report_mutex);
+	return ret;
+}
+
 static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
 		unsigned char report_type)
 {
@@ -411,6 +476,29 @@ err:
 	return ret;
 }
 
+static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
+			    __u8 *buf, size_t len, unsigned char rtype,
+			    int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return hidp_get_raw_report(hid, reportnum, buf, len, rtype);
+	case HID_REQ_SET_REPORT:
+		return hidp_set_raw_report(hid, reportnum, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+}
+
+static int hidp_output_report(struct hid_device *hid, __u8 *data, size_t count)
+{
+	struct hidp_session *session = hid->driver_data;
+
+	return hidp_send_intr_message(session,
+				      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
+				      data, count);
+}
+
 static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
@@ -727,6 +815,8 @@ static struct hid_ll_driver hidp_hid_driver = {
 	.stop = hidp_stop,
 	.open  = hidp_open,
 	.close = hidp_close,
+	.raw_request = hidp_raw_request,
+	.output_report = hidp_output_report,
 	.hidinput_input_event = hidp_hidinput_event,
 };
 
-- 
1.8.4.2

