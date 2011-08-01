From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Sun, 31 Jul 2011 23:34:09 -0700
Message-ID: <20110801063409.GB32118@core.coreip.homeip.net>
References: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63145 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab1HAGeP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Aug 2011 02:34:15 -0400
Received: by yxi11 with SMTP id 11so2968898yxi.19
        for <linux-input@vger.kernel.org>; Sun, 31 Jul 2011 23:34:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, kzjeef@gmail.com

Hi Zhang,

On Tue, Jul 26, 2011 at 05:25:54PM +0800, Zhang Jiejing wrote:
> +
> +	if (buf[0] == REPORT_MODE_SINGLE) {
> +		input_report_abs(input_dev, ABS_X, x);
> +		input_report_abs(input_dev, ABS_Y, y);
> +		input_report_key(input_dev, BTN_TOUCH, !!state);
> +		input_sync(input_dev);
> +		return IRQ_HANDLED;

In what cases does the device signal REPORT_MODE_SINGLE? When only one
finger touches the surface? Because we should still be using MT protocol
even if at the moment only one finger touches the surface. And it is
nice to provide non-MT compatibility data for legacy applications
regardless of the number of contacts currently active (see
drivers/input/input-mt.c for helpers).

> +	}
> +
> +	/* deal with multiple touch  */
> +	valid = state & EVENT_VAILD_MASK;
> +	id = (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
> +	down = state & EVENT_DOWN_UP;
> +
> +	if (!valid || id > MAX_SUPPORT_POINTS) {
> +		dev_dbg(&client->dev, "point invalid\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (down) {
> +		/* since egalax only report one of multi touch event,
> +		 * so we need record pervious event with different id
> +		 * and report them.*/
> +		events[id].valid = valid;
> +		events[id].status = down;
> +		events[id].x = x;
> +		events[id].y = y;
> +
> +		for (i = 0; i < MAX_SUPPORT_POINTS; i++) {
> +			if (!events[i].valid)
> +				continue;
> +			dev_dbg(&client->dev, "report id:%d valid:%d x:%d y:%d",
> +				i, valid, x, y);
> +
> +			input_report_abs(input_dev,
> +					 ABS_MT_TRACKING_ID, i);
> +			input_report_abs(input_dev,
> +					 ABS_MT_TOUCH_MAJOR, 1);

This does not provide any information, please drop.

> +			input_report_abs(input_dev,
> +					 ABS_MT_POSITION_X, events[i].x);
> +			input_report_abs(input_dev,
> +					 ABS_MT_POSITION_Y, events[i].y);
> +			input_mt_sync(input_dev);

It would be much better to use MT-B protocol since the device seems to
provide proper tracking IDs for the contacts.

> +
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(ABS_X, input_dev->absbit);
> +	__set_bit(ABS_Y, input_dev->absbit);
> +	input_set_abs_params(input_dev, ABS_X, 0, 32767, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, 32767, 0, 0);

You do not set any ABS_MT_* events here so your MT events will be
suppressed by input core.

> +
> +static __devexit int egalax_ts_remove(struct i2c_client *client)
> +{
> +	struct egalax_ts *data = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, data);
> +	input_unregister_device(data->input_dev);
> +	input_free_device(data->input_dev);

No calls to input_free_device() after calling input_unregister_device().

Thanks.

-- 
Dmitry
