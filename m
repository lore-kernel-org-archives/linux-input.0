From: "Oskar Schirmer" <os@emlix.com>
Subject: Re: [PATCH] ad7877: fix spi word size to 16 bit
Date: Mon, 17 May 2010 10:41:54 +0200
Message-ID: <20100517084153.GA18398@emlix.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
 <n2j8bd0f97a1005061126h7fecc32btad9986c0e38246f2@mail.gmail.com>
 <4BE3E02E.1090500@emlix.com>
 <h2l8bd0f97a1005071123u782bab2doee5c122dbd4c8642@mail.gmail.com>
 <20100513075335.GD30110@core.coreip.homeip.net>
 <20100515181523.GA3081@emlix.com>
 <AANLkTinn6VgvujPP3gGsteBGckIFgljn7B35DV6n8kwL@mail.gmail.com>
 <20100517072935.GA14891@emlix.com>
 <544AC56F16B56944AEC3BD4E3D5917712E568FC181@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.87]:38495 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614Ab0EQImB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 04:42:01 -0400
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568FC181@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Oskar Schirmer <os@emlix.com>, Mike Frysinger <vapier.adi@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel =?utf-8?B?R2zDtmNrbmVy?= <dg@emlix.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oliver Schneidewind <osw@emlix.com>

On Mon, May 17, 2010 at 09:14:39 +0100, Hennerich, Michael wrote:
> Oskar Schirmer wrote on 2010-05-17:
> > On Sun, May 16, 2010 at 15:25:34 -0400, Mike Frysinger wrote:
> >> On Sat, May 15, 2010 at 14:15, Oskar Schirmer wrote:
> >>> On Thu, May 13, 2010 at 00:53:35 -0700, Dmitry Torokhov wrote:
> >>>> On Fri, May 07, 2010 at 02:23:07PM -0400, Mike Frysinger wrote:
> >>>>> On Fri, May 7, 2010 at 05:41, Daniel Gl=C3=B6ckner wrote:
> >>>>>> On 05/06/2010 08:26 PM, Mike Frysinger wrote:
> >>>>>>> i think it'd be a better idea to do something like:
> >>>>>>>   if (spi->bits_per_word !=3D 16) {
> >>>>>>>     if (spi->bits_per_word) {
> >>>>>>>       dev_err(&spi->dev, "Invalid SPI settings;
> >>>>>>> bits_per_word must be 16\n");
> >>>>>>>       return -EINVAL;
> >>>>>>>     }
> >>>>>>>     spi->bits_per_word =3D 16;
> >>>>>>>     spi_setup(spi);
> >>>>>>>   }
> >>>>>>
> >>>>>> There is no way to set bits_per_word using struct spi_board_in=
fo.
> >>>>>> The description of that structure in spi.h explicitly lists th=
e
> >>>>>> wordsize as one of the parameters drivers should set themself =
in
> >>>>>> probe().
> >>>>>>
> >>>>>> Only struct bfin5xx_spi_chip allows to set this value in the
> > board code.
> >>>>>
> >>>>> an obvious shortcoming in the SPI framework that should be fixe=
d,
> >>>>> but that doesnt make any difference to the above code now does =
it ?
> >>>>>  it'll operate correctly regardless of the SPI bus master.
> >>>>
> >>>> So is the updated patch coming?
> >>>
> >>> The basic question I see is, whether it is in the responsibility
> >>> of
> >>> ad7877 to check a wrong setting possibly caused in board specific
> >>> code. If so, then the proposal by Mike should be used, but if not
> >>> so, it would introduce unneeded code.
> >>>
> >>> Remember: both versions end up in correctly setting bits_per_word=
,
> >>> with the difference merely in feedback level.
> >>
> >> imo, unsupported board settings should always be detected & reject=
ed.
> >> all SPI master drivers do this (detect & reject unsupported SPI
> >> slave settings).
> >
> > please note, that bits_per_word is not a board setting, it's a dema=
nd
> > of the device. consequently, there is no one to set unsupported val=
ues
> > and thus none to be detected.
> >
> > the only architecture setting bits_per_word thru spi_chip is blackf=
in,
> > but I cannot see a good reason, why the board settings should engag=
e
> > with a fixed demand of the device?
> >
> >   Oskar
>=20
> 100% agreed.
>=20
> Two ways to address the issue:
> 1) Forcing spi->bits_per_word =3D 16 like this patch does.
> 2) Or going with the default 8-bit transfers and using be16_to_cpu().
>=20
> Personally I prefer 1) unless someone tells me that not all SPI bus d=
rivers
> support 16-bit transfers.

yes, I prefer (1) too.

if (2) is for the bus driver that didn't support
16 bit up to now, though the peripheral unit does
support it, that bus driver needs a fix.

but then, if (2) is for, e.g., a 16 bit only device wired
to an 8 bit only bus driver, which, I'ld say, is a
board design fault. sure one may want to implement an
ugly software work around for it, just to rescue some
high budget project and managers calculated that messing
up the software will cost less then having another
board design cycle, but I'ld better propose to give the
hardware engineer the whip.

  Oskar
--=20
oskar schirmer, emlix gmbh, http://www.emlix.com
fon +49 551 30664-0, fax -11, bahnhofsallee 1b, 37081 g=C3=B6ttingen, g=
ermany
sitz der gesellschaft: g=C3=B6ttingen, amtsgericht g=C3=B6ttingen hr b =
3160
gesch=C3=A4ftsf=C3=BChrer: dr. uwe kracke, ust-idnr.: de 205 198 055

emlix - your embedded linux partner
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
