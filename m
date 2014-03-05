From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 2/4] HID: cp2112: remove the last hid_output_raw_report() call
Date: Wed,  5 Mar 2014 16:18:52 -0500
Message-ID: <1394054334-20438-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1394054334-20438-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394054334-20438-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, David Barksdale <dbarksdale@uplogix.com>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

tests have shown that output reports use hid_hw_output_report().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

changes since v1:
- removed FIXME
- actually use the proper calls and do not guess

 drivers/hid/hid-cp2112.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 860db694..a4fff699 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -290,7 +290,12 @@ static int cp2112_hid_output(struct hid_device *hdev, u8 *data, size_t count,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hdev->hid_output_raw_report(hdev, buf, count, report_type);
+	if (report_type == HID_OUTPUT_REPORT)
+		ret = hid_hw_output_report(hdev, buf, count);
+	else
+		ret = hid_hw_raw_request(hdev, buf[0], buf, count, report_type,
+				HID_REQ_SET_REPORT);
+
 	kfree(buf);
 	return ret;
 }
-- 
1.8.5.3
