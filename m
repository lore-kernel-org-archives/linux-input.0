From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/4] input: misc: gp2a: Use managed resource helpers
Date: Fri, 25 Jan 2019 18:50:42 +0100
Message-ID: <20190125175045.22576-2-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mchehab+samsung@kernel.org, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca, pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Simplify cleanup of failures by using managed resource helpers

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/gp2ap002a00f.c | 37 ++++++++++---------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index c6a29e57b5e4..79c8c4c56d1a 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -138,14 +138,15 @@ static int gp2a_probe(struct i2c_client *client,
 			return error;
 	}
 
-	error = gpio_request_one(pdata->vout_gpio, GPIOF_IN, GP2A_I2C_NAME);
+	error = devm_gpio_request_one(&client->dev, pdata->vout_gpio,
+				      GPIOF_IN, GP2A_I2C_NAME);
 	if (error)
 		goto err_hw_shutdown;
 
-	dt = kzalloc(sizeof(struct gp2a_data), GFP_KERNEL);
+	dt = devm_kzalloc(&client->dev, sizeof(struct gp2a_data), GFP_KERNEL);
 	if (!dt) {
 		error = -ENOMEM;
-		goto err_free_gpio;
+		goto err_hw_shutdown;
 	}
 
 	dt->pdata = pdata;
@@ -153,12 +154,12 @@ static int gp2a_probe(struct i2c_client *client,
 
 	error = gp2a_initialize(dt);
 	if (error < 0)
-		goto err_free_mem;
+		goto err_hw_shutdown;
 
-	dt->input = input_allocate_device();
+	dt->input = devm_input_allocate_device(&client->dev);
 	if (!dt->input) {
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_hw_shutdown;
 	}
 
 	input_set_drvdata(dt->input, dt);
@@ -171,19 +172,18 @@ static int gp2a_probe(struct i2c_client *client,
 
 	input_set_capability(dt->input, EV_SW, SW_FRONT_PROXIMITY);
 
-	error = request_threaded_irq(client->irq, NULL, gp2a_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-				IRQF_ONESHOT,
-			GP2A_I2C_NAME, dt);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			gp2a_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+			IRQF_ONESHOT, GP2A_I2C_NAME, dt);
 	if (error) {
 		dev_err(&client->dev, "irq request failed\n");
-		goto err_free_input_dev;
+		goto err_hw_shutdown;
 	}
 
 	error = input_register_device(dt->input);
 	if (error) {
 		dev_err(&client->dev, "device registration failed\n");
-		goto err_free_irq;
+		goto err_hw_shutdown;
 	}
 
 	device_init_wakeup(&client->dev, pdata->wakeup);
@@ -191,14 +191,6 @@ static int gp2a_probe(struct i2c_client *client,
 
 	return 0;
 
-err_free_irq:
-	free_irq(client->irq, dt);
-err_free_input_dev:
-	input_free_device(dt->input);
-err_free_mem:
-	kfree(dt);
-err_free_gpio:
-	gpio_free(pdata->vout_gpio);
 err_hw_shutdown:
 	if (pdata->hw_shutdown)
 		pdata->hw_shutdown(client);
@@ -210,12 +202,7 @@ static int gp2a_remove(struct i2c_client *client)
 	struct gp2a_data *dt = i2c_get_clientdata(client);
 	const struct gp2a_platform_data *pdata = dt->pdata;
 
-	free_irq(client->irq, dt);
-
 	input_unregister_device(dt->input);
-	kfree(dt);
-
-	gpio_free(pdata->vout_gpio);
 
 	if (pdata->hw_shutdown)
 		pdata->hw_shutdown(client);
-- 
2.17.1
