From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 18:45:33 +0100
Message-ID: <CAMuHMdWmGi6qKKt5YJm1i7FqDceqKosxsSRJRd8zqXO9jMzyoQ@mail.gmail.com>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1421333655-31029-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421333655-31029-3-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 3:54 PM, Laurent Pinchart
<laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> The I2C subsystem can match devices without explicit OF support based on
> the part of their compatible property after the comma. However, this
> mechanism uses the first compatible value only. For adxl34x OF device
> nodes the compatible property will contain the more specific
> "adi,adxl345" or "adi,adxl346" value first. This prevents the device
> node from being matched with the adxl34x driver.
>
> Fix this by adding an OF match table with an "adi,adxl345" compatible
> entry. There's no need to add the "adi,adxl346" entry as the ADXL346 is
> backward-compatible with the ADXL345 with differences handled by runtime
> detection of the device model.

Thanks!

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

> --- a/drivers/input/misc/adxl34x-i2c.c
> +++ b/drivers/input/misc/adxl34x-i2c.c

> +#ifdef CONFIG_OF
> +static const struct of_device_id adxl34x_of_id[] = {
> +       /*
> +        * The ADXL346 is backward-compatible with the ADXL345. Differences are
> +        * handled by runtime detection of the device model, there's thus no
> +        * need for listing the "adi,adxl346" compatible value explicitly.
> +        */
> +       { .compatible = "adi,adxl345", },
> +       /*
> +        * Deprecated, DT nodes should use one or more of the device-specific
> +        * compatible values "adi,adxl345" and "adi,adxl346".

Ideally, the two comments above are moved to a real DT binding document ;-)

> +        */
> +       { .compatible = "adi,adxl34x", },

I'd append "/* deprecated */" to the line above, so "git grep adxl34x"
will show its deprecated status.

> +       { }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
