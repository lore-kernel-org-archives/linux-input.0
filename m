From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/3] HID: i2c-hid: Read wMaxInputLength of input report
 instead of bufsize
Date: Mon, 23 Feb 2015 10:26:35 -0500
Message-ID: <20150223152630.GE27578@mail.corp.redhat.com>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
 <1424699565-138045-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424699565-138045-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Feb 23 2015 or thereabouts, Mika Westerberg wrote:
> Wacom digitizer (WCOM0008) on Lenovo Thinkpad 10 seems to allow readi=
ng of
> subsequent reports (or part of them) if we read more than wMaxInputLe=
ngth
> of data at the time. This data is not always aligned so that the next
> report would start right after another.
>=20
> For example we might get following sequence:
>=20
>  i2c_hid i2c-WCOM0008:00: input: 0a 00 02 21 20 17 ad 22 11 03
>  i2c_hid i2c-WCOM0008:00: input: ad 22 11 03 0a 00 02 21 20 17
>                                  ad 22 11 03 0a 00 02 21 20 17
>                                  ad 22 11 03 0a 00 02 21 20 17
>                                  ad 22 11 03 0a 00 02 21 20 17
>                                  ad 22 11 03 0a 00 02 21 20 17
>                                  ad 22 11 03 0a 00 02 21 20 17
>                                  ad 22 11 03
>  i2c_hid i2c-WCOM0008:00: input: 02 21 20 17 ad 22 11 03 0a 00
>                                  02 21 20 17 ad 22 11 03 0a 00
>                                  02 21 20 17 ad 22 11 03 0a 00
>                                  02 21 20 17 ad 22 11 03 0a 00
>                                  02 21 20 17 ad 22 11 03 0a 00
>                                  02 21 20 17 ad 22 11 03 0a 00
>                                  02 21 20 17
>  i2c_hid i2c-WCOM0008:00: i2c_hid_get_input: incomplete report (76/84=
50)
>=20
> The bufsize is 76 and wMaxInputLength is 10. In above example the fir=
st
> read gets right amount of data. The second and third reads get full b=
ufsize
> (76 bytes) but the report is missing a start already. This causes the
> driver to reject the report because we got less than was expected by =
the
> report length (0x2102 =3D 8450).
>=20
> If we read only wMaxInputLength at the time this does not happen at a=
ll and
> the digitizer works fine.
>=20
> Based on this change the driver to read wMaxInputLength bytes instead=
 of
> bufsize if the value looks sane.
>=20
> Reported-by: S=C3=A9bastien Bourdeauducq <sb@m-labs.hk>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

We can actually drop this one. Jiri already applied a patch sent last
week which does the exact same thing:
https://patchwork.kernel.org/patch/5857521/ (should appear shortly in
Jiri's tree I guess).

But thanks for confirming that it was really needed for other devices.

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-=
hid.c
> index 8f1dfc5c5d9c..404ccde49acd 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -369,9 +369,17 @@ static int i2c_hid_hwreset(struct i2c_client *cl=
ient)
> =20
>  static void i2c_hid_get_input(struct i2c_hid *ihid)
>  {
> +	unsigned max_input_length =3D le16_to_cpu(ihid->hdesc.wMaxInputLeng=
th);
>  	int ret, ret_size;
>  	int size =3D ihid->bufsize;
> =20
> +	/*
> +	 * Take the input length from HID descriptor if it is available and
> +	 * looks reasonable.
> +	 */
> +	if (max_input_length > 0)
> +		size =3D min_t(unsigned, ihid->bufsize, max_input_length);
> +
>  	ret =3D i2c_master_recv(ihid->client, ihid->inbuf, size);
>  	if (ret !=3D size) {
>  		if (ret < 0)
> --=20
> 2.1.4
>=20
