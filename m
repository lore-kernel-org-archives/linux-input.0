From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 13:17:39 +0100
Message-ID: <200811041317.40482.oliver@neukum.org>
References: <200811031731.38055.oliver@neukum.org> <490F57D3.6060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <490F57D3.6060503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
> Oliver Neukum napsal(a):
> > Hi Ji=C5=99is,
>=20
> :)
>=20
> Hi.

Hi,

>=20
> > this is the cleanup of hiddev against current vanilla. What do you =
think?
>=20
> See my comments below.

OK, all clear, except for:

> > @@ -828,6 +828,14 @@ int hiddev_connect(struct hid_device *hid, uns=
igned int force)
> > =20
> >  	hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] =3D hiddev;
>=20
> usbhid->intf->minor is set even after this call:

What does this mean?

	Regards
		Oliver



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
