From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Input/Touchscreen Driver: add support AD7877touchscreen driver (resend to linux-input mailist)
Date: Tue, 5 Feb 2008 10:27:53 -0000
Message-ID: <600D5CB4DFD93545BF61FF01473D11AC120187C2@limkexm2.ad.analog.com>
References: <20080204115801.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:29755 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbYBEK14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Feb 2008 05:27:56 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20080204115801.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <bryan.wu@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

Dmitry,

Thanks for you feedback.
Bryan is going to send out an updated patch.

Best regards,
Michael

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>Sent: Montag, 4. Februar 2008 18:13
>To: Bryan Wu
>Cc: Michael Hennerich; linux-input@vger.kernel.org
>Subject: Re: [PATCH] Input/Touchscreen Driver: add support
>AD7877touchscreen driver (resend to linux-input mailist)
>
>Hi Bryan,
>
>On Mon, Feb 04, 2008 at 05:52:38PM +0800, Bryan Wu wrote:
> +
>> +	spi_message_add_tail(&req->xfer[0], &req->msg);
>> +	spi_message_add_tail(&req->xfer[1], &req->msg);
>> +
>> +	status = spi_sync(spi, &req->msg);
>> +
>> +	if (req->msg.status)
>> +		status = req->msg.status;
>> +
>
>I think the "new way" for spi is to just check return value of
>spi_sync and not bother with req->msg.status, but even using
>old style spi_sycn I'd expect something like:
>
>	status = spi_sync(spi, &req->msg);
>	if (status == 0)
>		status = req->msg.status;
>
>> +
>> +static ssize_t ad7877_gpio3_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t count)
>> +{
>> +	struct ad7877 *ts = dev_get_drvdata(dev);
>> +	char *endp;
>> +	int i;
>> +
>> +	i = simple_strtoul(buf, &endp, 10);
>> +
>> +	if (i)
>> +		ts->gpio3=1;
>> +	else
>> +		ts->gpio3=0;
>> +
>
>I am tempted to change the above to ts->gpio3 = !!i;
>
>> +
>> +	if (likely(x && z1 && !device_suspended(&ts->spi->dev))) {
>> +		/* compute touch pressure resistance using equation #2
*/
>> +		Rt = z2;
>> +		Rt -= z1;
>> +		Rt *= x;
>> +		Rt *= ts->x_plate_ohms;
>> +		Rt /= z1;
>> +		Rt = (Rt + 2047) >> 12;
>> +	} else
>> +		Rt = 0;
>> +
>> +	if (Rt) {
>> +		input_report_abs(input_dev, ABS_X, x);
>> +		input_report_abs(input_dev, ABS_Y, y);
>> +		input_report_abs(input_dev, ABS_PRESSURE, Rt);
>> +		input_sync(input_dev);
>> +	}
>> +
>> +#ifdef	VERBOSE
>> +	if (Rt)
>> +		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
>> +			x, y, Rt, Rt ? "" : " UP");
>
>We check the same condition 3 times in a row. The compiler might
>combine them but why not help it?
>
>> +
>> +static int ad7877_suspend(struct spi_device *spi, pm_message_t
message)
>> +{
>> +	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
>> +
>> +	spi->dev.power.power_state = message;
>
>I think they are trying to get rid of power_state...
>
>> +	ad7877_disable(ts);
>> +
>> +	return 0;
>> +
>> +}
>> +
>> +static int ad7877_resume(struct spi_device *spi)
>> +{
>> +	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
>> +
>> +	spi->dev.power.power_state = PMSG_ON;
>
>Same here.
>
>> +
>> +	err = input_register_device(input_dev);
>> +	if (err)
>> +		goto err_idev;
>> +
>> +	ts->intr_flag = 0;
>> +
>> +	return 0;
>> +
>> +err_idev:
>> +	input_dev = NULL; /* so we don't try to free it later */
>
>But we _do_ need to free it if input_register_device() fails.
>
>Thanks.
>
>--
>Dmitry
