From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Fri, 27 Jun 2008 21:07:13 +0200
Message-ID: <200806272107.14934.oliver@neukum.org>
References: <200806261557.19095.oliver@neukum.org> <200806271050.02579.oliver@neukum.org> <20080627161036.GE19430@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080627161036.GE19430-ORSVBvAovxo@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag 27 Juni 2008 18:10:36 schrieb Ville Syrj=E4l=E4:
> On Fri, Jun 27, 2008 at 10:50:00AM +0200, Oliver Neukum wrote:
> > @@ -820,20 +824,34 @@ exit:
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
>=20
> What if the device is already suspended when open() is called?
>=20

It cannot be. usb_autopm_get_interface() is called, which will resume
the device.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
