From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 4/5] Input: add haptic drvier on max77843
Date: Mon, 23 Feb 2015 09:26:58 -0800
Message-ID: <20150223172658.GA604@dtor-glaptop>
References: <1424678991-13978-1-git-send-email-jaewon02.kim@samsung.com>
 <1424678991-13978-5-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424678991-13978-5-git-send-email-jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Jaew9on,

On Mon, Feb 23, 2015 at 05:09:50PM +0900, Jaewon Kim wrote:
> This patch adds support for haptic driver on max77843
> MFD(Multi Function Device) with PMIC, MUIC, LED, CHARGER.
> 
> This driver supports external pwm and LRA(Linear Resonant Actuator) motor.
> And it supports ff-memless interface from inpu framework.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

...

> +static void max77843_haptic_play_work(struct work_struct *work)
> +{
> +	struct max77843_haptic *haptic =
> +			container_of(work, struct max77843_haptic, work);
> +	int error;
> +
> +	mutex_lock(&haptic->mutex);
> +
> +	if (haptic->suspended)
> +		mutex_unlock(&haptic->mutex);

Huh?

> +
> +	error = max77843_haptic_set_duty_cycle(haptic);
> +	if (error) {
> +		dev_err(haptic->dev, "failed to set duty cycle: %d\n", error);
> +		return;

Here you are leaving with the mutex held.

> +	}
> +
> +	if (haptic->magnitude) {
> +		error = max77843_haptic_enable(haptic);
> +		if (error)
> +			dev_err(haptic->dev,
> +					"cannot enable haptic: %d\n", error);
> +	} else {
> +		max77843_haptic_disable(haptic);
> +		if (error)
> +			dev_err(haptic->dev,
> +					"cannot disable haptic: %d\n", error);
> +	}
> +
> +	mutex_unlock(&haptic->mutex);
> +}
> +

The rest seems quite reasonable.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
