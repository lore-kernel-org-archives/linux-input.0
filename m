From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c: add ELAN0605 to the ACPI table
Date: Sun, 12 Feb 2017 14:42:30 -0800
Message-ID: <20170212224230.GB15928@dtor-ws>
References: <PS1PR0401MB1961607122C29ADFF8F54A539C460@PS1PR0401MB1961.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36112 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdBLWmd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 17:42:33 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so7961221pgf.3
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2017 14:42:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <PS1PR0401MB1961607122C29ADFF8F54A539C460@PS1PR0401MB1961.apcprd04.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: IHARA Hiroka <ihara_h@live.jp>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Hiroka,

On Sun, Feb 12, 2017 at 07:55:23AM +0000, IHARA Hiroka wrote:
> ELAN0605 has been confirmed to be a variant of ELAN0600,
> which is blacklisted in the hid-core to be managed by elan_i2c.

Would you mind telling me what device(s) use ELAN0605?

Thanks!

> 
> Signed-off-by: Hiroka IHARA <ihara_h@live.jp>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fa598f7..1e1d0ad 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1231,6 +1231,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0000", 0 },
>  	{ "ELAN0100", 0 },
>  	{ "ELAN0600", 0 },
> +	{ "ELAN0605", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.9.3
> 

-- 
Dmitry
