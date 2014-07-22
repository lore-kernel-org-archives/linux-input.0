From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [RFC] edt-ft5x06 - cannot see IRQ Qfrom device after DT probe
Date: Tue, 22 Jul 2014 15:47:55 +0200
Message-ID: <53CE6B8B.20008@kernelconcepts.de>
References: <53C5685D.1090008@tqsc.de> <53C64D86.1010808@kernelconcepts.de> <53CE3F84.5030301@tqsc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2oc4rW12eBuEqptpfNEHedU1UTWWFwSpA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:41450 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaGVNsE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jul 2014 09:48:04 -0400
In-Reply-To: <53CE3F84.5030301@tqsc.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Niebel <list-09_linux_input@tqsc.de>, linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2oc4rW12eBuEqptpfNEHedU1UTWWFwSpA
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22/07/14 12:40, Markus Niebel wrote:
> Am 16.07.2014 12:01, wrote Simon Budig:
>> On 15/07/14 19:43, Markus Niebel wrote:
>>> - when adding an int-gpios node to devicetree and parsing this=20
>>> gpio the gpio will be configured as input - IRQ can be seen by=20
>>> CPU
>>>=20
>>> Question:
>>>=20
>>> - shall we add an int-gpio property to enable gpio pin config as=20
>>> input or
>>=20
>> Shouldn't it be possible to configure the pin as input directly=20
>> from the device tree, indepently from the touch driver section?
>=20
> I don't see, how to do that, maybe I did miss the right point.

Try looking at

Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

There you have the "input-enable" generic property.

> Global question is: how can we make sure, that the driver that=20
> request the IRQ requests also the GPIO (implicit or like in the old=20
> platfrom data days explicit)? But thats beyond input devices and my=20
> knowledge.

The driver does not depend on the IRQ coming from a "real" CPU gpio. It
*could* be an external gpio expander or whatever (whether that is a good
idea is debatable of course). When I submitted the first version of the
driver it had bits in it to configure the pin properly. The feedback
basically was to remove that, because it made some assumptions that you
can map the IRQ to the relevant GPIO, which is not always possible.

I hope that helps.

(But really, your bootloader really should have a *very* good reason to
configure the touch irq pin as output - I have the impression that right
now there are two outputs driving against each other in your setup - not
healthy for the hardware).

Bye,
        Simon

--=20
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen


--2oc4rW12eBuEqptpfNEHedU1UTWWFwSpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPOa4sACgkQO2O/RXesiHCbUwCeOao1JtSlx3jgH0VPC/KDcZEo
ShgAn1veVuTsz9jMSsHz1ejPOmwDyVWg
=+0XU
-----END PGP SIGNATURE-----

--2oc4rW12eBuEqptpfNEHedU1UTWWFwSpA--
