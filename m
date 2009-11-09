From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Mon, 09 Nov 2009 17:09:04 +0200
Message-ID: <1257779344.21596.502.camel@localhost>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <20091028054317.GB2368@core.coreip.homeip.net>
	 <20091028105001.GB26199@esdhcp04058.research.nokia.com>
	 <20091104090628.GG31062@gw.healthdatacare.com>
	 <1257326759.21596.92.camel@localhost>
	 <20091106075220.GC11311@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58268 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZKIPJP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2009 10:09:15 -0500
In-Reply-To: <20091106075220.GC11311@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 2009-11-05 at 23:52 -0800, Dmitry Torokhov wrote:
> On Wed, Nov 04, 2009 at 11:25:59AM +0200, Artem Bityutskiy wrote:
> > > > > I think registering a full-blown device for every key is way =
too much,
> > > > > given that most consumers of gpio-keys driver are embedded...=
 Besides, I
> > > > > don't think this should be driven from userspace. Board (plat=
form) code
> > > > > should know what GPIO make sense as wake up sources for the p=
articular
> > > > > device and should set up platform data accordingly.
> >=20
> > For example, on N900 we want to disable the lens cover / proximity =
/ etc
> > gpios when the phones' screen is locked. Simply because we do not w=
ant
> > the lines to generate interrupts, wakes up the CPU and waste our ba=
ttery
> > energy. But we do not want to disable the screen lock gpio, and som=
e
> > incoming call related gpios.
> >=20
> > So we really do want this to be userspace-driven.
> >=20
>=20
> OK, then maybe we should use 2 attributes, one showing gpios that can
> be used for wakeup and one showing gpios that are currently set up as
> wakeup sources. These can be built on using bitmap_scnlistprintf() an=
d
> bitmap_parselist() and can work with either GPIO numbers or keycodes.

Hi Dmitry,

could you please elaborate some more?

* are you talking about per-input device sysfs files?
* could you please give an example of how would I switch off, say, the
  SW_CAMERA_LENS_COVER gpio by the keycode.
* why this should be sysfs and not a new ioctl?
* should this be something specific to gpio-keys or common for all
  devices?

Thanks.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
