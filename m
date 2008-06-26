From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch]fix race between disconnect and open in usbtouch
Date: Thu, 26 Jun 2008 10:46:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806261045070.2811-100000@iolanthe.rowland.org>
References: <20080626134110.GE22310@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35349 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752865AbYFZOqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jun 2008 10:46:13 -0400
In-Reply-To: <20080626134110.GE22310@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Oliver Neukum <oliver@neukum.org>, daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 26 Jun 2008, Ville Syrj=E4l=E4 wrote:

> > --- linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c.=
alt	2008-06-26 15:23:34.000000000 +0200
> > +++ linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c	=
2008-06-26 15:23:38.000000000 +0200
> > @@ -973,8 +973,8 @@ static void usbtouch_disconnect(struct u
> > =20
> >  	dbg("%s - usbtouch is initialized, cleaning up", __FUNCTION__);
> >  	usb_set_intfdata(intf, NULL);
> > -	usb_kill_urb(usbtouch->irq);
> >  	input_unregister_device(usbtouch->input);
> > +	usb_kill_urb(usbtouch->irq);
> >  	usb_free_urb(usbtouch->irq);
> >  	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
> >  	kfree(usbtouch);
>=20
> I think you can just remove that usb_kill_urb() call since
> usbtouch_close() has already called it by that time.

How do you know that usbtouch_close has been called at this point?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
