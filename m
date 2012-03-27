From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: wacom - check for allocation failure in probe()
Date: Tue, 27 Mar 2012 23:15:12 +0300
Message-ID: <20120327201511.GA9197@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:36153 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2C0UP3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 16:15:29 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Eduard Hasenleithner <eduard@hasenleithner.at>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We accidentally removed the check for NULL in 3aac0ef10b "Input: wacom -
isolate input registration".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 19ba586..0d26921 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1002,6 +1002,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 		return -EINVAL;
 
 	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
+	if (!wacom)
+		return -ENOMEM;
 
 	wacom_wac = &wacom->wacom_wac;
 	wacom_wac->features = *((struct wacom_features *)id->driver_info);
