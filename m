From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input: elantech - force needed quirks on Fujitsu H760
Date: Mon, 3 Oct 2016 17:28:00 -0700
Message-ID: <20161004002800.GA27823@dtor-ws>
References: <alpine.DEB.2.11.1610032112360.18699@melchior.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33813 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbcJDA2D (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 20:28:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1610032112360.18699@melchior.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matti Kurkela <Matti.Kurkela@iki.fi>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 03, 2016 at 09:18:28PM +0300, Matti Kurkela wrote:
> 
> Just like Fujitsu CELSIUS H730, the H760 also has an Elantech
> touchpad with the same quirks. Without this patch, the touchpad is
> useless out-of-the-box as the mouse pointer won't move.
> 
> This patch makes the driver aware of both the crc_enabled=1
> requirement and the middle button, making the touchpad fully
> functional out-of-the-box.
> 
> Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>
> ---
> This patch will also apply without changes to older kernel versions:
> I made this originally on 4.4.19 and am currently using it on
> my work laptop with 4.4.22.
> 
> Backporting to any version that includes commit
> f386474e12a560e005ec7899e78f51f6bdc3cf41 should be trivial.

Applied and marked for stable, thank you.

> 
> --- linux-4.8/drivers/input/mouse/elantech.c.orig	2016-10-03 02:24:33.000000000 +0300
> +++ linux-4.8/drivers/input/mouse/elantech.c	2016-10-03 20:19:17.175141070 +0300
> @@ -1159,6 +1159,13 @@ static const struct dmi_system_id elante
>  			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
>  		},
>  	},
> +	{
> +		/* Fujitsu H760 also has a middle button */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H760"),
> +		},
> +	},
>  #endif
>  	{ }
>  };
> @@ -1503,6 +1510,13 @@ static const struct dmi_system_id elante
>  		},
>  	},
>  	{
> +		/* Fujitsu H760 does not work with crc_enabled == 0 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H760"),
> +		},
> +	},
> +	{
>  		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled == 0 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> 

-- 
Dmitry
