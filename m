From: Chow Loong Jin <hyperair@ubuntu.com>
Subject: Re: Thinkpad Edge E220S trackpoint detection [was: Re: Lenovo X220
 Touchpad + Trackpoint BIOS issue workaround ?]
Date: Tue, 04 Oct 2011 18:21:04 +0800
Message-ID: <4E8ADE10.70401@ubuntu.com>
References: <4E8ADD98.5000402@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFABC4E1DBCB13CBBA0998DE0"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51206 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab1JDKVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 06:21:08 -0400
Received: by ggnv2 with SMTP id v2so118090ggn.19
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 03:21:08 -0700 (PDT)
In-Reply-To: <4E8ADD98.5000402@ubuntu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFABC4E1DBCB13CBBA0998DE0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2011 18:19, Chow Loong Jin wrote:
> I was reading through the linux-input thread (as mentioned in the subje=
ct)
> regarding trackpoint detection, and noticed that it bore an uncanny res=
emblence
> to the issue I'm currently having with my Thinkpad Edge E220S. I'll sum=
marize
> the situation on my E220S here, which I believe to be more or less the =
same as
> the situation on the X220:
>  - Main device is a Synaptics touchpad/
>  - Trackpoint exists as a passthrough device/
>  - Trackpoint not detected until first resynchronization happens.
>  - Loss of sync can be triggered by moving the (undetected) trackpoint/=


I forgot to mention one more point:
 - Upon resync, the trackpoint gets detected as "PS/2 Generic Mouse".

--=20
Kind regards,
Loong Jin


--------------enigFABC4E1DBCB13CBBA0998DE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJOit4QAAoJEPvVIltYh1KhxNoP/3Fr6bGdYllZykDYuBE7+SOx
bAXcPIrJUm+f/GBvLmR+AzY7tfqP5ruKBBhSXu1jGUnTXRY16GDLGt+IIw0Zpp3D
3cA2UbIcSySFOlY1h6xKDTLc/wLtt5cb0j4eJhqdhAAgURgsC7mWDFotDyYRyteV
349SjPUOU+KxhJoYP3r7Tp6hSgYIwse30uFxKi/ca12Ggc3245ENGNkSOrNcAGQF
BBsfQkLESr+ARtg0nP4Div+28gwYpY1x1rj6SoPUpSEii85XxcBRs0S1MGEpGcMN
YAY69bQoR4TfXZh6NuLXHv5c0gp4GCd6f6CrtDORHoBtJ/KTA3xJwUaR3Esi7lli
3WZB0D/y/HqxdHfTbOQOPxePMs6oXzd4eZK1f45LLoNX9Tnwm4KvEP1i20tgivCN
r2i9DEqik3PfbexefSBPuVGErp/2iSEgOMLQKe/WFOttqlMkhnem3lMUIgk/C+sU
04QDY11NDSl1AGCvFNyu3WM0EsOB8oodWerSoUev/RmOwErut1LdeLK6mFhBkgJp
lHB1ARMbiwrN+yaqjfmvhzY+/FBR3dHEmw9s2BEvvI5Mkf5/f1fslCfNSNWO+zJd
94Y/bMMNicfWYpcrKUzPzxs3ufL+5GEBz9IqSGi5zsg8twgYa/jI181yMtkdo7tl
YI4Wg+MlPT/sHIPp5Dnt
=0EhA
-----END PGP SIGNATURE-----

--------------enigFABC4E1DBCB13CBBA0998DE0--
