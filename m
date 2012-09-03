From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH resend] Input: usbtouchscreen - initialize eGalax devices
Date: Mon, 3 Sep 2012 17:26:48 +0400
Message-ID: <20120903132648.GC11919@newmaster.mivlgu.local>
References: <20120831232338.GF24820@alittletooquiet.net>
 <20120901003726.GG24820@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mivlgu.ru ([195.20.195.134]:55152 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab2ICNdF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Sep 2012 09:33:05 -0400
Content-Disposition: inline
In-Reply-To: <20120901003726.GG24820@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2012 at 08:37:26PM -0400, Forest Bond wrote:
> From: Forest Bond <forest.bond@rapidrollout.com>
>=20
> Certain eGalax devices expose an interface with class HID and protocol
> None.  Some work with usbhid and some work with usbtouchscreen, but
> there is no easy way to differentiate.  Sending an eGalax diagnostic
> packet seems to kick them all into using the right protocol for
> usbtouchscreen, so we can continue to bind them all there (as opposed to
> handing some off to usbhid).
>=20
> This fixes a regression for devices that were claimed by (and worked
> with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff049f
> ("Input: usbtouchscreen - fix eGalax HID ignoring"), which made
> usbtouchscreen claim them instead.  With this patch they will still be
> claimed by usbtouchscreen, but they will actually report events
> usbtouchscreen can understand.  Note that these devices will be limited
> to the usbtouchscreen feature set so e.g. dual touch features are not
> supported.
>=20
> I have the distinct pleasure of needing to support devices of both types
> and have tested accordingly.
>=20
> Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> ---
>  drivers/input/touchscreen/usbtouchscreen.c |   36 ++++++++++++++++++++++=
++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/t=
ouchscreen/usbtouchscreen.c
> index e32709e..64b4b17 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -304,6 +304,41 @@ static int e2i_read_data(struct usbtouch_usb *dev, u=
nsigned char *pkt)
>  #define EGALAX_PKT_TYPE_REPT		0x80
>  #define EGALAX_PKT_TYPE_DIAG		0x0A
> =20
> +static int egalax_init(struct usbtouch_usb *usbtouch)
> +{
> +	int ret, i;
> +	unsigned char *buf;
> +	struct usb_device *udev =3D interface_to_usbdev(usbtouch->interface);
> +
> +	/* An eGalax diagnostic packet kicks the device into using the right
> +	 * protocol.  We send a "check active" packet.  The response will be
> +	 * read later and ignored.
> +	 */
> +
> +	buf =3D kmalloc(3, GFP_KERNEL);

	if (!buf)
		return -ENOMEM;

> +	buf[0] =3D EGALAX_PKT_TYPE_DIAG;
> +	buf[1] =3D 1;	/* length */
> +	buf[2] =3D 'A';	/* command - check active */
> +
> +	for (i =3D 0; i < 3; i++) {
> +		ret =3D usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> +				      0,
> +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +				      0, 0, buf, 3,
> +				      USB_CTRL_SET_TIMEOUT);
> +		if (ret >=3D 0) {
> +			ret =3D 0;
> +			break;
> +		}
> +		if (ret !=3D -EPIPE)
> +			break;
> +	}
> +
> +	kfree(buf);
> +
> +	return ret;
> +}

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFQRLAYW82GfkQfsqIRAgkRAKCHGe5MehDR6+BStWWFdYkW6nnGCgCff1hT
EvTTDo0HSs5pzS0KaAX17ic=
=mI6H
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
