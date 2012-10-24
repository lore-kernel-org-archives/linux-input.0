From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] touchscreen/ads7846.c: move filter variables to
 global include
Date: Wed, 24 Oct 2012 11:17:36 -0700
Message-ID: <20121024181735.GB18122@core.coreip.homeip.net>
References: <1351078736-16785-1-git-send-email-matthias.bgg@gmail.com>
 <1351078736-16785-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62066 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab2JXSRq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 14:17:46 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so541495pad.19
        for <linux-input@vger.kernel.org>; Wed, 24 Oct 2012 11:17:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351078736-16785-2-git-send-email-matthias.bgg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthias Brugger <matthias.bgg@googlemail.com>
Cc: linux-input@vger.kernel.org, grinberg@compulab.co.il, Matthias Brugger <matthias.bgg@gmail.com>

On Wed, Oct 24, 2012 at 01:38:56PM +0200, Matthias Brugger wrote:
> To implement a custom filter in the board platform code,
> the struct ads7846_filterd might be needed. This patch moves the struct
> to the global include file of the driver.

Why would a custom filer care about debounce filter's private data?
Just have it define its very own structure, no need to export.

Thanks.

> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/input/touchscreen/ads7846.c |    9 ---------
>  include/linux/spi/ads7846.h         |    9 +++++++++
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 9e61a4b..cc3b048 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -90,15 +90,6 @@ struct ads7846_packet {
>  	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
>  };
>  
> -struct ads7846_filterd {
> -	int			read_cnt;
> -	int			read_rep;
> -	int			last_read;
> -	u16			debounce_max;
> -	u16			debounce_tol;
> -	u16			debounce_rep;
> -};
> -
>  struct ads7846 {
>  	struct input_dev	*input;
>  	char			phys[32];
> diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
> index c64de9d..cc7b34d 100644
> --- a/include/linux/spi/ads7846.h
> +++ b/include/linux/spi/ads7846.h
> @@ -58,3 +58,12 @@ struct ads7846_platform_data {
>  	unsigned long irq_flags;
>  };
>  
> +struct ads7846_filterd {
> +	int			read_cnt;
> +	int			read_rep;
> +	int			last_read;
> +	u16			debounce_max;
> +	u16			debounce_tol;
> +	u16			debounce_rep;
> +};
> +
> -- 
> 1.7.9.5
> 

-- 
Dmitry
