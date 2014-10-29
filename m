From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] Input: max77693-haptic - fix potential overflow
Date: Wed, 29 Oct 2014 13:34:04 +0900
Message-ID: <54506E3C.9050206@samsung.com>
References: <20141028164322.GA13234@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141028164322.GA13234@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/29/2014 01:43 AM, Dmitry Torokhov wrote:
> Expression haptic->pwm_dev->period * haptic->magnitude is of type 'unsigned
> int' and may overflow. We need to convert one of the operands to u64 before
> multiplying, instead of casting result (potentially overflown) to u64.
> 
> Reported by Coverity: CID 1248753
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/max77693-haptic.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> index 7b1fde9..ef6a9d6 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -194,7 +194,7 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
>  				       struct ff_effect *effect)
>  {
>  	struct max77693_haptic *haptic = input_get_drvdata(dev);
> -	uint64_t period_mag_multi;
> +	u64 period_mag_multi;
>  
>  	haptic->magnitude = effect->u.rumble.strong_magnitude;
>  	if (!haptic->magnitude)
> @@ -205,8 +205,7 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
>  	 * The formula to convert magnitude to pwm_duty as follows:
>  	 * - pwm_duty = (magnitude * pwm_period) / MAX_MAGNITUDE(0xFFFF)
>  	 */
> -	period_mag_multi = (int64_t)(haptic->pwm_dev->period *
> -						haptic->magnitude);
> +	period_mag_multi = (u64)haptic->pwm_dev->period * haptic->magnitude;
>  	haptic->pwm_duty = (unsigned int)(period_mag_multi >>
>  						MAX_MAGNITUDE_SHIFT);
>  
> 

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
