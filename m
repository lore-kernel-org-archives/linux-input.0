From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 3/4] Input: auo_pixcir_ts - keep own pointer to platform_data
Date: Sat, 23 Feb 2013 12:57:43 +0100
Message-ID: <201302231257.43936.heiko@sntech.de>
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

When supporting devicetree the platformdata may not necessarily come
from the dev but may be generated in the driver instead.

Therefore keep the pointer in the driver struct instead of using
dev.platform_data.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/input/touchscreen/auo-pixcir-ts.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 6317a9c..c0a2483 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -111,6 +111,7 @@
 struct auo_pixcir_ts {
 	struct i2c_client	*client;
 	struct input_dev	*input;
+	const struct auo_pixcir_ts_platdata *pdata;
 	char			phys[32];
 
 	/* special handling for touch_indicate interupt mode */
@@ -132,7 +133,7 @@ static int auo_pixcir_collect_data(struct auo_pixcir_ts *ts,
 				   struct auo_point_t *point)
 {
 	struct i2c_client *client = ts->client;
-	const struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
+	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 	uint8_t raw_coord[8];
 	uint8_t raw_area[4];
 	int i, ret;
@@ -178,8 +179,7 @@ static int auo_pixcir_collect_data(struct auo_pixcir_ts *ts,
 static irqreturn_t auo_pixcir_interrupt(int irq, void *dev_id)
 {
 	struct auo_pixcir_ts *ts = dev_id;
-	struct i2c_client *client = ts->client;
-	const struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
+	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 	struct auo_point_t point[AUO_PIXCIR_REPORT_POINTS];
 	int i;
 	int ret;
@@ -290,7 +290,7 @@ static int auo_pixcir_int_config(struct auo_pixcir_ts *ts,
 					   int int_setting)
 {
 	struct i2c_client *client = ts->client;
-	struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
+	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_INT_SETTING);
@@ -527,6 +527,7 @@ static int auo_pixcir_probe(struct i2c_client *client,
 
 	msleep(200);
 
+	ts->pdata = pdata;
 	ts->client = client;
 	ts->touch_ind_mode = 0;
 	init_waitqueue_head(&ts->wait);
@@ -624,7 +625,7 @@ err_gpio_int:
 static int auo_pixcir_remove(struct i2c_client *client)
 {
 	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
-	const struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
+	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
 
 	free_irq(client->irq, ts);
 
-- 
1.7.2.3
