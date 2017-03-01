From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v14 3/5] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Date: Wed, 1 Mar 2017 12:52:38 -0800
Message-ID: <20170301205238.GH30349@dtor-ws>
References: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
 <80f16ceab50848e0fbdafda4057186c561bf519b.1488380468.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35226 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdCAUyr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 15:54:47 -0500
Content-Disposition: inline
In-Reply-To: <80f16ceab50848e0fbdafda4057186c561bf519b.1488380468.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com

Hi Ksenija,

On Wed, Mar 01, 2017 at 07:02:11PM +0100, Ksenija Stanojevic wrote:
> +static int mxs_lradc_ts_register(struct mxs_lradc_ts *ts)
> +{
> +	struct input_dev *input = ts->ts_input;
> +	struct device *dev = ts->dev;
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->name = "mxs-lradc-ts";
> +	input->id.bustype = BUS_HOST;
> +	input->open = mxs_lradc_ts_open;
> +	input->close = mxs_lradc_ts_close;
> +
> +	__set_bit(EV_ABS, input->evbit);
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(BTN_TOUCH, input->keybit);

If you end up re-spinnig the series, please drop __set_bit()s above and
replace with

	input_set_capability(input, EV_KEY, BTN_TOUCH);

because input_set_abs_params() already sets EV_ABS for you.

If you will not re-spin, you can leave it as is.

In any case:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


> +	__set_bit(INPUT_PROP_DIRECT, input->propbit);
> +	input_set_abs_params(input, ABS_X, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
> +	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_SINGLE_SAMPLE_MASK,
> +			     0, 0);
> +
> +	ts->ts_input = input;
> +	input_set_drvdata(input, ts);
> +
> +	return input_register_device(input);
> +}

Thanks.

-- 
Dmitry
