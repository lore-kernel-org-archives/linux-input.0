From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Mon, 10 May 2010 23:05:47 -0700
Message-ID: <20100511060547.GA9644@core.coreip.homeip.net>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
 <1273488154-2993-1-git-send-email-os@emlix.com>
 <20100510142225.4bf215ef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:65221 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab0EKGGE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 02:06:04 -0400
Content-Disposition: inline
In-Reply-To: <20100510142225.4bf215ef.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>

On Mon, May 10, 2010 at 02:22:25PM -0700, Andrew Morton wrote:
> On Mon, 10 May 2010 12:42:34 +0200
> "Oskar Schirmer" <os@emlix.com> wrote:
>=20
> > With dma based spi transmission, data corruption
> > is observed occasionally. With dma buffers located
> > right next to msg and xfer fields, cache lines
> > correctly flushed in preparation for dma usage
> > may be polluted again when writing to fields
> > in the same cache line.
> >=20
> > Make sure cache fields used with dma do not
> > share cache lines with fields changed during
> > dma handling. As both fields are part of a
> > struct that is allocated via kzalloc, thus
> > cache aligned, moving the fields to the 1st
> > position and insert padding for alignment
> > does the job.
>=20
> This sounds odd.  Doesn't it imply that some code somewhere is missin=
g
> some DMA synchronisation actions?
>=20
> >=20
> > v2: add a comment to explain why alignment is needed
> >=20
> > v3: fix the typo in comment and layout (- to end of line)
> >=20
> > diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/tou=
chscreen/ad7877.c
> > index 885354c..9ebb1b4 100644
> > --- a/drivers/input/touchscreen/ad7877.c
> > +++ b/drivers/input/touchscreen/ad7877.c
> > @@ -153,15 +153,29 @@ enum {
> >   */
> > =20
> >  struct ser_req {
> > +	u16			sample;
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the
> > +	 * transfer buffers to live in their own cache lines.
> > +	 */
> > +	char			__padalign[L1_CACHE_BYTES - sizeof(u16)];
>=20
> It would be better to use __cacheline_aligned, rather than open-codin=
g
> things in this manner.
>=20

OK, then I have the following which I will apply unless someone shouts.

--=20
Dmitry

Input: ad7877 - keep dma rx buffers in seperate cache lines

=46rom: Oskar Schirmer <os@emlix.com>

With dma based spi transmission, data corruption is observed
occasionally. With dma buffers located right next to msg and
xfer fields, cache lines correctly flushed in preparation for
dma usage may be polluted again when writing to fields in the
same cache line.

Make sure cache fields used with dma do not share cache lines
with fields changed during dma handling. As both fields are part
of a struct that is allocated via kzalloc, thus cache aligned,
moving the fields to the 1st position and insert padding for
alignment does the job.

Signed-off-by: Oskar Schirmer <os@emlix.com>
Signed-off-by: Daniel Gl=F6ckner <dg@emlix.com>
Signed-off-by: Oliver Schneidewind <osw@emlix.com>
Signed-off-by: Johannes Weiner <jw@emlix.com>
Acked-by: Mike Frysinger <vapier@gentoo.org>
[dtor@mail.ru - changed to use ___cacheline_aligned at suggestion
 of akpm]
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7877.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)


diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchsc=
reen/ad7877.c
index e019d53..0d2d7e5 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -156,9 +156,14 @@ struct ser_req {
 	u16			reset;
 	u16			ref_on;
 	u16			command;
-	u16			sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[6];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u16 sample ____cacheline_aligned;
 };
=20
 struct ad7877 {
@@ -182,8 +187,6 @@ struct ad7877 {
 	u8			averaging;
 	u8			pen_down_acc_interval;
=20
-	u16			conversion_data[AD7877_NR_SENSE];
-
 	struct spi_transfer	xfer[AD7877_NR_SENSE + 2];
 	struct spi_message	msg;
=20
@@ -195,6 +198,12 @@ struct ad7877 {
 	spinlock_t		lock;
 	struct timer_list	timer;		/* P: lock */
 	unsigned		pending:1;	/* P: lock */
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u16 conversion_data[AD7877_NR_SENSE] ____cacheline_aligned;
 };
=20
 static int gpio3;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
