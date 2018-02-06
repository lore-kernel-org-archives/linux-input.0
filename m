From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] HID: asus: Delete an error message for a failed memory
 allocation in two functions
Date: Tue, 6 Feb 2018 18:29:46 +0100
Message-ID: <668be04b-719e-31e7-05bf-7f5e6d6e0a83@users.sourceforge.net>
References: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:03:19 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6d2894b7d8e7..9573e0b41922 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -566,7 +566,6 @@ static int asus_start_multitouch(struct hid_device *hdev)
 
 	if (!dmabuf) {
 		ret = -ENOMEM;
-		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
 		return ret;
 	}
 
@@ -599,10 +598,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct asus_drvdata *drvdata;
 
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (drvdata == NULL) {
-		hid_err(hdev, "Can't alloc Asus descriptor\n");
+	if (!drvdata)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, drvdata);
 
-- 
2.16.1
