From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] ff-memless: fix signed to unsigned bit overflow in	ml_combile_effects()
Date: Fri, 08 May 2009 02:53:50 +0300
Message-ID: <4A03748E.3060709@gmail.com>
References: <20090507193206.9342.15843.stgit@fate.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:47337 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZEGXx6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2009 19:53:58 -0400
In-Reply-To: <20090507193206.9342.15843.stgit@fate.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Jussi Kivilinna wrote:
> When userspace sets effect->u.rumble.strong_magnitude to 0x8001 or larger,
> ml_combine_effects() would always return strong_magnitude 0xffff.
> 
> Problem is that 'gain' is passed in as signed integer. Multiplying magnitude
> (__u16) with gain (int) causes magnitude read as signed and results negative
> value (with magnitude > 0x8000). This signed integer is then divided and
> value, still negative, converted to 32bit unsigned integer. Finally checking
> combine overflow min(new+old, 0xffff) gives out 0xffff.
> 
> Fix is to simply change 'gain' to unsigned int.
> 
> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>

Acked-by: Anssi Hannula <anssi.hannula@gmail.com>

> ---
> 
>  drivers/input/ff-memless.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index bc4e40f..2d1415e 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c
> @@ -226,7 +226,7 @@ static int get_compatible_type(struct ff_device *ff, int effect_type)
>   */
>  static void ml_combine_effects(struct ff_effect *effect,
>  			       struct ml_effect_state *state,
> -			       int gain)
> +			       unsigned int gain)
>  {
>  	struct ff_effect *new = state->effect;
>  	unsigned int strong, weak, i;
> 


-- 
Anssi Hannula
