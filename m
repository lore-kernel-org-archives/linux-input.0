From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 2/2] input: cros_ec_keyb: Add of match table
Date: Fri, 19 Sep 2014 10:08:13 +0200
Message-ID: <1411114093-3505-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Doug Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

To enable the cros_ec_keyb driver to be auto-loaded when build as
module add an of match table (and export it) to match the modalias
information passed on to userspace as the Cros EC MFD driver registers
the MFD subdevices with an of_compatibility string.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 Changes in v2: Fixed some indentation issues

 drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 791781a..e1903ec 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -342,10 +342,19 @@ static int cros_ec_keyb_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_keyb_of_match[] = {
+	{ .compatible = "google,cros-ec-keyb" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
+#endif
+
 static struct platform_driver cros_ec_keyb_driver = {
 	.probe = cros_ec_keyb_probe,
 	.driver = {
 		.name = "cros-ec-keyb",
+		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
 		.pm	= &cros_ec_keyb_pm_ops,
 	},
 };
-- 
2.1.0
