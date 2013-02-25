From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: auo_pixcir_ts - add devicetree support
Date: Sun, 24 Feb 2013 19:06:41 -0800
Message-ID: <20130225030641.GA18433@core.coreip.homeip.net>
References: <201302231255.23772.heiko@sntech.de>
 <201302231258.16498.heiko@sntech.de>
 <20130224080015.GA20590@core.coreip.homeip.net>
 <201302241058.01412.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59257 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759574Ab3BYDGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Feb 2013 22:06:44 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so1400364pbb.34
        for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 19:06:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201302241058.01412.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Feb 24, 2013 at 10:58:00AM +0100, Heiko Stübner wrote:
> Hi Dmitry,
> 
> Am Sonntag, 24. Februar 2013, 09:00:15 schrieb Dmitry Torokhov:
> > Hi Heiko,
> > 
> > On Sat, Feb 23, 2013 at 12:58:16PM +0100, Heiko Stübner wrote:
> > > +static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device
> > > *dev) +{
> > > +	struct auo_pixcir_ts_platdata *pdata = NULL;
> > > +
> > > +#ifdef CONFIG_OF
> > > +	struct device_node *np = dev->of_node;
> > > +
> > > +	if (!np)
> > > +		return NULL;
> > > +
> > > +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > > +	if (!pdata) {
> > > +		dev_err(dev, "failed to allocate platform data\n");
> > > +		return NULL;
> > > +	}
> > 
> > I disike #ifdefs in the middle of the code, also it would be nice if we
> > signal the proper error instead of always using -EINVAL when there are
> > issues with platform/DT data.
> > 
> > How about the version of the patch below?
> 
> I tested it and everything of course still works :-) .

OK, great, then I will queue these for the next merge window.

Could you also try this patch (it however needs attached patch enhancing
devres to support custom actions).

Thanks.

-- 
Dmitry

Input: auo-pixer-ts - switch to using managed resources

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This simplifier error unwinding and device teardown.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/auo-pixcir-ts.c |  162 ++++++++++++-----------------
 1 file changed, 68 insertions(+), 94 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index dfa6d54..f4ba6ffa 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -533,13 +533,21 @@ static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device *dev)
 }
 #endif
 
+static void auo_pixcir_reset(void *data)
+{
+	struct auo_pixcir_ts *ts = data;
+
+	gpio_set_value(ts->pdata->gpio_rst, 0);
+}
+
 static int auo_pixcir_probe(struct i2c_client *client,
-				      const struct i2c_device_id *id)
+			    const struct i2c_device_id *id)
 {
 	const struct auo_pixcir_ts_platdata *pdata;
 	struct auo_pixcir_ts *ts;
 	struct input_dev *input_dev;
-	int ret;
+	int version;
+	int error;
 
 	pdata = dev_get_platdata(&client->dev);
 	if (!pdata) {
@@ -548,60 +556,30 @@ static int auo_pixcir_probe(struct i2c_client *client,
 			return PTR_ERR(pdata);
 	}
 
-	ts = kzalloc(sizeof(struct auo_pixcir_ts), GFP_KERNEL);
+	ts = devm_kzalloc(&client->dev,
+			  sizeof(struct auo_pixcir_ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
-	ret = gpio_request(pdata->gpio_int, "auo_pixcir_ts_int");
-	if (ret) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_int, ret);
-		goto err_gpio_int;
-	}
-
-	ret = gpio_direction_input(pdata->gpio_int);
-	if (ret) {
-		dev_err(&client->dev, "setting direction of gpio %d failed %d\n",
-			pdata->gpio_int, ret);
-		goto err_gpio_dir;
-	}
-
-	ret = gpio_request(pdata->gpio_rst, "auo_pixcir_ts_rst");
-	if (ret) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_rst, ret);
-		goto err_gpio_dir;
-	}
-
-	ret = gpio_direction_output(pdata->gpio_rst, 1);
-	if (ret) {
-		dev_err(&client->dev, "setting direction of gpio %d failed %d\n",
-			pdata->gpio_rst, ret);
-		goto err_gpio_rst;
+	input_dev = devm_input_allocate_device(&client->dev);
+	if (!input_dev) {
+		dev_err(&client->dev, "could not allocate input device\n");
+		return -ENOMEM;
 	}
 
-	msleep(200);
-
 	ts->pdata = pdata;
 	ts->client = client;
+	ts->input = input_dev;
 	ts->touch_ind_mode = 0;
+	ts->stopped = true;
 	init_waitqueue_head(&ts->wait);
 
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
 
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(&client->dev, "could not allocate input device\n");
-		goto err_input_alloc;
-	}
-
-	ts->input = input_dev;
-
 	input_dev->name = "AUO-Pixcir touchscreen";
 	input_dev->phys = ts->phys;
 	input_dev->id.bustype = BUS_I2C;
-	input_dev->dev.parent = &client->dev;
 
 	input_dev->open = auo_pixcir_input_open;
 	input_dev->close = auo_pixcir_input_close;
@@ -626,72 +604,69 @@ static int auo_pixcir_probe(struct i2c_client *client,
 			     AUO_PIXCIR_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
 
-	ret = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_VERSION);
-	if (ret < 0)
-		goto err_fw_vers;
-	dev_info(&client->dev, "firmware version 0x%X\n", ret);
-
-	ret = auo_pixcir_int_config(ts, pdata->int_setting);
-	if (ret)
-		goto err_fw_vers;
-
 	input_set_drvdata(ts->input, ts);
-	ts->stopped = true;
 
-	ret = request_threaded_irq(client->irq, NULL, auo_pixcir_interrupt,
-				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				   input_dev->name, ts);
-	if (ret) {
-		dev_err(&client->dev, "irq %d requested failed\n", client->irq);
-		goto err_fw_vers;
+	error = devm_gpio_request_one(&client->dev, pdata->gpio_int,
+				      GPIOF_DIR_IN, "auo_pixcir_ts_int");
+	if (error) {
+		dev_err(&client->dev, "request of gpio %d failed, %d\n",
+			pdata->gpio_int, error);
+		return error;
 	}
 
-	/* stop device and put it into deep sleep until it is opened */
-	ret = auo_pixcir_stop(ts);
-	if (ret < 0)
-		goto err_input_register;
-
-	ret = input_register_device(input_dev);
-	if (ret) {
-		dev_err(&client->dev, "could not register input device\n");
-		goto err_input_register;
+	error = devm_gpio_request_one(&client->dev, pdata->gpio_rst,
+				      GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
+				      "auo_pixcir_ts_int");
+	if (error) {
+		dev_err(&client->dev, "request of gpio %d failed, %d\n",
+			pdata->gpio_rst, error);
+		return error;
 	}
 
-	i2c_set_clientdata(client, ts);
-
-	return 0;
-
-err_input_register:
-	free_irq(client->irq, ts);
-err_fw_vers:
-	input_free_device(input_dev);
-err_input_alloc:
-	gpio_set_value(pdata->gpio_rst, 0);
-err_gpio_rst:
-	gpio_free(pdata->gpio_rst);
-err_gpio_dir:
-	gpio_free(pdata->gpio_int);
-err_gpio_int:
-	kfree(ts);
+	error = devm_add_action(&client->dev, auo_pixcir_reset, ts);
+	if (error) {
+		auo_pixcir_reset(ts);
+		dev_err(&client->dev, "failed to register xxx action, %d\n",
+			error);
+		return error;
+	}
 
-	return ret;
-}
+	msleep(200);
 
-static int auo_pixcir_remove(struct i2c_client *client)
-{
-	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
-	const struct auo_pixcir_ts_platdata *pdata = ts->pdata;
+	version = i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_VERSION);
+	if (version < 0) {
+		error = version;
+		return error;
+	}
 
-	free_irq(client->irq, ts);
+	dev_info(&client->dev, "firmware version 0x%X\n", version);
 
-	input_unregister_device(ts->input);
+	error = auo_pixcir_int_config(ts, pdata->int_setting);
+	if (error)
+		return error;
 
-	gpio_set_value(pdata->gpio_rst, 0);
-	gpio_free(pdata->gpio_rst);
+	error = request_threaded_irq(client->irq, NULL, auo_pixcir_interrupt,
+				     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				     input_dev->name, ts);
+	if (error) {
+		dev_err(&client->dev, "irq %d requested failed, %d\n",
+			client->irq, error);
+		return error;
+	}
 
-	gpio_free(pdata->gpio_int);
+	/* stop device and put it into deep sleep until it is opened */
+	error = auo_pixcir_stop(ts);
+	if (error)
+		return error;
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&client->dev, "could not register input device, %d\n",
+			error);
+		return error;
+	}
 
-	kfree(ts);
+	i2c_set_clientdata(client, ts);
 
 	return 0;
 }
@@ -718,7 +693,6 @@ static struct i2c_driver auo_pixcir_driver = {
 		.of_match_table	= of_match_ptr(auo_pixcir_ts_dt_idtable),
 	},
 	.probe		= auo_pixcir_probe,
-	.remove		= auo_pixcir_remove,
 	.id_table	= auo_pixcir_idtable,
 };
 

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devm-add-custom-action.patch"

devres: allow adding custom actions to the stack

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sometimes drivers need to execute one-off actions in their error handling
or device teardown paths. An example would be toggling a GPIO line to
reset the controlled device into predefined state.

To allow performing such actions when using managed resources let's allow
adding them to stack/group of devres resources.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/devres.c  |   74 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    4 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 6683906..507379e 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -671,6 +671,80 @@ int devres_release_group(struct device *dev, void *id)
 EXPORT_SYMBOL_GPL(devres_release_group);
 
 /*
+ * Custom devres actions allow inserting a simple function call
+ * into the teadown sequence.
+ */
+
+struct action_devres {
+	void *data;
+	void (*action)(void *);
+};
+
+static int devm_action_match(struct device *dev, void *res, void *p)
+{
+	struct action_devres *devres = res;
+	struct action_devres *target = p;
+
+	return devres->action == target->action &&
+	       devres->data == target->data;
+}
+
+static void devm_action_release(struct device *dev, void *res)
+{
+	struct action_devres *devres = res;
+
+	devres->action(devres->data);
+}
+
+/**
+ * devm_add_action() - add a custom action to list of managed resources
+ * @dev: Device that owns the action
+ * @action: Function that should be called
+ * @data: Pointer to data passed to @action implementation
+ *
+ * This adds a custom action to the list of managed resources so that
+ * it gets executed as part of standard resource unwinding.
+ */
+int devm_add_action(struct device *dev, void (*action)(void *), void *data)
+{
+	struct action_devres *devres;
+
+	devres = devres_alloc(devm_action_release,
+			      sizeof(struct action_devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	devres->data = data;
+	devres->action = action;
+
+	devres_add(dev, devres);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_add_action);
+
+/**
+ * devm_remove_action() - removes previously added custom action
+ * @dev: Device that owns the action
+ * @action: Function implementing the action
+ * @data: Pointer to data passed to @action implementation
+ *
+ * Removes instance of @action previously added by devm_add_action().
+ * Both action and data should match one of the existing entries.
+ */
+void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
+{
+	struct action_devres devres = {
+		.data = data,
+		.action = action,
+	};
+
+	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
+			       &devres));
+
+}
+EXPORT_SYMBOL_GPL(devm_remove_action);
+
+/*
  * Managed kzalloc/kfree
  */
 static void devm_kzalloc_release(struct device *dev, void *res)
diff --git a/include/linux/device.h b/include/linux/device.h
index 2fbf088..ba7c802 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -578,6 +578,10 @@ extern void devm_kfree(struct device *dev, void *p);
 void __iomem *devm_request_and_ioremap(struct device *dev,
 			struct resource *res);
 
+/* allows to add/remove a custom action to devres stack */
+int devm_add_action(struct device *dev, void (*action)(void *), void *data);
+void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
+
 struct device_dma_parameters {
 	/*
 	 * a low level driver may set these to teach IOMMU code about

--2fHTh5uZTiUOsy+g--
