From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] HID: magicmouse: make transfer buffers DMA capable
Date: Mon, 21 Nov 2016 11:48:41 +0100
Message-ID: <1479725322-30863-4-git-send-email-benjamin.tissoires@redhat.com>
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
 drivers/hid/hid-magicmouse.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d6fa496..20b40ad 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -493,7 +493,8 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 static int magicmouse_probe(struct hid_device *hdev,
 	const struct hid_device_id *id)
 {
-	__u8 feature[] = { 0xd7, 0x01 };
+	const u8 feature[] = { 0xd7, 0x01 };
+	u8 *buf;
 	struct magicmouse_sc *msc;
 	struct hid_report *report;
 	int ret;
@@ -544,6 +545,12 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 	report->size = 6;
 
+	buf = kmemdup(feature, sizeof(feature), GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_stop_hw;
+	}
+
 	/*
 	 * Some devices repond with 'invalid report id' when feature
 	 * report switching it into multitouch mode is sent to it.
@@ -552,8 +559,9 @@ static int magicmouse_probe(struct hid_device *hdev,
 	 * but there seems to be no other way of switching the mode.
 	 * Thus the super-ugly hacky success check below.
 	 */
-	ret = hid_hw_raw_request(hdev, feature[0], feature, sizeof(feature),
+	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(feature),
 				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	kfree(buf);
 	if (ret != -EIO && ret != sizeof(feature)) {
 		hid_err(hdev, "unable to request touch data (%d)\n", ret);
 		goto err_stop_hw;
-- 
2.7.4
