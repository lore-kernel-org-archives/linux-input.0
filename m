From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Tue, 11 May 2010 02:37:21 -0400
Message-ID: <AANLkTimgZTNi6eevEAJw1BdbAJwkyCfgYe7srqmHVrUX@mail.gmail.com>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<1273488154-2993-1-git-send-email-os@emlix.com> <20100510142225.4bf215ef.akpm@linux-foundation.org>
	<20100511060547.GA9644@core.coreip.homeip.net> <AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
	<20100511062110.GB9644@core.coreip.homeip.net> <AANLkTiktu7N5IXknkkJ9D5L4z5plhuGvD45IVqJm9zG1@mail.gmail.com>
	<20100511063309.GC9644@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100511063309.GC9644@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>
List-Id: linux-input@vger.kernel.org

On Tue, May 11, 2010 at 02:33, Dmitry Torokhov wrote:
> On Tue, May 11, 2010 at 02:23:34AM -0400, Mike Frysinger wrote:
>> On Tue, May 11, 2010 at 02:21, Dmitry Torokhov wrote:
>> > On Tue, May 11, 2010 at 02:11:41AM -0400, Mike Frysinger wrote:
>> >> On Tue, May 11, 2010 at 02:05, Dmitry Torokhov wrote:
>> >> > Dmitry
>> >> >
>> >> > Input: ad7877 - keep dma rx buffers in seperate cache lines
>> >> >
>> >> > From: Oskar Schirmer <os@emlix.com>
>> >> >
>> >> > With dma based spi transmission, data corruption is observed
>> >> > occasionally. With dma buffers located right next to msg and
>> >> > xfer fields, cache lines correctly flushed in preparation for
>> >> > dma usage may be polluted again when writing to fields in the
>> >> > same cache line.
>> >> >
>> >> > Make sure cache fields used with dma do not share cache lines
>> >> > with fields changed during dma handling. As both fields are par=
t
>> >> > of a struct that is allocated via kzalloc, thus cache aligned,
>> >> > moving the fields to the 1st position and insert padding for
>> >> > alignment does the job.
>> >> >
>> >> > Signed-off-by: Oskar Schirmer <os@emlix.com>
>> >> > Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
>> >> > Signed-off-by: Oliver Schneidewind <osw@emlix.com>
>> >> > Signed-off-by: Johannes Weiner <jw@emlix.com>
>> >> > Acked-by: Mike Frysinger <vapier@gentoo.org>
>> >> > [dtor@mail.ru - changed to use ___cacheline_aligned at suggesti=
on
>> >> > =C2=A0of akpm]
>> >> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> >> > ---
>> >> >
>> >> > =C2=A0drivers/input/touchscreen/ad7877.c | =C2=A0 15 ++++++++++=
++---
>> >> > =C2=A01 files changed, 12 insertions(+), 3 deletions(-)
>> >> >
>> >> >
>> >> > diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input=
/touchscreen/ad7877.c
>> >> > index e019d53..0d2d7e5 100644
>> >> > --- a/drivers/input/touchscreen/ad7877.c
>> >> > +++ b/drivers/input/touchscreen/ad7877.c
>> >> > @@ -156,9 +156,14 @@ struct ser_req {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_on;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command;
>> >> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=
=A0msg;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xf=
er[6];
>> >> > +
>> >> > + =C2=A0 =C2=A0 =C2=A0 /*
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA (thus cache coherency mainte=
nance) requires the
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* transfer buffers to live in thei=
r own cache lines.
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >> > + =C2=A0 =C2=A0 =C2=A0 u16 sample ____cacheline_aligned;
>> >> > =C2=A0};
>> >> >
>> >> > =C2=A0struct ad7877 {
>> >> > @@ -182,8 +187,6 @@ struct ad7877 {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0averaging;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pen_down_acc_interval;
>> >> >
>> >> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversion_data[AD7877_NR_SENSE];
>> >> > -
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xf=
er[AD7877_NR_SENSE + 2];
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=
=A0msg;
>> >> >
>> >> > @@ -195,6 +198,12 @@ struct ad7877 {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0lock;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timer_list =C2=A0 =C2=A0 =C2=A0=
 timer; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* P: lock */
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0pending:1; =C2=A0 =C2=A0 =C2=A0/* P: lock *=
/
>> >> > +
>> >> > + =C2=A0 =C2=A0 =C2=A0 /*
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA (thus cache coherency mainte=
nance) requires the
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* transfer buffers to live in thei=
r own cache lines.
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >> > + =C2=A0 =C2=A0 =C2=A0 u16 conversion_data[AD7877_NR_SENSE] ___=
_cacheline_aligned;
>> >> > =C2=A0};
>> >>
>> >> i'm not sure this is correct. =C2=A0the cached_aligned attribute =
makes sure
>> >> it starts on a cache boundary, but it doesnt make sure it pads ou=
t to
>> >> one. =C2=A0so it might work more of the time, but i dont think it=
's
>> >> guaranteed.
>> >
>> > The buffers are moved to the end of the structure - there is nothi=
ng
>> > else there.
>>
>> what guarantee exactly do you have for that statement ?
>
> The data is kmalloced, kmalloc aligns on cacheline boundary AFAIK whi=
ch
> means that next kmalloc data chunk will not share "our" cacheline.

so obvious once you say it out loud.  as long as kmalloc() guarantees
it, your patch sounds fine to me.  once Oskar double checks, ship it!

thanks :)
-mike
