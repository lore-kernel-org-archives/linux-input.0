From: Oskar Schirmer <os@emlix.com>
Subject: Re: [PATCH] ad7877: keep dma rx buffers in seperate cache lines
Date: Fri, 7 May 2010 12:15:44 +0200
Message-ID: <20100507101544.GB25342@emlix.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com> <1273142265-11929-2-git-send-email-os@emlix.com> <g2j8bd0f97a1005061146l2b01e45do15bf46162e38ce84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.87]:58325 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169Ab0EGKPr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 May 2010 06:15:47 -0400
Content-Disposition: inline
In-Reply-To: <g2j8bd0f97a1005061146l2b01e45do15bf46162e38ce84@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Oskar Schirmer <os@emlix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?utf-8?B?R2zDtmNrbmVy?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>

On Thu, May 06, 2010 at 14:46:04 -0400, Mike Frysinger wrote:
> On Thu, May 6, 2010 at 06:37, Oskar Schirmer wrote:
> > =C2=A0struct ser_req {
> > + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0__padalign[L1_CACHE_BYTES - sizeof(u16)];
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_on;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command;
> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=A0m=
sg;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xfer[6=
];
> > =C2=A0};
>=20
> are you sure this is necessary ?  ser_req is only ever used with
> spi_sync() and it's allocated/released on the fly, so how could
> anything be reading that memory between the start of the transmission
> and the return to adi7877 ?

msg is handed over to spi_sync, it contains the addresses
which will be used to programme the DMA: the spi master
transfer function will read these fields to start DMA.

E.g., drivers/spi/atmel_spi.c, assures cache coherency
in function atmel_spi_dma_map_xfer, one xfer at a time.
Multiple transfers are worked on in a loop in atmel_spi_transfer,
so when coherency for transfer #1 is ensured, addresses
for transfer #2 are read from the msg and xfer structs,
caching lines which have been just before invalidated.

And, citing Documentation/DMA-API.txt, Part Id:
"mapped region must begin exactly on a cache line
boundary and end exactly on one", which is our case.

>=20
> > =C2=A0struct ad7877 {
> > + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversion_data[AD7877_NR_SENSE];
> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0__padalign[L1_CACHE_BYTES
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - AD=
7877_NR_SENSE * sizeof(u16)];
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*input;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys[32];
> >
> > @@ -182,8 +188,6 @@ struct ad7877 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0averaging;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pen_down_acc_interval;
> >
> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversion_data[AD7877_NR_SENSE];
> > -
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xfer[A=
D7877_NR_SENSE + 2];
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=A0m=
sg;
>=20
> i can see the spi_message inside of this struct being a problem
> because the spi transfer is doing asynchronously with spi_async().
> however, i would add a comment right above these two fields with a
> short explanation as to why they're at the start and why the pad
> exists so someone down the line doesnt move it.

The code says "pad to align according to L1 cache, and
keep away other stuff by exactly the amount so it is
off the line". I'ld guess a comment would repeat just
this, so it is superfluous. But if opinions differ on
this topic, we can have a comment added, sure.

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
