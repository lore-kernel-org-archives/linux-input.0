From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Wed, 04 Nov 2009 11:25:59 +0200
Message-ID: <1257326759.21596.92.camel@localhost>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <20091028054317.GB2368@core.coreip.homeip.net>
	 <20091028105001.GB26199@esdhcp04058.research.nokia.com>
	 <20091104090628.GG31062@gw.healthdatacare.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20465 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbZKDJ0L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2009 04:26:11 -0500
In-Reply-To: <20091104090628.GG31062@gw.healthdatacare.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: dmitry.torokhov@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 2009-11-04 at 11:06 +0200, Mika Westerberg wrote:
> On Wed, Oct 28, 2009 at 12:50:01PM +0200, Mika Westerberg wrote:
> > Hi,
> >=20
> > On Wed, Oct 28, 2009 at 06:43:17AM +0100, ext Dmitry Torokhov wrote=
:
> > >=20
> > > On Fri, Oct 23, 2009 at 03:15:46PM +0300, Mika Westerberg wrote:
> > > > From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > > >=20
> > > > In some embedded devices gpio lines are used as keys/buttons
> > > > through input layer and gpio-keys.  It is, however, impossible
> > > > to disable gpio lines separately from waking up the cpu.  For
> > > > example when device is locked we don't want accidental camera
> > > > button press to cause the device to wakeup just to notice that
> > > > it should continue sleeping.
> > > >=20
> > > > This patch exports gpio-keys through sysfs and allows userland
> > > > to control whether single gpio line should wakeup the cpu or no=
t.
> > > >=20
> > > > Sysfs interface is accessible via:
> > > >=20
> > > > 	/sys/class/input/gpio-keys/input/input0/gpio-key.N/
> > > >=20
> > > > Following attributes are exported per gpio key:
> > > >=20
> > > > 	/code    ... input event code (ro)
> > > > 	/type    ... input event type (ro)
> > > > 	/desc    ... description of the button (ro)
> > > > 	/disable ... enable/disable gpio line (rw)
> > > >=20
> > > > Userspace should be able to find out what key to disable/enable
> > > > by investigating {code, type, desc} tuple.
> > > >=20
> > >=20
> > > I think registering a full-blown device for every key is way too =
much,
> > > given that most consumers of gpio-keys driver are embedded... Bes=
ides, I
> > > don't think this should be driven from userspace. Board (platform=
) code
> > > should know what GPIO make sense as wake up sources for the parti=
cular
> > > device and should set up platform data accordingly.

=46or example, on N900 we want to disable the lens cover / proximity / =
etc
gpios when the phones' screen is locked. Simply because we do not want
the lines to generate interrupts, wakes up the CPU and waste our batter=
y
energy. But we do not want to disable the screen lock gpio, and some
incoming call related gpios.

So we really do want this to be userspace-driven.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
