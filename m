From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 10:43:59 -0700
Message-ID: <20150319174359.GK30732@dtor-ws>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
 <20150319152526.GA3651@balvenie>
 <20150319155830.GB18134@mail.corp.redhat.com>
 <20150319164746.GA1648@balvenie>
 <20150319170649.GE18134@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150319170649.GE18134@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 19, 2015 at 01:06:49PM -0400, Benjamin Tissoires wrote:
> On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > On Thu, Mar 19, 2015 at 11:58:31AM -0400, Benjamin Tissoires wrote:
> > > On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > > Again, sorry, I thought I answered it. With the kernel patches ap=
plied:
> > > - disabled in the bios without psmouse.proto=3Dimps -> touchpad s=
till
> > >   enabled, trackstick + buttons working
> > > - disabling in the bios + psmouse.proto=3Dimps -> touchpad disabl=
ed,
> > >   trackstick + buttons working
> > > - enabled in the bios + psmouse.proto=3Dimps -> touchpad barely u=
sable,
> > >   trackstick + buttons working
> > >=20
> > > That should cover all the cases :)
> > >=20
> > Actually, one is missing: =E2=80=9Ctouchpad enabled / without
> > psmouse.proto=3Dimps=E2=80=9D, but it doesn't really matter for me =
since I'm not
> > using the touchpad anyway.
>=20
> Yes, but that is the most used case, and if this one was not working
> then the patch series would have been moot :)
>=20
> >=20
> > But that also means if I want a disabled touchpad (without using xi=
nput
> > disable) I'm forced to use psmouse.proto=3Dimps. It does work fine =
but I
> > then lose the speed and sensitivity attributes (in
> > /sys/devices/platform/i8042/...) and the Trackpoint device itself i=
s
> > gone from the input subsystem (everything goes to the touchpad one)=
=2E
> >=20
> > I find that a bit confusing, and think it'd be best if the touchpad
> > disabling could be handled even when IMPS/2 is not used, but maybe =
it's
> > impossible to do?

It is possible, but that task is on Lenovo's BIOS engineers to
implement. The kernel queries the device and responds accordingly; ther=
e
is no separate "check BIOS settings" pass. "proto=3Dimps" simply tells
psmouse driver to skip the advanced protocol "magic knocks" and try
initalize mouse as MS Intellimouse compatible device.

I'd be curious to compare i8042 data (i8042.debug) from booting with
both proto=3Dimps and without (note that keystrokes for your password w=
ill
be recorded there if you decide to post the logs), but again just for
curiosity's sake as I wonder how exactly they done disabling that it
only works for Intellimouse mode.

Thanks.

--=20
Dmitry
