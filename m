From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [patch 22/22] input: ads7846: introduce platform specific way to
	synchronize sampling
Date: Fri, 13 Mar 2009 10:50:27 +0800
Message-ID: <f17812d70903121950h768fb7d0t234e040f34656f0c@mail.gmail.com>
References: <200903041959.n24JxDIQ028495@imap1.linux-foundation.org>
	 <20090313023400.GA16163@dtor-d630.eng.vmware.com>
	 <F71A24FDAED97E4CB6D3A8E8A97D5C544A38E1D6@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:8221 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbZCMCu3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2009 22:50:29 -0400
Received: by rv-out-0506.google.com with SMTP id g37so129702rvb.1
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2009 19:50:28 -0700 (PDT)
In-Reply-To: <F71A24FDAED97E4CB6D3A8E8A97D5C544A38E1D6@SC-VEXCH1.marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <ymiao3@marvell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>

2009/3/13 Eric Miao <ymiao3@marvell.com>:
>
>
>> -----Original Message-----
>> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> Sent: 2009=E5=B9=B43=E6=9C=8813=E6=97=A5 10:34
>> To: akpm@linux-foundation.org
>> Cc: linux-input@vger.kernel.org; Eric Miao; david-b@pacbell.net
>> Subject: Re: [patch 22/22] input: ads7846: introduce platform specif=
ic way
>> to synchronize sampling
>>
>> Hi,
>>
>> On Wed, Mar 04, 2009 at 11:59:13AM -0800, akpm@linux-foundation.org =
wrote:
>> > From: Eric Miao <eric.miao@marvell.com>
>> >
>> > Noises can be introduced when LCD signals are being driven, some p=
latforms
>> > provide a signal to assist the synchronization of this sampling pr=
ocedure.
>> >
>> > Signed-off-by: Eric Miao <eric.miao@marvell.com>
>> > Cc: David Brownell <david-b@pacbell.net>
>> > Cc: Dmitry Torokhov <dtor@mail.ru>
>> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> > ---
>> >
>> > =C2=A0drivers/input/touchscreen/ads7846.c | =C2=A0 10 ++++++++++
>> > =C2=A0include/linux/spi/ads7846.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 ++
>> > =C2=A02 files changed, 12 insertions(+)
>> >
>> > diff -puN drivers/input/touchscreen/ads7846.c~input-ads7846-introd=
uce-
>> platform-specific-way-to-synchronize-sampling
>> drivers/input/touchscreen/ads7846.c
>> > --- a/drivers/input/touchscreen/ads7846.c~input-ads7846-introduce-
>> platform-specific-way-to-synchronize-sampling
>> > +++ a/drivers/input/touchscreen/ads7846.c
>> > @@ -127,6 +127,8 @@ struct ads7846 {
>> > =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*filter_cleanup)(void *data);
>> > =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*get_pendown_state)(void);
>> > =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_pendown;
>> > +
>> > + =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(*wait_for_sync)(void);
>> > =C2=A0};
>> >
>> > =C2=A0/* leave chip selected when we're done, for quicker re-selec=
t? */
>> > @@ -511,6 +513,10 @@ static int get_pendown_state(struct ads7
>> > =C2=A0 =C2=A0 =C2=A0 return !gpio_get_value(ts->gpio_pendown);
>> > =C2=A0}
>> >
>> > +static void null_wait_for_sync(void)
>> > +{
>> > +}
>> > +
>> > =C2=A0/*
>> > =C2=A0 * PENIRQ only kicks the timer. =C2=A0The timer only reissue=
s the SPI transfer,
>> > =C2=A0 * to retrieve touchscreen status.
>> > @@ -686,6 +692,7 @@ static void ads7846_rx_val(void *ads)
>> > =C2=A0 =C2=A0 =C2=A0 default:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
>> > =C2=A0 =C2=A0 =C2=A0 }
>> > + =C2=A0 =C2=A0 ts->wait_for_sync();
>> > =C2=A0 =C2=A0 =C2=A0 status =3D spi_async(ts->spi, m);
>> > =C2=A0 =C2=A0 =C2=A0 if (status)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&ts->spi-=
>dev, "spi_async --> %d\n",
>> > @@ -723,6 +730,7 @@ static enum hrtimer_restart ads7846_time
>> > =C2=A0 =C2=A0 =C2=A0 } else {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pen is still d=
own, continue with the measurement */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->msg_idx =3D 0=
;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->wait_for_sync();
>>
>> We are in hard IRQ context here. What is the expectation of
>> wait_for_sync()? How long are we waiting here?
>>
>
> This should be a workaround for broken hardware and I don't expect
> this sync time on every boards.
>

The sync time depends on the moment of this sync between two HSYNC,
I don't expect that to be very long, yet the hardware is broken enough =
to
endure this latency.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
