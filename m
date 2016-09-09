From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] Input: atkbd - filter buggy codes on ASUS Q500A
Date: Fri, 9 Sep 2016 10:27:27 +0200
Message-ID: <20a5ddab-eea3-51db-b0f5-6ccaeda0ef83@rempel-privat.de>
References: <1469821304-30255-1-git-send-email-linux@rempel-privat.de>
 <20160804005052.GC36266@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pHMbDf2wn9MlFeo1XcLWcCA5mGaEwHdqj"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:63161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752500AbcIII1g (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Sep 2016 04:27:36 -0400
In-Reply-To: <20160804005052.GC36266@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHMbDf2wn9MlFeo1XcLWcCA5mGaEwHdqj
Content-Type: multipart/mixed; boundary="1W9hcmVHFL1jJh0a3O71jvru9X157U8ab";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Message-ID: <20a5ddab-eea3-51db-b0f5-6ccaeda0ef83@rempel-privat.de>
Subject: Re: [PATCH] Input: atkbd - filter buggy codes on ASUS Q500A
References: <1469821304-30255-1-git-send-email-linux@rempel-privat.de>
 <20160804005052.GC36266@dtor-ws>
In-Reply-To: <20160804005052.GC36266@dtor-ws>

--1W9hcmVHFL1jJh0a3O71jvru9X157U8ab
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 04.08.2016 um 02:50 schrieb Dmitry Torokhov:
> Hi Oleksij,
>=20
> On Fri, Jul 29, 2016 at 09:41:44PM +0200, Oleksij Rempel wrote:
>> Some revision of ASUS Q500A series have keyboard related
>> issue which is reproducible only if Windows with installed ASUS
>> tools was ever started.
>> In this case the Linux side will have blocked keyboard or
>> report wrong or incomplete hotkey events.
>> To make Linux work properly again complete power down
>> (unplug power supply and remove battery) should be made.
>>
>> Linux/atkbd after clean start will get fallowing code on VOLUME_UP
>> key: {0xe0, 0x30, 0xe0, 0xb0}. After Windows, same key will generate t=
his
>> codes: {0xe1, 0x23, 0xe0, 0x30, 0xe0, 0xb0}. As result atkdb will
>> be confused by buggy codes.
>>
>> This patch is filtering this buggy code out.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D119391
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> Sponsored-by: Alex Henrie <alexhenrie24@gmail.com>
>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> I'd prefer it was done as a i8042_filter() installed in a platform
> driver (asus-laptop.c?). I a filter you'd need to note the fact that yo=
u
> received e1 and when you receive next character you either swallo both
> or re-inject e1 and the new character. See filter implementation in
> ./drivers/input/misc/ideapad_slidebar.c.
>=20
> The scancode fixup method is quite old and is better suited when you
> actually want to use the scancode, just a different one. Here you are
> forced to user ATKBD_RET_ERR which causes debug messages and increment
> error counter.

Hm... i was seeking for a proper place for this filter and noticed
fallowing issue. If asus_nb_wmi driver is loaded and machine is in bad
state after windows start i get this scan codes:

0x5f 0xdf
0x5f 0xdf 0x23
0x5f 0xdf
0x5f 0xdf 0x23
0xe0 0x1f 0xe0 0x9f
0xe0 0x1f 0xe0 0x9f 0x23
0xe0 0x1f 0xe0 0x9f
0xe0 0x1f 0xe0 0x9f 0x23
0xe0 0x3b 0xe0 0xbb
0xe0 0x3b 0xe0 0xbb 0x23
0xe0 0x3b 0xe0 0xbb
0xe0 0x3b 0xe0 0xbb 0x23

--- 0x23 is a good indicator for previously described corrupted codes.

If i remove asus_nb_wmi driver, i'll get only 0x23 on each second hot
kay event:

0x23
0x23
0x23

I ask my self if it make any sense to filter it in platform driver.
Because in case it is not loaded i still have broken keyboard. If atkbd
is not load, there is no issue - it is just not working ;)


> Thanks.
>=20
>> ---
>>  drivers/input/keyboard/atkbd.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/a=
tkbd.c
>> index ec876b5..949c199 100644
>> --- a/drivers/input/keyboard/atkbd.c
>> +++ b/drivers/input/keyboard/atkbd.c
>> @@ -996,6 +996,17 @@ static unsigned int atkbd_oqo_01plus_scancode_fix=
up(struct atkbd *atkbd,
>>  	return code;
>>  }
>> =20
>> +static unsigned int atkbd_asus_q500a_scancode_fixup(struct atkbd *atk=
bd,
>> +						    unsigned int code)
>> +{
>> +	if (atkbd->translated && atkbd->emul =3D=3D 2 && code =3D=3D 0x23) {=

>> +		atkbd->emul =3D 0;
>> +		return ATKBD_RET_ERR;
>> +	}
>> +
>> +	return code;
>> +}
>> +
>>  /*
>>   * atkbd_set_keycode_table() initializes keyboard's keycode table
>>   * according to the selected scancode set
>> @@ -1802,6 +1813,14 @@ static const struct dmi_system_id atkbd_dmi_qui=
rk_table[] __initconst =3D {
>>  		},
>>  		.callback =3D atkbd_deactivate_fixup,
>>  	},
>> +	{
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Q500A"),
>> +		},
>> +		.callback =3D atkbd_setup_scancode_fixup,
>> +		.driver_data =3D atkbd_asus_q500a_scancode_fixup,
>> +	},
>>  	{ }
>>  };
>> =20
>> --=20
>> 2.7.4
>>
>=20


--=20
Regards,
Oleksij


--1W9hcmVHFL1jJh0a3O71jvru9X157U8ab--

--pHMbDf2wn9MlFeo1XcLWcCA5mGaEwHdqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlfScnAACgkQHwImuRkmbWnG2gD+MdI5pd7hpNf3Fm0r1W46qVmp
olgfvMOqW/FQm2sU+FMBAJbwzO4j49IwA/jzf8InsbOyyjMOBHo8oindDJ0Lv0qU
=9quz
-----END PGP SIGNATURE-----

--pHMbDf2wn9MlFeo1XcLWcCA5mGaEwHdqj--
