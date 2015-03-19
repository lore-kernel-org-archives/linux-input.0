From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 17:47:46 +0100
Message-ID: <20150319164746.GA1648@balvenie>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
 <20150319152526.GA3651@balvenie>
 <20150319155830.GB18134@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	x-action=pgp-signed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [78.194.244.226] ([78.194.244.226]:43911 "EHLO molly.corsac.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbbCSQtr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 12:49:47 -0400
In-Reply-To: <20150319155830.GB18134@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Mar 19, 2015 at 11:58:31AM -0400, Benjamin Tissoires wrote:
> On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > Am I right? Thanks for the information, I'll also try to point our
> > kernel maintainers to that thread and ask them if it's possible to
> > backport them to the 3.16 kernel for Jessie.
>=20
> Yes, please do. For the record, they are already in Fedora.
>=20
Ok, will do.

> Again, sorry, I thought I answered it. With the kernel patches applie=
d:
> - disabled in the bios without psmouse.proto=3Dimps -> touchpad still
>   enabled, trackstick + buttons working
> - disabling in the bios + psmouse.proto=3Dimps -> touchpad disabled,
>   trackstick + buttons working
> - enabled in the bios + psmouse.proto=3Dimps -> touchpad barely usabl=
e,
>   trackstick + buttons working
>=20
> That should cover all the cases :)
>=20
Actually, one is missing: =E2=80=9Ctouchpad enabled / without
psmouse.proto=3Dimps=E2=80=9D, but it doesn't really matter for me sinc=
e I'm not
using the touchpad anyway.

But that also means if I want a disabled touchpad (without using xinput
disable) I'm forced to use psmouse.proto=3Dimps. It does work fine but =
I
then lose the speed and sensitivity attributes (in
/sys/devices/platform/i8042/...) and the Trackpoint device itself is
gone from the input subsystem (everything goes to the touchpad one).

I find that a bit confusing, and think it'd be best if the touchpad
disabling could be handled even when IMPS/2 is not used, but maybe it's
impossible to do?

Sorry for the ~user-related questions.

Regards,
- --=20
Yves-Alexis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCgAGBQJVCv2tAAoJEG3bU/KmdcCl1KsIAJOH5Q2v/Dtp5R69Sgq3ERcU
VscKl3K4Mqv4U8mNU47PBgSRWBOlZ7OuOkyJbo/gBKaxwNP6mnctn8BWfu3bzXVA
ycSbUgpiws+EsZXkPL+ej7qtxWu0UamUKR9Aoeto6NDy/2KCzcBWCGtfgyVFvsL7
BxC9bPX2tGhgE+9tt+S+AW03aovSfmIipV7XCY3A5hB1lzpjvZwagAzY5PwgI9sj
8gsaDlHeb9l0KFtElVgU+aF2CM1Q07VWQbE6Jcims2LJgLcrOWraye50YP/s7WA4
dC+9n+yY4bm3Q1YyjKUK8Rgq7WzWJFk8O+mJlS81I3tc41Ihg/RlZkUKxg7rM4A=3D
=3DYqYu
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
