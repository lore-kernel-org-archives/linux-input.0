From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Wishlist: Add support for software-rf-switch in Fujitsu-Siemens
 notebook
Date: Mon, 17 Oct 2011 05:03:47 +0100
Message-ID: <1318824232.3340.1.camel@deadeye>
References: <20110625211738.3615.21718.reportbug@lisa>
	 <1317441406.4068.43.camel@deadeye> <20111002221253.GA18253@elie>
	 <4E9B3DCC.7050106@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2lKckFK/YtNx6n0D08BW"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41264 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750982Ab1JQEEL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Oct 2011 00:04:11 -0400
In-Reply-To: <4E9B3DCC.7050106@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tino Schmidt <mailtinoshomepage@gmx.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-input@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>, Martin =?UTF-8?Q?Ve=C4=8De=C5=99a?= <ja@marvec.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, =?ISO-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>, 631664@bugs.debian.org


--=-2lKckFK/YtNx6n0D08BW
Content-Type: multipart/mixed; boundary="=-F/UWe4dnxjf6AAXZntAe"


--=-F/UWe4dnxjf6AAXZntAe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2011-10-16 at 22:25 +0200, Tino Schmidt wrote:
[...] =20
> Hi,
> I'm sorry for the long delay but I can use the laptop only on weekend.=
=20
> Here is the output:
>=20
> # modprobe wistron_btns force=3D1
> FATAL: Error inserting wistron_btns=20
> (/lib/modules/2.6.26-2-686/kernel/drivers/input/misc/wistron_btns.ko):=
=20
> No such device

It looks like this model is rather different, maybe not a Wistron design
at all.

I would prefer you to test against Linux 3.0, but it appears that the
model detection has not changed since 2.6.26.

> # dmesg
> [  168.628474] wistron_btns: BIOS entry point not found
>=20
> and
> # grep . /sys/class/dmi/id/*_{vendor,name,version}
> /sys/class/dmi/id/bios_vendor:FUJITSU SIEMENS
> /sys/class/dmi/id/board_vendor:FUJITSU SIEMENS
> /sys/class/dmi/id/chassis_vendor:FUJITSU SIEMENS
> /sys/class/dmi/id/sys_vendor:FUJITSU SIEMENS
> /sys/class/dmi/id/board_name:AMILO A1655
> /sys/class/dmi/id/product_name:AMILO A Series
> /sys/class/dmi/id/bios_version:1.0C-8044-8A20
> /sys/class/dmi/id/board_version:Rev0.4b
> /sys/class/dmi/id/chassis_version:N/A
> /sys/class/dmi/id/product_version:0100

Please build and test the attached driver (make && insmod
amilo-rfkill.ko).  It provides a standard rfkill device which you can
control with e.g. the 'rfkill' command, and will only bind to specific
models.

If this works, I'll submit the code upstream.

Ben.

--=20
Ben Hutchings
No political challenge can be met by shopping. - George Monbiot


--=-F/UWe4dnxjf6AAXZntAe
Content-Type: application/x-compressed-tar; name="amilo-rfkill.tar.gz"
Content-Disposition: attachment; filename="amilo-rfkill.tar.gz"
Content-Transfer-Encoding: base64

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


--=-F/UWe4dnxjf6AAXZntAe--

--=-2lKckFK/YtNx6n0D08BW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATpupI+e/yOyVhhEJAQpUzQ/+Mo/eHBObSfFrYxS8UiNkf4XF3XN3i36N
BehSetgTEemuu4bGbtvVpB6sKamyg+cackCC0+63Tjx2ljYsp1ViWqtq/D4kG/VD
B3XMcGZnxFSVK5IyM2VrBu3MnrxVByNmYOHfF8BGb83VJc2vpXJRRbvFPWsvb7ez
ICNow4+Txv0N/Ub84a7FTmcZX51o/N5qQfjiSXtPM1YmZsWBfmoOm15InS6LydBx
/SEzokbu1Ak9NWbVzgTRlrSwKrW22R30JsbVYjBqIRiuZ9/J9nRYAbwjRY6dxEk9
7JaFZyBhAHYwfuBwG3QzdMOmjuJu1jCietF6iGFuoFHe0/fdSAlRWieymQcE71H9
TM6mHfBFdacojSt4hqEYC0yDWbpZNgVju8A2BvJ0fn7cqJT1KXBW41nWfA5GTexF
EUdTZ7AVRDRKOsl10xV/UTBxT7LOO6Fbd/qBdXLcW6iIVw0vvUipjKEClaWt7ZJT
xwE4KuIYv2apl19dBUF47DYaK6VvquWsA4n3Ik9qjyBnrjh6po9eFi3zCKQoNVqq
nNB/6LXcybkp+/LOXc7Mcw7+35cEl7lMiZGm2n1SoxYKMdNvw3JL1EjhVPiIjIJ0
CsSxaI4AoMDTZwlReuElsSYRpgj5Do0muX8u7gJYqyimNJIJuLYctvMYtCvvK7Ps
71xhjREmv9Q=
=yJ3f
-----END PGP SIGNATURE-----

--=-2lKckFK/YtNx6n0D08BW--
