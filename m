From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-saitek: Delete an error message for a failed memory
 allocation in saitek_probe()
Date: Sat, 3 Feb 2018 09:19:21 +0100
Message-ID: <e04a936f-9925-3808-9274-6cffe3c63cc3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:63488 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeBCITc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 03:19:32 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 09:12:24 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-saitek.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 39e642686ff0..49355ceddd85 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -45,10 +45,8 @@ static int saitek_probe(struct hid_device *hdev,
 	int ret;
 
 	ssc = devm_kzalloc(&hdev->dev, sizeof(*ssc), GFP_KERNEL);
-	if (ssc == NULL) {
-		hid_err(hdev, "can't alloc saitek descriptor\n");
+	if (!ssc)
 		return -ENOMEM;
-	}
 
 	ssc->quirks = quirks;
 	ssc->mode = -1;
-- 
2.16.1

