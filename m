From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH v2] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Tue, 22 Oct 2013 08:08:12 +0200
Message-ID: <5266164C.3060509@butterbrot.org>
References: <1382287751-21515-1-git-send-email-floe@butterbrot.org> <20131021162006.GB4575@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GirmGBBFV3JtbmUdQuxAHSivv7DnU6wls"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:35952 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab3JVGIP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Oct 2013 02:08:15 -0400
In-Reply-To: <20131021162006.GB4575@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, rydberg@euromail.se, dh.herrmann@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GirmGBBFV3JtbmUdQuxAHSivv7DnU6wls
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

thanks for your quick feedback, a few questions below:

On 21.10.2013 18:20, Dmitry Torokhov wrote:
> On Sun, Oct 20, 2013 at 06:49:11PM +0200, Florian Echtler wrote:
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
>=20
> Proper internal kernel types are u8, u16, u32. For user-facing APIs
> __u8, __u16, and __u32 should be used. Also, since this is data coming
> directly off the wire, you should be using __le16, __le32, etc, and the=
n
> do __leXX_to_cpu() conversion before using it in calculations.
OK, I'll switch to u32 throughout (also for the float, I'll explain in a
commment). However, I haven't found a single other touchscreen driver
which uses __le32, even though they all probably process raw wire data -
can you suggest an example?

>> +/* debug helper macro */
>> +#define get_dev(x) (&(x->usbdev->dev))
> Just stick that dev in sur40_state and then use sur40->dev throughout.
OK.

>> +	struct sur40_header *header =3D &(sur40->bulk_in_buffer->header);
> No need to have parenthesis around & operator.
>> +	struct sur40_blob *inblob =3D &(sur40->bulk_in_buffer->blobs[0]);
> Same here.
Intention seems clearer to me with parentheses, but if this doesn't
conform to coding style, I'll fix it.

>> +	if (!sur40->bulk_in_buffer) {
>> +		dev_err(&interface->dev, "Unable to allocate input buffer.");
>> +		sur40_delete(sur40);
> Would prefer standard kernel error unwinding style (gotos to proper
> unwinding point).
Something like this example from ucb1400_ts?

	error =3D input_register_device(ucb->ts_idev);
	if (error)
		goto err_free_irq;

	return 0;

err_free_irq:
	free_irq(ucb->irq, ucb);
err_free_devs:
	input_free_device(ucb->ts_idev);
err:
	return error;


Best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--GirmGBBFV3JtbmUdQuxAHSivv7DnU6wls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlJmFkwACgkQ7CzyshGvathQ+wCfQODPTlBE3uB4fbLbIQtRpM4j
+L0An1Tk0FtrWlFe7Am2VtS95ocr4rcT
=Nhar
-----END PGP SIGNATURE-----

--GirmGBBFV3JtbmUdQuxAHSivv7DnU6wls--
