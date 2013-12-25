From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH 1/5] input: Add new sun4i-ts
 driver for Allwinner sunxi SoC's rtp controller
Date: Wed, 25 Dec 2013 02:40:58 -0800
Message-ID: <20131225104058.GA18980@roeck-us.net>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCKMZDW5VIHBBPHM5KKQKGQEPYDV7XY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1387923847-1294-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 24, 2013 at 11:24:03PM +0100, Hans de Goede wrote:
> Note the sun4i-ts controller is capable of detecting a second touch, but when
> a second touch is present then the accuracy becomes so bad the reported touch
> location is not useable.
> 
> The original android driver contains some complicated heuristics using the
> aprox. distance between the 2 touches to see if the user is making a pinch
> open / close movement, and then reports emulated multi-touch events around
> the last touch coordinate (as the dual-touch coordinates are worthless).
> 
> These kinds of heuristics are just asking for trouble (and don't belong
> in the kernel). So this driver offers straight forward, reliable single
> touch functionality only.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig    |  10 ++
>  drivers/input/touchscreen/Makefile   |   1 +
>  drivers/input/touchscreen/sun4i-ts.c | 272 +++++++++++++++++++++++++++++++++++

[ ... ]

> +
> +static int sun4i_ts_probe(struct platform_device *pdev)
> +{
> +	struct sun4i_ts_data *ts;
> +	int ret = -ENOMEM;
> +
> +	ts = kzalloc(sizeof(struct sun4i_ts_data), GFP_KERNEL);

How about using devm_kzalloc() here ? That would simplify the cleanup
path significantly as you could just return from most error cases.

Guenter
