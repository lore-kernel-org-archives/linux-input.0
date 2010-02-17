From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: S2R resume crash in 2.6.33-rc7 - NULL pointer dereference in
 dev_get_drvdata() for usbhid
Date: Wed, 17 Feb 2010 14:24:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002171423010.30967@pobox.suse.cz>
References: <20100213135720.603e5f64@neptune.home> <Pine.LNX.4.44L0.1002131238580.23844-100000@netrider.rowland.org> <20100213193609.3337b3f0@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213193609.3337b3f0-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 13 Feb 2010, Bruno Pr=C3=A9mont wrote:

> > > This lets me guess that hid_add_device() is doing something wrong
> > > here when report parsing fails... (as that one is the only one wh=
ich
> > > could be doing the initialization of usbhid which does work for t=
he
> > > first interface announced by my keyboard)
> >=20
> > I don't know about doing anything wrong...  However it does appear
> > that in this case the interface is registered on the HID bus but
> > doesn't get bound to a driver.  Jiri will know whether or not that'=
s
> > the desired outcome.
> >=20
> > On the other hand, I don't think there would be anything wrong with=
=20
> > moving the
> >=20
> > 	usbhid->intf =3D intf;
> > 	usbhid->ifnum =3D interface->desc.bInterfaceNumber;
> >=20
> > lines from usbhid_start() to usbhid_probe(), just before the call t=
o
> > hid_add_device().  It should fix the bug, and those lines do belong=
 in
> > the probe routine.  Jiri, any problems with doing this?
>=20
> With the below patch (which is only half of the move work) I don't
> get crashes anymore. Though I wonder if other initialization steps
> (like the spin_lock_init() right before setting usbhid->intf) would
> need to be moved as well.
>=20
> Bruno
>=20
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index e2997a8..690ca75 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1154,6 +1154,8 @@ static int usbhid_probe(struct usb_interface *i=
ntf, const struct usb_device_id *
> =20
>  	hid->driver_data =3D usbhid;
>  	usbhid->hid =3D hid;
> +	usbhid->intf =3D intf;
> +	usbhid->ifnum =3D interface->desc.bInterfaceNumber;
> =20
>  	ret =3D hid_add_device(hid);
>  	if (ret) {
>=20

Thanks for beating me with looking into this guys.

I have pushed fix for this into for-next branch, so it should appear in=
=20
tomorrow linux-next pile. If you still experience the problem, please l=
et=20
me know.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
