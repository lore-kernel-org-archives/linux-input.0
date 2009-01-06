From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: Support special keys on laptop by default?
Date: Tue, 06 Jan 2009 15:27:23 +0100
Message-ID: <49636A4B.2050201@wincor-nixdorf.com>
References: <4963594B.9040705@wincor-nixdorf.com> <alpine.LRH.1.10.0901061526200.24105@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96E864A3D8823DCA1049E8D7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxpdbe2.wincor-nixdorf.com ([80.154.98.130]:43710 "EHLO
	mxpdbe2.wincor-nixdorf.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914AbZAFOae (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2009 09:30:34 -0500
In-Reply-To: <alpine.LRH.1.10.0901061526200.24105@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-laptop@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96E864A3D8823DCA1049E8D7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jiri Kosina wrote:
> On Tue, 6 Jan 2009, Niels de Vos wrote:
>=20
>> on my HP/Compaq nc6400 there are three keys (info, presentation and
>> battery) not directly recognized. If I press any of the keys, I get:
>>
>> atkbd.c: Unknown key released (translated set 2, code 0xd9 on isa0060/=
serio0).
>> atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.
> [ ... ]
>> Where should I start looking for creating a patch for solving problems=
=20
>> of this kind? There seem to be quirks in atkbd.c, but I think they are=
=20
>> used for some other workarounds.
>=20
> Please see=20
> http://people.freedesktop.org/~hughsient/quirk/quirk-keymap-index.html
>=20

Thanks Jiri!


--------------enig96E864A3D8823DCA1049E8D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJY2pL5KAkGQPO/QoRAnPfAKDUZe2GTWmsLaaM5l83CVuTo2EH9gCfUpVP
ZcXliSZsgsJ7MxhMPRsEoNc=
=o+gk
-----END PGP SIGNATURE-----

--------------enig96E864A3D8823DCA1049E8D7--
