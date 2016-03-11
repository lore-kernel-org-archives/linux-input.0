From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: egalax_ts - remove unused definitions
Date: Fri, 11 Mar 2016 10:08:52 -0800
Message-ID: <20160311180852.GC13175@dtor-ws>
References: <1457129278-9165-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33510 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcCKSIz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 13:08:55 -0500
Received: by mail-pa0-f53.google.com with SMTP id fl4so104660031pad.0
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2016 10:08:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457129278-9165-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

Hi Fabio,

On Fri, Mar 04, 2016 at 07:07:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> REPORT_MODE_MOUSE and REPORT_MODE_VENDOR are never used in the driver,
> so let's just remove them.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/input/touchscreen/egalax_ts.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> index 1afc08b..a260476 100644
> --- a/drivers/input/touchscreen/egalax_ts.c
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -29,18 +29,6 @@
>  #include <linux/input/mt.h>
>  #include <linux/of_gpio.h>
>  
> -/*
> - * Mouse Mode: some panel may configure the controller to mouse mode,
> - * which can only report one point at a given time.
> - * This driver will ignore events in this mode.
> - */
> -#define REPORT_MODE_MOUSE		0x1
> -/*
> - * Vendor Mode: this mode is used to transfer some vendor specific
> - * messages.
> - * This driver will ignore events in this mode.
> - */
> -#define REPORT_MODE_VENDOR		0x3

Keeping this does not add to runtime size and is not excessive, I do not
see harm in not keeping it.

>  /* Multiple Touch Mode */
>  #define REPORT_MODE_MTTOUCH		0x4
>  
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
