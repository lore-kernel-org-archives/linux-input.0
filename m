From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: eGalax touchscreen regression
Date: Fri, 26 Apr 2013 18:09:05 +0300
Message-ID: <1366988945.3603.46.camel@sauron.fi.intel.com>
References: <1366708088.9823.16.camel@sauron.fi.intel.com>
	 <20130423154007.GB4104@core.coreip.homeip.net>
	 <1366794193.21369.11.camel@sauron.fi.intel.com>
	 <3076410.nE1Nu6ITeM@wuerfel>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3429 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3DZPGu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Apr 2013 11:06:50 -0400
In-Reply-To: <3076410.nE1Nu6ITeM@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hui Wang <jason77.wang@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hofemeier, Ulf" <ulf.hofemeier@intel.com>

On Fri, 2013-04-26 at 16:59 +0200, Arnd Bergmann wrote:
> On Wednesday 24 April 2013 12:03:13 Artem Bityutskiy wrote:
> > On Tue, 2013-04-23 at 08:40 -0700, Dmitry Torokhov wrote:
> > > > the eGalax driver now requires OF. For us this is a regression =
because
> > > > we do not have OF: https://bugs.tizen.org/jira/browse/TIVI-740
> > >=20
> > > I see. In this case we need to come up with a platform data to pa=
ss
> > > wakeup gpio in case platform does not support OF. irq_to_gpio() i=
s not
> > > supported on many platforms, causing compilation errors.
> > >=20
> > > Is the platform that you are trying to use the touchscreen upstre=
am?
> >=20
> > OK, so this is about just a monitor with a touchscreen (Giantec hig=
h-res
> > capacitive 11.6=E2=80=9D LCD monitor). The touchscreen is connected=
 to a
> > commodity hardware via USB.
> >=20
> > So yes, the platform _is_ upstream  Namely, we use just a SandyBrid=
ge
> > PC.
>=20
> So you use a usb-to-i2c interface?

I do not think so. The problem is that I do not have the HW, so I was
making guesses, and it looks like this driver has nothing to do with th=
e
regression we've got. Sorry for the noise. We'll investigate this more
carefully internally.

--=20
Best Regards,
Artem Bityutskiy

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
