From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] Input: bcm5974: Improve a size determination in
 bcm5974_probe()
Date: Wed, 24 Jan 2018 21:32:08 +0100
Message-ID: <02af8e7d-b6f9-10f9-4f56-de657477bfd5@users.sourceforge.net>
References: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:49405 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXUcM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 15:32:12 -0500
In-Reply-To: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 21:21:11 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/mouse/bcm5974.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 685f56c08931..c827b31c8530 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -915,7 +915,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 	cfg = bcm5974_get_config(udev);
 
 	/* allocate memory for our device state and initialize it */
-	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!dev || !input_dev) {
 		dev_err(&iface->dev, "out of memory\n");
-- 
2.16.1

