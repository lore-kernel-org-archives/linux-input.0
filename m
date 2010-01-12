From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Tue, 12 Jan 2010 13:57:15 +0000
Message-ID: <8A42379416420646B9BFAC9682273B6D0F0DEC9F@limkexm3.ad.analog.com>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org> <8bd0f97a1001070846s26a98899sbb9c6caaffd57c68@mail.gmail.com> <20100107170707.GA3439@core.coreip.homeip.net> <201001071243.41191.rgetz@blackfin.uclinux.org> <20100110074826.GA16057@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:19257 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0ALN5T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 08:57:19 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <20100110074826.GA16057@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>On Thu, Jan 07, 2010 at 12:43:41PM -0500, Robin Getz wrote:
>> On Thu 7 Jan 2010 12:07, Dmitry Torokhov pondered:
>> > On Thu, Jan 07, 2010 at 11:46:15AM -0500, Mike Frysinger wrote:
>> > > On Thu, Jan 7, 2010 at 11:16, Robin Getz wrote:
>> > > > On Thu 7 Jan 2010 02:31, Dmitry Torokhov pondered:
>> > > >> On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrot=
e:
>> > > >> > From: Michael Hennerich <michael.hennerich@analog.com>
>> > > >> >
>> > > >> > Drop the simple fancy sysfs hooks for the aux GPIOs and
>expose these
>> via
>> > > >> > the gpiolib interface so that other drivers can use them.
>> > > >>
>> > > >> Would not that mess up current users (if any) that may rely o=
n
>the
>> > > >> existing sysfs attributes?
>> > > >
>> > > > We have talked =A0to the existing users of this (that we know =
of),
>and
>> they
>> > > > agreed that doing things the "standard" way with gpiolib is th=
e
>better
>> way to
>> > > > move forward on things.
>> > >
>> > > there is a standard sysfs interface for accessing gpios already
>too
>> > > which this change allows people to utilize
>> >
>> > Using (and providing) standard interfaces are laudible goal, howev=
er
>> > that does not mean we can screw existing users over. Now Robin sai=
s
>that
>> > you talked to users (at least some) and this being an embedded
>platform
>> > taht might be OK but generally sysfs is userspace interface and th=
us
>are
>> > not to be changed lightly, only extended.
>>
>> I agree - but in this case - the driver in question has only been in
>mainline
>> a few kernel versions (since March'09).
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-
>2.6.git;a=3Dhistory;f=3Ddrivers/input/touchscreen/ad7879.c;hb=3DHEAD
>>
>> And the only feedback we have gotten was to make this change - so
>people could
>> use the gpio in other drivers more than requests about userspace...
>>
>
>OK, fair enough. ANd to limit exposure we probably want to get it into
>.33... So is there an updated version of the patch coming (addressing
>missing gpiochip_remove)?

We're going to send an updated patch shortly.

Thanks and best regards,
Michael
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
