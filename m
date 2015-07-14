From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 17:49:39 +0200
Message-ID: <20150714154939.GA20875@katana>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com>
 <20150714114917.GG1517@katana>
 <alpine.LNX.2.00.1507141452140.7522@pobox.suse.cz>
 <CAAj6DX2_ZwFqpKD5JjbWuJw7SJv3G+DhpnD6tZAoDcF32GQ=0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAj6DX2_ZwFqpKD5JjbWuJw7SJv3G+DhpnD6tZAoDcF32GQ=0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>, Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This is a MFD; should be split in GPIO and I2C, then each part moved
> in its respective tree.

Yes, this is the conclusion we drew last time, too. It might seem
overkill for such simple devices, still this case shows how much drivers
can suffer if missing the expertise of the apropriate subsystem. That
being said, world is full of cornercases, I agree.

> Anyone already working in this direction?

I'd be very surprised :)


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpS+TAAoJEBQN5MwUoCm2kQkQALYjxV1dhUZesqhRwWRtlrUN
aEVusyT7bPlEhGJFqaNXAioWwb+0QDGP5rQzDH0gpXShGuXoIWGajx/NEe30uMih
MEruguWfVm9CuP5CcqlyDQ6nEb8sPUmGeqg44waOZG4r+pMBRLQrEnxkelkHvkYU
MWv+buIa0oR6ueRcUu94se0uKRt7ExywLQLmj1yv+c5kqe5Qy0u27c1zVE6XluwO
UBvcUlX666LE1o+N4nJQNjQBBXjYnLmnFWAaVBZDtZl5smEY/8UVhemD76PydP1P
1TcsxZZxURo8sefVN+PU8DWHGWsTYyCQYg7VMjq4r1Dn0Uoe/B8eAVtzjH3GAukR
TN5XkoAwHVuFcOyxMyh9Hp47q+VnTzeepqO3JgjEtxVA5FF4blnrrDUeEy7kWZAo
+xeMf6se3sm3VLrS0M586Z8l9UUBUJN4v7/uN6fEnHpua7SpNaF5hP/mG3cbmZ2U
z1TRtWog+mkCgpgaQVI3v4EQLdL5Rr0kRoohTQce3jAGin+fPcDMl2laYYZCgCIE
GHE48sNWhLh3IRGVPe5NPKqgODp292nvzavDU3mnPlQf3A09stsHgwsMduDG86fm
FxzMvPvJScLFYwmXX5fClI5c9Hw1BmYZY/Qv34eygJc3X9/qxJcsSuMD8h4e3x3y
HqMNIeuhlyp/8vZ/S0F/
=/Ghu
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
