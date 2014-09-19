From: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
Date: Fri, 19 Sep 2014 10:08:12 +0200
Message-ID: <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411114093-3505-1-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

To enable the cros-ec-tunnel driver to be auto-loaded when build as a
module add an of match table (and export it) to match the modalias
information passed on to userspace as the Cros EC MFD driver registers
the MFD subdevices with an of_compatibility string.

Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Reviewed-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 Changes in v2: none

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 05e033c..0403ec1 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -310,11 +310,20 @@ static int ec_i2c_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_i2c_of_match[] = {
+	{ .compatible = "google,cros-ec-i2c-tunnel" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
+#endif
+
 static struct platform_driver ec_i2c_tunnel_driver = {
 	.probe = ec_i2c_probe,
 	.remove = ec_i2c_remove,
 	.driver = {
 		.name = "cros-ec-i2c-tunnel",
+		.of_match_table = of_match_ptr(cros_ec_i2c_of_match),
 	},
 };
 
-- 
2.1.0
