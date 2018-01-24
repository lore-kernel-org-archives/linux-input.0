From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: gtco: Improve a size determination in gtco_probe()
Date: Wed, 24 Jan 2018 16:15:59 +0100
Message-ID: <0c363cc1-5532-e482-82bf-c8b59c2bd72f@users.sourceforge.net>
References: <5c4410ab-5174-ce8d-cab6-7979aa61f996@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:54899 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933948AbeAXPQD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 10:16:03 -0500
In-Reply-To: <5c4410ab-5174-ce8d-cab6-7979aa61f996@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 15:08:42 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/tablet/gtco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index f2670872735f..6094241d4aa1 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -829,7 +829,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	struct usb_device	*udev = interface_to_usbdev(usbinterface);
 
 	/* Allocate memory for device structure */
-	gtco = kzalloc(sizeof(struct gtco), GFP_KERNEL);
+	gtco = kzalloc(sizeof(*gtco), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!gtco || !input_dev) {
 		dev_err(&usbinterface->dev, "No more memory\n");
-- 
2.16.1

