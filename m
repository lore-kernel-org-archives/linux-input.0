From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 15:24:51 +0100
Message-ID: <20150319142450.GA1641@balvenie>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	x-action=pgp-signed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:55824 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbbCSOZq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 10:25:46 -0400
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Feb 06, 2015 at 03:04:28PM -0500, Benjamin Tissoires wrote:
> Hi,
>=20
> This is the second episode of the Lenovo 2015 party :)
>=20
> Thanks to Andrew, we now have an idea within the driver of what are t=
he extra
> buttons aimed for, and the patch series looks cleaner.
> Many thanks for your help.
>=20
> I marked only patches 1/7, 2/7 and 3/7 as stable because they are rea=
lly
> stable fixes. Without the rest of the series, user-space can cope wit=
h the
> kernel result, and so there is IMO no need to backport too many patch=
es in
> stable. I bet distributions will cherry-pick the rest of the series h=
owever.
>=20
Hi,

I recently bought a ThinkPad X250 [1]. I'm running Debian sid with the
4.0-rc4 kernel right now.

I don't use the touchpad at all, but rather the trackpoint, so I
disabled the touchpad in the BIOS. Following some advice, I setup the
input system using psmouse.proto=3Dimps with a custom Xorg.conf.d confi=
g
file for the =E2=80=9Ctouchpad=E2=80=9D (the Trackpoint device disappea=
rs when using
IMPS). It works fine with xf86-input-evdev, and the psmouse module
correctly respects the BIOS setting (the touchpad itself is disabled).

Then I was made aware of that patch set and of the xf86-input-synaptics
patches [2].

I tried the patchset at [3], disabling the psmouse.proto=3Dimps, but I
don't yet installed xf86-input-synaptics. Here are the results:

- - the trackpoint device reappears
- - the hardware buttons seem to work, and are assigned the the trackpo=
int
  device (and can configured using the standard trackpoint config file)
- - the touchpad is enabled, so it looks like the BIOS setting is not
  respected

So I have two questions/remarks about this:

- - if I don't use the touchpad, do I need xf86-input-synaptics at all?
- - how can I have the BIOS setting respected by the psmouse/synaptics
  kernel module (like when using psmouse)

Thanks for your patchset anyway, and regards,

[1] http://www.corsac.net/X250
[2] http://cgit.freedesktop.org/xorg/driver/xf86-input-synaptics/
[3] https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/log/
- --=20
Yves-Alexis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCgAGBQJVCtwvAAoJEG3bU/KmdcClNNYIAIyaikIj76wq0evHDWFAPcZN
5fACdhoEHtnLJYlTUe+b35ywhPLNSLpmjr//goOLqTnqHSSScM/09s4tyCbk9vWp
JprHzfp3HK1ggx4sa6MQlR5cX8wUA5AP/LhYCuKgsPrkD5cNX4Q818FWrYNnB6Hm
y7uC3Mcs9KDk1KvyK79dSMg1lrdtIMCkvgO+81fZPUQOsd3FjMq5vci0zqxHnxZB
1694fY+j9ZMAlyD+wZ/NGsANjZDdqYm/dy5i+NrYjVb53sJD/piZ+NsuIgP4neRJ
Y3kskJbFB/bfv29N4LETT3JrqmYfsvcOMoilnnh8P1f73VTsdgJGw6brtmt0cKE=3D
=3D7KN3
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
