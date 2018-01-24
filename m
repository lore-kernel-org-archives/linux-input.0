From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: appletouch: Improve a size determination in
 atp_probe()
Date: Wed, 24 Jan 2018 20:57:56 +0100
Message-ID: <ff27c617-d605-f65c-f707-df75b7f5df42@users.sourceforge.net>
References: <a86a6a93-21eb-4571-465c-24d4c0687965@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:49321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbeAXT57 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 14:57:59 -0500
In-Reply-To: <a86a6a93-21eb-4571-465c-24d4c0687965@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 20:46:49 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/mouse/appletouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 3a709d21ea93..ea4888693889 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -866,7 +866,7 @@ static int atp_probe(struct usb_interface *iface,
 	}
 
 	/* allocate memory for our device state and initialize it */
-	dev = kzalloc(sizeof(struct atp), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!dev || !input_dev) {
 		dev_err(&iface->dev, "Out of memory\n");
-- 
2.16.1

