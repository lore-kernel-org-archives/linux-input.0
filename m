From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [patch 22/22] input: ads7846: introduce platform specific way to
	synchronize sampling
Date: Sat, 14 Mar 2009 11:41:58 +0800
Message-ID: <f17812d70903132041u5df5d6f7u9cc9577d2dc95a60@mail.gmail.com>
References: <200903041959.n24JxDIQ028495@imap1.linux-foundation.org>
	 <F71A24FDAED97E4CB6D3A8E8A97D5C544A38E1D6@SC-VEXCH1.marvell.com>
	 <f17812d70903121950h768fb7d0t234e040f34656f0c@mail.gmail.com>
	 <200903131809.40400.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:59990 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZCNDmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Mar 2009 23:42:00 -0400
Received: by rv-out-0506.google.com with SMTP id g37so689063rvb.1
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2009 20:41:58 -0700 (PDT)
In-Reply-To: <200903131809.40400.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Eric Miao <ymiao3@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, Mar 14, 2009 at 9:09 AM, David Brownell <david-b@pacbell.net> w=
rote:
> On Thursday 12 March 2009, Eric Miao wrote:
>> >
>> > This should be a workaround for broken hardware and I don't expect
>> > this sync time on every boards.
>> >
>>
>> The sync time depends on the moment of this sync between two HSYNC,
>> I don't expect that to be very long,
>
> But how long is that? =C2=A01/(50 KHz) or so?
>

=46or Sharp Zaurus, let's say a poodle, with PXA255 and QVGA LCD
portrait, a typical of 320 lines per frame (although counting in blank
VSYNC will make this a bit larger), and 60Hz frame refresh rate:

1 HSYNC =3D 1/(60Hz * 320) =3D 52.08us

An average sync time would be half of this, say, 26us.

Having another interrupt to trigger the sampling will be a bit
trickier and considering this average of 26us on a 400MHz
PXA255, and another interrupt latency, I don't see too much
benefit of doing that.

And my personal feeling of the final result with the GUI seems
quite responsive, though I didn't stress test that.

>
>> yet the hardware is broken enough to
>> endure this latency.
>
> Actually I heard from someone else this morning that it's not just
> "broken" hardware that sees touchscreen ADC sampling noise related
> to hsync. =C2=A0So this patch makes sense ... although there's no way=
 to
> guarantee the SPI requests won't have queueing delays before they
> arrive at the touchscreen controller, possibly hitting the next
> hsync interval.
>
> It seems that it's surprisingly tricky to get clean samples from
> touchscreens. =C2=A0There's physical oscillation to compensate, which
> changes capacitance until it damps down. =C2=A0There's also electrica=
l
> oscillation from charging the various sense lines. =C2=A0Add to that =
a
> bunch of honest-to-goodness noise associated with hsync and vsync...
> yeech! =C2=A0It would be a Good Thing if someone were to split out th=
e
> sample filtering logic from this driver so it could be used with
> other touchscreen drivers.
>

Yes, sample filtering can actually be made input device wise.

There are actually some user-land solution to this, e.g. tslib.
Yet this sync issue seems annoyingly unavoidable even with
a fine grained filter, or maybe I didn't try my best to tweak those
filters to a maximum potential yet, and I gave up on that finally.

> - Dave
>
>



--=20
Cheers
- eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
