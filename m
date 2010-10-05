From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2] Input: Make ADS7846 independent on regulator
Date: Tue, 5 Oct 2010 10:21:30 +0200
Message-ID: <201010051021.30496.marek.vasut@gmail.com>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com> <20100909094120.GB1988@rakim.wolfsonmicro.main> <4CAACA63.6090202@compulab.co.il>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35059 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924Ab0JEIVi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 04:21:38 -0400
In-Reply-To: <4CAACA63.6090202@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org

Dne =C3=9At 5. =C5=99=C3=ADjna 2010 08:49:07 Igor Grinberg napsal(a):
>  On 09/09/10 12:41, Mark Brown wrote:
> > On Thu, Sep 09, 2010 at 10:27:17AM +0200, Marek Vasut wrote:
> >> Dne =C3=9At 7. z=C3=A1=C5=99=C3=AD 2010 14:53:35 Mark Brown napsal=
(a):
> >>> From a regulator API usage point of view a separate implementatio=
n of
> >>> the same thing was nacked - there are regulator API facilties for
> >>> hiding missing regulators from drivers when needed to get systems
> >>> going, unless the device genuinely can cope without supplies it s=
hould
> >>> be relying on those.
>=20
> I actually, don't see why ads7846 is strictly relying on the regulato=
r
> and I don't understand, why ads7846 driver has to bail out if the reg=
ulator
> is not found? Why shouldn't the driver try to continue?
> I think it should bail out only in case communicating with the device
> failed.

Well, I can't but agree ... it's unnecessary crud indeed.
>=20
> >> Maybe these platforms should have been fixed prior to applying the=
 patch
> >> adding regulator goo into ads7846 driver then. What's the way to g=
o now
> >> then ?
> >=20
> > Fix the platforms and use the dummy regulators to keep them going u=
ntil
> > that happens.  It's trivial to do the hookup in the platforms.
>=20
> You want each platform, that does not have a special regulated power =
supply
> for the ads7846, to define a dummy regulator just to cope with that
> artificial dependency of the device driver?

You can enable some option in the regulator stuff that automagically sh=
oves in a=20
dummy regulator, but it's still additional crud.

> I think it is a waste and big code duplication in each platform
> that does not have that special regulator.

Indeed
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
