From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: S2R resume crash in 2.6.33-rc7 - NULL pointer dereference in
 dev_get_drvdata() for usbhid
Date: Sat, 13 Feb 2010 12:46:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002131238580.23844-100000@netrider.rowland.org>
References: <20100213135720.603e5f64@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213135720.603e5f64-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 13 Feb 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:

> On Mon, 08 February 2010 Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote=
:
> > Clearly something is setting usbhid->intf to NULL.  But I don't see
> > any code that would do it.  You may have to resort to putting
> > printk() statements at various strategic places to find out where i=
t
> > happens. You could start with the beginnings and ends of hid_suspen=
d,
> > hid_resume, and hid_reset_resume.  Maybe also usbhid_disconnect(),
> > just in case.
>=20
> I did add a few printk()s and WARN_ON()s to get a better idea of
> why/when usbhid->intf is NULL and it is already since probe time of t=
he
> second interface anounced by the USB keyboard (hid.debug=3D1):

=2E..

> This lets me guess that hid_add_device() is doing something wrong
> here when report parsing fails... (as that one is the only one which
> could be doing the initialization of usbhid which does work for the
> first interface announced by my keyboard)

I don't know about doing anything wrong...  However it does appear that
in this case the interface is registered on the HID bus but doesn't get
bound to a driver.  Jiri will know whether or not that's the desired
outcome.

On the other hand, I don't think there would be anything wrong with=20
moving the

	usbhid->intf =3D intf;
	usbhid->ifnum =3D interface->desc.bInterfaceNumber;

lines from usbhid_start() to usbhid_probe(), just before the call to
hid_add_device().  It should fix the bug, and those lines do belong in
the probe routine.  Jiri, any problems with doing this?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
