From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Using gpio_keys with regmapped gpio?
Date: Fri, 3 Apr 2015 09:13:54 +0200
Message-ID: <CAMuHMdVMKLAz5sZuVH9s720aa4Vk=+vd2TpCHM7Ns2KUPpFVPw@mail.gmail.com>
References: <551AFC2F.3060300@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551AFC2F.3060300-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Thor,

On Tue, Mar 31, 2015 at 9:57 PM, Thor Thayer
<tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> wrote:
> Which brings up my next question. Can the gpio_keys framework be used with a
> regmapped gpio? I haven't been able to find any examples of gpio_keys with
> an external gpio expander and maybe this isn't valid usage.

Kzm9g uses gpio-keys with a PCF8575 i2c GPIO expander, cfr.
arch/arm/boot/dts/sh73a0-kzm9g.dts. It doesn't use regmap, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
