From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] input: synaptics-rmi4: make array
 rmi_f54_report_type_names static
Date: Mon, 2 Oct 2017 15:18:52 -0700
Message-ID: <20171002221852.GA12530@roeck-us.net>
References: <20171002220525.11339-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37709 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBWSz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Oct 2017 18:18:55 -0400
Content-Disposition: inline
In-Reply-To: <20171002220525.11339-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 02, 2017 at 11:05:25PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The array rmi_f54_report_type_names is local to the source and does
> not need to be in global scope, so make it static. Also make the array
> const char * const
> 
> Cleans up sparse warning:
> symbol 'rmi_f54_report_type_names' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/input/rmi4/rmi_f54.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index f5206e2c767e..70f6310f1d15 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -73,7 +73,7 @@ enum rmi_f54_report_type {
>  	F54_MAX_REPORT_TYPE,
>  };
>  
> -const char *rmi_f54_report_type_names[] = {
> +static const char * const rmi_f54_report_type_names[] = {
>  	[F54_REPORT_NONE]		= "Unknown",
>  	[F54_8BIT_IMAGE]		= "Normalized 8-Bit Image",
>  	[F54_16BIT_IMAGE]		= "Normalized 16-Bit Image",
> -- 
> 2.14.1
> 
