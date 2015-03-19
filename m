From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 10:46:27 -0400
Message-ID: <20150319144627.GA18134@mail.corp.redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150319142450.GA1641@balvenie>
Sender: linux-kernel-owner@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> On Fri, Feb 06, 2015 at 03:04:28PM -0500, Benjamin Tissoires wrote:
> > Hi,
> >=20
> > This is the second episode of the Lenovo 2015 party :)
> >=20
> > Thanks to Andrew, we now have an idea within the driver of what are=
 the extra
> > buttons aimed for, and the patch series looks cleaner.
> > Many thanks for your help.
> >=20
> > I marked only patches 1/7, 2/7 and 3/7 as stable because they are r=
eally
> > stable fixes. Without the rest of the series, user-space can cope w=
ith the
> > kernel result, and so there is IMO no need to backport too many pat=
ches in
> > stable. I bet distributions will cherry-pick the rest of the series=
 however.
> >=20
> Hi,
>=20
> I recently bought a ThinkPad X250 [1]. I'm running Debian sid with th=
e
> 4.0-rc4 kernel right now.
>=20
> I don't use the touchpad at all, but rather the trackpoint, so I
> disabled the touchpad in the BIOS. Following some advice, I setup the
> input system using psmouse.proto=3Dimps with a custom Xorg.conf.d con=
fig
> file for the =E2=80=9Ctouchpad=E2=80=9D (the Trackpoint device disapp=
ears when using
> IMPS). It works fine with xf86-input-evdev, and the psmouse module
> correctly respects the BIOS setting (the touchpad itself is disabled)=
=2E
>=20
> Then I was made aware of that patch set and of the xf86-input-synapti=
cs
> patches [2].
>=20
> I tried the patchset at [3], disabling the psmouse.proto=3Dimps, but =
I
> don't yet installed xf86-input-synaptics. Here are the results:
>=20
> - the trackpoint device reappears
> - the hardware buttons seem to work, and are assigned the the trackpo=
int
>   device (and can configured using the standard trackpoint config fil=
e)
> - the touchpad is enabled, so it looks like the BIOS setting is not
>   respected
>=20
> So I have two questions/remarks about this:
>=20
> - if I don't use the touchpad, do I need xf86-input-synaptics at all?

Wether you use it or not, with the current kernel patch set, there will
be no modifications to do in xf86-input-synaptics. Legacy versions will
work just fine and the trackstick/touchpads are seen like they were in
the past (lik ein the thinkpads t410 .. t430).

So I would advice to just revert to whatever Xorg / xf86-input-synaptic=
s
/ configuration you had from your distribution, apply the patches (or
wait for 4.0-rc5), and you are done.

> - how can I have the BIOS setting respected by the psmouse/synaptics
>   kernel module (like when using psmouse)

I was confused at first so I double checked. If you use the
psmouse.proto=3Dimps boot parameter, then the bios setting is respected=
=2E

If the trackpad is enabled, it is barely usable, but that's what you ge=
t
:)

>=20
> Thanks for your patchset anyway, and regards,

Thanks for your testings.

Cheers,
Benjamin


>=20
> [1] http://www.corsac.net/X250
> [2] http://cgit.freedesktop.org/xorg/driver/xf86-input-synaptics/
> [3] https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/log/
> --=20
> Yves-Alexis
