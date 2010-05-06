From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] ad7877: fix spi word size to 16 bit
Date: Thu, 6 May 2010 14:26:00 -0400
Message-ID: <n2j8bd0f97a1005061126h7fecc32btad9986c0e38246f2@mail.gmail.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56756 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab0EFS0X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 14:26:23 -0400
In-Reply-To: <1273142265-11929-1-git-send-email-os@emlix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskar Schirmer <os@emlix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Michael Hennerich <michael.hennerich@analog.com>

On Thu, May 6, 2010 at 06:37, Oskar Schirmer wrote:
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -669,6 +669,8 @@ static int __devinit ad7877_probe(struct spi_devi=
ce *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&spi->=
dev, "SPI CLK %d Hz?\n",spi->max_speed_hz);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 spi->bits_per_word =3D 16;
> + =C2=A0 =C2=A0 =C2=A0 spi_setup(spi);

i think it'd be a better idea to do something like:
  if (spi->bits_per_word !=3D 16) {
    if (spi->bits_per_word) {
      dev_err(&spi->dev, "Invalid SPI settings; bits_per_word must be 1=
6\n");
      return -EINVAL;
    }
    spi->bits_per_word =3D 16;
    spi_setup(spi);
  }
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
