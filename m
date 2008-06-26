From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Thu, 26 Jun 2008 16:56:05 +0200
Message-ID: <200806261656.06457.oliver@neukum.org>
References: <200806261557.19095.oliver@neukum.org> <20080626144545.GF22310@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080626144545.GF22310-ORSVBvAovxo@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag 26 Juni 2008 16:45:45 schrieb Ville Syrj=E4l=E4:
> On Thu, Jun 26, 2008 at 03:57:17PM +0200, Oliver Neukum wrote:
> > Hi,
> >=20
> > this is power management for usbtouch. Could somebody test it?
> >=20
> > 	Regards
> > 		Oliver
> >=20
> > ---
> >=20
> > --- linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c.=
alt2	2008-06-26 15:23:38.000000000 +0200
> > +++ linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c	=
2008-06-26 15:48:44.000000000 +0200
> > @@ -89,13 +89,17 @@ struct usbtouch_usb {
> >  	int buf_len;
> >  	struct urb *irq;
> >  	struct usb_device *udev;
> > +	struct usb_interface *intf;
> >  	struct input_dev *input;
> >  	struct usbtouch_device_info *type;
> > +	struct mutex lock;
> >  	char name[128];
> >  	char phys[64];
> > =20
> >  	int x, y;
> >  	int touch, press;
> > +
> > +	char open:1;
> >  };
> > =20
> > =20
> > @@ -820,13 +824,23 @@ exit:
> >  static int usbtouch_open(struct input_dev *input)
> >  {
> >  	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
> > +	int rv;
> > =20
> > +	rv =3D usb_autopm_get_interface(usbtouch->intf);
> > +	if (rv < 0)
> > +		goto bail;
> > +	mutex_lock(&usbtouch->lock);
> >  	usbtouch->irq->dev =3D usbtouch->udev;
> > =20
> > -	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
> > -		return -EIO;
> > -
> > -	return 0;
> > +	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
> > +		rv =3D -EIO;
> > +		usb_autopm_put_interface(usbtouch->intf);
> > +	} else {
> > +		usbtouch->open =3D 1;
> > +	}
> > +	mutex_unlock(&usbtouch->lock);
> > +bail:
> > +	return rv;
> >  }
> > =20
> >  static void usbtouch_close(struct input_dev *input)
> > @@ -834,6 +848,10 @@ static void usbtouch_close(struct input_
> >  	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
> > =20
> >  	usb_kill_urb(usbtouch->irq);
>=20
> If usbtouch_resume() happens here it will resubmit the urb.

Thanks. That's a bug.

> > +	mutex_lock(&usbtouch->lock);
> > +	usbtouch->open =3D 0;
> > +	mutex_unlock(&usbtouch->lock);
> > +	usb_autopm_put_interface(usbtouch->intf);
> >  }
> > =20
> > =20
> > @@ -889,6 +907,8 @@ static int usbtouch_probe(struct usb_int
> > =20
> >  	usbtouch->udev =3D udev;
> >  	usbtouch->input =3D input_dev;
> > +	mutex_init(&usbtouch->lock);
> > +	usbtouch->intf =3D intf;
> > =20
> >  	if (udev->manufacturer)
> >  		strlcpy(usbtouch->name, udev->manufacturer, sizeof(usbtouch->nam=
e));
> > @@ -973,20 +993,76 @@ static void usbtouch_disconnect(struct u
> > =20
> >  	dbg("%s - usbtouch is initialized, cleaning up", __FUNCTION__);
> >  	usb_set_intfdata(intf, NULL);
> > -	input_unregister_device(usbtouch->input);
> >  	usb_kill_urb(usbtouch->irq);
> > +	input_unregister_device(usbtouch->input);
> >  	usb_free_urb(usbtouch->irq);
> >  	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
> >  	kfree(usbtouch);
> >  }
>=20
> Already discussed :)

OK.

> > +static int usbtouch_suspend(struct usb_interface *intf, pm_message=
_t message)
> > +{
> > +	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
> > +
> > +	dbg("%s - called", __FUNCTION__);
> > +
> > +	mutex_lock(&usbtouch->lock);
> > +	usb_kill_urb(usbtouch->irq);
> > +	mutex_unlock(&usbtouch->lock);
> > +	return 0;
> > +}
>=20
> Shouldn't all the usb_kill_urb() callers check the usbtouch->open fla=
g
> first? Perhaps it's not considered an error to kill an unsubmitted ur=
b
> though.

It's no problem to call usb_kill_urb() on an unsubmitted urb.
That must be the case as the urb can always finish.

> > +static int usbtouch_resume(struct usb_interface *intf)
> > +{
> > +	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
> > +	int rv =3D 0;
> > +
> > +	dbg("%s - called", __FUNCTION__);
> > +
> > +	mutex_lock(&usbtouch->lock);
> > +	if (usbtouch->open)
> > +		rv =3D usb_submit_urb(usbtouch->irq, GFP_NOIO);
> > +	mutex_unlock(&usbtouch->lock);
> > +	return rv;
> > +}
> > +
> > +static int usbtouch_pre_reset(struct usb_interface *intf)
> > +{
> > +	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
> > +
> > +	dbg("%s - called", __FUNCTION__);
> > +
> > +	mutex_lock(&usbtouch->lock);
> > +	usb_kill_urb(usbtouch->irq);
> > +	return 0;
> > +}
> > +
> > +static int usbtouch_post_reset(struct usb_interface *intf)
> > +{
> > +	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
> > +	int rv =3D 0;
> > +
> > +	dbg("%s - called", __FUNCTION__);
> > +
> > +	if (usbtouch->open)
> > +		rv =3D usb_submit_urb(usbtouch->irq, GFP_NOIO);
> > +	mutex_unlock(&usbtouch->lock);
> > +	return rv;
> > +}
>=20
> Hmm. Are pre_reset and post_reset actually required in such simple ca=
ses?
> AFAICS device reset is already protected against pm and autopm. Or is
> resubmitting urbs necessary after a reset? I'm mainly interested sinc=
e
> I didn't implement these callbacks in my ati_remote2 patch.

If somebody resets the device you can assume it was in a bad shape.
It's much safer to cleanly resubmit.

> >  MODULE_DEVICE_TABLE(usb, usbtouch_devices);
> > =20
> >  static struct usb_driver usbtouch_driver =3D {
> >  	.name		=3D "usbtouchscreen",
> >  	.probe		=3D usbtouch_probe,
> >  	.disconnect	=3D usbtouch_disconnect,
> > +	.suspend	=3D usbtouch_suspend,
> > +	.resume		=3D usbtouch_resume,
> > +	.reset_resume	=3D usbtouch_resume,
>=20
> What is the purpose of providing identical resume and reset_resume?
> AFAICS reset_resume is only called if USB_QUIRK_RESET_RESUME is
> enabled.

It is also called if you resume from STD if power was lost.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
