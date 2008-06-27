From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Fri, 27 Jun 2008 23:51:47 +0300
Message-ID: <20080627205147.GI19430@sci.fi>
References: <200806261557.19095.oliver@neukum.org> <200806272107.14934.oliver@neukum.org> <20080627202027.GG19430@sci.fi> <200806272241.22513.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806272241.22513.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 27, 2008 at 10:41:20PM +0200, Oliver Neukum wrote:
> Am Freitag 27 Juni 2008 22:20:27 schrieb Ville Syrj=E4l=E4:
> > On Fri, Jun 27, 2008 at 09:07:13PM +0200, Oliver Neukum wrote:
> > > Am Freitag 27 Juni 2008 18:10:36 schrieb Ville Syrj=E4l=E4:
> > > > On Fri, Jun 27, 2008 at 10:50:00AM +0200, Oliver Neukum wrote:
> > > > > @@ -820,20 +824,34 @@ exit:
> > > > >  static int usbtouch_open(struct input_dev *input)
> > > > >  {
> > > > >  	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
> > > > > +	int rv;
> > > > > =20
> > > > > +	rv =3D usb_autopm_get_interface(usbtouch->intf);
> > > > > +	if (rv < 0)
> > > > > +		goto bail;
> > > > > +	mutex_lock(&usbtouch->lock);
> > > > >  	usbtouch->irq->dev =3D usbtouch->udev;
> > > > > =20
> > > > > -	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
> > > > > -		return -EIO;
> > > > > -
> > > > > -	return 0;
> > > > > +	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
> > > > > +		rv =3D -EIO;
> > > > > +		usb_autopm_put_interface(usbtouch->intf);
> > > > > +	} else {
> > > > > +		usbtouch->open =3D 1;
> > > > > +	}
> > > > > +	mutex_unlock(&usbtouch->lock);
> > > > > +bail:
> > > > > +	return rv;
> > > > >  }
> > > >=20
> > > > What if the device is already suspended when open() is called?
> > > >=20
> > >=20
> > > It cannot be. usb_autopm_get_interface() is called, which will re=
sume
> > > the device.
> >=20
> > Ah, so it resumes the device even if it was not autosuspended but
> > suspended for another reason?
>=20
> The other reason is either system wide, in which case nobody can call=
 open,
> or it is forcibly suspended via sysfs, causing usb_submit_urb() to fa=
il later
> on.

Which will also fail the open() itself. Isn't that bad? That is, you ca=
n
suspend an already open device without the users the device noticing
but you can't open it if you happen to suspend it at just the right tim=
e.
That doesn't strike me as good behaviour for a driver.

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
