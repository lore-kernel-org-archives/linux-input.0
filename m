From: Oskar Schirmer <os@emlix.com>
Subject: Re: [PATCH] ad7877: keep dma rx buffers in seperate cache lines
Date: Sun, 9 May 2010 10:50:09 +0200
Message-ID: <20100509085007.GA2402@emlix.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com> <1273142265-11929-2-git-send-email-os@emlix.com> <g2j8bd0f97a1005061146l2b01e45do15bf46162e38ce84@mail.gmail.com> <20100507101544.GB25342@emlix.com> <w2w8bd0f97a1005071128o63fba35fl824cc997980fee03@mail.gmail.com> <20100508223206.GA365@emlix.com> <l2u8bd0f97a1005082145te5965291q91a5daa01695e3d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.87]:46379 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab0EIIuN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 May 2010 04:50:13 -0400
Content-Disposition: inline
In-Reply-To: <l2u8bd0f97a1005082145te5965291q91a5daa01695e3d9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Johannes Weiner <jw@emlix.com>, Oskar Schirmer <os@emlix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?utf-8?B?R2zDtmNrbmVy?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, "Hennerich, Michael" <Michael.Hennerich@analog.com>

On Sun, May 09, 2010 at 00:45:41 -0400, Mike Frysinger wrote:
> On Sat, May 8, 2010 at 18:32, Johannes Weiner wrote:
> > On Fri, May 07, 2010 at 02:28:16PM -0400, Mike Frysinger wrote:
> >> On Fri, May 7, 2010 at 06:15, Oskar Schirmer wrote:
> >> > On Thu, May 06, 2010 at 14:46:04 -0400, Mike Frysinger wrote:
> >> >> On Thu, May 6, 2010 at 06:37, Oskar Schirmer wrote:
> >> >> > =C2=A0struct ser_req {
> >> >> > + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
> >> >> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__padalign[L1_CACHE_BYTES - sizeof(u=
16)];
> >> >> > +
> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset;
> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_on;
> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command;
> >> >> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=
=A0msg;
> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 =
xfer[6];
> >> >> > =C2=A0};
> >> >>
> >> >> are you sure this is necessary ? =C2=A0ser_req is only ever use=
d with
> >> >> spi_sync() and it's allocated/released on the fly, so how could
> >> >> anything be reading that memory between the start of the transm=
ission
> >> >> and the return to adi7877 ?
> >> >
> >> > msg is handed over to spi_sync, it contains the addresses
> >> > which will be used to programme the DMA: the spi master
> >> > transfer function will read these fields to start DMA.
> >>
> >> so the issue is coming from the SPI master drivers and not the AD7=
877 driver
> >
> > No, the issue is coming from ad7877 placing a transmission buffer
> > into the same cache line with memory locations that are accessed ou=
tside
> > the driver's scope.
>=20
> you missed the point of my comment.  as i clearly explained in the
> other structure, the AD7877 driver was causing the cache desync.  her=
e
> it is the SPI master that is implicitly causing it.  i'm not talking
> about the AD7877 being correct wrt to the implicit SPI/DMA
> requirements, just what code exactly is triggering the cache issues.

In both cases ad7877 did place DMA buffers in the same
cache line with reference data needed by spi master to
programme the DMA engine. Once the machinery is started thru
spi_sync, the other case uses spi_async. Both cases open out
into master->transfer via spi_async. In both cases, with
drivers/spi/atmel_spi.c, cache lines are flushed and then
reference data is fed into the DMA engine, thereby
causing the line in question to be cached untimely.

Note, that atmel_spi (thus master) is not wrong here,
as it must assume DMA buffers being correctly aligned
into separate cache lines, so accessing reference data
after cache flush is not vicious. So in both cases the
problem is caused by ad7877 and thus fixed analoguously.

>=20
> > =C2=A0/*
> > =C2=A0 * DMA (thus cache coherency maintainance) requires the
> > =C2=A0 * transfer buffers to live in their own cache lines.
> > =C2=A0 */
> > =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 __padalign[...];
> >
> > ? =C2=A0It might be obvious what the code does, but I agree with
> > Mike that it might not be immediately apparent why it's needed.
>=20
> comment looks fine once the spelling is fixed (maintenance).  thanks.

Ok, will prepare that soon.
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
