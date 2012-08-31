From: Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Subject: Re: [PATCH] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 18:53:53 -0400
Message-ID: <20120831225353.GE24820@alittletooquiet.net>
References: <20120831192632.GA30202@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1208311555140.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1208311555140.1328-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 31, 2012 at 04:04:58PM -0400, Alan Stern wrote:
> On Fri, 31 Aug 2012, Dmitry Torokhov wrote:
>=20
> > > > +		/* Send a "check active" packet. The response will be read
> > > > +		 * later and ignored. */
> > > > +		ret =3D usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> > > > +				      0,
> > > > +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > > > +				      0, 0, "\x0A\x01A", 0,
> > >=20
> > >    You probably can't send data from the .const section (as well as o=
ff the
> > > stack) -- they can be DMA'ed and there'll be issues with cache consis=
tency on
> > > non-x86 arches. You should allocate the data with kmalloc().
> > >    Although, on the second thought, maybe I'm wrong in this case... n=
ot really
> > > sure about sending -- receiving (to the .data section) could certainl=
y be harmful...
> >=20
> > Hmm, do we actually send anything here? The "size" passed to
> > usb_control_msg() is 0 so I don't think we use that data at all...
>=20
> Good point.  Perhaps the 0 is a typo, in which case data does get sent
> and the buffer must be kmalloc'ed.  If the 0 is correct then the buffer
> should be NULL, not "\x0A\x01A" (and what's the purpose of the leading
> '0' in the second byte?).
>=20
> In addition, although the bRequestType specifies USB_DIR_OUT, the pipe
> value is usb_rcvctrlpipe.  Is this transfer meant to be IN or OUT?

Thanks again to all for the review.  My theory for why the previous patch w=
orked
in spite of its wrongness is that the device actually switches modes when it
receives a control message with USB_TYPE_VENDOR even though the documentati=
on
suggests an actual diagnostic packet must be received.

Does this (untested) patch look more reasonable?


diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/tou=
chscreen/usbtouchscreen.c
index e32709e..64b4b17 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -304,6 +304,41 @@ static int e2i_read_data(struct usbtouch_usb *dev, uns=
igned char *pkt)
 #define EGALAX_PKT_TYPE_REPT		0x80
 #define EGALAX_PKT_TYPE_DIAG		0x0A
=20
+static int egalax_init(struct usbtouch_usb *usbtouch)
+{
+	int ret, i;
+	unsigned char *buf;
+	struct usb_device *udev =3D interface_to_usbdev(usbtouch->interface);
+
+	/* An eGalax diagnostic packet kicks the device into using the right
+	 * protocol.  We send a "check active" packet.  The response will be
+	 * read later and ignored.
+	 */
+
+	buf =3D kmalloc(3, GFP_KERNEL);
+	buf[0] =3D EGALAX_PKT_TYPE_DIAG;
+	buf[1] =3D 1;	/* length */
+	buf[2] =3D 'A';	/* command - check active */
+
+	for (i =3D 0; i < 3; i++) {
+		ret =3D usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				      0,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				      0, 0, buf, 3,
+				      USB_CTRL_SET_TIMEOUT);
+		if (ret >=3D 0) {
+			ret =3D 0;
+			break;
+		}
+		if (ret !=3D -EPIPE)
+			break;
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
 static int egalax_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 {
 	if ((pkt[0] & EGALAX_PKT_TYPE_MASK) !=3D EGALAX_PKT_TYPE_REPT)
@@ -1056,6 +1091,7 @@ static struct usbtouch_device_info usbtouch_dev_info[=
] =3D {
 		.process_pkt	=3D usbtouch_process_multi,
 		.get_pkt_len	=3D egalax_get_pkt_len,
 		.read_data	=3D egalax_read_data,
+		.init		=3D egalax_init,
 	},
 #endif
=20

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBBQIEACgkQRO4fQQdv5Ay/zACguVCfukDyd1fc2wz3AG1QpX1W
TQEAoNqEBt00yPGxjShcXD5Owomm47Ey
=Cel5
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
