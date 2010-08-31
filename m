From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 2/6 v2] HID: magicmouse: move features reports to static array
Date: Tue, 31 Aug 2010 14:41:04 -0400
Message-ID: <1283280068-12285-2-git-send-email-chase.douglas@canonical.com>
References: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Poole <mdpoole@troilus.org>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Chase Douglas <chase.douglas@ubuntu.com>

By moving the feature reports to an array, we can easily support
more products with different initialization reports. This will be
useful for enabling the Apple Magic Trackpad.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Acked-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d38b529..3a2147d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -377,14 +377,23 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 	}
 }
 
+struct feature {
+	__u8 data[3];
+	__u8 length;
+};
+
+static struct feature mouse_features[] = {
+	{ { 0xd7, 0x01 }, 2 },
+	{ { 0xf8, 0x01, 0x32 }, 3 }
+};
+
 static int magicmouse_probe(struct hid_device *hdev,
 	const struct hid_device_id *id)
 {
-	__u8 feature_1[] = { 0xd7, 0x01 };
-	__u8 feature_2[] = { 0xf8, 0x01, 0x32 };
 	struct input_dev *input;
 	struct magicmouse_sc *msc;
 	struct hid_report *report;
+	int i;
 	int ret;
 
 	msc = kzalloc(sizeof(*msc), GFP_KERNEL);
@@ -426,19 +435,15 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 	report->size = 6;
 
-	ret = hdev->hid_output_raw_report(hdev, feature_1, sizeof(feature_1),
-			HID_FEATURE_REPORT);
-	if (ret != sizeof(feature_1)) {
-		dev_err(&hdev->dev, "unable to request touch data (1:%d)\n",
-				ret);
-		goto err_stop_hw;
-	}
-	ret = hdev->hid_output_raw_report(hdev, feature_2,
-			sizeof(feature_2), HID_FEATURE_REPORT);
-	if (ret != sizeof(feature_2)) {
-		dev_err(&hdev->dev, "unable to request touch data (2:%d)\n",
-				ret);
-		goto err_stop_hw;
+	for (i = 0; i < ARRAY_SIZE(mouse_features); i++) {
+		ret = hdev->hid_output_raw_report(hdev, mouse_features[i].data,
+				mouse_features[i].length, HID_FEATURE_REPORT);
+		if (ret != mouse_features[i].length) {
+			dev_err(&hdev->dev,
+				"unable to request touch data (%d:%d)\n",
+				i, ret);
+			goto err_stop_hw;
+		}
 	}
 
 	input = input_allocate_device();
-- 
1.7.1
