From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 14:29:02 -0400
Message-ID: <20150319182902.GA19505@mail.corp.redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
 <20150319152526.GA3651@balvenie>
 <20150319155830.GB18134@mail.corp.redhat.com>
 <20150319164746.GA1648@balvenie>
 <20150319170649.GE18134@mail.corp.redhat.com>
 <20150319174359.GK30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbbCSS3P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 14:29:15 -0400
Content-Disposition: inline
In-Reply-To: <20150319174359.GK30732@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 19 2015 or thereabouts, Dmitry Torokhov wrote:
> On Thu, Mar 19, 2015 at 01:06:49PM -0400, Benjamin Tissoires wrote:
> > On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > > On Thu, Mar 19, 2015 at 11:58:31AM -0400, Benjamin Tissoires wrot=
e:
> > > > On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > > > Again, sorry, I thought I answered it. With the kernel patches =
applied:
> > > > - disabled in the bios without psmouse.proto=3Dimps -> touchpad=
 still
> > > >   enabled, trackstick + buttons working
> > > > - disabling in the bios + psmouse.proto=3Dimps -> touchpad disa=
bled,
> > > >   trackstick + buttons working
> > > > - enabled in the bios + psmouse.proto=3Dimps -> touchpad barely=
 usable,
> > > >   trackstick + buttons working
> > > >=20
> > > > That should cover all the cases :)
> > > >=20
> > > Actually, one is missing: =E2=80=9Ctouchpad enabled / without
> > > psmouse.proto=3Dimps=E2=80=9D, but it doesn't really matter for m=
e since I'm not
> > > using the touchpad anyway.
> >=20
> > Yes, but that is the most used case, and if this one was not workin=
g
> > then the patch series would have been moot :)
> >=20
> > >=20
> > > But that also means if I want a disabled touchpad (without using =
xinput
> > > disable) I'm forced to use psmouse.proto=3Dimps. It does work fin=
e but I
> > > then lose the speed and sensitivity attributes (in
> > > /sys/devices/platform/i8042/...) and the Trackpoint device itself=
 is
> > > gone from the input subsystem (everything goes to the touchpad on=
e).
> > >=20
> > > I find that a bit confusing, and think it'd be best if the touchp=
ad
> > > disabling could be handled even when IMPS/2 is not used, but mayb=
e it's
> > > impossible to do?
>=20
> It is possible, but that task is on Lenovo's BIOS engineers to
> implement. The kernel queries the device and responds accordingly; th=
ere
> is no separate "check BIOS settings" pass. "proto=3Dimps" simply tell=
s
> psmouse driver to skip the advanced protocol "magic knocks" and try
> initalize mouse as MS Intellimouse compatible device.
>=20
> I'd be curious to compare i8042 data (i8042.debug) from booting with
> both proto=3Dimps and without (note that keystrokes for your password=
 will
> be recorded there if you decide to post the logs), but again just for
> curiosity's sake as I wonder how exactly they done disabling that it
> only works for Intellimouse mode.
>=20

There you go:
http://people.freedesktop.org/~tissoire/boot_bios_disabled_with_imps.tx=
t
http://people.freedesktop.org/~tissoire/boot_bios_disabled_no_imps.txt

An no, there is no trace of my password on this, I carefully ssh to the
box to extract the logs :)

Cheers,
Benjamin

> Thanks.
>=20
> --=20
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
