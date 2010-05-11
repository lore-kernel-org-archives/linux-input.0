From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Mon, 10 May 2010 23:33:09 -0700
Message-ID: <20100511063309.GC9644@core.coreip.homeip.net>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
 <1273488154-2993-1-git-send-email-os@emlix.com>
 <20100510142225.4bf215ef.akpm@linux-foundation.org>
 <20100511060547.GA9644@core.coreip.homeip.net>
 <AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
 <20100511062110.GB9644@core.coreip.homeip.net>
 <AANLkTiktu7N5IXknkkJ9D5L4z5plhuGvD45IVqJm9zG1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59501 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757029Ab0EKGdP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 02:33:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTiktu7N5IXknkkJ9D5L4z5plhuGvD45IVqJm9zG1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>

On Tue, May 11, 2010 at 02:23:34AM -0400, Mike Frysinger wrote:
> On Tue, May 11, 2010 at 02:21, Dmitry Torokhov wrote:
> > On Tue, May 11, 2010 at 02:11:41AM -0400, Mike Frysinger wrote:
> >> On Tue, May 11, 2010 at 02:05, Dmitry Torokhov wrote:
> >> > On Mon, May 10, 2010 at 02:22:25PM -0700, Andrew Morton wrote:
> >> >> On Mon, 10 May 2010 12:42:34 +0200 Oskar Schirmer wrote:
> >> >> > With dma based spi transmission, data corruption
> >> >> > is observed occasionally. With dma buffers located
> >> >> > right next to msg and xfer fields, cache lines
> >> >> > correctly flushed in preparation for dma usage
> >> >> > may be polluted again when writing to fields
> >> >> > in the same cache line.
> >> >> >
> >> >> > Make sure cache fields used with dma do not
> >> >> > share cache lines with fields changed during
> >> >> > dma handling. As both fields are part of a
> >> >> > struct that is allocated via kzalloc, thus
> >> >> > cache aligned, moving the fields to the 1st
> >> >> > position and insert padding for alignment
> >> >> > does the job.
> >> >>
> >> >> This sounds odd. =A0Doesn't it imply that some code somewhere i=
s missing
> >> >> some DMA synchronisation actions?
> >> >>
> >> >> >
> >> >> > v2: add a comment to explain why alignment is needed
> >> >> >
> >> >> > v3: fix the typo in comment and layout (- to end of line)
> >> >> >
> >> >> > diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/inp=
ut/touchscreen/ad7877.c
> >> >> > index 885354c..9ebb1b4 100644
> >> >> > --- a/drivers/input/touchscreen/ad7877.c
> >> >> > +++ b/drivers/input/touchscreen/ad7877.c
> >> >> > @@ -153,15 +153,29 @@ enum {
> >> >> > =A0 */
> >> >> >
> >> >> > =A0struct ser_req {
> >> >> > + =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sample;
> >> >> > + =A0 /*
> >> >> > + =A0 =A0* DMA (thus cache coherency maintenance) requires th=
e
> >> >> > + =A0 =A0* transfer buffers to live in their own cache lines.
> >> >> > + =A0 =A0*/
> >> >> > + =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__padalign[=
L1_CACHE_BYTES - sizeof(u16)];
> >> >>
> >> >> It would be better to use __cacheline_aligned, rather than open=
-coding
> >> >> things in this manner.
> >> >>
> >> >
> >> > OK, then I have the following which I will apply unless someone =
shouts.
> >> >
> >> > --
> >> > Dmitry
> >> >
> >> > Input: ad7877 - keep dma rx buffers in seperate cache lines
> >> >
> >> > From: Oskar Schirmer <os@emlix.com>
> >> >
> >> > With dma based spi transmission, data corruption is observed
> >> > occasionally. With dma buffers located right next to msg and
> >> > xfer fields, cache lines correctly flushed in preparation for
> >> > dma usage may be polluted again when writing to fields in the
> >> > same cache line.
> >> >
> >> > Make sure cache fields used with dma do not share cache lines
> >> > with fields changed during dma handling. As both fields are part
> >> > of a struct that is allocated via kzalloc, thus cache aligned,
> >> > moving the fields to the 1st position and insert padding for
> >> > alignment does the job.
> >> >
> >> > Signed-off-by: Oskar Schirmer <os@emlix.com>
> >> > Signed-off-by: Daniel Gl=F6ckner <dg@emlix.com>
> >> > Signed-off-by: Oliver Schneidewind <osw@emlix.com>
> >> > Signed-off-by: Johannes Weiner <jw@emlix.com>
> >> > Acked-by: Mike Frysinger <vapier@gentoo.org>
> >> > [dtor@mail.ru - changed to use ___cacheline_aligned at suggestio=
n
> >> > =A0of akpm]
> >> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >> > ---
> >> >
> >> > =A0drivers/input/touchscreen/ad7877.c | =A0 15 ++++++++++++---
> >> > =A01 files changed, 12 insertions(+), 3 deletions(-)
> >> >
> >> >
> >> > diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/=
touchscreen/ad7877.c
> >> > index e019d53..0d2d7e5 100644
> >> > --- a/drivers/input/touchscreen/ad7877.c
> >> > +++ b/drivers/input/touchscreen/ad7877.c
> >> > @@ -156,9 +156,14 @@ struct ser_req {
> >> > =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset=
;
> >> > =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ref_o=
n;
> >> > =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 comma=
nd;
> >> > - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sample=
;
> >> > =A0 =A0 =A0 =A0struct spi_message =A0 =A0 =A0msg;
> >> > =A0 =A0 =A0 =A0struct spi_transfer =A0 =A0 xfer[6];
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* DMA (thus cache coherency maintenance) requir=
es the
> >> > + =A0 =A0 =A0 =A0* transfer buffers to live in their own cache l=
ines.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 u16 sample ____cacheline_aligned;
> >> > =A0};
> >> >
> >> > =A0struct ad7877 {
> >> > @@ -182,8 +187,6 @@ struct ad7877 {
> >> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ave=
raging;
> >> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pen=
_down_acc_interval;
> >> >
> >> > - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conver=
sion_data[AD7877_NR_SENSE];
> >> > -
> >> > =A0 =A0 =A0 =A0struct spi_transfer =A0 =A0 xfer[AD7877_NR_SENSE =
+ 2];
> >> > =A0 =A0 =A0 =A0struct spi_message =A0 =A0 =A0msg;
> >> >
> >> > @@ -195,6 +198,12 @@ struct ad7877 {
> >> > =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> >> > =A0 =A0 =A0 =A0struct timer_list =A0 =A0 =A0 timer; =A0 =A0 =A0 =
=A0 =A0/* P: lock */
> >> > =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pending:1=
; =A0 =A0 =A0/* P: lock */
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* DMA (thus cache coherency maintenance) requir=
es the
> >> > + =A0 =A0 =A0 =A0* transfer buffers to live in their own cache l=
ines.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 u16 conversion_data[AD7877_NR_SENSE] ____cacheline=
_aligned;
> >> > =A0};
> >>
> >> i'm not sure this is correct. =A0the cached_aligned attribute make=
s sure
> >> it starts on a cache boundary, but it doesnt make sure it pads out=
 to
> >> one. =A0so it might work more of the time, but i dont think it's
> >> guaranteed.
> >
> > The buffers are moved to the end of the structure - there is nothin=
g
> > else there.
>=20
> what guarantee exactly do you have for that statement ?

The data is kmalloced, kmalloc aligns on cacheline boundary AFAIK which
means that next kmalloc data chunk will not share "our" cacheline.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
