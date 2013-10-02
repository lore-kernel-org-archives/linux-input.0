From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH] add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pixelsense)
Date: Wed, 02 Oct 2013 10:01:28 +0200
Message-ID: <524BD2D8.505@butterbrot.org>
References: <1378934763-17938-1-git-send-email-floe@butterbrot.org> <20130918193853.GA2070@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HatCk8aMNiOn26THpCEeaNANFoc2CHaXm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:60271 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab3JBIvy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Oct 2013 04:51:54 -0400
In-Reply-To: <20130918193853.GA2070@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dmitry.torokhov@gmail.com, dh.herrmann@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HatCk8aMNiOn26THpCEeaNANFoc2CHaXm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18.09.2013 21:38, Henrik Rydberg wrote:
> Hi Florian,=20
> Thanks for the driver, this is excellent work. Please find some nit-pic=
ks inline.

Hello Henrik, thanks for your feedback and sorry for the long silence -
some final questions before the next iteration are below:

>> +/* read 512 bytes from endpoint 0x86 -> get header + blobs */
>> +struct sur40_header {
>> +
>> +	uint16_t type;       /* always 0x0001 */
>> +	uint16_t count;      /* count of blobs (if 0: continue prev. packet)=
 */
>> +
>> +	uint32_t packet_id;
>> +
>> +	uint32_t timestamp;  /* milliseconds (inc. by 16 or 17 each frame) *=
/
>> +	uint32_t unknown;    /* "epoch?" always 02/03 00 00 00 */
>> +};
>=20
> Since you read these structs directly from the device, it would be
> good to see the endianess explicitly. It probably also means this will
> only work on some architectures... ;-) Also, you may want to use the
> __packed attribute.

Do you mean to add a comment about the endianness, or to use other data
types? If so, which ones? __packed is a good point, will add this.

>> +struct sur40_blob {
>> +
>> +	uint16_t blob_id;
>> +
>> +	uint8_t action;      /* 0x02 =3D enter/exit, 0x03 =3D update (?) */
>> +	uint8_t unknown;     /* always 0x01 or 0x02 (no idea what this is?) =
*/
>> +
>> +	uint16_t bb_pos_x;   /* upper left corner of bounding box */
>> +	uint16_t bb_pos_y;
>> +
>> +	uint16_t bb_size_x;  /* size of bounding box */
>> +	uint16_t bb_size_y;
>> +
>> +	uint16_t pos_x;      /* finger tip position */
>> +	uint16_t pos_y;
>> +
>> +	uint16_t ctr_x;      /* centroid position */
>> +	uint16_t ctr_y;
>> +
>> +	uint16_t axis_x;     /* somehow related to major/minor axis, mostly:=
 */
>> +	uint16_t axis_y;     /* axis_x =3D=3D bb_size_y && axis_y =3D=3D bb_=
size_x */
>> +
>> +	float angle;         /* orientation in radians relative to x axis */=

>=20
> float is unusual in the kernel - is it actually ieee 754 encoded?

Yes - was also surprised to see this directly from the hardware.

> Same here. Also, you could add a struct like this:
>=20
> struct sur40_data {
>        struct sur40_header	header;
>        struct sur40_blob	blobs[];
> };
>=20
> which should make conversion easier later on.

Good idea.

>> +
>> +/* read 8 bytes using control message 0xc0,0xb1,0x00,0x00 */
>> +struct sur40_sensors {
>> +	uint16_t temp;
>> +	uint16_t acc_x;
>> +	uint16_t acc_y;
>> +	uint16_t acc_z;
>> +};
>
> Hmm, seems to be unused?

Yes, I was planning to add some extra interface (sysfs?) for this later.
I'll remove it for now.

>> +/* polling interval (ms) */
>> +#define POLL_INTERVAL 10
>=20
> Interesting that 100 Hz is enough here - is it the limit of the
> device, or simply picked out of convenience?

The device itself is running at 60 Hz, so I picked a lower interval to
make sure that new packets are polled as soon as they are ready. The USB
bulk read will block anyway until new data is available, so this could
probably even be lowered to 15 ms.

>> +	input_mt_slot(input, slotnum);
>> +	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
>> +	wide =3D (blob->bb_size_x > blob->bb_size_y);
>> +	major =3D max(blob->bb_size_x, blob->bb_size_y);
>> +	minor =3D min(blob->bb_size_x, blob->bb_size_y);
>> +
>> +	input_event(input, EV_ABS, ABS_MT_POSITION_X, blob->pos_x);
>> +	input_event(input, EV_ABS, ABS_MT_POSITION_Y, blob->pos_y);
>> +	input_event(input, EV_ABS, ABS_MT_TOOL_X, blob->ctr_x);
>> +	input_event(input, EV_ABS, ABS_MT_TOOL_Y, blob->ctr_y);
>> +	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
>> +	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
>> +	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
>> +}
>=20
> You mention there is an angle in the data, but I take it it is not (yet=
) useful?

Right, this could actually be translated into degrees [0..359] and used
for orientation. Good point.

>> +	/* use the bulk-in endpoint tested above */
>> +	sur40->bulk_in_size =3D le16_to_cpu(endpoint->wMaxPacketSize);
>> +	sur40->bulk_in_epaddr =3D endpoint->bEndpointAddress;
>> +	sur40->bulk_in_buffer =3D kmalloc(2 * sur40->bulk_in_size, GFP_KERNE=
L);
>=20
> The factor of two looks a bit cryptic? There also seem to be functions
> to extract the packet size nowadays, if one wants to get fancy.

Ah, yes. The factor of two is actually completely unnecessary, the USB
bulk read should just use sur40->bulk_in_size for the request size.

Best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--HatCk8aMNiOn26THpCEeaNANFoc2CHaXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlJL0tgACgkQ7CzyshGvatg7lQCeOesbGY3h4VnVoTsNupm4Vpv0
DuYAniWrXjSaJcje6eVchhUoxBIq2PE3
=9f+M
-----END PGP SIGNATURE-----

--HatCk8aMNiOn26THpCEeaNANFoc2CHaXm--
