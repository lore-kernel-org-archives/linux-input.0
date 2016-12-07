From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH V1] hid: hid-multitouch:- No need of devm functions
Date: Wed,  7 Dec 2016 20:29:33 +0530
Message-ID: <1481122773-6909-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In function mt_probe, the memory allocated for td->fields
is live within the function only. After the allocation
it is immediately freed with devm_kfree. There is no need
to allocate memory for td->fields with devm function so
replace devm_kzalloc with kzalloc and devm_kfree with kfree.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-multitouch.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fb6f1f4..13ea309 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1126,11 +1126,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->mt_report_id = -1;
 	hid_set_drvdata(hdev, td);
 
-	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
-				  GFP_KERNEL);
+	td->fields = kzalloc(sizeof(struct mt_fields), GFP_KERNEL);
 	if (!td->fields) {
 		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error_nomem;
 	}
 
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
@@ -1138,11 +1138,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto error_free;
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto error_free;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -1153,10 +1153,15 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mt_set_input_mode(hdev);
 
 	/* release .fields memory as it is not used anymore */
-	devm_kfree(&hdev->dev, td->fields);
+	kfree(td->fields);
 	td->fields = NULL;
 
 	return 0;
+
+error_free:
+	kfree(td->fields);
+error_nomem:
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4
