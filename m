From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/4] HID: Add transport-driver callbacks to the hid_ll_driver struct
Date: Wed, 22 Jan 2014 13:49:41 -0500
Message-ID: <1390416584-3667-2-git-send-email-frank.praznik@oh.rr.com>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48404 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbaAVSuT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 13:50:19 -0500
In-Reply-To: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add raw_request and output_report callbacks to the hid_ll_driver struct.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 include/linux/hid.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 31b9d29..003cc8e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -700,8 +700,14 @@ struct hid_ll_driver {
 			struct hid_report *report, int reqtype);
 
 	int (*wait)(struct hid_device *hdev);
-	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 
+	int (*raw_request) (struct hid_device *hdev, unsigned char reportnum,
+			    __u8 *buf, size_t len, unsigned char rtype,
+			    int reqtype);
+
+	int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t len);
+
+	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 };
 
 #define	PM_HINT_FULLON	1<<5
-- 
1.8.4.2

