From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 13:06:49 -0400
Message-ID: <20150319170649.GE18134@mail.corp.redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
 <20150319152526.GA3651@balvenie>
 <20150319155830.GB18134@mail.corp.redhat.com>
 <20150319164746.GA1648@balvenie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150319164746.GA1648@balvenie>
Sender: linux-kernel-owner@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> On Thu, Mar 19, 2015 at 11:58:31AM -0400, Benjamin Tissoires wrote:
> > On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > Again, sorry, I thought I answered it. With the kernel patches appl=
ied:
> > - disabled in the bios without psmouse.proto=3Dimps -> touchpad sti=
ll
> >   enabled, trackstick + buttons working
> > - disabling in the bios + psmouse.proto=3Dimps -> touchpad disabled=
,
> >   trackstick + buttons working
> > - enabled in the bios + psmouse.proto=3Dimps -> touchpad barely usa=
ble,
> >   trackstick + buttons working
> >=20
> > That should cover all the cases :)
> >=20
> Actually, one is missing: =E2=80=9Ctouchpad enabled / without
> psmouse.proto=3Dimps=E2=80=9D, but it doesn't really matter for me si=
nce I'm not
> using the touchpad anyway.

Yes, but that is the most used case, and if this one was not working
then the patch series would have been moot :)

>=20
> But that also means if I want a disabled touchpad (without using xinp=
ut
> disable) I'm forced to use psmouse.proto=3Dimps. It does work fine bu=
t I
> then lose the speed and sensitivity attributes (in
> /sys/devices/platform/i8042/...) and the Trackpoint device itself is
> gone from the input subsystem (everything goes to the touchpad one).
>=20
> I find that a bit confusing, and think it'd be best if the touchpad
> disabling could be handled even when IMPS/2 is not used, but maybe it=
's
> impossible to do?

I honestly did not spent much time understanding the IMPS/2 boot option
and the way it is advertised by the bios. I just made the above
statements.

To solve your problem, your desktop environment must have a "disable
touchpad" switch in the configuration panel. At least, gnome has. This
way, your settings should come back at each login.
And if this is not sufficient enough, you can always add a xorg.conf.d
snippet which disables the touchpad when X starts.

Cheers,
Benjamin

>=20
> Sorry for the ~user-related questions.
>=20
> Regards,
> --=20
> Yves-Alexis
