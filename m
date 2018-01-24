From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] Input: bcm5974: Delete an error message for a failed
 memory allocation in bcm5974_wellspring_mode()
Date: Wed, 24 Jan 2018 21:30:09 +0100
Message-ID: <9371a1f7-beee-212d-05d7-ba081a6990c1@users.sourceforge.net>
References: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:54808 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXUaN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 15:30:13 -0500
In-Reply-To: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 21:09:28 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/mouse/bcm5974.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index d0122134f320..994805513df9 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -670,7 +670,6 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 
 	data = kmalloc(c->um_size, GFP_KERNEL);
 	if (!data) {
-		dev_err(&dev->intf->dev, "out of memory\n");
 		retval = -ENOMEM;
 		goto out;
 	}
-- 
2.16.1

