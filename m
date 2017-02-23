From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input:touchscreen:ad7879-spi.c: Fix regmap flag_masks
Date: Thu, 23 Feb 2017 00:43:48 -0800
Message-ID: <20170223084348.GK18639@dtor-ws>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
 <1487780078-18510-2-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36852 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWIn5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 03:43:57 -0500
Content-Disposition: inline
In-Reply-To: <1487780078-18510-2-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 22, 2017 at 05:14:35PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Mask only applied to the top byte of the register
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Thank you Michael, I folded it with the patch introducing regmaps.

> ---
>  drivers/input/touchscreen/ad7879-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
> index f2c06b5..b995891 100644
> --- a/drivers/input/touchscreen/ad7879-spi.c
> +++ b/drivers/input/touchscreen/ad7879-spi.c
> @@ -19,8 +19,8 @@
>  
>  #define MAX_SPI_FREQ_HZ      5000000
>  
> -#define AD7879_CMD_MAGIC     0xE000
> -#define AD7879_CMD_READ      BIT(10)
> +#define AD7879_CMD_MAGIC     0xE0
> +#define AD7879_CMD_READ      BIT(2)
>  
>  static const struct regmap_config ad7879_spi_regmap_config = {
>  	.reg_bits = 16,
> -- 
> 2.7.4
> 

-- 
Dmitry
