From: Nelson Castillo <arhuaco@freaks-unidos.net>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
Date: Tue, 20 Oct 2009 03:21:17 -0500
Message-ID: <2accc2ff0910200121g4f2c0839l96c7d99e4f4de47a@mail.gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com> <20091019120744.GB7412@n2100.arm.linux.org.uk>
	<2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
	<20091020073946.GB723@n2100.arm.linux.org.uk>
Reply-To: arhuaco@freaks-unidos.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:43641 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbZJTIVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 04:21:34 -0400
Received: by qyk32 with SMTP id 32so3772259qyk.4
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2009 01:21:39 -0700 (PDT)
In-Reply-To: <20091020073946.GB723@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, Shine Liu <shinel@foxmail.com>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tue, Oct 20, 2009 at 2:39 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 19, 2009 at 11:21:40PM -0500, Nelson Castillo wrote:
>> There is one case where "whatever way" fails here. If you get a set =
of
>> points and you notice they have noise you can schedule more
>> conversions _right_away_ without latency to get new points from the
>> ADC. That's what the "group filter" does and you can not do that fro=
m
>> tslib and I say it after learning how to write tslib filters.
>
> In which case people aren't implementing their kernel drivers correct=
ly.
> The kernel is supposed to produce a stream of samples when the pen is
> touched, and those samples should be delivered to tslib. =A0tslib's f=
ilters
> then has the responsibility to read groups of samples, and filter the=
m
> using whatever method that the user wants.

The group filter (that mixes information from X and Y) could be ported
to user-space but we would need points at a much higher rate.

Can the s3c driver send the events at full speed? (Maximum possible ADC=
 rate?).

Even if it's possible I think we would monopolize the adc driver
needlessly because we don't need all that conversions when there is
not much noise. Please read on.

> I also don't buy your comparison on your web page since there's almos=
t
> zero details of what you're comparing. =A0You don't give details of w=
hat
> filters you're using with the userspace method - for all the reader
> knows, you're not using tslib at all.

Blame lack of time.

Most of the time tslib filtering worked well when we have good pressure=
=2E

We have problems when we don't have much pressure and in this case
there is a lot of noise and the events that are reported by the driver
are actually noise. This noise would be more common at pen-down before
the adc readings settle and at pen-up.

This is the noise we filtered in most cases.

I remember I wrote a tslib filter to skip the N first and the M last
points but it was not enough.

http://svn.arhuaco.org/svn/src/openmoko/touchscreen/tslib-skip_module.p=
atch

I should report some data here so that you can see how bad the noise
problem is. It might be a hardware problem. I've heard of other boards
that also have a lot of noise.

I did read this message last month in tslib:

https://lists.berlios.de/pipermail/tslib-general/2009-September/000228.=
html

  I've taken the tack that we when we use the resistive
  sensors we have to take sloppy positioning and mis-clicks
  into the user interface design.

Really? We managed to fix a similar problem. Perhaps it can also be
fixed with tslib but we tried and we could not. This was the last
message in the thread so I took it as a conclusion.

>> Most people who hear about the filters blindly say "this should be
>> done in user-space" without considering this fact.
>
> I'm the original author of tslib. =A0Don't think for a moment that I =
haven't
> any experience in this area.

I already knew, and I know, I know :-)

Perhaps I need to replace talk with data but I don't really feel like
doing it now. I could do it later.

If everyone solves the noise problem in resistive touchscreens with
tslib then there is no need for in-kernel filtering. But then I see
the reply I quoted from the tslib ML where it is stated that one has
to learn to live with the "sloppy positioning and mis-clicks". I don't
think this is acceptable if there is a solution.

As you wrote before it will not work in all cases, but I've seen it's
working for a few s3c-based projects.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
