From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] input: add driver for pixcir i2c touchscreens
Date: Tue, 5 Jul 2011 21:30:20 +0200
Message-ID: <20110705193020.GB29549@polaris.bitmath.org>
References: <4DDB2516.6050302@pixcir.com.cn>
 <20110704165000.GD8144@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:38587 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1GET21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 15:28:27 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 6F981EAB37
	for <linux-input@vger.kernel.org>; Tue,  5 Jul 2011 21:28:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110704165000.GD8144@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jcbian <jcbian@pixcir.com.cn>, linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

Hi Dmitry,

> +static void pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
> +{
> +	struct pixcir_i2c_ts_data *tsdata = data;
> +
> +	u8 touching;
> +	u16 posx1, posy1, posx2, posy2;
> +	u8 rdbuf[10], wrbuf[1] = { 0 };
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
> +	touching = rdbuf[0];
> +	posx1 = (rdbuf[3] << 8) | rdbuf[2];
> +	posy1 = (rdbuf[5] << 8) | rdbuf[4];
> +	posx2 = (rdbuf[7] << 8) | rdbuf[6];
> +	posy2 = (rdbuf[9] << 8) | rdbuf[8];
> +
> +	input_report_key(tsdata->input, BTN_TOUCH, touching);
> +	input_report_abs(tsdata->input, ABS_X, posx1);
> +	input_report_abs(tsdata->input, ABS_Y, posy1);
> +
> +	input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
> +	input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
> +	input_mt_sync(tsdata->input);
> +
> +	if (touching == 2) {
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);
> +		input_mt_sync(tsdata->input);
> +	}
> +
> +	input_sync(tsdata->input);
> +}

If the above function handles zero fingers as well, the MT finger
count comes out wrong in that case.

Cheers,
Henrik
