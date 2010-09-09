From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2] Input: Make ADS7846 independent on regulator
Date: Thu, 9 Sep 2010 10:27:17 +0200
Message-ID: <201009091027.18176.marek.vasut@gmail.com>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com> <4C862EB3.4080006@compulab.co.il> <20100907125335.GD25830@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41842 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0III10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 04:27:26 -0400
In-Reply-To: <20100907125335.GD25830@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org

Dne =C3=9At 7. z=C3=A1=C5=99=C3=AD 2010 14:53:35 Mark Brown napsal(a):
> On Tue, Sep 07, 2010 at 03:23:15PM +0300, Igor Grinberg wrote:
> >  Seems that there are some more platforms then Sharp Zaurus
> >=20
> > are interested in this patch.
> >=20
> > Dmitry, Mike, Pavel,
> >=20
> > What's the status of it?
>=20
> From a regulator API usage point of view a separate implementation of
> the same thing was nacked - there are regulator API facilties for hid=
ing
> missing regulators from drivers when needed to get systems going, unl=
ess
> the device genuinely can cope without supplies it should be relying o=
n
> those.

Maybe these platforms should have been fixed prior to applying the patc=
h adding=20
regulator goo into ads7846 driver then. What's the way to go now then ?

Thanks, Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
