From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [RFC] edt-ft5x06 - cannot see IRQ Qfrom device after DT probe
Date: Wed, 16 Jul 2014 12:01:42 +0200
Message-ID: <53C64D86.1010808@kernelconcepts.de>
References: <53C5685D.1090008@tqsc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LdnngclUrGgIMjV56sUT8PnomIoaTPIKN"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:59353 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397AbaGPKa0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jul 2014 06:30:26 -0400
In-Reply-To: <53C5685D.1090008@tqsc.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Niebel <list-09_linux_input@tqsc.de>, linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LdnngclUrGgIMjV56sUT8PnomIoaTPIKN
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 15/07/14 19:43, Markus Niebel wrote:
> - when adding an int-gpios node to devicetree and parsing this gpio the=
 gpio will be configured as input
> - IRQ can be seen by CPU
>=20
> Question:
>=20
> - shall we add an int-gpio property to enable gpio pin config as input =
or

Shouldn't it be possible to configure the pin as input directly from the
device tree, indepently from the touch driver section?

Bye,
        Simon

--=20
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen



--LdnngclUrGgIMjV56sUT8PnomIoaTPIKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPGTYYACgkQO2O/RXesiHBuMQCeN8w0fo3JE2+kJDLDji3U2F7f
O+IAoLu4fQqOCLcJgyvNupXBYkzh6WI+
=JHB8
-----END PGP SIGNATURE-----

--LdnngclUrGgIMjV56sUT8PnomIoaTPIKN--
