From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2] Input: Make ADS7846 independent on regulator
Date: Tue, 05 Oct 2010 08:49:07 +0200
Message-ID: <4CAACA63.6090202@compulab.co.il>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com> <4C862EB3.4080006@compulab.co.il> <20100907125335.GD25830@sirena.org.uk> <201009091027.18176.marek.vasut@gmail.com> <20100909094120.GB1988@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:34003 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab0JEGtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 02:49:22 -0400
In-Reply-To: <20100909094120.GB1988@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org

 On 09/09/10 12:41, Mark Brown wrote:
> On Thu, Sep 09, 2010 at 10:27:17AM +0200, Marek Vasut wrote:
>> Dne =C3=9At 7. z=C3=A1=C5=99=C3=AD 2010 14:53:35 Mark Brown napsal(a=
):
>>> From a regulator API usage point of view a separate implementation =
of
>>> the same thing was nacked - there are regulator API facilties for h=
iding
>>> missing regulators from drivers when needed to get systems going, u=
nless
>>> the device genuinely can cope without supplies it should be relying=
 on
>>> those.

I actually, don't see why ads7846 is strictly relying on the regulator
and I don't understand, why ads7846 driver has to bail out if the regul=
ator
is not found? Why shouldn't the driver try to continue?
I think it should bail out only in case communicating with the device f=
ailed.

>> Maybe these platforms should have been fixed prior to applying the p=
atch adding=20
>> regulator goo into ads7846 driver then. What's the way to go now the=
n ?
> Fix the platforms and use the dummy regulators to keep them going unt=
il
> that happens.  It's trivial to do the hookup in the platforms.

You want each platform, that does not have a special regulated power su=
pply
for the ads7846, to define a dummy regulator just to cope with that art=
ificial
dependency of the device driver?
I think it is a waste and big code duplication in each platform
that does not have that special regulator.

--=20
Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
