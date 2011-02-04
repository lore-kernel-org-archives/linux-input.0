From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Remove fixed config data from driver file; add
 config to platform data
Date: Fri, 4 Feb 2011 00:57:54 -0800
Message-ID: <20110204085754.GE13046@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB52D.4020400@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55424 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1BDI6C (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 03:58:02 -0500
Received: by pxi15 with SMTP id 15so368187pxi.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 00:58:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4AB52D.4020400@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

On Thu, Feb 03, 2011 at 04:01:17PM +0200, Iiro Valkonen wrote:
> +	if (pdata->config) {
> +		init_vals = (u8 *)pdata->config;
> +	} else {
> +		dev_err(dev, "No cfg data defined, skipping reg init\n");
> +		return 0;
>  	}
>  
>  	for (i = 0; i < data->info.object_num; i++) {
> diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt602240_ts.h
> index 0b4c72f..130f8bc 100644
> --- a/include/linux/i2c/qt602240_ts.h
> +++ b/include/linux/i2c/qt602240_ts.h
> @@ -33,6 +33,7 @@ struct mxt_platform_data {
>  	unsigned int threshold;
>  	unsigned int voltage;
>  	unsigned char orient;
> +	unsigned char *config;

This should be "const u8 *config". Also it would be a good idea to also
pass length and validate it when dereferencing.

Thanks.

-- 
Dmitry
