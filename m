From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: zet6223 - Export OF device ID as module aliases
Date: Mon, 20 Feb 2017 17:08:55 -0300
Message-ID: <20170220200855.9951-1-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:36324
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750935AbdBTUJI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 15:09:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jelle van der Waa <jelle@vdwaa.nl>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
device was registered via OF, this means that exporting the OF device ID
table device aliases in the module is not needed. But in order to change
how the core reports modaliases to user-space, it's better to export it.

Before this patch:

$ modinfo drivers/input/touchscreen/zet6223.ko | grep alias
alias:          i2c:zet6223

After this patch:

$ modinfo drivers/input/touchscreen/zet6223.ko | grep alias
alias:          of:N*T*Czeitec,zet6223C*
alias:          of:N*T*Czeitec,zet6223
alias:          i2c:zet6223

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/zet6223.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/zet6223.c b/drivers/input/touchscreen/zet6223.c
index e7fb00b511ec..19ffcc7b886c 100644
--- a/drivers/input/touchscreen/zet6223.c
+++ b/drivers/input/touchscreen/zet6223.c
@@ -245,6 +245,7 @@ static const struct of_device_id zet6223_of_match[] = {
 	{ .compatible = "zeitec,zet6223" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, zet6223_of_match);
 
 static const struct i2c_device_id zet6223_id[] = {
 	{ "zet6223", 0},
-- 
2.9.3

