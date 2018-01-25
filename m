From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] Input: ims-pcu: Improve a size determination in two
 functions
Date: Thu, 25 Jan 2018 19:53:48 +0100
Message-ID: <1819bb70-3c2c-a86a-29a2-5fb049c3f194@users.sourceforge.net>
References: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:63143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeAYSyB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 13:54:01 -0500
In-Reply-To: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 19:20:38 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/ims-pcu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4aca2a02ff6d..d7778b273151 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -288,12 +288,10 @@ static void ims_pcu_gamepad_report(struct ims_pcu *pcu, u32 data)
 
 static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 {
-	struct ims_pcu_gamepad *gamepad;
-	struct input_dev *input;
 	int error;
+	struct ims_pcu_gamepad *gamepad = kzalloc(sizeof(*gamepad), GFP_KERNEL);
+	struct input_dev *input = input_allocate_device();
 
-	gamepad = kzalloc(sizeof(struct ims_pcu_gamepad), GFP_KERNEL);
-	input = input_allocate_device();
 	if (!gamepad || !input) {
 		dev_err(pcu->dev,
 			"Not enough memory for gamepad device\n");
@@ -2003,10 +2001,9 @@ static int ims_pcu_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
-	struct ims_pcu *pcu;
 	int error;
+	struct ims_pcu *pcu = kzalloc(sizeof(*pcu), GFP_KERNEL);
 
-	pcu = kzalloc(sizeof(struct ims_pcu), GFP_KERNEL);
 	if (!pcu)
 		return -ENOMEM;
 
-- 
2.16.1

