From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] HID: rmi: make transfer buffers DMA capable
Date: Mon, 21 Nov 2016 11:48:42 +0100
Message-ID: <1479725322-30863-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Kernel v4.9 strictly enforces DMA capable buffers, so we need to remove
buffers allocated on the stack.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-rmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 9cd2ca3..be89bcb 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -188,10 +188,16 @@ static int rmi_set_page(struct hid_device *hdev, u8 page)
 static int rmi_set_mode(struct hid_device *hdev, u8 mode)
 {
 	int ret;
-	u8 txbuf[2] = {RMI_SET_RMI_MODE_REPORT_ID, mode};
+	const u8 txbuf[2] = {RMI_SET_RMI_MODE_REPORT_ID, mode};
+	u8 *buf;
 
-	ret = hid_hw_raw_request(hdev, RMI_SET_RMI_MODE_REPORT_ID, txbuf,
+	buf = kmemdup(txbuf, sizeof(txbuf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, RMI_SET_RMI_MODE_REPORT_ID, buf,
 			sizeof(txbuf), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	kfree(buf);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to set rmi mode to %d (%d)\n", mode,
 			ret);
-- 
2.7.4
