From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/3] Input: qt1070 - Add OF device ID table
Date: Tue, 21 Feb 2017 15:12:54 -0300
Message-ID: <20170221181254.14748-3-javier@osg.samsung.com>
References: <20170221181254.14748-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170221181254.14748-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

The compatible strings don't have a vendor prefix because that's how it's
used currently, and changing this will be a Device Tree ABI break.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/keyboard/qt1070.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 5a5778729e37..76bb51309a78 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -274,9 +274,18 @@ static const struct i2c_device_id qt1070_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, qt1070_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id qt1070_of_match[] = {
+	{ .compatible = "qt1070", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qt1070_of_match);
+#endif
+
 static struct i2c_driver qt1070_driver = {
 	.driver	= {
 		.name	= "qt1070",
+		.of_match_table = of_match_ptr(qt1070_of_match),
 		.pm	= &qt1070_pm_ops,
 	},
 	.id_table	= qt1070_id,
-- 
2.9.3
