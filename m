From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Remove superfluous assignment in
 edt_ft5x06_register_write()
Date: Wed, 13 Aug 2014 15:29:22 -0700
Message-ID: <20140813222921.GB11620@core.coreip.homeip.net>
References: <1407960005.4388.2.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36192 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbaHMW30 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 18:29:26 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so434161pdi.34
        for <linux-input@vger.kernel.org>; Wed, 13 Aug 2014 15:29:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407960005.4388.2.camel@ubuntu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maks Naumov <maksqwe1@ukr.net>
Cc: linux-input@vger.kernel.org

On Wed, Aug 13, 2014 at 01:00:05PM -0700, Maks Naumov wrote:
> Signed-off-by: Maks Naumov <maksqwe1@ukr.net>

Applied, thank you.

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 5a6d50c..8857d5b 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -262,7 +262,6 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
>  	case M06:
>  		wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
>  		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
> -		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
>  		wrbuf[2] = value;
>  		wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
>  		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
> -- 
> 1.9.1
> 
> 
> 

-- 
Dmitry
