From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH 5/7] input: add driver for tnetv107x touchscreen
 controller
Date: Tue, 14 Sep 2010 12:08:42 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C210EEE1@dbde02.ent.ti.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
 <1284395388-32687-6-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47412 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0INGiu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 02:38:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8E6ckvI018622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 01:38:48 -0500
In-Reply-To: <1284395388-32687-6-git-send-email-cyril@ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Chemparathy, Cyril" <cyril@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.da>


Hi Cyril,
Minor comments/doubts
> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> owner@vger.kernel.org] On Behalf Of Chemparathy, Cyril
> Sent: Monday, September 13, 2010 10:00 PM
> To: linux-input@vger.kernel.org; davinci-linux-open-
> source@linux.davincidsp.com
> Cc: Chemparathy, Cyril
> Subject: [PATCH 5/7] input: add driver for tnetv107x touchscreen
> controller
> 
> This patch adds support for tnetv107x's on-chip touchscreen controller.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  drivers/input/touchscreen/Kconfig        |    6 +
>  drivers/input/touchscreen/Makefile       |    1 +
>  drivers/input/touchscreen/tnetv107x-ts.c |  481


> +
> +static inline void tsc_report_up(struct tsc_data *ts)
> +{
> +	input_report_abs(ts->input_dev, ABS_PRESSURE, 0);
> +	input_report_key(ts->input_dev, BTN_TOUCH, 0);
> +	input_sync(ts->input_dev);
> +}
> +
> +static inline void tsc_report(struct tsc_data *ts, int x, int y, int p)
> +{
> +	input_report_abs(ts->input_dev, ABS_X, x);
> +	input_report_abs(ts->input_dev, ABS_Y, y);
> +	input_report_abs(ts->input_dev, ABS_PRESSURE, p);

Did not understand why no sync here.

> +}
> +
> +static inline void tsc_report_down(struct tsc_data *ts, bool touch)
> +{
> +	if (touch)
> +		input_report_key(ts->input_dev, BTN_TOUCH, 1);

Even if you donot report you do a sync.

> +	input_sync(ts->input_dev);
> +}
> +
> +static inline void tsc_poll(unsigned long data)
> +{
> +	struct tsc_data *ts = (struct tsc_data *)data;
> +	unsigned long flags;
> +	int i, val, x, y, p;
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +
> +	if (ts->sample_count >= TSC_SKIP) {
> +		tsc_report_up(ts);
> +	} else if (ts->sample_count > 0) {
> +		/*
> +		 * A touch event lasted less than our skip count.  Salvage and
> +		 * report anyway.
> +		 */
> +		for (i = 0, val = 0; i < ts->sample_count; i++)
> +			val += ts->samples[i].x;
> +		x = val / ts->sample_count;
> +
> +		for (i = 0, val = 0; i < ts->sample_count; i++)
> +			val += ts->samples[i].y;
> +		y = val / ts->sample_count;
> +
> +		for (i = 0, val = 0; i < ts->sample_count; i++)
> +			val += ts->samples[i].p;
> +		p = val / ts->sample_count;
> +
> +		tsc_report(ts, x, y, p);
> +		tsc_report_down(ts, true);
> +	}
> +
> +	ts->sample_count = 0;
> +
> +	spin_unlock_irqrestore(&ts->lock, flags);
> +}
> +
> +static irqreturn_t tsc_irq(int irq, void *dev_id)
> +{
> +	struct tsc_data *ts = (struct tsc_data *)dev_id;
> +	struct sample *sample;
> +	int index;
> +
> +	spin_lock(&ts->lock);
> +
> +	index = ts->sample_count % TSC_SAMPLES;
> +	sample = &ts->samples[index];
> +	if (tsc_read_sample(ts, sample) >= 0) {
> +		++ts->sample_count;
> +
> +		if (ts->sample_count < TSC_SKIP)
> +			goto done;
> +
> +		index = (ts->sample_count - TSC_TAIL_SKIP - 1) % TSC_SAMPLES;
> +		sample = &ts->samples[index];
> +
> +		tsc_report(ts, sample->x, sample->y, sample->y);
> +		tsc_report_down(ts, (ts->sample_count == TSC_SKIP));
> +done:
> +		mod_timer(&ts->timer, jiffies + TSC_PENUP_POLL);
> +	}
> +
> +	spin_unlock(&ts->lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t tsc_cal_show(struct device *dev, struct device_attribute
> *attr,
> +			    char *buf)
> +{
> +	struct tsc_data *ts = dev_get_drvdata(dev);
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < 6; i++)
> +		len += snprintf(buf+len, PAGE_SIZE-len, "%d ", ts->cal[i]);
> +
> +	len += snprintf(buf+len, PAGE_SIZE-len, "%d\n", ts->cal[6]);
> +
> +	return len;
> +}
> +
> +/*
> + * The calibration data format is identical to the contents of tslib's
> + * generated output
> + */
> +static ssize_t tsc_cal_store(struct device *dev, struct device_attribute
> *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct tsc_data *ts = dev_get_drvdata(dev);
> +	int index = 0;
> +	int cal[TSC_CAL_SIZE];
> +	const char *cur = buf, *end = buf + count;
> +	char *tmp;
> +	unsigned long flags;
> +
> +	for (index = 0; index < TSC_CAL_SIZE; index++) {
> +		while (isspace(*cur) && cur < end)
> +			cur++;
> +		if (cur >= end) {
> +			dev_err(ts->dev, "premature end in calib data\n");
> +			return -EINVAL;
> +		}
> +
> +		if (isdigit(*cur) || *cur == '-') {
> +			cal[index] = simple_strtol(cur, &tmp, 0);
> +			cur = tmp;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +	memcpy(ts->cal, cal, sizeof(cal));
> +	spin_unlock_irqrestore(&ts->lock, flags);
> +
> +	return count;
> +}
> +
> +static struct device_attribute tsc_attr_cal =
> +	__ATTR(tscal, S_IWUSR | S_IRUGO, tsc_cal_show, tsc_cal_store);
> +
> +static int tsc_probe(struct platform_device *pdev)

May consider __devinit as this memory location may not be needed afterwards.

> +{
> +	struct tnetv107x_tsc_data *pdata = pdev->dev.platform_data;
> +	struct tsc_data *ts;
> +	int ret = 0, *cal;
> +	u32 rev = 0, val = 0;
> +	struct device *dev = &pdev->dev;
> +
> +	if (!pdata) {
> +		dev_err(dev, "could not find platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	ts = kzalloc(sizeof(struct tsc_data), GFP_KERNEL);
> +	if (!ts) {
> +		dev_err(dev, "cannot allocate device info\n");
> +		return -ENOMEM;
> +	}
> +
> +	ts->dev = dev;
> +	ts->data = *pdata;
> +	dev_set_drvdata(dev, ts);
> +
> +	cal = (tscal_set == TSC_CAL_SIZE) ? tscal : ts-
> >data.calibration_data;
> +	memcpy(ts->cal, cal, TSC_CAL_SIZE * sizeof(int));
> +
> +	ret = -ENOMEM;
> +	ts->input_dev = input_allocate_device();
> +	if (!ts->input_dev) {
> +		dev_err(dev, "cannot allocate input device\n");
> +		goto error0;
> +	}
> +
> +	ret = -ENODEV;
> +	ts->tsc_irq = platform_get_irq(pdev, 0);
> +	if (ts->tsc_irq < 0) {
> +		dev_err(dev, "cannot determine device interrupt\n");
> +		goto error1;
> +	}
> +
> +	ret = -ENODEV;
> +	ts->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!ts->res) {
> +		dev_err(dev, "cannot determine register area\n");
> +		goto error1;
> +	}
> +
> +	ret = -EINVAL;
> +	if (!request_mem_region(ts->res->start, resource_size(ts->res),
> +				pdev->name)) {
> +		dev_err(dev, "cannot claim register memory\n");
> +		goto error1;
> +	}
> +
> +	ret = -ENOMEM;
> +	ts->regs = ioremap(ts->res->start, resource_size(ts->res));
> +	if (!ts->regs) {
> +		dev_err(dev, "cannot map register memory\n");
> +		goto error2;
> +	}
> +
> +	ret = -EINVAL;
> +	ts->clk = clk_get(dev, NULL);
> +	if (!ts->clk) {
> +		dev_err(dev, "cannot claim device clock\n");
> +		goto error3;
> +	}
> +	clk_enable(ts->clk);
> +
> +	spin_lock_init(&ts->lock);
> +
> +	init_timer(&ts->timer);
> +	setup_timer(&ts->timer, tsc_poll, (unsigned long)ts);
> +
> +	/* Go to idle mode, before any initialization */
> +	while ((tsc_read(ts, tscm) & IDLE) == 0)
> +		barrier();
> +
> +	/* Configure the TSC Control register*/
> +	val = (PONBG | PON | PVSTC(4) | ONE_SHOT | ZMEASURE_EN);
> +	tsc_write(ts, tscm, val);
> +
> +	/* Bring TSC out of reset: Clear AFE reset bit */
> +	val &= ~(AFERST);
> +	tsc_write(ts, tscm, val);
> +	udelay(10);
> +
> +	/* Configure all pins for hardware control*/
> +	tsc_write(ts, bwcm, 0);
> +
> +	/* Finally enable the TSC */
> +	tsc_set_bits(ts, tscm, TSC_EN);
> +
> +	ret = -EINVAL;
> +	if (request_irq(ts->tsc_irq, tsc_irq, 0, "tnetv107x-ts", ts)) {
> +		dev_err(dev, "Could not allocate ts irq\n");
> +		goto error4;
> +	}
> +
> +	ret = device_create_file(ts->dev, &tsc_attr_cal);
> +	if (ret < 0) {
> +		dev_err(dev, "Could not create sysfs entry!\n");
> +		goto error5;
> +	}
> +
> +	rev = tsc_read(ts, rev);
> +	ts->input_dev->name       = "tnetv107x-ts";
> +	ts->input_dev->phys       = "tnetv107x-ts/input0";
> +	ts->input_dev->id.bustype = BUS_HOST;
> +	ts->input_dev->id.vendor  = 0x0001;
> +	ts->input_dev->id.product = ((rev >>  8) & 0x07);
> +	ts->input_dev->id.version = ((rev >> 16) & 0xfff);
> +	ts->input_dev->dev.parent = &pdev->dev;
> +
> +	/* Declare capabilities */
> +	set_bit(EV_KEY,       ts->input_dev->evbit);
> +	set_bit(BTN_TOUCH,    ts->input_dev->keybit);
> +	set_bit(EV_ABS,       ts->input_dev->evbit);
> +	set_bit(ABS_X,        ts->input_dev->absbit);
> +	set_bit(ABS_Y,        ts->input_dev->absbit);
> +	set_bit(ABS_PRESSURE, ts->input_dev->absbit);
> +
> +	input_set_abs_params(ts->input_dev, ABS_X, 0, ts->data.xres, 5, 0);
> +	input_set_abs_params(ts->input_dev, ABS_Y, 0, ts->data.yres, 5, 0);
> +	input_set_abs_params(ts->input_dev, ABS_PRESSURE, 0, 4095, 128, 0);
> +
> +	ret = input_register_device(ts->input_dev);
> +	if (ret < 0)
> +		goto error6;
> +
> +	return 0;
> +
> +error6:
> +	device_remove_file(ts->dev, &tsc_attr_cal);
> +error5:
> +	free_irq(ts->tsc_irq, ts);
> +error4:
> +	clk_disable(ts->clk);
> +	clk_put(ts->clk);
> +error3:
> +	iounmap(ts->regs);
> +error2:
> +	release_mem_region(ts->res->start, resource_size(ts->res));
> +error1:
> +	input_free_device(ts->input_dev);
> +error0:
> +	kfree(ts);
> +	dev_set_drvdata(dev, NULL);
> +	return ret;
> +}
> +
> +static int tsc_remove(struct platform_device *pdev)
Same as probe.
> +{
> +	struct tsc_data *ts = dev_get_drvdata(&pdev->dev);
> +
> +	if (!ts)
> +		return 0;
> +
> +	tsc_clr_bits(ts, tscm, TSC_EN);
> +	del_timer_sync(&ts->timer);
> +	device_remove_file(ts->dev, &tsc_attr_cal);
> +	free_irq(ts->tsc_irq, ts);
> +	clk_disable(ts->clk);
> +	clk_put(ts->clk);
> +	iounmap(ts->regs);
> +	release_mem_region(ts->res->start, resource_size(ts->res));
> +	input_free_device(ts->input_dev);
> +	kfree(ts);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	return 0;
> +}
> +
> +static int tsc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	/* Nothing yet */
> +	return 0;
> +}
> +
> +static int tsc_resume(struct platform_device *pdev)
> +{
> +	/* Nothing yet */
> +	return 0;
> +}
> +
> +static struct platform_driver tsc_driver = {
> +	.probe		= tsc_probe,
> +	.remove		= tsc_remove,
> +	.suspend	= tsc_suspend,
> +	.resume		= tsc_resume,
> +	.driver.name	= "tnetv107x-ts",
> +};
> +
> +static int __init tsc_init(void)
> +{
> +	return platform_driver_register(&tsc_driver);
> +}
> +
> +static void __exit tsc_exit(void)
> +{
> +	platform_driver_unregister(&tsc_driver);
> +}
> +
> +module_init(tsc_init);
> +module_exit(tsc_exit);
> +
> +MODULE_DESCRIPTION("TNETV107X Touchscreen Driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
