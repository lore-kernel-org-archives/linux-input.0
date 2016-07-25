From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 11:14:10 -0700
Message-ID: <1469470451-111822-2-git-send-email-briannorris@chromium.org>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>
List-Id: linux-input@vger.kernel.org

cros_ec_cmd_xfer returns success status if the command transport
completes successfully, but the execution result is incorrectly ignored.
In many cases, the execution result is assumed to be successful, leading
to ignored errors and operating on uninitialized data.

We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
problems. Let's use it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index a0d95ff682ae..2d5ff86398d0 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -215,7 +215,7 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 	msg->outsize = request_len;
 	msg->insize = response_len;
 
-	result = cros_ec_cmd_xfer(bus->ec, msg);
+	result = cros_ec_cmd_xfer_status(bus->ec, msg);
 	if (result < 0) {
 		dev_err(dev, "Error transferring EC i2c message %d\n", result);
 		goto exit;
-- 
2.8.0.rc3.226.g39d4020
