From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] ad7877: keep dma rx buffers in seperate cache lines
Date: Fri, 7 May 2010 14:28:16 -0400
Message-ID: <w2w8bd0f97a1005071128o63fba35fl824cc997980fee03@mail.gmail.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
	<1273142265-11929-2-git-send-email-os@emlix.com> <g2j8bd0f97a1005061146l2b01e45do15bf46162e38ce84@mail.gmail.com>
	<20100507101544.GB25342@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:49920 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab0EGS2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 May 2010 14:28:38 -0400
In-Reply-To: <20100507101544.GB25342@emlix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskar Schirmer <os@emlix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>

On Fri, May 7, 2010 at 06:15, Oskar Schirmer wrote:
> On Thu, May 06, 2010 at 14:46:04 -0400, Mike Frysinger wrote:
>> On Thu, May 6, 2010 at 06:37, Oskar Schirmer wrote:
>> > =C2=A0struct ser_req {
>> > + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
>> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__padalign[L1_CACHE_BYTES - sizeof(u16)]=
;
>> > +
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_on;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command;
>> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=A0=
msg;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xfer[=
6];
>> > =C2=A0};
>>
>> are you sure this is necessary ? =C2=A0ser_req is only ever used wit=
h
>> spi_sync() and it's allocated/released on the fly, so how could
>> anything be reading that memory between the start of the transmissio=
n
>> and the return to adi7877 ?
>
> msg is handed over to spi_sync, it contains the addresses
> which will be used to programme the DMA: the spi master
> transfer function will read these fields to start DMA.

so the issue is coming from the SPI master drivers and not the AD7877 d=
river

>> > =C2=A0struct ad7877 {
>> > + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversion_data[AD7877_NR_SENSE];
>> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__padalign[L1_CACHE_BYTES
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - AD=
7877_NR_SENSE * sizeof(u16)];
>> > +
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*input;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys[32];
>> >
>> > @@ -182,8 +188,6 @@ struct ad7877 {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0averaging;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pen_down_acc_interval;
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversion_data[AD7877_NR_SENSE];
>> > -
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer =C2=A0 =C2=A0 xfer[=
AD7877_NR_SENSE + 2];
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message =C2=A0 =C2=A0 =C2=A0=
msg;
>>
>> i can see the spi_message inside of this struct being a problem
>> because the spi transfer is doing asynchronously with spi_async().
>> however, i would add a comment right above these two fields with a
>> short explanation as to why they're at the start and why the pad
>> exists so someone down the line doesnt move it.
>
> The code says "pad to align according to L1 cache, and
> keep away other stuff by exactly the amount so it is
> off the line". I'ld guess a comment would repeat just
> this, so it is superfluous. But if opinions differ on
> this topic, we can have a comment added, sure.

not everyone knows to read every single piece of documentation that
may or may not be affected implicitly in the call stack.  a simple
comment here is not superfluous.

since the other struct is also going to be changed, a comment should
be placed there as well.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
