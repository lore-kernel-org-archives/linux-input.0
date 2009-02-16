From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] input: xpad.c - Xbox 360 wireless and sysfs support
Date: Mon, 16 Feb 2009 16:21:27 +0100
Message-ID: <200902161621.28142.oliver@neukum.org>
References: <5aa163d00902142008g138826br80d3ea989e7af691@mail.gmail.com> <200902160931.34771.oliver@neukum.org> <5aa163d00902160522r3a22412je3f5202076f57a0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5aa163d00902160522r3a22412je3f5202076f57a0a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Monday 16 February 2009 14:22:05 schrieb Mike Murphy:
> >
> > 3. Possible memory leak in error case:
> >
> > +static struct xpad_data *xpad_create_data(const char *name, struct=
 kobject *parent) {
> > + =A0 =A0 =A0 struct xpad_data *data =3D NULL;
> > + =A0 =A0 =A0 int check;
> > +
> > + =A0 =A0 =A0 data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> > + =A0 =A0 =A0 if (!data)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> > +
> > + =A0 =A0 =A0 check =3D kobject_init_and_add(&data->kobj, &xpad_kty=
pe, parent, "%s", name);
> > + =A0 =A0 =A0 if (check) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kobject_put(&data->kobj);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> > + =A0 =A0 =A0 }
> >
>=20
> My understanding from Documentation/kobject.txt is that the
> kobject_put in the 2nd error check will set the kobj's reference
> counter to zero, eventually causing the kobject core to call my
> cleanup function for the ktype (xpad_release) and free the memory. Is
> this not correct? I find the sysfs docs to be fairly thin... and sysf=
s

I don't know. I also find that documentation thin.
Please add that the memory is freed elsewhere.

> seems to be substantially more complex than procfs or ioctls would be
> for the same purpose. However, everything I read suggested that sysfs
> is the "best" way to go in a modern kernel.
>=20
> > 4. Why the cpup variety?
> >
> > + =A0 =A0 =A0 coords[0] =3D (__s16) le16_to_cpup((__le16 *)(data + =
x_offset));
> >
>=20
> The cpup cast is in the original stable driver
> (drivers/input/joystick/xpad.c), and I didn't question it.
>=20
> > 5. What happens if this work is already scheduled?
> >
> > =A0 =A0 =A0 =A0if (data[0] & 0x08) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 padnum =3D xpad->controller_data->con=
troller_number;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data[1] & 0x80) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->pad_present =3D=
 1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_submit_urb(xpad->=
bulk_out, GFP_ATOMIC);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->pad_present =3D=
 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Wir=
eless Xbox 360 pad #%d present\n", padnum);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xpad->controller_data=
->pad_present =3D 1;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&xpad->work=
, &xpad_work_controller);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&xpad->=
work);
> >

> 1. The user has to remove the battery pack from the controller,
> reinstall the battery pack, and re-activate the controller by pushing
> and holding the center button for at least 1 second.
>=20
> 2. The kernel has to be busy enough not to have completed the work in
> the ~2 seconds a human could have done (1).

Also what happens if the work is scheduled  and you unplug?

> I need a bit of guidance from someone who has a better understanding
> of the work queues to have a good solution to this one. Is switching
> to PREPARE_WORK sufficient (with an INIT_WORK somewhere in
> xpad_probe)? Or is a more involved solution needed?
>=20
> > 6. No GFP_ATOMIC. If you can take a mutex you can sleep.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_submit_urb(xpad->irq_out, GFP_ATO=
MIC);
> >
>=20
> Per the "Linux Device Drivers" book (O'Reilly, 3rd ed), the claim is
> made that submissions while holding a mutex should be GFP_ATOMIC. My

That is not correct. It is true while holding a spinlock, not a mutex.

> tests seemed to verify this claim... as sending LED commands
> GFP_KERNEL while holding the mutex resulted in BUGs (scheduling while
> atomic) in dmesg. Switching those GFP_KERNELs to GFP_ATOMICs
> eliminated that particular BUG.

Please post that BUG.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
