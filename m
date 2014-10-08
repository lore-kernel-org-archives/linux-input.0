From: Christian Hesse <mail@eworm.de>
Subject: usbhid: 10 seconds delay with N-Trig Duosense
Date: Wed, 8 Oct 2014 11:20:30 +0200
Message-ID: <20141008112030.5bd55644@leda.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/4VAUyhAO3I=hchAJ8nalRja"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx.mylinuxtime.de ([148.251.109.235]:39990 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaJHJ0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 05:26:43 -0400
Received: from leda.localdomain (unknown [10.10.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id B2BDC21A73
	for <linux-input@vger.kernel.org>; Wed,  8 Oct 2014 11:20:35 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--Sig_/4VAUyhAO3I=hchAJ8nalRja
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I am having trouble with N-Trig Duosense in a Lenovo Thinkpad T410s. Kernel
version is 3.16.4. In lsusb the device identifies as:

Bus 002 Device 004: ID 1b96:0001 N-Trig Duosense Transparent
Electromagnetic Digitizer

The touchscreen works, however loading usbhid module results in a 10 seconds
delay. I have tried to add some quirks, looks like the only way to get rid =
of
the delay is to ignore the device completly with HID_QUIRK_IGNORE:

usbhid.quirks=3D0x1b96:0x0001:0x4

Any chance to make the device work without delay?

Please CC as I am not subscribed to the list.
--=20
Schoene Gruesse
Chris
                         O< ascii ribbon campaign
                   stop html mail - www.asciiribbon.org

--Sig_/4VAUyhAO3I=hchAJ8nalRja
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUNQHeAAoJEFTtyRYJvJGDGWwP/0LxCbc3kuBBkZWZUMxeZDxp
M0tG6+wXb73zE5vlH9aCvYnmg9iSRdbAMth9454zlahdeOysBwzpwc34y7sRyrQ6
hSQ8mljcsLkd1DDYsAKVLlwkyttoyBS8lTG8rGF/fJsvwumsnP5XEAZanoHrqc3R
CVpycMRgn8EFrdZdG0YdW9azjZfsf+CJEDDtgkMxzjnNNTYBS48OkHxhmoYHiVsK
xf5BaRxA0T6Vodk2vLu3vjUL4QkyZbx7TRqJXEBWH5NnMTlGP365nK4Tg9x8fMBu
VQTRbxGSUrfH7+6uJYBbI6kdsTkxJI09npe30aAWQz3+Mn94veccMKHhmWLVsDlq
DQW5chUsLAQ+LBvA0jLuq6pp8AX88zP19JP9ezYbPNNkAeKkcV3Z023MliNZ0cni
VoArRQcxpPPbKaPMqJOkbO0/JV43vU/1rLEX9GZgTaMPPakXmrqTbXHAaxTqt0LN
OiJlFoJLDZufy4UegdLJ0ZCBTidCqkCFICtwDL/2JmGLLlXXtCqJ9ODWWjEdNdin
KkqEq/jnPJWF3w1ObtUzCsbV70WY3EpzYk9CzAQ3Ix6+rOWnPebCRWx1gfNXwS7S
/BpLzP4dY14jfwDunXKyAhO16vR4hvzD7s57n9vx7T065vfwgWQ1axtL3yPsXvBm
fXimN4Orcn6ogDk16R17
=4D8W
-----END PGP SIGNATURE-----

--Sig_/4VAUyhAO3I=hchAJ8nalRja--
