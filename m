From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: edt-ft5x06 - switch to newer gpio framework
Date: Tue, 29 Sep 2015 22:14:51 +0300
Message-ID: <20150929191451.GA4411@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36069 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbbI2TO6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 15:14:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: fcooper@ti.com
Cc: linux-input@vger.kernel.org

Hello Franklin S Cooper Jr,

This is a semi-automatic email about new static checker warnings.

The patch 13c23cd18bd1: "Input: edt-ft5x06 - switch to newer gpio 
framework" from Sep 11, 2015, leads to the following Smatch complaint:

drivers/input/touchscreen/edt-ft5x06.c:988 edt_ft5x06_ts_probe()
	 error: we previously assumed 'tsdata->wake_gpio' could be null (see line 908)

drivers/input/touchscreen/edt-ft5x06.c
   907	
   908		if (tsdata->wake_gpio) {
                    ^^^^^^^^^^^^^^^^^
Patch introduces a new NULL check.

   909			usleep_range(5000, 6000);
   910			gpiod_set_value_cansleep(tsdata->wake_gpio, 1);
   911		}
   912	
   913		if (tsdata->reset_gpio) {
   914			usleep_range(5000, 6000);
   915			gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
   916			msleep(300);
   917		}
   918	
   919		input = devm_input_allocate_device(&client->dev);
   920		if (!input) {
   921			dev_err(&client->dev, "failed to allocate input device.\n");
   922			return -ENOMEM;
   923		}
   924	
   925		mutex_init(&tsdata->mutex);
   926		tsdata->client = client;
   927		tsdata->input = input;
   928		tsdata->factory_mode = false;
   929	
   930		error = edt_ft5x06_ts_identify(client, tsdata, fw_version);
   931		if (error) {
   932			dev_err(&client->dev, "touchscreen probe failed\n");
   933			return error;
   934		}
   935	
   936		edt_ft5x06_ts_set_regs(tsdata);
   937		edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
   938		edt_ft5x06_ts_get_parameters(tsdata);
   939	
   940		dev_dbg(&client->dev,
   941			"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
   942			tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
   943	
   944		input->name = tsdata->name;
   945		input->id.bustype = BUS_I2C;
   946		input->dev.parent = &client->dev;
   947	
   948		input_set_abs_params(input, ABS_MT_POSITION_X,
   949				     0, tsdata->num_x * 64 - 1, 0, 0);
   950		input_set_abs_params(input, ABS_MT_POSITION_Y,
   951				     0, tsdata->num_y * 64 - 1, 0, 0);
   952	
   953		touchscreen_parse_properties(input, true);
   954	
   955		error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
   956		if (error) {
   957			dev_err(&client->dev, "Unable to init MT slots.\n");
   958			return error;
   959		}
   960	
   961		input_set_drvdata(input, tsdata);
   962		i2c_set_clientdata(client, tsdata);
   963	
   964		irq_flags = irq_get_trigger_type(client->irq);
   965		if (irq_flags == IRQF_TRIGGER_NONE)
   966			irq_flags = IRQF_TRIGGER_FALLING;
   967		irq_flags |= IRQF_ONESHOT;
   968	
   969		error = devm_request_threaded_irq(&client->dev, client->irq,
   970						NULL, edt_ft5x06_ts_isr, irq_flags,
   971						client->name, tsdata);
   972		if (error) {
   973			dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
   974			return error;
   975		}
   976	
   977		error = sysfs_create_group(&client->dev.kobj, &edt_ft5x06_attr_group);
   978		if (error)
   979			return error;
   980	
   981		error = input_register_device(input);
   982		if (error)
   983			goto err_remove_attrs;
   984	
   985		edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
   986		device_init_wakeup(&client->dev, 1);
   987	
   988		dev_dbg(&client->dev,
   989			"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
   990			client->irq, desc_to_gpio(tsdata->wake_gpio),
                                                  ^^^^^^^^^^^^^^^^^
Patch introduces a new unchecked dereference, (inside the function call).

regards,
dan carpenter
