From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - fix F01 DOM formatting
Date: Thu, 9 Jan 2014 22:27:53 -0800
Message-ID: <20140110062753.GA24123@core.coreip.homeip.net>
References: <1389298893-4043-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40683 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaAJG14 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jan 2014 01:27:56 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so4203676pde.27
        for <linux-input@vger.kernel.org>; Thu, 09 Jan 2014 22:27:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389298893-4043-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, Jan 09, 2014 at 12:21:33PM -0800, Christopher Heiny wrote:
> Use a sensible format string for the date of manufacture formatting.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/rmi4/rmi_f01.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 1cb11ea..9e6a578 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -50,7 +50,7 @@ struct f01_basic_properties {
>  	bool has_lts;
>  	bool has_adjustable_doze;
>  	bool has_adjustable_doze_holdoff;
> -	char dom[9]; /* YYYYMMDD + '\0' */
> +	char dom[11]; /* YYYY/MM/DD + '\0' */
>  	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
>  	u16 productinfo;
>  };
> @@ -190,8 +190,7 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
>  	props->has_adjustable_doze_holdoff =
>  			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF;
>  
> -	snprintf(props->dom, sizeof(props->dom),
> -		 "20%02x%02x%02x",
> +	snprintf(props->dom, sizeof(props->dom), "20%02d/%02d/%02d",
>  		 basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
>  		 basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
>  		 basic_query[7] & RMI_F01_QRY7_DAY_MASK);

-- 
Dmitry
