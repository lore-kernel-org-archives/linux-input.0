From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Tue, 18 Jul 2017 10:10:24 +0200
Message-ID: <fcd4fd4e-4387-b2af-7c5f-39b772de9371@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-2-quentin.schulz@free-electrons.com>
 <20170717112912.rsi72f4t74nsp6nr@flea>
 <522ebac5-49ba-fb18-4d9a-b8e50c9d55c3@free-electrons.com>
 <20170718075707.h2ul6vlhsco4ts5u@flea>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BJXg97VSfQiRgkmLmtmPdw7bXfdBVAnen"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718075707.h2ul6vlhsco4ts5u@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJXg97VSfQiRgkmLmtmPdw7bXfdBVAnen
Content-Type: multipart/mixed; boundary="NOWvRp2SlmGsMm4JXkVqSmrpVDIRBQhMN";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org,
 hdegoede@redhat.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Message-ID: <fcd4fd4e-4387-b2af-7c5f-39b772de9371@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-2-quentin.schulz@free-electrons.com>
 <20170717112912.rsi72f4t74nsp6nr@flea>
 <522ebac5-49ba-fb18-4d9a-b8e50c9d55c3@free-electrons.com>
 <20170718075707.h2ul6vlhsco4ts5u@flea>
In-Reply-To: <20170718075707.h2ul6vlhsco4ts5u@flea>

--NOWvRp2SlmGsMm4JXkVqSmrpVDIRBQhMN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 18/07/2017 09:57, Maxime Ripard wrote:
> On Tue, Jul 18, 2017 at 09:36:04AM +0200, Quentin Schulz wrote:
>>>> +
>>>> +	error =3D sysfs_create_group(&pdev->dev.kobj,
>>>> +				   axp20x_pek->attribute_group);
>>>
>>> Wouldn't it make more sense to just store the startup_time structure
>>> in the axp20x_pek structure, rather than duplicating all this?
>>>
>>
>> I don't know. Basically, you would need to recreate manually all the
>> structures in the probe function, but why not.
>=20
> Why?
>=20
> You have access to axp20x_pek in the readout function. You can just
> use the table stored in the structure here, and just ignore any
> argument you might have.
>=20

All I'm saying is that:
struct axp20x_time is referenced in struct axp20x_pek_ext_attr which in
turn is referenced in struct dev_ext_attribute which is referenced in
struct attribute which is reference in const struct attribute_group
which is finally used to add/remove a sysfs group programmatically.

The earlier in the chain you decide to stop duplicating code, the most
structures you have to programmatically create. That was my point.

Quentin

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--NOWvRp2SlmGsMm4JXkVqSmrpVDIRBQhMN--

--BJXg97VSfQiRgkmLmtmPdw7bXfdBVAnen
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZbcJwAAoJEIS4mnU+4PGj8AUQAIbaaoco7z/GA7o3KHaZoU7Z
HiU6sWCbEWPMoiDidOXdh+htMaq7IfPQIWsyYvfkXGmS2LQfqrTpK2GEOvdleLVD
kszsWnCAV6yt2i5vgabLNCqYeH+cdgfmBidMS3UaJUPoqlmMcbHLcrE14R1mekNZ
l59Efu2yeUX4Kt3orVqdxjciB4P3/mG6sjB/i73+gb1WVuDSYqZ8MEYiCon1PQzT
vdbDfLRTfqWFLGaN2cx2LCNm9m8l1OIWLi7qcvH5TVX7vSBeH0TY9jNWwH7y0bKj
2KE9XuhpZVYDPcAsGtAp0S2HXclWLn0XzRkXtw8TlQpHc3U07lm20GlOj1xt/KvS
+Tr0ub6KtbtykRYZWrbfGxVMSaT0/RvGpNEhyzpwH6yB5DwaQTsSAKwFLxzDJmnA
m3qSMZC1L1mTaS8Ch4G6+lwre40tEICTOV+QkHGyvap9+u9tPr4f+asUcz9Cbp3I
uUzYxClZUoLo4a/wtTL3gFUXeasbeYgIjhLBiSSLZTcZoIy0Rvyml5AJz8FG/RIV
biR25yM2ytVD6ce6cnlr8n8vjwjVlbdSJqPHg0rfMCBMLOX3r4ZdxgCDjL+xkKDl
SBbWcS+DhfiZdMi1+ZCvjr/fqN3u7Sm7MHZnAvUXZTCFfmzq7ofPet0Uq3P2Zj8/
jTrKSBWzF/ZUQMyQ8oca
=c7q2
-----END PGP SIGNATURE-----

--BJXg97VSfQiRgkmLmtmPdw7bXfdBVAnen--
