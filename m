From: Sebastian =?utf-8?Q?Dalfu=C3=9F?= <sd@sedf.de>
Subject: Re: hid: egalax 0x0eef:0x0001 no longer detected by hid-multitouch
Date: Sat, 31 Aug 2013 01:23:39 +0200
Message-ID: <20130830232339.GA14739@sedf.de>
References: <20130830175946.GA17584@sedf.de>
 <20130830184502.GH13685@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sedf.de ([46.38.234.219]:52496 "EHLO sedf.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3H3XXq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Aug 2013 19:23:46 -0400
Content-Disposition: inline
In-Reply-To: <20130830184502.GH13685@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: linux-input@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Forest,

On Fri, Aug 30, 2013 at 02:45:02PM -0400, Forest Bond wrote:
> For now look at hid_ignore in hid-core.c.  You can probably set
> HID_QUIRK_NO_IGNORE to work around the problem.  You'll probably also wan=
t to
> blacklist usbtouchscreen.

That helped indeed.

Changing

        case USB_VENDOR_ID_DWAV:
                /* These are handled by usbtouchscreen. hdev->type is proba=
bly
                 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
                 * usbtouchscreen. */
                if ((hdev->product =3D=3D USB_DEVICE_ID_EGALAX_TOUCHCONTROL=
LER ||
                     hdev->product =3D=3D USB_DEVICE_ID_DWAV_TOUCHCONTROLLE=
R) &&
                    hdev->type !=3D HID_TYPE_USBMOUSE)
                        return true;
                break;

to

        case USB_VENDOR_ID_DWAV:
                /* These are handled by usbtouchscreen. hdev->type is proba=
bly
                 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
                 * usbtouchscreen. */
                if (hdev->product =3D=3D USB_DEVICE_ID_DWAV_TOUCHCONTROLLER=
 &&
                    hdev->type !=3D HID_TYPE_USBMOUSE)
                        return true;
                break;

did the trick.
I also commented the dev id in usbtouchscreen.c out.

//      {USB_DEVICE(0x0eef, 0x0001), .driver_info =3D DEVTYPE_EGALAX},

Thanks,
Sebastian Dalfu=C3=9F

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iEYEARECAAYFAlIhKXsACgkQQfdJUNXnsjoKWwCgkvQStua5NdedCmRGnPxt1/be
o/4AnjGW18D1jVtFCrJxsf0O0sooWBh0
=+qpu
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
