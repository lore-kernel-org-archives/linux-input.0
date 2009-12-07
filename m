From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] Input: Add direction to ff-memless
Date: Mon, 07 Dec 2009 23:16:52 +0200
Message-ID: <4B1D70C4.9000603@iki.fi>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:56238 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964987AbZLGV05 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 16:26:57 -0500
In-Reply-To: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Jari Vanhala wrote:
> This adds simple direction calculation to effect
> combine. It's useful to decide motor direction for
> rumble (vibrator).

Interesting. None of the existing rumble drivers use the direction
field. I assume your device has two directions for the motor?

I'm somewhat suspicious if the motor direction matters at all, but I
guess it could.

> Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
> ---
>  drivers/input/ff-memless.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index 2d1415e..9af009a 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c
> @@ -221,6 +221,14 @@ static int get_compatible_type(struct ff_device *ff, int effect_type)
>  	return 0;
>  }
>  
> +static unsigned int ml_calculate_direction(
> +	unsigned int direction, unsigned int force,
> +	unsigned int new_direction, unsigned int new_force)
> +{
> +	return ((u32)direction * force + new_direction * new_force) /
> +		(force + new_force);
> +}

What if direction is 0xf000 and new_direction is 0x1000? The correct
behaviour would be to use direction 0x0000 or so, but this code would
return 0x8000 (assuming equal forces).

>  /*
>   * Combine two effects and apply gain.
>   */
> @@ -255,6 +263,19 @@ static void ml_combine_effects(struct ff_effect *effect,
>  	case FF_RUMBLE:
>  		strong = new->u.rumble.strong_magnitude * gain / 0xffff;
>  		weak = new->u.rumble.weak_magnitude * gain / 0xffff;
> +
> +		if (effect->u.rumble.strong_magnitude + strong)
> +			effect->direction = ml_calculate_direction(
> +				effect->direction,
> +				effect->u.rumble.strong_magnitude,
> +				new->direction, strong);
> +		else if (effect->u.rumble.weak_magnitude + weak)
> +			effect->direction = ml_calculate_direction(
> +				effect->direction,
> +				effect->u.rumble.weak_magnitude,
> +				new->direction, weak);
> +		else
> +			effect->direction = 0;
>  		effect->u.rumble.strong_magnitude =
>  			min(strong + effect->u.rumble.strong_magnitude,
>  			    0xffffU);

Looks ok.

We could also additionally carry the effect of directions into magnitude
when summing the force vectors, so that two equal-magnitude rumbles with
opposite directions would cancel themselves out. I'd be slightly against
that, though, as rumble doesn't really have clear directions anyway.
(just mentioning this in case someone thinks we should do that)

-- 
Anssi Hannula
