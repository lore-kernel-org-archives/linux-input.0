From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] input: add driver for pixcir i2c touchscreens
Date: Sat, 23 Jul 2011 20:18:38 +0200
Message-ID: <20110723181838.GA5270@polaris.bitmath.org>
References: <4DDB2516.6050302@pixcir.com.cn>
 <20110704165000.GD8144@core.coreip.homeip.net>
 <20110705193020.GB29549@polaris.bitmath.org>
 <20110709201209.GA27874@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:60553 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1GWSPI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jul 2011 14:15:08 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 682B3EB091
	for <linux-input@vger.kernel.org>; Sat, 23 Jul 2011 20:15:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110709201209.GA27874@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jcbian <jcbian@pixcir.com.cn>, linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

On Sat, Jul 09, 2011 at 01:12:10PM -0700, Dmitry Torokhov wrote:
> On Tue, Jul 05, 2011 at 09:30:20PM +0200, Henrik Rydberg wrote:
> > 
> > If the above function handles zero fingers as well, the MT finger
> > count comes out wrong in that case.
> > 
> 
> Hmm, indeed. How about the patch below instead?

Looks good, thanks.

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

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
> +	} else {
> +		input_report_key(tsdata->input, BTN_TOUCH, 0);
> +		if (old_touch)
> +			input_mt_sync(tsdata->input);
> +	}
> +
> +	input_sync(tsdata->input);
> +}

Henrik
