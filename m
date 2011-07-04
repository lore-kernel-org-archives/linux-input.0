From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: atmel_mxt_ts - Make wait-after-reset period
 compatible with all chips
Date: Mon, 4 Jul 2011 03:04:36 -0700
Message-ID: <20110704100435.GA3723@core.coreip.homeip.net>
References: <4E11825B.3000409@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35307 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab1GDKEm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 06:04:42 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so4327396iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 03:04:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E11825B.3000409@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Mon, Jul 04, 2011 at 12:05:31PM +0300, Iiro Valkonen wrote:
> The delay before the chip can be accessed after reset varies between different
> chips in maXTouch family. Waiting for 200ms and then monitoring the CHG (chip
> is ready when the line is low) is guaranteed to work with all chips.
> 
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |    4 +++-
>  include/linux/i2c/atmel_mxt_ts.h         |    1 +
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 1e61387..8870e7b 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -170,7 +170,7 @@
>  #define MXT_BOOT_VALUE		0xa5
>  #define MXT_BACKUP_VALUE	0x55
>  #define MXT_BACKUP_TIME		25	/* msec */
> -#define MXT_RESET_TIME		65	/* msec */
> +#define MXT_RESET_TIME		200	/* msec */
>  
>  #define MXT_FWRESET_TIME	175	/* msec */
>  
> @@ -828,6 +828,8 @@ static int mxt_initialize(struct mxt_data *data)
>  	mxt_write_object(data, MXT_GEN_COMMAND,
>  			MXT_COMMAND_RESET, 1);
>  	msleep(MXT_RESET_TIME);
> +	while (data->pdata->read_chg())
> +		msleep(2);

I would prefer if we did not wait indefinitely but timed out after
certain number of retries.

Thanks.

-- 
Dmitry
