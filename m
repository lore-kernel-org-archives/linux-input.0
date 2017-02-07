From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 09/18] HID: Return an error code only as a constant in
 hid_allocate_device()
Date: Tue, 7 Feb 2017 20:51:37 +0100
Message-ID: <58187414-2ced-17cb-cb6a-0fe87d0e5fac@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:49584 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752885AbdBGTvz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 14:51:55 -0500
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 19:17:36 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the local variable "ret" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f4ea3590954c..a5db000ed1c4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2716,11 +2716,10 @@ EXPORT_SYMBOL_GPL(hid_add_device);
 struct hid_device *hid_allocate_device(void)
 {
 	struct hid_device *hdev;
-	int ret = -ENOMEM;
 
 	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
-		return ERR_PTR(ret);
+		return ERR_PTR(-ENOMEM);
 
 	device_initialize(&hdev->dev);
 	hdev->dev.release = hid_device_release;
-- 
2.11.1

