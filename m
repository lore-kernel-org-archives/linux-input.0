From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 01/11] HID: uHID: implement .raw_request
Date: Sat,  1 Feb 2014 23:50:20 -0500
Message-ID: <1391316630-29541-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1391316630-29541-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391316630-29541-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It was missing, so adding it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/uhid.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index f5a2b19..438c9f1 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -270,6 +270,22 @@ static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
 	return count;
 }
 
+static int uhid_raw_request(struct hid_device *hid, unsigned char reportnum,
+			    __u8 *buf, size_t len, unsigned char rtype,
+			    int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return uhid_hid_get_raw(hid, reportnum, buf, len, rtype);
+	case HID_REQ_SET_REPORT:
+		if (buf[0] != reportnum)
+			return -EINVAL;
+		return uhid_hid_output_raw(hid, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+}
+
 static struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
@@ -277,6 +293,7 @@ static struct hid_ll_driver uhid_hid_driver = {
 	.close = uhid_hid_close,
 	.parse = uhid_hid_parse,
 	.output_report = uhid_hid_output_report,
+	.raw_request = uhid_raw_request,
 };
 
 #ifdef CONFIG_COMPAT
-- 
1.8.3.1
