From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v4 04/24] hwmon: pwm-fan: use pwm_get_xxx()
 helpers where appropriate
Date: Mon, 16 Nov 2015 09:00:05 -0800
Message-ID: <564A0B95.6010603@roeck-us.net>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-5-git-send-email-boris.brezillon@free-electrons.com>
 <5649FD5B.3000208@roeck-us.net> <20151116175322.48dba6f9@bbrezillon>
Reply-To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBCKMZDW5VIHBBHUXVCZAKGQEGKBKILQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151116175322.48dba6f9@bbrezillon>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee>
List-Id: linux-input@vger.kernel.org

On 11/16/2015 08:53 AM, Boris Brezillon wrote:
> On Mon, 16 Nov 2015 07:59:23 -0800
> Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>
>> On 11/16/2015 12:56 AM, Boris Brezillon wrote:
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
>>
>> s/((p))/(p)/
>>
>>> |
>>> -(p)->period = e;
>>> +pwm_set_period((p), e);
>>> |
>>> -(p)->period
>>> +pwm_get_period((p))
>>
>> s/((p))/(p)/
>>
>>> |
>>> -(p)->duty_cycle = e;
>>> +pwm_set_duty_cycle((p), e);
>>
>> The (p) seems unnecessary here.
>
> I don't get this one. You mean I should drop one the parenthesis around
> p, right?
>

Same as above - s/(p)/p/. It should never be necessary to write
	pwm_set_duty_cycle((p), e)
since
	pwm_set_duty_cycle(p, e)
should be the same.

On the other side, I did not see this expression used in any of the patches,
though maybe I missed it.

Thanks,
Guenter
