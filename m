From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/7] i2c: i2c-cros-ec-tunnel: Set retries to 3
Date: Mon, 28 Jul 2014 14:19:22 +0200
Message-ID: <1406549967-21291-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

Since the i2c bus can get wedged on the EC sometimes, set the number of retries
to 3. Since we un-wedge the bus immediately after the wedge happens, this is the
correct fix since only one transfer will fail.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 05e033c..a4411da 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define I2C_MAX_RETRIES 3
+
 /**
  * struct ec_i2c_device - Driver data for I2C tunnel
  *
@@ -290,6 +292,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	bus->adap.algo_data = bus;
 	bus->adap.dev.parent = &pdev->dev;
 	bus->adap.dev.of_node = np;
+	bus->adap.retries = I2C_MAX_RETRIES;
 
 	err = i2c_add_adapter(&bus->adap);
 	if (err) {
-- 
2.0.0.rc2
