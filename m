From: "Vadim A. Misbakh-Soloviov" <mva@mva.name>
Subject: [HELP] mediabuttons/buttons_backlight on MSI G-series laptops
Date: Thu, 12 Sep 2013 15:49:34 +0700
Message-ID: <5231801E.5040007@mva.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hdrvG465ikMqJcT1KxRNf45mUMb3eerQV"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward2l.mail.yandex.net ([84.201.143.145]:50950 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab3ILI4C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Sep 2013 04:56:02 -0400
Received: from smtp19.mail.yandex.net (smtp19.mail.yandex.net [95.108.252.19])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id 9F9CA1AC0CCA
	for <linux-input@vger.kernel.org>; Thu, 12 Sep 2013 12:49:35 +0400 (MSK)
Received: from smtp19.mail.yandex.net (localhost [127.0.0.1])
	by smtp19.mail.yandex.net (Yandex) with ESMTP id 61950BE0237
	for <linux-input@vger.kernel.org>; Thu, 12 Sep 2013 12:49:35 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hdrvG465ikMqJcT1KxRNf45mUMb3eerQV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, list!

I wat to try to write a kernel driver for some mediabuttons (and their
backlight) on my laptop, that don't want to work otherwise.
First of all, can you suggest me some ways for reverse-engineering if I
have no MS Windows OS (and don't want to buy it and even to install it)?
Actually, exactly that buttons requires additional software to work even
on windows (two different programms for Win7 and Win8, both on .NET).

Unfortunately, kernel totally ignores two of that buttons, DisplayOff
(with it's backlight) and FlightMode (without backlight): neither evbug
nor acpid can't see any events on it. And it is also some buttons, that
requires "setkeycodes", including "Eject" one, that works fine at
BIOS/GRUB2 stage, for example. Also, it is virtual buttons on plugging
in/out AC cord, CoolerBooster and Turbo one.

So, there is may things, that requires to be rewritten, but I don't
know, if it is okay to redefine such behaviour in module.

P.S. I talking about MSI GE60 0NC (problem is the same for all of
G-series laptops), so if anyone already working on this issue =E2=80=94 I=
'd glad
to participate.

P.P.S. I already tried platform-dependent code for MSI, but without any
luck.


--hdrvG465ikMqJcT1KxRNf45mUMb3eerQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMYAeAAoJECZQPTSbOzNLe6kQAJUldmeT2MCZLCXzFgn+slHf
VLprM+bWOnpcs68MH9YXVk/chUksvLL0XQ3tNqWDujoJM2AORLi+mkHe58AaXb0g
GY9OpuqKgzONkT16/iskpLJ8QoT6XZ3iuBEx5pk7B2b0XaL4WEwrZoqNLP+ypeqY
B1qupj7QM4szo4kezC7Xa1c0fRsm0wDuZKFf/E7nDH8uw6ISQC5tT77CQRyc6KZ9
BGI7dDBSs7QWhPe41asCuvfnGLwxPVErSlwo74i3gzh9tq4dLDkGu9kWjJzS2R2d
aJLnwSS35qUS92C0t0vWpm2tHmeHDzYfvcbJ8xe9bgF2IZk3FJvO/m+hOR4j4hIi
n4sDaSwswN4UWOhECmu1NIvbaTOaj6+OeuejvswH0bmrHEfW2PtAtka8Ez9nN/je
Sh0s8QSsLuZeNkUSTOt7nUmTX9vrVxcEyGlMD8uzaC81utwCqKw7VqYvbAtBx7IX
MlCZW3JFNSl4dqNoIp7mziaWRp5abjZKYQjp1qQ8XK75OQkoROH6sTm4PdzrxGzO
DlyPRIj3IJYmZwZr5pCB1Rim3FtL3iHEY9+5SPo/kTarmcW6xGcstIH8PVUOz6/K
sENbJk86C7/7p28QIFNOLD5qL6TIgr08LNWr918Z6a2j/yNDLXOUWn4+OZfM3YrM
AJbK+zxk2x1QhSnX09X5
=yV04
-----END PGP SIGNATURE-----

--hdrvG465ikMqJcT1KxRNf45mUMb3eerQV--
