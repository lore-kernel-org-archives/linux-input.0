From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v3] Input: add ST1232 touchscreen controller driver.
Date: Wed, 15 Dec 2010 10:16:57 +0100
Message-ID: <4D088789.9060102@euromail.se>
References: <1292400728-15521-1-git-send-email-chinyeow.sim.xt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:60090 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab0LOJRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Dec 2010 04:17:48 -0500
In-Reply-To: <1292400728-15521-1-git-send-email-chinyeow.sim.xt@renesas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chinyeow.sim.xt@renesas.com
Cc: tsoni@codeaurora.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

> +

> +static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
> +{
> +	int i, ret, flg;


A "int count = 0;" makes more sense than flg.

> +	struct st1232_ts_data *ts = dev_id;
> +	struct st1232_ts_finger *finger = ts->finger;
> +
> +	ret = st1232_ts_read_data(ts);
> +	if (ret < 0)
> +		goto end;
> +
> +	/* multi touch protocol */
> +	for (i = 0, flg = 0; i < MAX_FINGERS; i++) {


flg initialization is hidden here, see above comment.

> +		if (!finger[i].is_valid)
> +			continue;
> +		else
> +			flg = 1;


dropping this...

> +
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +					finger[i].t);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, finger[i].x);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, finger[i].y);
> +		input_mt_sync(ts->input_dev);


and simply "count++;" here.

> +	}
> +
> +	/* SYN_MT_REPORT only if no contact */
> +	if (!flg)


(!count)

> +		input_mt_sync(ts->input_dev);
> +
> +	/* SYN_REPORT */
> +	input_sync(ts->input_dev);
> +
> +end:
> +	return IRQ_HANDLED;
> +}
> +
> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +				0, MAX_AREA, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +				MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +				MIN_Y, MAX_Y, 0, 0);
> +
> +	ret = input_register_device(ts->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to register %s input device\n",
> +			ts->input_dev->name);
> +		goto err_free_input_device;
> +	}
> +
> +	ret = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
> +					IRQF_ONESHOT, client->name, ts);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_input_device;
> +	}
> +
> +	device_init_wakeup(&client->dev, 1);
> +
> +	return 0;
> +
> +err_free_input_device:
> +	input_free_device(ts->input_dev);
> +err_free_mem:
> +	kfree(ts);
> +err:
> +	return ret;
> +}


Thank you,
Henrik
