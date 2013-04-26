From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: eGalax touchscreen regression
Date: Fri, 26 Apr 2013 16:59:09 +0200
Message-ID: <3076410.nE1Nu6ITeM@wuerfel>
References: <1366708088.9823.16.camel@sauron.fi.intel.com> <20130423154007.GB4104@core.coreip.homeip.net> <1366794193.21369.11.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53652 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3DZO7K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Apr 2013 10:59:10 -0400
In-Reply-To: <1366794193.21369.11.camel@sauron.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: artem.bityutskiy@linux.intel.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hui Wang <jason77.wang@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hofemeier, Ulf" <ulf.hofemeier@intel.com>

On Wednesday 24 April 2013 12:03:13 Artem Bityutskiy wrote:
> On Tue, 2013-04-23 at 08:40 -0700, Dmitry Torokhov wrote:
> > > the eGalax driver now requires OF. For us this is a regression be=
cause
> > > we do not have OF: https://bugs.tizen.org/jira/browse/TIVI-740
> >=20
> > I see. In this case we need to come up with a platform data to pass
> > wakeup gpio in case platform does not support OF. irq_to_gpio() is =
not
> > supported on many platforms, causing compilation errors.
> >=20
> > Is the platform that you are trying to use the touchscreen upstream=
?
>=20
> OK, so this is about just a monitor with a touchscreen (Giantec high-=
res
> capacitive 11.6=E2=80=9D LCD monitor). The touchscreen is connected t=
o a
> commodity hardware via USB.
>=20
> So yes, the platform _is_ upstream  Namely, we use just a SandyBridge
> PC.

So you use a usb-to-i2c interface?

You have to figure out how the wakeup line is connected to the eGalax
device and provide an alternative implementation for egalax_wake_up_dev=
ice
that can be used in your case then.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
