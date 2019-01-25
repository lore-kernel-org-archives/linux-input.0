From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/3] input: misc: bma150: Use managed resources helpers
Date: Fri, 25 Jan 2019 19:43:58 +0100
Message-ID: <20190125184400.17669-2-pawel.mikolaj.chmiel@gmail.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The driver can be cleaned up by using managed resource helpers

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 40 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 1efcfdf9f8a8..d101bb0a33d6 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -471,7 +471,7 @@ static int bma150_register_input_device(struct bma150_data *bma150)
 	struct input_dev *idev;
 	int error;
 
-	idev = input_allocate_device();
+	idev = devm_input_allocate_device(&bma150->client->dev);
 	if (!idev)
 		return -ENOMEM;
 
@@ -482,10 +482,8 @@ static int bma150_register_input_device(struct bma150_data *bma150)
 	input_set_drvdata(idev, bma150);
 
 	error = input_register_device(idev);
-	if (error) {
-		input_free_device(idev);
+	if (error)
 		return error;
-	}
 
 	bma150->input = idev;
 	return 0;
@@ -496,7 +494,7 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 	struct input_polled_dev *ipoll_dev;
 	int error;
 
-	ipoll_dev = input_allocate_polled_device();
+	ipoll_dev = devm_input_allocate_polled_device(&bma150->client->dev);
 	if (!ipoll_dev)
 		return -ENOMEM;
 
@@ -511,10 +509,8 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 	bma150_init_input_device(bma150, ipoll_dev->input);
 
 	error = input_register_polled_device(ipoll_dev);
-	if (error) {
-		input_free_polled_device(ipoll_dev);
+	if (error)
 		return error;
-	}
 
 	bma150->input_polled = ipoll_dev;
 	bma150->input = ipoll_dev->input;
@@ -543,7 +539,8 @@ static int bma150_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	bma150 = kzalloc(sizeof(struct bma150_data), GFP_KERNEL);
+	bma150 = devm_kzalloc(&client->dev, sizeof(struct bma150_data),
+			      GFP_KERNEL);
 	if (!bma150)
 		return -ENOMEM;
 
@@ -556,7 +553,7 @@ static int bma150_probe(struct i2c_client *client,
 				dev_err(&client->dev,
 					"IRQ GPIO conf. error %d, error %d\n",
 					client->irq, error);
-				goto err_free_mem;
+				return error;
 			}
 		}
 		cfg = &pdata->cfg;
@@ -566,14 +563,14 @@ static int bma150_probe(struct i2c_client *client,
 
 	error = bma150_initialize(bma150, cfg);
 	if (error)
-		goto err_free_mem;
+		return error;
 
 	if (client->irq > 0) {
 		error = bma150_register_input_device(bma150);
 		if (error)
-			goto err_free_mem;
+			return error;
 
-		error = request_threaded_irq(client->irq,
+		error = devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, bma150_irq_thread,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					BMA150_DRIVER, bma150);
@@ -582,12 +579,12 @@ static int bma150_probe(struct i2c_client *client,
 				"irq request failed %d, error %d\n",
 				client->irq, error);
 			input_unregister_device(bma150->input);
-			goto err_free_mem;
+			return error;
 		}
 	} else {
 		error = bma150_register_polled_device(bma150);
 		if (error)
-			goto err_free_mem;
+			return error;
 	}
 
 	i2c_set_clientdata(client, bma150);
@@ -595,10 +592,6 @@ static int bma150_probe(struct i2c_client *client,
 	pm_runtime_enable(&client->dev);
 
 	return 0;
-
-err_free_mem:
-	kfree(bma150);
-	return error;
 }
 
 static int bma150_remove(struct i2c_client *client)
@@ -607,15 +600,10 @@ static int bma150_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 
-	if (client->irq > 0) {
-		free_irq(client->irq, bma150);
+	if (client->irq > 0)
 		input_unregister_device(bma150->input);
-	} else {
+	else
 		input_unregister_polled_device(bma150->input_polled);
-		input_free_polled_device(bma150->input_polled);
-	}
-
-	kfree(bma150);
 
 	return 0;
 }
-- 
2.17.1
