From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/3] Input: synaptics_i2c - Add OF device ID table
Date: Tue, 21 Feb 2017 15:12:53 -0300
Message-ID: <20170221181254.14748-2-javier@osg.samsung.com>
References: <20170221181254.14748-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170221181254.14748-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Aniroop Mathur <a.mathur@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/mouse/synaptics_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index cb2bf203f4ca..8538318d332c 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -652,9 +652,18 @@ static const struct i2c_device_id synaptics_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id synaptics_i2c_of_match[] = {
+	{ .compatible = "synaptics,synaptics_i2c", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, synaptics_i2c_of_match);
+#endif
+
 static struct i2c_driver synaptics_i2c_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
+		.of_match_table = of_match_ptr(synaptics_i2c_of_match),
 		.pm	= &synaptics_i2c_pm,
 	},
 
-- 
2.9.3
