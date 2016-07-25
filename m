From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] Input: cros_ec_keyb - Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 11:14:11 -0700
Message-ID: <1469470451-111822-3-git-send-email-briannorris@chromium.org>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32847 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbcGYSO2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 14:14:28 -0400
Received: by mail-pa0-f49.google.com with SMTP id ks6so63637485pab.0
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 11:14:28 -0700 (PDT)
In-Reply-To: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>

cros_ec_cmd_xfer returns success status if the command transport
completes successfully, but the execution result is incorrectly ignored.
In many cases, the execution result is assumed to be successful, leading
to ignored errors and operating on uninitialized data.

We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
problems. Let's use it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index b01966dc7eb3..6e48616a3a88 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -160,7 +160,7 @@ static int cros_ec_keyb_get_state(struct cros_ec_keyb *ckdev, uint8_t *kb_state)
 	msg->insize = ckdev->cols;
 	msg->outsize = 0;
 
-	ret = cros_ec_cmd_xfer(ckdev->ec, msg);
+	ret = cros_ec_cmd_xfer_status(ckdev->ec, msg);
 	if (ret < 0) {
 		dev_err(ckdev->dev, "Error transferring EC message %d\n", ret);
 		goto exit;
-- 
2.8.0.rc3.226.g39d4020

