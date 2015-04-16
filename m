From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] HID: bug fixes in hid-cp2112 driver
Date: Thu, 16 Apr 2015 09:41:58 +0200
Message-ID: <20150416074158.GA913@katana>
References: <1429143746-16967-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55633 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbbDPHlS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 03:41:18 -0400
Content-Disposition: inline
In-Reply-To: <1429143746-16967-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: dbarksdale@uplogix.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 05:22:26PM -0700, Ellen Wang wrote:
> 1. cp2112_xfer() byte swaps smbus words incorrectly:
>=20
> While i2c is by and large big endian, smbus transactions are
> little endian.  This only affects word operands.  Essentially,
> all occurences of be16 in cp2112_xfer() are now le16.
>=20
> 2. I2C_SMBUS_BYTE write in cp2112_xfer() should pass "command"
> as the single data byte, not "data->byte":
>=20
> When tickled the right way, this actually segfaults the kernel
> because "data" is NULL.
>=20
> 3. cp2112_i2c_xfer() only supports a single i2c_msg and only
> reads up to 61 bytes:
>=20
> This is a serious limitation.  For example, the at24 eeprom driver
> generates paired write and read messages (for eeprom address and data).
> And the reads can be quite large.  The fix consists of a loop

Well, at24 detects how many bytes it got and continues from there.

> to go through all the messages, and a loop around cp2112_read()
> to pick up all the returned data.  For extra credit, it now also
> supports write-read pairs and implements them as
> CP2112_DATA_WRITE_READ_REQUEST.
>=20
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
> ---
> This is a funny driver that is a bridge from usb hid to i2c.
> So while it officially belongs to hid, most of the functionality
> is about i2c.  So I'm sending this patch to both linux-input
> and linux-i2c.  David Barksdale <dbarksdale@uplogix.com> is
> the original author/owner in the .c file.

Probably, this would be best an MFD driver with the i2c and gpio
functionality sourced out to the relevant subsystems. Dunno how well
this works with hid drivers, though.

> While this patch contains three bug fixes, the first two are
> quite trivial.  I'm hoping it's OK to glom them into one.

Then, it should be easy to factor them out? Really, the "one patch per
issue" rule is extremly helpful when fixing regressions.

> ---
>  drivers/hid/hid-cp2112.c |  147 +++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 92 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 3318de6..3999af3 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -444,11 +444,30 @@ static int cp2112_i2c_write_req(void *buf, u8 slave=
_address, u8 *data,
>  	return data_length + 3;
>  }
> =20
> +static int cp2112_i2c_write_read_req(void *buf, u8 slave_address,
> +				     u8 *addr, int addr_length,
> +				     int read_length)
> +{
> +	struct cp2112_write_read_req_report *report =3D buf;
> +
> +	if (read_length < 1 || read_length > 512 ||
> +	    addr_length > sizeof(report->target_address))
> +		return -EINVAL;

This shows the drawback of having I2C master drivers not in the
i2c-directory: It easily misses updates to the i2c-core.
We now have the i2c-quirk infrastructure (2187f03a9576c4) which this
driver should make use of. It can describe this...

> +	for (m =3D msgs; m < msgs + num; m++) {
> +		/*
> +		 * If the top two messages are a write followed by a read,
> +		 * then we do them together as CP2112_DATA_WRITE_READ_REQUEST.
> +		 * Otherwise, process one message.
> +		 */
> +

and this and the core will check the messages for you. It should
simplify your code, too.


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL2fGAAoJEBQN5MwUoCm2GnsQALXvrlAFnBB6u4YowWxhB2dL
6Bko+r06hGl4n/DoH+MYGP1fp1rXa22tBDEiynDimXCUqGx2ecIHIuzw/cX+c7v0
f4i9Mf9V9DRHSChuINqGXl+6joL9Dwoh8nde4ymcD3vc5ne5KhiJ668hWP45eKF6
l0SzcA9yoU0SKLoUQQ0Z+GdbPCGs7P0hMJ/qyM1kpkxZhHpeXrxHoljv5b69Eghe
idFixGaSY1i0xiR2HJ9ilzgaxW3ExhSgc7F/8YjwaITJMRLgsrnrSTrq0EVtcnwW
ZiGSgrvQcqe+ba4lXQ0eP4mLmMNn3lgMv9TsK4sQsVQkVX79kwUP/SpRtR1ic102
v3WwWTW8TKYVRsD6cjWRqncoYm+GplnNWycs2TN9OvAhC2yBu8OIZWglX9PH6kUR
8h159s+5dfeuUHTkmKCZNyBEmYvtlg4gyqq48ml1SL3EJntORPV2lgKW1lfSbdac
UdRwIiPurUcCI1Fn7YTU+ExBY/7CEMoMH7dMx7nAGCccQkVYEZPCXJnn1Rh7DnI2
//hueZ1rm8uNr1pUoiOJHGlj9T4XwtgeNZUsgTmU3Ap/CSEI5uAKvekqIkYmgBoq
YadmABP+CQp0zwMSiN2k1CdhkVWG3h4zId5TbQKCxpnBdNZYzTu7wKftvvuD+YlM
ALON7I3SHbFFmCunB+kz
=ugno
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
