From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 09/12] HID: uhid: rename uhid_raw_request to uhid_hid_raw_request
Date: Tue, 29 Jul 2014 17:14:23 +0200
Message-ID: <1406646866-999-10-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64793 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaG2PPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:15:01 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so9197262wgh.27
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:15:00 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

We use strict prefixed in uhid.c:
  uhid_char_*: implement char-dev callbacks
  uhid_dev_*: implement uhid device management and runtime
  uhid_hid_*: implement hid-dev callbacks

uhid_raw_request is an hid callback, so rename it to uhid_hid_raw_request.

While at it, move it closer to it's extracted helpers and keep the same
order as in "struct hid_driver".

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 8f5e46b..8bf613e 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -203,6 +203,21 @@ unlock:
 	return ret ? ret : len;
 }
 
+static int uhid_hid_raw_request(struct hid_device *hid, unsigned char reportnum,
+				__u8 *buf, size_t len, unsigned char rtype,
+				int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return uhid_hid_get_report(hid, reportnum, buf, len, rtype);
+	case HID_REQ_SET_REPORT:
+		/* TODO: implement proper SET_REPORT functionality */
+		return -ENOSYS;
+	default:
+		return -EIO;
+	}
+}
+
 static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, size_t count,
 			       unsigned char report_type)
 {
@@ -247,29 +262,14 @@ static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
 	return uhid_hid_output_raw(hid, buf, count, HID_OUTPUT_REPORT);
 }
 
-static int uhid_raw_request(struct hid_device *hid, unsigned char reportnum,
-			    __u8 *buf, size_t len, unsigned char rtype,
-			    int reqtype)
-{
-	switch (reqtype) {
-	case HID_REQ_GET_REPORT:
-		return uhid_hid_get_report(hid, reportnum, buf, len, rtype);
-	case HID_REQ_SET_REPORT:
-		/* TODO: implement proper SET_REPORT functionality */
-		return -ENOSYS;
-	default:
-		return -EIO;
-	}
-}
-
 static struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
 	.close = uhid_hid_close,
 	.parse = uhid_hid_parse,
+	.raw_request = uhid_hid_raw_request,
 	.output_report = uhid_hid_output_report,
-	.raw_request = uhid_raw_request,
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.0.3

