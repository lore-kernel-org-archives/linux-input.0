From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - remove unneeded check
Date: Tue, 19 Aug 2014 11:56:40 -0700
Message-ID: <20140819185639.GA26302@core.coreip.homeip.net>
References: <20140817142851.GA21153@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140817142851.GA21153@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Aug 17, 2014 at 07:28:52AM -0700, Dmitry Torokhov wrote:
> This fixes the following issue reported by Coverity:
> 
> ** CID 1231785:  Unsigned compared against 0  (NO_EFFECT)
> /drivers/input/touchscreen/atmel_mxt_ts.c: 1157 in mxt_prepare_cfg_mem()
> 
> The variable 'byte_offset' is declared as unsigned int and therefore can never
> be less than 0.
> 

Withdrawn - Linus recommended to become intimate with the compiler instead.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index db178ed..8780c9a 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1154,7 +1154,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
>  
>  			byte_offset = reg + i - cfg_start_ofs;
>  
> -			if (byte_offset >= 0 && byte_offset < config_mem_size) {
> +			if (byte_offset < config_mem_size) {
>  				*(config_mem + byte_offset) = val;
>  			} else {
>  				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
> -- 
> 2.1.0.rc2.206.gedb03e5
> 
> 
> -- 
> Dmitry

-- 
Dmitry
