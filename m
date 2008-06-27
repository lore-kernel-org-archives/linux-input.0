From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [rft]power management for usbtouch
Date: Fri, 27 Jun 2008 16:17:46 +0300
Message-ID: <20080627131746.GD19430@sci.fi>
References: <200806261557.19095.oliver@neukum.org> <20080626144545.GF22310@sci.fi> <200806261656.06457.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:60388 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbYF0NRr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2008 09:17:47 -0400
Content-Disposition: inline
In-Reply-To: <200806261656.06457.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Jun 26, 2008 at 04:56:05PM +0200, Oliver Neukum wrote:
> Am Donnerstag 26 Juni 2008 16:45:45 schrieb Ville Syrj=E4l=E4:
> > On Thu, Jun 26, 2008 at 03:57:17PM +0200, Oliver Neukum wrote:
> > >  MODULE_DEVICE_TABLE(usb, usbtouch_devices);
> > > =20
> > >  static struct usb_driver usbtouch_driver =3D {
> > >  	.name		=3D "usbtouchscreen",
> > >  	.probe		=3D usbtouch_probe,
> > >  	.disconnect	=3D usbtouch_disconnect,
> > > +	.suspend	=3D usbtouch_suspend,
> > > +	.resume		=3D usbtouch_resume,
> > > +	.reset_resume	=3D usbtouch_resume,
> >=20
> > What is the purpose of providing identical resume and reset_resume?
> > AFAICS reset_resume is only called if USB_QUIRK_RESET_RESUME is
> > enabled.
>=20
> It is also called if you resume from STD if power was lost.

That's the case with USB_PERSIST and persist_enabled turned on right?
So the core will simply disconnect+reconnect the device if persistance
is not enabled (or if reset_resume is not provided). Hmm. I suppose it'=
s
better to have a reset_resume than do the disconnect+reconnect trick
since then the input device will not disappear, making it more friendly
towards non-hotlug aware applications.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
