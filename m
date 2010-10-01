From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2] Input: Make ADS7846 independent on regulator
Date: Fri, 1 Oct 2010 02:20:38 +0200
Message-ID: <201010010220.38321.marek.vasut@gmail.com>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com> <201009091027.18176.marek.vasut@gmail.com> <20100909094120.GB1988@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33015 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0JAAUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Sep 2010 20:20:43 -0400
In-Reply-To: <20100909094120.GB1988@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org

Dne =C4=8Ct 9. z=C3=A1=C5=99=C3=AD 2010 11:41:20 Mark Brown napsal(a):
> On Thu, Sep 09, 2010 at 10:27:17AM +0200, Marek Vasut wrote:
> > Dne =C3=9At 7. z=C3=A1=C5=99=C3=AD 2010 14:53:35 Mark Brown napsal(=
a):
> > > From a regulator API usage point of view a separate implementatio=
n of
> > > the same thing was nacked - there are regulator API facilties for
> > > hiding missing regulators from drivers when needed to get systems
> > > going, unless the device genuinely can cope without supplies it s=
hould
> > > be relying on those.
> >=20
> > Maybe these platforms should have been fixed prior to applying the =
patch
> > adding regulator goo into ads7846 driver then. What's the way to go=
 now
> > then ?
>=20
> Fix the platforms and use the dummy regulators to keep them going unt=
il
> that happens.  It's trivial to do the hookup in the platforms.

Igor, any update on this?

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
