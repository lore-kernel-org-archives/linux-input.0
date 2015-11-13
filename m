From: Marty Plummer <netz.kernel@gmail.com>
Subject: Assistance in remapping keys with no scancode in kernel module
Date: Thu, 12 Nov 2015 19:59:21 -0600
Message-ID: <564543F9.9000109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ApejLCVtLC2KRgJLQXRFigaT93rIXj8LG"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36289 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbKMB7b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2015 20:59:31 -0500
Received: by ykdr82 with SMTP id r82so124850815ykd.3
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2015 17:59:30 -0800 (PST)
Received: from [192.168.43.56] ([172.56.20.113])
        by smtp.gmail.com with ESMTPSA id t123sm18694321ywg.51.2015.11.12.17.59.30
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2015 17:59:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ApejLCVtLC2KRgJLQXRFigaT93rIXj8LG
Content-Type: multipart/mixed;
 boundary="------------010309020703030001030402"

This is a multi-part message in MIME format.
--------------010309020703030001030402
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Greetings

Having recently purchased a Logitech G105 Gaming Keyboard(046d:c248) I've=
 began
the process of reverse engineering the effects of the proprietery Logitec=
h
Gaming Software (hereafter LGS) on the device to enable its full potentia=
l in
linux, using a number of tools (usbmon, hid-debug, virtual machines) to f=
ollow
the actions and logic used.

As of right now, I've discovered the following:
1. That the macro key remapping (either as standard keyboard keys or full=
 macros)
   occurs in software and is not stored on the device itself (as opposed =
to
   other Logitech GSeries devices).

2. That keys G1-6 keys (hereafter GKeys) default to functioning as F1-6 u=
ntil a
   certain set of packets are sent to it from LGS or otherwise, after whi=
ch the
   F1-6 functionality ends.

3. Before the F# keys are disabled, the GKeys sends hid reports on interf=
ace 0
   identical to 'normal' F# keys and special reports on interface 1, with=
 no
   scancode, of three bytes in size, on one hid usage, ff00.0003 (vendor =
defined)
   after the F# keys are disabled only the reports on interface 1 remain.=


4. The M1-3 and MR keys (hereafter MKeys) send no reports on interface 0 =
at all,
   and reports on the same usage (ff00.0003) as the GKeys.

5. One can easily determine which GKeys and MKeys are being pressed via b=
itwise
   logic, as the three bytes follow a consistant pattern of:

   >03 gg mm
   where 03 is constant, gg is a value indicating the depressed GKeys (0x=
01 << n-1)
   AND'd together and mm is a value indicating the depressed MKeys (0x01 =
<< n-1),
   also AND'd together, where MR is treated as M4.

6. Absolutely no standard scancode/keycode/etc is reported for these keys=
 (as
   detectable by evtest, xev, showkeys, etc).


My current dilemma is how one is to transform this data into something us=
able,
as the fact they all report on the same usage there is no simple way I ca=
n find
to remap these keys.

If anyone has any insight on this matter, please assist.

Information on these reports and raw usbmon logs can be found at
https://github.com/GSeriesDev/gseries-tools/g105

	Regards,
		Marty Plummer


--------------010309020703030001030402
Content-Type: application/pgp-keys;
 name="0xC030918D.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xC030918D.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
PDE9Qw9g6bHvAnTue6j5eKZcjA=3D=3D
=3DF/fe
-----END PGP PUBLIC KEY BLOCK-----


--------------010309020703030001030402
Content-Type: application/pgp-keys;
 name="0xC030918D.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xC030918D.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
PDE9Qw9g6bHvAnTue6j5eKZcjA=3D=3D
=3DF/fe
-----END PGP PUBLIC KEY BLOCK-----

--------------010309020703030001030402--

--ApejLCVtLC2KRgJLQXRFigaT93rIXj8LG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWRUQBAAoJEHWEtN3AMJGNAB4P/3EPMFcpnGI66sYxQ4oDHIxh
I5trYm/sDtKhNh6JpZDxAnUYLZmrVmezp1drCaVKb/Oy7z+D3SLn4v7ZmxzOCR1K
6xifLvV81uStd46U0x7sjJhh2++Fn9yvBjhs7GGEhWTBTlIhnsL175AfWMURT7fd
FTOSi6H0/C7Znp4XfwWXvAy4FAzGBO8thlElUqbu3ZItLFPNKGdiy/5Bnb/U7ImO
0UVBHXTzAqkMG3kwbC+aQBwCRSuHvpjXjgkPvTRPibdbYoGkY8HDFrQqr/9mmoa8
smrz6V+hNTDnw4k1aW+CmUgk1BARPlpWwDXhRajMeIIuGcHYkl4rhKumuCKin81B
DiZL0e+DmXDQtf1Z2B0pksP982izOsF4625qAPq+7jbsxlU2vWJZRKpQAlOmmbQk
VYkSHgyONPC+q/jMh5YY5QHDfO8kiT1chZZ/o91yRoLVYvUoOq+03VDAxW4BqYwY
JKa0wwsU3Kc3IH344kKyr0AeUrvgiWF0xSDEFm4a9UK5V57UkZe1TtsG3HWtx703
6C97lt44DppZNOhJdmKqXLonN/7uHVIJuUr/OL1mmFq5GOLRNfuvQaXIRXljhw0m
AeGElBx+3+lptGp/X/B7JPcoipp4iXPaevQf6IqrXdJYLJtOhN011xeTWjbWDKRc
z0IwqMb1Awt924K5iJ8p
=H1lA
-----END PGP SIGNATURE-----

--ApejLCVtLC2KRgJLQXRFigaT93rIXj8LG--
