From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-a4tech: Delete an error message for a failed memory
 allocation in a4_probe()
Date: Tue, 6 Feb 2018 20:52:52 +0100
Message-ID: <236c998d-02d4-f120-3d03-4619a2bb89d9@users.sourceforge.net>
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
Date: Tue, 6 Feb 2018 20:48:04 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-a4tech.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-a4tech.c b/drivers/hid/hid-a4tech.c
index 9428ea7cdf8a..7a364f17f39e 100644
--- a/drivers/hid/hid-a4tech.c
+++ b/drivers/hid/hid-a4tech.c
@@ -91,10 +91,8 @@ static int a4_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 
 	a4 = devm_kzalloc(&hdev->dev, sizeof(*a4), GFP_KERNEL);
-	if (a4 == NULL) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!a4)
 		return -ENOMEM;
-	}
 
 	a4->quirks = id->driver_data;
 
-- 
2.16.1
