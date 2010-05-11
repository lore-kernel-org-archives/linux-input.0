From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Tue, 11 May 2010 02:11:41 -0400
Message-ID: <AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<1273488154-2993-1-git-send-email-os@emlix.com> <20100510142225.4bf215ef.akpm@linux-foundation.org>
	<20100511060547.GA9644@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52468 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0EKGMC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 02:12:02 -0400
In-Reply-To: <20100511060547.GA9644@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>

On Tue, May 11, 2010 at 02:05, Dmitry Torokhov wrote:
> On Mon, May 10, 2010 at 02:22:25PM -0700, Andrew Morton wrote:
>> On Mon, 10 May 2010 12:42:34 +0200 Oskar Schirmer wrote:
>> > With dma based spi transmission, data corruption
>> > is observed occasionally. With dma buffers located
>> > right next to msg and xfer fields, cache lines
>> > correctly flushed in preparation for dma usage
>> > may be polluted again when writing to fields
>> > in the same cache line.
>> >
>> > Make sure cache fields used with dma do not
>> > share cache lines with fields changed during
>> > dma handling. As both fields are part of a
>> > struct that is allocated via kzalloc, thus
>> > cache aligned, moving the fields to the 1st
>> > position and insert padding for alignment
>> > does the job.
>>
>> This sounds odd. =C2=A0Doesn't it imply that some code somewhere is =
missing
>> some DMA synchronisation actions?
>>
>> >
>> > v2: add a comment to explain why alignment is needed
>> >
>> > v3: fix the typo in comment and layout (- to end of line)
>> >
>> > diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/to=
uchscreen/ad7877.c
>> > index 885354c..9ebb1b4 100644
>> > --- a/drivers/input/touchscreen/ad7877.c
>> > +++ b/drivers/input/touchscreen/ad7877.c
>> > @@ -153,15 +153,29 @@ enum {
>> > =C2=A0 */
>> >
>> > =C2=A0struct ser_req {
>> > + =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sample;
>> > + =C2=A0 /*
>> > + =C2=A0 =C2=A0* DMA (thus cache coherency maintenance) requires t=
he
>> > + =C2=A0 =C2=A0* transfer buffers to live in their own cache lines=
=2E
>> > + =C2=A0 =C2=A0*/
>> > + =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__padalign[L1_CACHE_BYTES - sizeof(u16)];
>>
>> It would be better to use __cacheline_aligned, rather than open-codi=
ng
>> things in this manner.
>>
>
> OK, then I have the following which I will apply unless someone shout=
s.
>
> --
> Dmitry
>
> Input: ad7877 - keep dma rx buffers in seperate cache lines
>
> From: Oskar Schirmer <os@emlix.com>
>
> With dma based spi transmission, data corruption is observed
> occasionally. With dma buffers located right next to msg and
> xfer fields, cache lines correctly flushed in preparation for
> dma usage may be polluted again when writing to fields in the
> same cache line.
>
> Make sure cache fields used with dma do not share cache lines
> with fields changed during dma handling. As both fields are part
> of a struct that is allocated via kzalloc, thus cache aligned,
> moving the fields to the 1st position and insert padding for
> alignment does the job.
>
> Signed-off-by: Oskar Schirmer <os@emlix.com>
> Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
> Signed-off-by: Oliver Schneidewind <osw@emlix.com>
> Signed-off-by: Johannes Weiner <jw@emlix.com>
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> [dtor@mail.ru - changed to use ___cacheline_aligned at suggestion
> =C2=A0of akpm]
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =C2=A0drivers/input/touchscreen/ad7877.c | =C2=A0 15 ++++++++++++---
> =C2=A01 files changed, 12 insertions(+), 3 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touch=
screen/ad7877.c
> index e019d53..0d2d7e5 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -156,9 +156,14 @@ struct ser_req {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_on;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command;
> - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=A0msg=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xfer[6];
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA (thus cache coherency maintenance)=
 requires the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* transfer buffers to live in their own =
cache lines.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 u16 sample ____cacheline_aligned;
> =C2=A0};
>
> =C2=A0struct ad7877 {
> @@ -182,8 +187,6 @@ struct ad7877 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0averaging;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pen_down_acc_interval;
>
> - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 conversion_data[AD7877_NR_SENSE];
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xfer[AD7=
877_NR_SENSE + 2];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=A0msg=
;
>
> @@ -195,6 +198,12 @@ struct ad7877 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timer_list =C2=A0 =C2=A0 =C2=A0 tim=
er; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* P: lock */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pending:1; =C2=A0 =C2=A0 =C2=A0/* P: lock */
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA (thus cache coherency maintenance)=
 requires the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* transfer buffers to live in their own =
cache lines.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 u16 conversion_data[AD7877_NR_SENSE] ____cache=
line_aligned;
> =C2=A0};

i'm not sure this is correct.  the cached_aligned attribute makes sure
it starts on a cache boundary, but it doesnt make sure it pads out to
one.  so it might work more of the time, but i dont think it's
guaranteed.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
