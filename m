From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch]fix race between disconnect and open in usbtouch
Date: Thu, 26 Jun 2008 10:30:11 -0400
Message-ID: <20080626143010.GA17001@anvil.corenet.prv>
References: <200806261532.06544.oliver@neukum.org> <20080626134110.GE22310@sci.fi> <200806261549.28084.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806261549.28084.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 26, 2008 at 03:49:26PM +0200, Oliver Neukum wrote:
> Am Donnerstag 26 Juni 2008 15:41:10 schrieb Ville Syrj=E4l=E4:
> > > --- linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.=
c.alt=A0=A0=A0=A0=A0=A0=A0=A02008-06-26 15:23:34.000000000 +0200
> > > +++ linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.=
c=A0=A0=A0=A02008-06-26 15:23:38.000000000 +0200
> > > @@ -973,8 +973,8 @@ static void usbtouch_disconnect(struct u
> > > =A0
> > > =A0=A0=A0=A0=A0=A0dbg("%s - usbtouch is initialized, cleaning up"=
, __FUNCTION__);
> > > =A0=A0=A0=A0=A0=A0usb_set_intfdata(intf, NULL);
> > > -=A0=A0=A0=A0=A0usb_kill_urb(usbtouch->irq);
> > > =A0=A0=A0=A0=A0=A0input_unregister_device(usbtouch->input);
> > > +=A0=A0=A0=A0=A0usb_kill_urb(usbtouch->irq);
> > > =A0=A0=A0=A0=A0=A0usb_free_urb(usbtouch->irq);
> > > =A0=A0=A0=A0=A0=A0usbtouch_free_buffers(interface_to_usbdev(intf)=
, usbtouch);
> > > =A0=A0=A0=A0=A0=A0kfree(usbtouch);
> >=20
> > I think you can just remove that usb_kill_urb() call since
> > usbtouch_close() has already called it by that time.
>=20
> Are you sure?

Yes, calling dev->close for opened devices as part of unregister is don=
e
by the input core.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
