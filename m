From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: gtco: Delete an error message for a failed memory
 allocation in gtco_probe()
Date: Wed, 24 Jan 2018 16:14:45 +0100
Message-ID: <6a7cfd59-769a-9e3e-3c24-e7b028d96254@users.sourceforge.net>
References: <5c4410ab-5174-ce8d-cab6-7979aa61f996@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c4410ab-5174-ce8d-cab6-7979aa61f996@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 15:03:33 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/tablet/gtco.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index 4b8b9d7aa75e..f2670872735f 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -902,7 +902,6 @@ static int gtco_probe(struct usb_interface *usbinterface,
 
 	report = kzalloc(le16_to_cpu(hid_desc->wDescriptorLength), GFP_KERNEL);
 	if (!report) {
-		dev_err(&usbinterface->dev, "No more memory for report\n");
 		error = -ENOMEM;
 		goto err_free_urb;
 	}
-- 
2.16.1
