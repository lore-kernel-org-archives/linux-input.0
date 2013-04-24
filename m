From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: eGalax touchscreen regression
Date: Wed, 24 Apr 2013 12:03:13 +0300
Message-ID: <1366794193.21369.11.camel@sauron.fi.intel.com>
References: <1366708088.9823.16.camel@sauron.fi.intel.com>
	 <20130423154007.GB4104@core.coreip.homeip.net>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130423154007.GB4104@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hui Wang <jason77.wang@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hofemeier, Ulf" <ulf.hofemeier@intel.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2013-04-23 at 08:40 -0700, Dmitry Torokhov wrote:
> > the eGalax driver now requires OF. For us this is a regression beca=
use
> > we do not have OF: https://bugs.tizen.org/jira/browse/TIVI-740
>=20
> I see. In this case we need to come up with a platform data to pass
> wakeup gpio in case platform does not support OF. irq_to_gpio() is no=
t
> supported on many platforms, causing compilation errors.
>=20
> Is the platform that you are trying to use the touchscreen upstream?

OK, so this is about just a monitor with a touchscreen (Giantec high-re=
s
capacitive 11.6=E2=80=9D LCD monitor). The touchscreen is connected to =
a
commodity hardware via USB.

So yes, the platform _is_ upstream :-) Namely, we use just a SandyBridg=
e
PC.

--=20
Best Regards,
Artem Bityutskiy
