From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Mon, 10 Jul 2017 09:11:53 +0200
Message-ID: <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ej5059R8plLfkMNAMOiN8GR06Xcj9kVxO"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:40385 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbdGJHME (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 03:12:04 -0400
In-Reply-To: <20170709214105.GE21945@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Martin Kaltenbrunner <modin@yuri.at>, Peter Hutterer <peter.hutterer@who-t.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ej5059R8plLfkMNAMOiN8GR06Xcj9kVxO
Content-Type: multipart/mixed; boundary="18aF9eUE0QIU9ts5VIIhp7H0BNJPIWN1r";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Martin Kaltenbrunner <modin@yuri.at>,
 Peter Hutterer <peter.hutterer@who-t.net>
Message-ID: <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
In-Reply-To: <20170709214105.GE21945@dtor-ws>

--18aF9eUE0QIU9ts5VIIhp7H0BNJPIWN1r
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Good point, I'll send an updated patch ASAP.

Related question: we first attempted to label non-touch objects as MT_TOO=
L_PALM,
but it looks like userspace (Xorg in particular) doesn't actually disting=
uish
between MT_TOOL_* types; is that correct?

Best, Florian

On 09.07.2017 23:41, Dmitry Torokhov wrote:
> On Sun, Jul 09, 2017 at 08:54:51PM +0200, Florian Echtler wrote:
>> The SUR40 labels all reported blobs as touch, token, or generic blob.
>> Previously, all blobs were reported as touch regardless of type, causi=
ng
>> lots of false positives. Present patch fixes this.
>>
>> Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
>> Signed-off-by: Florian Echtler <floe@butterbrot.org>
>> ---
>>  drivers/input/touchscreen/sur40.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchsc=
reen/sur40.c
>> index 12bdee9..fbd4010 100644
>> --- a/drivers/input/touchscreen/sur40.c
>> +++ b/drivers/input/touchscreen/sur40.c
>> @@ -309,6 +309,8 @@ static void sur40_report_blob(struct sur40_blob *b=
lob, struct input_dev *input)
>>  	int slotnum =3D input_mt_get_slot_by_key(input, blob->blob_id);
>>  	if (slotnum < 0 || slotnum >=3D MAX_CONTACTS)
>>  		return;
>> +	if (blob->type !=3D SUR40_TOUCH)
>> +		return;
>=20
> I think we should be checking blob type before trying to get slot
> number.
>=20
>> =20
>>  	input_mt_slot(input, slotnum);
>>  	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
>> --=20
>> 2.7.4
>>
>=20
> Thanks.
>=20


--=20
SENT FROM MY DEC VT50 TERMINAL


--18aF9eUE0QIU9ts5VIIhp7H0BNJPIWN1r--

--Ej5059R8plLfkMNAMOiN8GR06Xcj9kVxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlljKLkACgkQ7CzyshGvatiA4gCfX2TQxTQVGsg0eYv8WUa0tBCg
IsAAn1rSZxaSilucYrwMRGDHv1wqyWpm
=Uvcl
-----END PGP SIGNATURE-----

--Ej5059R8plLfkMNAMOiN8GR06Xcj9kVxO--
