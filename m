From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] ad7877: fix spi word size to 16 bit
Date: Fri, 7 May 2010 14:23:07 -0400
Message-ID: <h2l8bd0f97a1005071123u782bab2doee5c122dbd4c8642@mail.gmail.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
	<n2j8bd0f97a1005061126h7fecc32btad9986c0e38246f2@mail.gmail.com>
	<4BE3E02E.1090500@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53874 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab0EGSXa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 May 2010 14:23:30 -0400
In-Reply-To: <4BE3E02E.1090500@emlix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>
Cc: Oskar Schirmer <os@emlix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Schneidewind <osw@emlix.com>, Michael Hennerich <michael.hennerich@analog.com>

On Fri, May 7, 2010 at 05:41, Daniel Gl=C3=B6ckner wrote:
> On 05/06/2010 08:26 PM, Mike Frysinger wrote:
>> i think it'd be a better idea to do something like:
>> =C2=A0 if (spi->bits_per_word !=3D 16) {
>> =C2=A0 =C2=A0 if (spi->bits_per_word) {
>> =C2=A0 =C2=A0 =C2=A0 dev_err(&spi->dev, "Invalid SPI settings; bits_=
per_word must be 16\n");
>> =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 spi->bits_per_word =3D 16;
>> =C2=A0 =C2=A0 spi_setup(spi);
>> =C2=A0 }
>
> There is no way to set bits_per_word using struct spi_board_info. The
> description of that structure in spi.h explicitly lists the wordsize =
as
> one of the parameters drivers should set themself in probe().
>
> Only struct bfin5xx_spi_chip allows to set this value in the board co=
de.

an obvious shortcoming in the SPI framework that should be fixed, but
that doesnt make any difference to the above code now does it ?  it'll
operate correctly regardless of the SPI bus master.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
