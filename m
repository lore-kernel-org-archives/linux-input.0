From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] input: add driver for pixcir i2c touchscreens
Date: Sat, 23 Jul 2011 20:24:21 +0200
Message-ID: <20110723182421.GB5270@polaris.bitmath.org>
References: <20110709201209.GA27874@core.coreip.homeip.net>
 <4DDB2516.6050302@pixcir.com.cn>
 <20110704165000.GD8144@core.coreip.homeip.net>
 <20110705193020.GB29549@polaris.bitmath.org>
 <512aa3.8e15.1312673550c.Coremail.jcbian@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:52250 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1GWSUu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jul 2011 14:20:50 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 2032AEAFF1
	for <linux-input@vger.kernel.org>; Sat, 23 Jul 2011 20:20:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <512aa3.8e15.1312673550c.Coremail.jcbian@pixcir.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jcbian <jcbian@pixcir.com.cn>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

On Thu, Jul 14, 2011 at 10:21:57AM +0800, jcbian wrote:
> Hi Dmitry & Henrik,
> 
>         Thanks for your suggestions and modification .I have test it and it works well.
>  Indeed,I think the old_touch is not needed,the follow
> 
> +		if (old_touch)
> +			input_mt_sync(tsdata->input);
> 
> could be removed. So,How about below?

Also fine, although the removed brackets is a slight style
violation. No need to resend though.

> +static void pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
> +{
> +	struct pixcir_i2c_ts_data *tsdata = data;
> +	u8 rdbuf[10], wrbuf[1] = { 0 };
> +	u8 touch, old_touch;
> +	int ret;
> +
> +	ret = i2c_master_send(tsdata->client, wrbuf, sizeof(wrbuf));
> +	if (ret != sizeof(wrbuf)) {
> +		dev_err(&tsdata->client->dev,
> +			"%s: i2c_master_send failed(), ret=%d\n",
> +			__func__, ret);
> +		return;
> +	}
> +
> +	ret = i2c_master_recv(tsdata->client, rdbuf, sizeof(rdbuf));
> +	if (ret != sizeof(rdbuf)) {
> +		dev_err(&tsdata->client->dev,
> +			"%s: i2c_master_recv failed(), ret=%d\n",
> +			__func__, ret);
> +		return;
> +	}
> +
> +	touch = rdbuf[0];
> +	old_touch = rdbuf[1];
> +	if (touch) {
> +		u16 posx1 = (rdbuf[3] << 8) | rdbuf[2];
> +		u16 posy1 = (rdbuf[5] << 8) | rdbuf[4];
> +		u16 posx2 = (rdbuf[7] << 8) | rdbuf[6];
> +		u16 posy2 = (rdbuf[9] << 8) | rdbuf[8];
> +
> +		input_report_key(tsdata->input, BTN_TOUCH, 1);
> +		input_report_abs(tsdata->input, ABS_X, posx1);
> +		input_report_abs(tsdata->input, ABS_Y, posy1);
> +
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
> +		input_mt_sync(tsdata->input);
> +
> +		if (touch == 2) {
> +			input_report_abs(tsdata->input,
> +					 ABS_MT_POSITION_X, posx2);
> +			input_report_abs(tsdata->input,
> +					 ABS_MT_POSITION_Y, posy2);
> +			input_mt_sync(tsdata->input);
> +		}
> +	} else
> +		input_report_key(tsdata->input, BTN_TOUCH, 0);
> +
> +	input_sync(tsdata->input);
> +}

Thanks,
Henrik
