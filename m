From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 11:50:31 -0800
Message-ID: <20101203195030.GB21277@core.coreip.homeip.net>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
 <20101203124240.GH3182@sirena.org.uk>
 <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
 <20101203135346.GI3182@sirena.org.uk>
 <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:47668 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0LCT47 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 14:56:59 -0500
Received: by gxk19 with SMTP id 19so5281982gxk.11
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 11:56:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 11:36:50AM -0600, Bill Gatliff wrote:
> Mark:
>=20
>=20
> On Fri, Dec 3, 2010 at 7:53 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> >
> > Surely that's what poll() and whatnot are for? =A0If userspace has =
to poll
> > at all that seems to be a failure in itself.
>=20
> The poll() and blocking read() system calls allow an application to
> tell an input device that it is prepared to receive an event, and for
> an input device driver to tell userspace when an event has occurred.
> As implemented in evdev, however, neither system call provides a
> natural, consistent way for userspace to tell an input device driver
> how often it wants data--- or even if it wants any (at the moment) at
> all.

Right. The indication that application wants the data is open() call. I=
f
userspace does not want data, it should close() the interface.

Drivers have no idea what users want to do with the data so they can't
decide whether to ignore the hardware or query it and queue events up.
Some applications might be interested in "sample on demand", while
others would prefer events to be queued and consumed at once.

[... cut long argument for an inconsistent and incompatible change to
the interface ...]

BTW, if application reads (supplies space for) just one event should we
disacard the rest of hardware state that we read from the device? You
know, just asking...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
