From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-zydacron: Delete an error message for a failed memory
 allocation in zc_probe()
Date: Fri, 2 Feb 2018 21:46:37 +0100
Message-ID: <4064fe6c-18d1-1a82-ea46-9c2d86cdbf69@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:50635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeBBUqq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Feb 2018 15:46:46 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:41:37 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-zydacron.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1a660bd97ab2..3e8afaea2ab3 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -170,10 +170,8 @@ static int zc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct zc_device *zc;
 
 	zc = devm_kzalloc(&hdev->dev, sizeof(*zc), GFP_KERNEL);
-	if (zc == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
+	if (!zc)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, zc);
 
-- 
2.16.1

