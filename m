From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 10/14] HID: wiimote: replace hid_output_raw_report with hid_hw_output_report for output requests
Date: Mon, 10 Feb 2014 12:58:55 -0500
Message-ID: <1392055139-19631-11-git-send-email-benjamin.tissoires@redhat.com>
References: <1392055139-19631-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392055139-19631-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

For BT transport layer,
  ret = hid_output_raw_report(A, B, C, HID_OUTPUT_REPORT);
is equivalent to
  ret = hid_hw_output_report(A, B, C);

So use the new API where available

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-wiimote-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index d7dc6c5b..d003914 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -28,14 +28,14 @@ static int wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 	__u8 *buf;
 	int ret;
 
-	if (!hdev->hid_output_raw_report)
+	if (!hdev->ll_driver->output_report)
 		return -ENODEV;
 
 	buf = kmemdup(buffer, count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_output_raw_report(hdev, buf, count, HID_OUTPUT_REPORT);
+	ret = hid_hw_output_report(hdev, buf, count);
 
 	kfree(buf);
 	return ret;
-- 
1.8.3.1
