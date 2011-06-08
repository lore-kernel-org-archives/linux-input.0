From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Wed, 8 Jun 2011 12:31:46 -0300
Message-ID: <20110608153146.GG2465@nautilus.holoscopio.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
 <20110602144146.GB3508@nautilus.holoscopio.com>
 <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
 <20110603124428.GA2379@nautilus.holoscopio.com>
 <BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
 <BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
 <20110608125758.GA2465@nautilus.holoscopio.com>
 <BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:56915 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab1FHPbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 11:31:52 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2011 at 10:56:29PM +0800, Chih-Wei Huang wrote:
> Thanks, Benjamin and Cascardo.
>=20
> 2011/6/8 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> > Thanks, Benjamin. That clarifies a lot and points what the real fix
> > should be for this device.
> > Chih-Wei, could you send us the results of your tests? I don't have the
> > device available right now. I could get it next week, perhaps, if my
> > client still gets it.
>=20
> I'm glad to do so.
> But what test results did you want me to show exactly?
>=20
> Let me clarify my situation:
> * Device under test: ASUS ET1602, touchscreen id (1bfd:1688).
> * Kernel: 2.6.38, with android patches (from Google)
> * Android version: 2.2.2 (froyo)
>=20
> By the previous observation from getevent, I added
> the following patch to android framework:
>=20
> diff --git a/libs/ui/EventHub.cpp b/libs/ui/EventHub.cpp
> index 0e11823..6ef9da1 100755
> --- a/libs/ui/EventHub.cpp
> +++ b/libs/ui/EventHub.cpp
> @@ -670,7 +671,7 @@ int EventHub::open_device(const char *deviceName)
>          device->classes |=3D CLASS_TOUCHSCREEN | CLASS_TOUCHSCREEN_MT;
>=20
>      // Is this an old style single-touch driver?
> -    } else if (test_bit(BTN_TOUCH, key_bitmask)
> +    } else if ((test_bit(BTN_TOUCH, key_bitmask) ||
> test_bit(BTN_MOUSE, key_bitmask))
>              && test_bit(ABS_X, abs_bitmask) && test_bit(ABS_Y, abs_bitma=
sk)) {
>          device->classes |=3D CLASS_TOUCHSCREEN;
>      }
>=20
> Then the touch device (event7) is correctly recognized by
> the android framework and works fine.
>=20
> Without this patch, event7 is ignored and only event6 is detected,
> but no touch event generated from it.
>=20
> Let me know if you need more details.
>=20
> I'll try Benjamin's suggestion tomorrow.
>=20
> Regards,
> --=20
> Chih-Wei
> Android-x86 project
> http://www.android-x86.org

I was referring to Benjamin's multi-touch solution, perhaps, reverting
the multi-device patch already. By the way, did you test it without the
multi-device patch and did it work, or did you test it only with 2.6.32?

Regards,
Cascardo.

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN75XhAAoJEEWxSg7udFZItioP/2Vv+ZGTjHWIz5Wyly3ewXPx
RSd1imIk6YgTwHFcRx5Z3ZodnT44F1+K5vaGv0UF5FRYCM1fsemVZ5ZTxI3xUviq
+vLlg63Clk6UOvLbNbMdPwECPBNSYR2C7fxvD/fIA1K/qejJFK9kPtSYazRcjW8z
+Zo/7m37cwjt555GkWBPT//Up0rKT2S+9kXJBTCCiL5IdLwwSgI3niS1r/8l8qLm
DnXH9mZTnJjHny6aSqcr96Jh98oHPt805JLLA4wnC1CdFqeK3WQKM3V3CXnJRvth
EU8x21Fg2L3zipyhJeN1LIckyeLnGYjMWk9o0bnzRyUkq2rCppvbz5YyiUtoTrqu
THLKH6u0lIIDC0KowWxud/jzyIqazWbrCvahq6lw1kV7prEZO+8YSbqM912MC56b
ZDVMbq9r+51OHvpxjDzXlai3tZ6uKE+2K+io+V9ahN8f6BE5wRXK8+sMaokZs8dr
vzh3/XVGhrZs4faFhuE3my+SAVd/XRm9LD6vt32WLJKTaSJLR44H5zifQOH7fhQa
fke5lhVpHQP9y8oZoMMXWWDPkKWnxVeBQpP+NW7X8id8HK7YngmKpEipu0dzwuf3
j/NRsT3MdJhsZpjpyWtw5uuHGzi/A/udnUiw6Ys4EV5Tuv4CcmokVbLvGLqZ8ENz
b02Owo2e7OAgOujgFoI8
=KxGM
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--
