From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/4] Input: auo-pixcir-ts - handle reset gpio directly
Date: Sat, 23 Feb 2013 12:56:48 +0100
Message-ID: <201302231256.48476.heiko@sntech.de>
References: <201302231255.23772.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201302231255.23772.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Devicetree based platforms don't handle device callbacks very well
and until now no board has come along that needs more extended hwinit
than pulling the rst gpio high.

Therefore pull the reset handling directly into the driver and remove
the callbacks from the driver.

If extended device setup is needed at some later point, power-sequences
would probably be the solution of choice.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/input/touchscreen/auo-pixcir-ts.c |   26 ++++++++++++++++++++------
 include/linux/input/auo-pixcir-ts.h       |    4 +---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 813413e..6317a9c 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -511,8 +511,21 @@ static int auo_pixcir_probe(struct i2c_client *client,
 		goto err_gpio_dir;
 	}
 
-	if (pdata->init_hw)
-		pdata->init_hw(client);
+	ret = gpio_request(pdata->gpio_rst, "auo_pixcir_ts_rst");
+	if (ret) {
+		dev_err(&client->dev, "request of gpio %d failed, %d\n",
+			pdata->gpio_rst, ret);
+		goto err_gpio_dir;
+	}
+
+	ret = gpio_direction_output(pdata->gpio_rst, 1);
+	if (ret) {
+		dev_err(&client->dev, "setting direction of gpio %d failed %d\n",
+			pdata->gpio_rst, ret);
+		goto err_gpio_rst;
+	}
+
+	msleep(200);
 
 	ts->client = client;
 	ts->touch_ind_mode = 0;
@@ -597,8 +610,9 @@ err_input_register:
 err_fw_vers:
 	input_free_device(input_dev);
 err_input_alloc:
-	if (pdata->exit_hw)
-		pdata->exit_hw(client);
+	gpio_set_value(pdata->gpio_rst, 0);
+err_gpio_rst:
+	gpio_free(pdata->gpio_rst);
 err_gpio_dir:
 	gpio_free(pdata->gpio_int);
 err_gpio_int:
@@ -616,8 +630,8 @@ static int auo_pixcir_remove(struct i2c_client *client)
 
 	input_unregister_device(ts->input);
 
-	if (pdata->exit_hw)
-		pdata->exit_hw(client);
+	gpio_set_value(pdata->gpio_rst, 0);
+	gpio_free(pdata->gpio_rst);
 
 	gpio_free(pdata->gpio_int);
 
diff --git a/include/linux/input/auo-pixcir-ts.h b/include/linux/input/auo-pixcir-ts.h
index 75d4be7..5049f21 100644
--- a/include/linux/input/auo-pixcir-ts.h
+++ b/include/linux/input/auo-pixcir-ts.h
@@ -43,12 +43,10 @@
  */
 struct auo_pixcir_ts_platdata {
 	int gpio_int;
+	int gpio_rst;
 
 	int int_setting;
 
-	void (*init_hw)(struct i2c_client *);
-	void (*exit_hw)(struct i2c_client *);
-
 	unsigned int x_max;
 	unsigned int y_max;
 };
-- 
1.7.2.3
