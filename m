From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: magicmouse: Delete an error message for a failed memory
 allocation in magicmouse_probe()
Date: Sat, 3 Feb 2018 22:20:10 +0100
Message-ID: <79c01fa9-647c-5c34-41cc-3bc9c09f38ee@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:53391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeBCVUY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 16:20:24 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 22:15:05 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-magicmouse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 42ed887ba0be..8d17a812c5ba 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -501,10 +501,8 @@ static int magicmouse_probe(struct hid_device *hdev,
 	int ret;
 
 	msc = devm_kzalloc(&hdev->dev, sizeof(*msc), GFP_KERNEL);
-	if (msc == NULL) {
-		hid_err(hdev, "can't alloc magicmouse descriptor\n");
+	if (!msc)
 		return -ENOMEM;
-	}
 
 	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 
-- 
2.16.1

