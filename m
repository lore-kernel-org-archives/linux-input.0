From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Input: cyttsp4 - SPI driver for Cypress TMA4XX touchscreen devices
Date: Sun, 7 Jul 2013 21:15:24 +0200
Message-ID: <CAMuHMdXS=35MVinOPNRKi=bAzVpqvL-QEm+QsciO1Xe-BYzc4Q@mail.gmail.com>
References: <20130704235117.733726609A1@gitolite.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34484 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab3GGTPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Jul 2013 15:15:25 -0400
In-Reply-To: <20130704235117.733726609A1@gitolite.kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>, Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 5, 2013 at 1:51 AM, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> +++ b/drivers/input/touchscreen/cyttsp4_spi.c

> +static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
> +                          u8 op, u8 reg, u8 *buf, int length)
> +{

> +       if (reg > 255)

As "reg" is "u8", this is never true:

drivers/input/touchscreen/cyttsp4_spi.c: In function =E2=80=98cyttsp_sp=
i_xfer=E2=80=99:
drivers/input/touchscreen/cyttsp4_spi.c:66: warning: comparison is
always false due to limited range of data type

> +               wr_buf[0] =3D op + CY_SPI_A8_BIT;
> +       else
> +               wr_buf[0] =3D op;

Can the if-clause and the first branch just be removed, or is there a r=
eal bug
involved (e.g. wrong type for "reg")?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
