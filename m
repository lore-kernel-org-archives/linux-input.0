From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Mon, 11 Nov 2013 11:08:07 +0100
Message-ID: <5280AC87.4020905@butterbrot.org>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org> <20131111073105.GA7645@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="73EBpcglXmKM8tjTBE94PlGKJwValNdHq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:58674 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730Ab3KKKIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 05:08:10 -0500
In-Reply-To: <20131111073105.GA7645@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, rydberg@euromail.se, dh.herrmann@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--73EBpcglXmKM8tjTBE94PlGKJwValNdHq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On 11.11.2013 08:31, Dmitry Torokhov wrote:
> Hi Florian,
>=20
> On Wed, Nov 06, 2013 at 03:26:51PM +0100, Florian Echtler wrote:
>> +
>> +	/* max value unknown, but major/minor axis
>> +	 * can never be larger than screen */
>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>> +		0, SENSOR_RES_X, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
>> +		0, SENSOR_RES_Y, 0, 0);
>=20
> If the range is unknown do we really want to specify min/max?
Geometrically speaking, these _are_ the min/max values. I can't say for
sure if the device has a cutoff threshold somewhere, but in terms of
geometric interpretation, I'd say this is correct.

> Also, does the patch below mess up or device or it still works?
I'll test this tomorrow (no access to SUR40 today). If everything works,
should I resubmit my patch with yours included or just tell you that
it's fine?

BR, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--73EBpcglXmKM8tjTBE94PlGKJwValNdHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlKArIcACgkQ7CzyshGvatg+qwCfXqKB1ESRWBD7E0tG8oyKRRc+
9LEAn2fvWDa1qSqpok9BdwbFkfYzdeY+
=uV2I
-----END PGP SIGNATURE-----

--73EBpcglXmKM8tjTBE94PlGKJwValNdHq--
