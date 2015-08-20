From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Thu, 20 Aug 2015 18:35:24 +0200
Message-ID: <55D601CC.4030707@metafoo.de>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de> <20150806225501.GA24261@dtor-ws> <55C468BC.60500@metafoo.de> <20150807163213.GB30852@dtor-ws> <20150820163301.GA12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M40gvcwtIR8wgQflkrHaiP51xhl89QFxE"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-030.synserver.de ([212.40.185.30]:1074 "EHLO
	smtp-out-030.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbHTQgE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 12:36:04 -0400
In-Reply-To: <20150820163301.GA12027@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M40gvcwtIR8wgQflkrHaiP51xhl89QFxE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/20/2015 06:33 PM, Mark Brown wrote:
> On Fri, Aug 07, 2015 at 09:32:13AM -0700, Dmitry Torokhov wrote:
>> On Fri, Aug 07, 2015 at 10:13:48AM +0200, Lars-Peter Clausen wrote:
>=20
>>> We know that it is used when CONFIG_PM_SLEEP is defined and we know t=
hat it
>>> is unused CONFIG_PM_SLEEP is not defined. Marking the function as
>>> __maybe_unused will cause the compiler to not generate a warning when=
 the
>>> function is really unused. Making this explicit works much better.
>=20
>> It will also drop the code form the final image and having the functio=
ns
>> in provides better compile coverage.
>=20
> Just discussed this in person with Dmitry: I'll apply the patch just no=
w
> for v4.3 and we can incrementally improve the ifdef handling after.

Great, thanks. I was about to send a patch with the ifdefs removed tomorr=
ow.



--M40gvcwtIR8wgQflkrHaiP51xhl89QFxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1gHVAAoJEOj3aLScRbOZT2cP/2mn3Y+nWpxUQGLiALRLZoUs
IuWw8ydi2BdfDOHCzQs7h54xU05DdXQly13thlhqaJtIxXDGW+So6/n0str2uVV0
3VgUhroLkcL/J1kHDt5SM5JvnnB47u8tfVMKzr1OreVAZlkUXh7NSsLYBSWnKN4L
B40WJzzsx50Z2b5cvkWf1PXkXOMUa/RSztfZ1dgCPcomIzVboxDQIADVn4h9ktl3
Gy+dxnrL/LngBGYdt1AHVzz1ILZY4ZuL3shH5ZVUqItIVig1gmlJKUYw4qRTkJvU
biJVx3yJCq21E5YiC3NSHZ7wpdP8vU+HWwVBy9702LTpakEa58/lu942m0KB2WN5
fL2x1hOSOZP3xdkr1p7GGKxHKgOoE+fbRuNmizIKSOIsPSRxV3J0c+7Gn/frhqke
rS4URYz6H46m41G7qTwACc7wzrCwP9qQQxneyaxAaCd9ndKP9WyzlT9Fm7V2PhSD
TwMZEpNSsVPB7MfoFpEVKqPZRlrf7U3aRMwAcF/JtKHseuaMhBdLJLQYixWFcyWU
a5C5pE9qq8C0xtGqyWBdrUA+IRWIdgjwI8a9RM81GxgFhRrg7PTKao3T/JcTT8CA
5MiMhSazPdtyTTU7LN7IMb6dkxJ+0doMPuScZMrNwAmM1uoyoJd+ST7FXYv/RzLz
IEoDZM3AecOg4aPg7e1u
=Xvhw
-----END PGP SIGNATURE-----

--M40gvcwtIR8wgQflkrHaiP51xhl89QFxE--
