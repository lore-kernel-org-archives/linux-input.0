From: Nelson Castillo <arhuaco@freaks-unidos.net>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
Date: Fri, 23 Oct 2009 00:38:26 -0500
Message-ID: <2accc2ff0910222238g31161deoe704a889df3c4b3a@mail.gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com> <20091019120744.GB7412@n2100.arm.linux.org.uk>
	<2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
	<20091020073946.GB723@n2100.arm.linux.org.uk> <2accc2ff0910200121g4f2c0839l96c7d99e4f4de47a@mail.gmail.com>
	<20091020094132.GA17240@sirena.org.uk>
Reply-To: arhuaco@freaks-unidos.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:44790 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZJWFil convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2009 01:38:41 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1306918qwb.37
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2009 22:38:46 -0700 (PDT)
In-Reply-To: <20091020094132.GA17240@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, dtor@mail.ru, Shine Liu <shinel@foxmail.com>, dmitry.torokhov@gmail.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 20, 2009 at 4:41 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 20, 2009 at 03:21:17AM -0500, Nelson Castillo wrote:
>
>> Can the s3c driver send the events at full speed? (Maximum possible =
ADC rate?).

Yes, but in packets I think (The way I would know how to implement it).
We could try sending 2000 events per second to user-space and see what
happens :-) :-)

>> Even if it's possible I think we would monopolize the adc driver
>> needlessly because we don't need all that conversions when there is
>> not much noise. Please read on.
>
> There's currently no facility to push sample rate requests down into =
the
> kernel from userspace. =A0However, this is a good idea in general - t=
here
> was some recent (brief) discussion of doing this on the linux-input l=
ist.

I see. It makes sense.

ATM one big difference with the kernel approach is that in the kernel
you can request the adc conversions on demand.

> Since different use cases have different sample rate requirements (su=
ch
> as the difference between handwriting recognition which can need 200
> samples/second and a simple finger operated menu which may be happy w=
ith
> 10) there's value in being able to vary the sample rate at run time. =
=A0I
> was intending to look at this shortly as part of some touchscreen dri=
ver
> development I need to do soon or perhaps someone else will pick up th=
e
> idea, if it does get implemented then obviously tslib would also be a=
ble
> to use it here.

With a lot more points you can indeed do better filtering in users-pace=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
