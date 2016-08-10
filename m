From: Brian Norris <briannorris@chromium.org>
Subject: [RESEND PATCH 2/2] Input: cros_ec_keyb - Fix usage of cros_ec_cmd_xfer()
Date: Wed, 10 Aug 2016 13:37:19 -0700
Message-ID: <1470861439-129201-3-git-send-email-briannorris@chromium.org>
References: <1470861439-129201-1-git-send-email-briannorris@chromium.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1470861439-129201-1-git-send-email-briannorris@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>, "# 9798ac6d32c1 mfd : cros_ec : Add cros_ec_cmd_xfer_status helper" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

cros_ec_cmd_xfer returns success status if the command transport
completes successfully, but the execution result is incorrectly ignored.
In many cases, the execution result is assumed to be successful, leading
to ignored errors and operating on uninitialized data.

We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
problems. Let's use it.

[Regarding the 'Fixes' tag; there is significant refactoring since the driver's
introduction, but the underlying logical error exists throughout I believe]

Fixes: 6af6dc2d2aa6 ("input: Add ChromeOS EC keyboard driver")
Cc: <stable@vger.kernel.org> # 9798ac6d32c1 mfd: cros_ec: Add cros_ec_cmd_xfer_status() helper
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
