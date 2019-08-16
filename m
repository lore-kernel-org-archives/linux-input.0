From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 59/63] Input: atmel_mxt_ts: Prevent crash due to freeing of input device
Date: Fri, 16 Aug 2019 17:38:26 +0900
Message-ID: <20190816083830.19553-5-jiada_wang@mentor.com>
References: <20190816083830.19553-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083830.19553-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>

Move sysfs creation after intializing the input device to
prevent crash due to freeing of input device by function via sysfs.

Signed-off-by: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
Signed-off-by: Sanjeev Chugh <sanjeev_chugh@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 431c2c54eab0..8e95f46a30d7 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2962,6 +2962,8 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 		goto err_free_mem;
 	}
 
+	data->input_dev = input_dev;
+
 	if (data->gpio_attrs.attrs) {
 		error = sysfs_create_group(&input_dev->dev.kobj,
 					   &data->gpio_attrs);
@@ -2972,11 +2974,10 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 		}
 	}
 
-	data->input_dev = input_dev;
-
 	return 0;
 
 err_free_mem:
+	data->input_dev = NULL;
 	input_free_device(input_dev);
 	return error;
 }
@@ -4597,13 +4598,6 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		msleep(MXT_RESET_TIME);
 	}
 
-	error = sysfs_create_group(&client->dev.kobj, &mxt_fw_attr_group);
-	if (error) {
-		dev_err(&client->dev, "Failure %d creating fw sysfs group\n",
-			error);
-		return error;
-	}
-
 	INIT_WORK(&data->watchdog_work, mxt_watchdog_work);
 
 	/* setup watchdog timer */
@@ -4613,11 +4607,18 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	error = mxt_initialize(data);
 	if (error)
-		goto err_free_object;
+		goto err_del_wd_timer;
+
+	error = sysfs_create_group(&client->dev.kobj, &mxt_fw_attr_group);
+	if (error) {
+		dev_err(&client->dev, "Failure %d creating fw sysfs group\n",
+			error);
+		goto err_del_wd_timer;
+	}
 
 	return 0;
 
-err_free_object:
+err_del_wd_timer:
 	cancel_work_sync(&data->watchdog_work);
 	mxt_stop_wd_timer(data);
 	mxt_free_input_device(data);
-- 
2.19.2
