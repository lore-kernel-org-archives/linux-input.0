From: Nelson Castillo <arhuaco@freaks-unidos.net>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
Date: Mon, 19 Oct 2009 23:21:40 -0500
Message-ID: <2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com> <20091019120744.GB7412@n2100.arm.linux.org.uk>
Reply-To: arhuaco@freaks-unidos.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:41179 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZJTEVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 00:21:55 -0400
Received: by qyk32 with SMTP id 32so3683320qyk.4
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2009 21:22:00 -0700 (PDT)
In-Reply-To: <20091019120744.GB7412@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, Shine Liu <shinel@foxmail.com>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Oct 19, 2009 at 7:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 19, 2009 at 01:28:13PM +0200, Maurus Cuelenaere wrote:
>> Do you know that there's another patch (at Openmoko) created by Nels=
on
>> Castillo that does the same, but also has support for kernel-space
>> touchscreen filters? (I think [1] is his latest version)
>> I don't know how your patch performs, but according to [2] the filte=
rs
>> should help a lot avoiding jitter etc.
>> I'm not sure whether Nelson has submitted his patches for mainline
>> review yet and what the status is on the kernel filters, but IMHO do=
ing
>> some filtering in kernel space (see the "Why are we doing filtering =
in
>> kernel space?" part of [2]) which results in a "cleaner" output is
>> preferred over reporting possible "jittery" data.

I did submit the filter stuff once and I applied ALL the upstream
feedback we got from Andrew M.

> It doesn't really describe why doing the filtering in kernel space is
> apparantly soo much better than doing it in tslib - it's seems to jus=
t
> do some handwaving kind of argument:

Some drivers do some kind of filtering. Even the other one for this
chip submitted to linux-arm-kernel a few days ago.

> =A0 Let's say we would like to deliver a TS event to user space each =
10
> =A0 milliseconds. In the GTA02 with the current configuration the
> =A0 Analog/Digital conversion time of a sample is 0.4697 milliseconds=
, thus
> =A0 can get 18 samples for each event that we send to user-space. Sen=
ding the
> =A0 event (with 18 samples) takes us about 8.45 milliseconds.
>
> So far so good. =A0But, according to my maths, 8.45ms is less than 10=
ms.

In practice the event is generated each 10ms because of the jiffies
resolution and the use of a timer but this might not be true if
someone uses the filters with a different driver/configuration.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Sometimes we
> =A0 even decide that the event should not be sent to user-space (beca=
use the
> =A0 hardware didn't provide reliable data), and our tests show that i=
t's the
> =A0 right thing to do. In previous versions of the driver light taps =
would
> =A0 confuse the driver (that would report bad clicks) and this is no =
longer an
> =A0 issue.
>
> Err, that doesn't seem to follow on from the previous point.
>
> The reason that we decided raw events should be passed to userspace a=
nd
> the processing done there is that it allows all of the _policy_ of
> deciding how to process touchscreen events to be configured. =A0There=
's
> lots of different parameters and ways to filter touchscreens, and som=
e
> are specific to individual touchscreen setups.

Yes, ignoring the event might not be the best thing to do if this is a =
policy.

"Giving up" could be implemented as sending a point of bad quality
instead of ignoring the event. It's better to implement "I give up
trying to get a better point for you" instead of "I driver decide you
should never know someone touched the screen because it was all
noise".

> This is why tslib is entirely modular, and allows any combination of
> modules to be loaded to process the touchscreen samples - it's there
> to provide a totally flexible infrastructure to filter and scale
> the output from the touchscreen in whatever way is required for the
> hardware.

There is one case where "whatever way" fails here. If you get a set of
points and you notice they have noise you can schedule more
conversions _right_away_ without latency to get new points from the
ADC. That's what the "group filter" does and you can not do that from
tslib and I say it after learning how to write tslib filters.

Most people who hear about the filters blindly say "this should be
done in user-space" without considering this fact.

> I don't think there is any single filtering system which can properly
> filter the output of any one touchscreen, and I don't think that putt=
ing
> this filtering in the kernel is a sane approach. =A0It _may_ be a san=
e
> approach for one particular touchscreen setup, but it certainly isn't
> for all.

I've found the filters to be useful and I would like to see them
upstream but not if people don't find them to be useful.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
