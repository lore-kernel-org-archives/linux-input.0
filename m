From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH] Input: ad7879: support auxiliary
	GPIOs via gpiolib
Date: Thu, 7 Jan 2010 11:46:15 -0500
Message-ID: <8bd0f97a1001070846s26a98899sbb9c6caaffd57c68@mail.gmail.com>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org>
	<20100107073114.GC2314@core.coreip.homeip.net> <201001071116.19616.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:49689 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab0AGQqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 11:46:36 -0500
Received: by qyk30 with SMTP id 30so8467231qyk.33
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2010 08:46:35 -0800 (PST)
In-Reply-To: <201001071116.19616.rgetz@blackfin.uclinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jan 7, 2010 at 11:16, Robin Getz wrote:
> On Thu 7 Jan 2010 02:31, Dmitry Torokhov pondered:
>> On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrote:
>> > From: Michael Hennerich <michael.hennerich@analog.com>
>> >
>> > Drop the simple fancy sysfs hooks for the aux GPIOs and expose the=
se via
>> > the gpiolib interface so that other drivers can use them.
>>
>> Would not that mess up current users (if any) that may rely on the
>> existing sysfs attributes?
>
> We have talked =C2=A0to the existing users of this (that we know of),=
 and they
> agreed that doing things the "standard" way with gpiolib is the bette=
r way to
> move forward on things.

there is a standard sysfs interface for accessing gpios already too
which this change allows people to utilize
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
