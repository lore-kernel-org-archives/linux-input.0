From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: apple: Delete an error message for a failed memory
 allocation in apple_probe()
Date: Tue, 6 Feb 2018 20:35:01 +0100
Message-ID: <83d48f20-dd03-00fc-bfea-cd4a87b7254c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 20:06:53 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 25b7bd56ae11..d739dd3aa622 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -374,10 +374,8 @@ static int apple_probe(struct hid_device *hdev,
 	int ret;
 
 	asc = devm_kzalloc(&hdev->dev, sizeof(*asc), GFP_KERNEL);
-	if (asc == NULL) {
-		hid_err(hdev, "can't alloc apple descriptor\n");
+	if (!asc)
 		return -ENOMEM;
-	}
 
 	asc->quirks = quirks;
 
-- 
2.16.1
