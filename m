From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] Input: mpu3050: add of_match table for device-tree probing
Date: Thu, 22 Dec 2011 18:39:52 -0800
Message-ID: <1324607992-2919-1-git-send-email-olof@lixom.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34858 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab1LWCkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Dec 2011 21:40:03 -0500
Received: by iaeh11 with SMTP id h11so14366728iae.19
        for <linux-input@vger.kernel.org>; Thu, 22 Dec 2011 18:40:02 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>

Adding invn,mpu3050 as the initial id.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/input/misc/mpu3050.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index f71dc72..e9a57e3 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -348,11 +348,18 @@ static const struct i2c_device_id mpu3050_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mpu3050_ids);
 
+static const struct of_device_id mpu3050_of_match[] = {
+	{ .compatible = "invn,mpu3050", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mpu3050_of_match);
+
 static struct i2c_driver mpu3050_i2c_driver = {
 	.driver	= {
 		.name	= "mpu3050",
 		.owner	= THIS_MODULE,
 		.pm	= &mpu3050_pm,
+		.of_match_table = mpu3050_of_match,
 	},
 	.probe		= mpu3050_probe,
 	.remove		= __devexit_p(mpu3050_remove),
-- 
1.7.8.GIT

