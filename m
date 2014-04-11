From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Fri, 11 Apr 2014 13:25:03 +0200
Message-ID: <235623053.nj0gFkxyW5@wuerfel>
References: <1397209093-10077-1-git-send-email-carlo@caione.org> <1397209093-10077-2-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBRNCT6NAKGQEPXCCKOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1397209093-10077-2-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Friday 11 April 2014 11:38:05 Carlo Caione wrote:
> +#define AXP20X_IRQ(_irq, _off, _mask) \
> +       [AXP20X_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
> +
> +static const struct regmap_irq axp20x_regmap_irqs[] = {
> +       AXP20X_IRQ(ACIN_OVER_V,         0, 7),
> +       AXP20X_IRQ(ACIN_PLUGIN,         0, 6),
> +       AXP20X_IRQ(ACIN_REMOVAL,        0, 5),
> +       AXP20X_IRQ(VBUS_OVER_V,         0, 4),
> +       AXP20X_IRQ(VBUS_PLUGIN,         0, 3),
> +       AXP20X_IRQ(VBUS_REMOVAL,        0, 2),
> +       AXP20X_IRQ(VBUS_V_LOW,          0, 1),
> +       AXP20X_IRQ(BATT_PLUGIN,         1, 7),
> +       AXP20X_IRQ(BATT_REMOVAL,        1, 6),
> +       AXP20X_IRQ(BATT_ENT_ACT_MODE,   1, 5),
> +       AXP20X_IRQ(BATT_EXIT_ACT_MODE,  1, 4),
> +       AXP20X_IRQ(CHARG,               1, 3),
> +       AXP20X_IRQ(CHARG_DONE,          1, 2),
> +       AXP20X_IRQ(BATT_TEMP_HIGH,      1, 1),

Why do you have to enumerate the interrupts here? Can't you just
put all the numbers into the DT nodes of the devices using them?

In general, I would say that the mfd driver should not care about
what is connected to it.

	Arnd
