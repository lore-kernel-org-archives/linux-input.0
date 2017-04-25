From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] HID: Wacom: Use devm_kcalloc() in two functions
Date: Tue, 25 Apr 2017 17:13:55 +0200
Message-ID: <d0224def-26ba-d33b-e9be-a6218259c8e4@users.sourceforge.net>
References: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:54114 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949061AbdDYPOP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 11:14:15 -0400
In-Reply-To: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 25 Apr 2017 16:06:08 +0200

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus use the corresponding function "devm_kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of data structures by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/wacom_sys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0022c0dac88a..550faf8819ea 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1245,7 +1245,7 @@ static int wacom_led_groups_alloc_and_register_one(struct device *dev,
 	if (!devres_open_group(dev, &wacom->led.groups[group_id], GFP_KERNEL))
 		return -ENOMEM;
 
-	leds = devm_kzalloc(dev, sizeof(struct wacom_led) * count, GFP_KERNEL);
+	leds = devm_kcalloc(dev, count, sizeof(*leds), GFP_KERNEL);
 	if (!leds) {
 		error = -ENOMEM;
 		goto err;
@@ -1345,8 +1345,7 @@ static int wacom_led_groups_allocate(struct wacom *wacom, int count)
 	struct wacom_group_leds *groups;
 	int error;
 
-	groups = devm_kzalloc(dev, sizeof(struct wacom_group_leds) * count,
-			      GFP_KERNEL);
+	groups = devm_kcalloc(dev, count, sizeof(*groups), GFP_KERNEL);
 	if (!groups)
 		return -ENOMEM;
 
-- 
2.12.2

