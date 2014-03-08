From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2 4/8] Input: pixcir_i2c_ts: Use Type-B Multi-Touch protocol
Date: Sat, 08 Mar 2014 16:11:45 +0100
Message-ID: <531B3331.9050008@euromail.se>
References: <1393428486-15001-1-git-send-email-rogerq@ti.com> <1393428486-15001-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:34177 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaCHPHZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Mar 2014 10:07:25 -0500
In-Reply-To: <1393428486-15001-5-git-send-email-rogerq@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, dmitry.torokhov@gmail.com
Cc: jcbian@pixcir.com.cn, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hi Roger,

the MT implementation seems mostly fine, just one curiosity:

>  static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
>  {
>  	struct pixcir_i2c_ts_data *tsdata = dev_id;
>  	const struct pixcir_ts_platform_data *pdata = tsdata->chip;
> +	struct pixcir_report_data report;
>  
>  	while (!tsdata->exiting) {
> -		pixcir_ts_poscheck(tsdata);
> -
> -		if (gpio_get_value(pdata->gpio_attb))
> +		/* parse packet */
> +		pixcir_ts_parse(tsdata, &report);
> +
> +		/* report it */
> +		pixcir_ts_report(tsdata, &report);
> +
> +		if (gpio_get_value(pdata->gpio_attb)) {
> +			if (report.num_touches) {
> +				/*
> +				 * Last report with no finger up?
> +				 * Do it now then.
> +				 */
> +				input_mt_sync_frame(tsdata->input);
> +				input_sync(tsdata->input);

Why is this special handling needed?

Thanks,
Henrik

