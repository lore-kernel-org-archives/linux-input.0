From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input/Touchscreen Driver: add support AD7877
	touchscreen driver (resend to linux-input mailist)
Date: Mon, 4 Feb 2008 12:12:43 -0500
Message-ID: <20080204115801.ZZRA012@mailhub.coreip.homeip.net>
References: <1202118758.6286.5.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:42577 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbYBDRMt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Feb 2008 12:12:49 -0500
Received: by an-out-0708.google.com with SMTP id d31so538115and.103
        for <linux-input@vger.kernel.org>; Mon, 04 Feb 2008 09:12:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1202118758.6286.5.camel@roc-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <bryan.wu@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

Hi Bryan,

On Mon, Feb 04, 2008 at 05:52:38PM +0800, Bryan Wu wrote:
 +
> +	spi_message_add_tail(&req->xfer[0], &req->msg);
> +	spi_message_add_tail(&req->xfer[1], &req->msg);
> +
> +	status = spi_sync(spi, &req->msg);
> +
> +	if (req->msg.status)
> +		status = req->msg.status;
> +

I think the "new way" for spi is to just check return value of
spi_sync and not bother with req->msg.status, but even using
old style spi_sycn I'd expect something like:

	status = spi_sync(spi, &req->msg);
	if (status == 0)
		status = req->msg.status;

> +
> +static ssize_t ad7877_gpio3_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct ad7877 *ts = dev_get_drvdata(dev);
> +	char *endp;
> +	int i;
> +
> +	i = simple_strtoul(buf, &endp, 10);
> +
> +	if (i)
> +		ts->gpio3=1;
> +	else
> +		ts->gpio3=0;
> +

I am tempted to change the above to ts->gpio3 = !!i;

> +
> +	if (likely(x && z1 && !device_suspended(&ts->spi->dev))) {
> +		/* compute touch pressure resistance using equation #2 */
> +		Rt = z2;
> +		Rt -= z1;
> +		Rt *= x;
> +		Rt *= ts->x_plate_ohms;
> +		Rt /= z1;
> +		Rt = (Rt + 2047) >> 12;
> +	} else
> +		Rt = 0;
> +
> +	if (Rt) {
> +		input_report_abs(input_dev, ABS_X, x);
> +		input_report_abs(input_dev, ABS_Y, y);
> +		input_report_abs(input_dev, ABS_PRESSURE, Rt);
> +		input_sync(input_dev);
> +	}
> +
> +#ifdef	VERBOSE
> +	if (Rt)
> +		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
> +			x, y, Rt, Rt ? "" : " UP");

We check the same condition 3 times in a row. The compiler might
combine them but why not help it?

> +
> +static int ad7877_suspend(struct spi_device *spi, pm_message_t message)
> +{
> +	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
> +
> +	spi->dev.power.power_state = message;

I think they are trying to get rid of power_state...

> +	ad7877_disable(ts);
> +
> +	return 0;
> +
> +}
> +
> +static int ad7877_resume(struct spi_device *spi)
> +{
> +	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
> +
> +	spi->dev.power.power_state = PMSG_ON;

Same here.

> +
> +	err = input_register_device(input_dev);
> +	if (err)
> +		goto err_idev;
> +
> +	ts->intr_flag = 0;
> +
> +	return 0;
> +
> +err_idev:
> +	input_dev = NULL; /* so we don't try to free it later */

But we _do_ need to free it if input_register_device() fails.

Thanks.

-- 
Dmitry
