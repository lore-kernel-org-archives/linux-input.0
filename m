From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH] Input: max77693-haptic - fix potential overflow
Date: Wed, 29 Oct 2014 12:22:37 +0900
Message-ID: <54505D7D.4000704@samsung.com>
References: <20141028164322.GA13234@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141028164322.GA13234@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

2014=EB=85=84 10=EC=9B=94 29=EC=9D=BC 01:43=EC=97=90 Dmitry Torokhov =EC=
=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> Expression haptic->pwm_dev->period * haptic->magnitude is of type 'un=
signed
> int' and may overflow. We need to convert one of the operands to u64 =
before
> multiplying, instead of casting result (potentially overflown) to u64=
=2E
>
> Reported by Coverity: CID 1248753
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/misc/max77693-haptic.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/mis=
c/max77693-haptic.c
> index 7b1fde9..ef6a9d6 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -194,7 +194,7 @@ static int max77693_haptic_play_effect(struct inp=
ut_dev *dev, void *data,
>   				       struct ff_effect *effect)
>   {
>   	struct max77693_haptic *haptic =3D input_get_drvdata(dev);
> -	uint64_t period_mag_multi;
> +	u64 period_mag_multi;
>  =20
>   	haptic->magnitude =3D effect->u.rumble.strong_magnitude;
>   	if (!haptic->magnitude)
> @@ -205,8 +205,7 @@ static int max77693_haptic_play_effect(struct inp=
ut_dev *dev, void *data,
>   	 * The formula to convert magnitude to pwm_duty as follows:
>   	 * - pwm_duty =3D (magnitude * pwm_period) / MAX_MAGNITUDE(0xFFFF)
>   	 */
> -	period_mag_multi =3D (int64_t)(haptic->pwm_dev->period *
> -						haptic->magnitude);
> +	period_mag_multi =3D (u64)haptic->pwm_dev->period * haptic->magnitu=
de;
>   	haptic->pwm_duty =3D (unsigned int)(period_mag_multi >>
>   						MAX_MAGNITUDE_SHIFT);
>  =20


There was casting miss in multiplying.
Thanks.

Acked-by : Jaewon Kim <jaewon02.kim@samsung.com>
