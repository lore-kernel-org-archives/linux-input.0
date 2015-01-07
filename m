From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: adxl34x - add device tree documentation
Date: Wed, 7 Jan 2015 10:42:31 +0100
Message-ID: <CAMuHMdVfqzTf034vyDPEYrnZ7+3iE+h2H+7Cs-ifJrePDrw-rg@mail.gmail.com>
References: <1420599537-28740-1-git-send-email-walter@vanguardiasur.com.ar>
	<1420599537-28740-2-git-send-email-walter@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420599537-28740-2-git-send-email-walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 7, 2015 at 3:58 AM, Walter Lozano
<walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> wrote:
> diff --git a/Documentation/devicetree/bindings/input/adxl34x.txt b/Documentation/devicetree/bindings/input/adxl34x.txt
> new file mode 100644
> index 0000000..0774f7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adxl34x.txt
> @@ -0,0 +1,53 @@
> +Device Tree bindings for adxl34x digital accelerometer, both spi and i2c.
> +
> +Depending on the interface this node should be a child of a spi or i2c bus.
> +
> +Required properties:
> +- compatible: "adxl34x"

"adi,adxl34x"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
