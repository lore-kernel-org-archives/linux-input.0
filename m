From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v4 05/24] misc: max77693-haptic: use
 pwm_get_xxx() helpers where appropriate
Date: Mon, 16 Nov 2015 07:55:33 -0800
Message-ID: <5649FC75.8020203@roeck-us.net>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-6-git-send-email-boris.brezillon@free-electrons.com>
 <5649D5D0.6080204@samsung.com> <20151116145509.3ea50eb0@bbrezillon>
Reply-To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBCKMZDW5VIHBBAXZU6ZAKGQEKAHZKMI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151116145509.3ea50eb0@bbrezillon>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee>
List-Id: linux-input@vger.kernel.org

On 11/16/2015 05:55 AM, Boris Brezillon wrote:
> Hi Krzysztof,
>
> On Mon, 16 Nov 2015 22:10:40 +0900
> Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> W dniu 16.11.2015 o 17:56, Boris Brezillon pisze:
>>> Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
>>> Doing that will ease adaptation of the PWM framework to support atomic
>>> update.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>> ---
>>> Patch generated with the following coccinelle script:
>>>
>>> --->8---
>>> virtual patch
>>>
>>> @@
>>> struct pwm_device *p;
>>> expression e;
>>> @@
>>> (
>>> -(p)->polarity = e;
>>> +pwm_set_polarity((p), e);
>>> |
>>> -(p)->polarity
>>> +pwm_get_polarity((p))
>>> |
>>> -(p)->period = e;
>>> +pwm_set_period((p), e);
>>> |
>>> -(p)->period
>>> +pwm_get_period((p))
>>> |
>>> -(p)->duty_cycle = e;
>>> +pwm_set_duty_cycle((p), e);
>>> |
>>> -(p)->duty_cycle
>>> +pwm_get_duty_cycle((p))
>>> )
>>> --->8---
>>> ---
>>>   drivers/input/misc/max77693-haptic.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
>>> index 6d96bff..a038fb3 100644
>>> --- a/drivers/input/misc/max77693-haptic.c
>>> +++ b/drivers/input/misc/max77693-haptic.c
>>> @@ -70,10 +70,11 @@ struct max77693_haptic {
>>>
>>>   static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
>>>   {
>>> -	int delta = (haptic->pwm_dev->period + haptic->pwm_duty) / 2;
>>> +	int delta = (pwm_get_period((haptic->pwm_dev)) + haptic->pwm_duty) / 2;
>>
>> Double parentheses over argument are not needed so just:
>> pwm_get_period(haptic->pwm_dev) + ...
>
> Actually it was generated with coccinelle, hence I didn't fix existing
> coding style issues, but I have no problem fixing them.
>
There was no existing coding style issue. Your coccinelle script introduces it.
You might want to consider updating your script and remove the unnecessary (( ))
from it.

Guenter

> Thanks,
>
> Boris
>
>>
>> Beside that patch looks good, so with removing parentheses here and below:
>>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>
>> Best regards,
>> Krzysztof
>>
>>>   	int error;
>>>
>>> -	error = pwm_config(haptic->pwm_dev, delta, haptic->pwm_dev->period);
>>> +	error = pwm_config(haptic->pwm_dev, delta,
>>> +			   pwm_get_period((haptic->pwm_dev)));
>>>   	if (error) {
>>>   		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
>>>   		return error;
>>> @@ -245,7 +246,7 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
>>>   	 * The formula to convert magnitude to pwm_duty as follows:
>>>   	 * - pwm_duty = (magnitude * pwm_period) / MAX_MAGNITUDE(0xFFFF)
>>>   	 */
>>> -	period_mag_multi = (u64)haptic->pwm_dev->period * haptic->magnitude;
>>> +	period_mag_multi = (u64)pwm_get_period((haptic->pwm_dev)) * haptic->magnitude;
>>>   	haptic->pwm_duty = (unsigned int)(period_mag_multi >>
>>>   						MAX_MAGNITUDE_SHIFT);
>>>
>>>
>>
>
>
>
