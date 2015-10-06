From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ads7846: correct the value got from SPI
Date: Tue, 6 Oct 2015 15:50:09 -0700
Message-ID: <20151006225009.GF31850@dtor-ws>
References: <1444140010-23939-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36345 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbbJFWuM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 18:50:12 -0400
Received: by pablk4 with SMTP id lk4so63055pab.3
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2015 15:50:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444140010-23939-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-input@vger.kernel.org, Andrey Gelman <andrey.gelman@compulab.co.il>, Haibo Chen <haibo.chen@freescale.com>

On Tue, Oct 06, 2015 at 05:00:10PM +0300, Igor Grinberg wrote:
> From: Andrey Gelman <andrey.gelman@compulab.co.il>
> 
> According to the touch controller spec, SPI return a 16 bit value,
> only 12 bits are valid, they are bit[14-3].
> 
> The value of MISO and MOSI can be configured when SPI is in idle mode.
> Currently this touch driver assumes the SPI bus sets the MOSI and
> MISO in low level when SPI bus is in idle mode. So the bit[15] of the
> value got from SPI bus is always 0. But when SPI bus congfigures the
> MOSI and MISO in high level during the SPI idle mode, the bit[15] of
> the value get from SPI is always 1. If bit[15] is not masked, we may
> get the wrong value.
> 
> Mask the invalid bit to make sure the correct value gets returned.
> Regardless of the SPI bus idle configuration.
> 
> Signed-off-by: Andrey Gelman <andrey.gelman@compulab.co.il>
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ads7846.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 727d88c..8e2a44d 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -666,18 +666,22 @@ static int ads7846_no_filter(void *ads, int data_idx, int *val)
>  
>  static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
>  {
> +	int value;
>  	struct spi_transfer *t =
>  		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
>  
>  	if (ts->model == 7845) {
> -		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
> +		value = be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1]));
>  	} else {
>  		/*
>  		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
>  		 * padding; built from two 8 bit values written msb-first.
>  		 */
> -		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
> +		value = be16_to_cpup((__be16 *)t->rx_buf);
>  	}
> +
> +	/* enforce ADC output is 12 bits width */
> +	return (value >> 3) & 0xfff;
>  }
>  
>  static void ads7846_update_value(struct spi_message *m, int val)
> -- 
> 2.4.9
> 

-- 
Dmitry
