From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ad7877: fix spi word size to 16 bit
Date: Thu, 13 May 2010 00:53:35 -0700
Message-ID: <20100513075335.GD30110@core.coreip.homeip.net>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
 <n2j8bd0f97a1005061126h7fecc32btad9986c0e38246f2@mail.gmail.com>
 <4BE3E02E.1090500@emlix.com>
 <h2l8bd0f97a1005071123u782bab2doee5c122dbd4c8642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47130 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0EMHxk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 May 2010 03:53:40 -0400
Content-Disposition: inline
In-Reply-To: <h2l8bd0f97a1005071123u782bab2doee5c122dbd4c8642@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oskar Schirmer <os@emlix.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Schneidewind <osw@emlix.com>, Michael Hennerich <michael.hennerich@analog.com>

On Fri, May 07, 2010 at 02:23:07PM -0400, Mike Frysinger wrote:
> On Fri, May 7, 2010 at 05:41, Daniel Gl=F6ckner wrote:
> > On 05/06/2010 08:26 PM, Mike Frysinger wrote:
> >> i think it'd be a better idea to do something like:
> >> =A0 if (spi->bits_per_word !=3D 16) {
> >> =A0 =A0 if (spi->bits_per_word) {
> >> =A0 =A0 =A0 dev_err(&spi->dev, "Invalid SPI settings; bits_per_wor=
d must be 16\n");
> >> =A0 =A0 =A0 return -EINVAL;
> >> =A0 =A0 }
> >> =A0 =A0 spi->bits_per_word =3D 16;
> >> =A0 =A0 spi_setup(spi);
> >> =A0 }
> >
> > There is no way to set bits_per_word using struct spi_board_info. T=
he
> > description of that structure in spi.h explicitly lists the wordsiz=
e as
> > one of the parameters drivers should set themself in probe().
> >
> > Only struct bfin5xx_spi_chip allows to set this value in the board =
code.
>=20
> an obvious shortcoming in the SPI framework that should be fixed, but
> that doesnt make any difference to the above code now does it ?  it'l=
l
> operate correctly regardless of the SPI bus master.

So is the updated patch coming?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
