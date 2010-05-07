From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] ad7877: keep dma rx buffers in seperate cache lines
Date: Fri, 7 May 2010 14:07:53 +0200
Message-ID: <20100507120753.GB4413@cmpxchg.org>
References: <1273142265-11929-1-git-send-email-os@emlix.com> <1273142265-11929-2-git-send-email-os@emlix.com> <g2j8bd0f97a1005061146l2b01e45do15bf46162e38ce84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <g2j8bd0f97a1005061146l2b01e45do15bf46162e38ce84@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Oskar Schirmer <os@emlix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>
List-Id: linux-input@vger.kernel.org

On Thu, May 06, 2010 at 02:46:04PM -0400, Mike Frysinger wrote:
> On Thu, May 6, 2010 at 06:37, Oskar Schirmer wrote:
> > =A0struct ser_req {
> > + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sample;
> > + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__padalig=
n[L1_CACHE_BYTES - sizeof(u16)];
> > +
> > =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset;
> > =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ref_on;
> > =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 command;
> > - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sample;
> > =A0 =A0 =A0 =A0struct spi_message =A0 =A0 =A0msg;
> > =A0 =A0 =A0 =A0struct spi_transfer =A0 =A0 xfer[6];
> > =A0};
>=20
> are you sure this is necessary ?  ser_req is only ever used with
> spi_sync() and it's allocated/released on the fly, so how could
> anything be reading that memory between the start of the transmission
> and the return to adi7877 ?

The master driver can.  atmel_spi flushes the cache of the buffers
pretty early when queuing a message and touches the message members
afterwards.

> > =A0struct ad7877 {
> > + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conversio=
n_data[AD7877_NR_SENSE];
> > + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__padalig=
n[L1_CACHE_BYTES
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 - AD7877_NR_SENSE * sizeof(u16)];
> > +
> > =A0 =A0 =A0 =A0struct input_dev =A0 =A0 =A0 =A0*input;
> > =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys[32]=
;
> >
> > @@ -182,8 +188,6 @@ struct ad7877 {
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0averag=
ing;
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pen_do=
wn_acc_interval;
> >
> > - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conversio=
n_data[AD7877_NR_SENSE];
> > -
> > =A0 =A0 =A0 =A0struct spi_transfer =A0 =A0 xfer[AD7877_NR_SENSE + 2=
];
> > =A0 =A0 =A0 =A0struct spi_message =A0 =A0 =A0msg;
>=20
> i can see the spi_message inside of this struct being a problem
> because the spi transfer is doing asynchronously with spi_async().
> however, i would add a comment right above these two fields with a
> short explanation as to why they're at the start and why the pad
> exists so someone down the line doesnt move it.

Good idea.
