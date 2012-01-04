From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] input: Synaptics USB device driver
Date: Wed, 4 Jan 2012 10:20:41 +0100
Message-ID: <201201041020.41795.oneukum@suse.de>
References: <20120103194033.779cb829@greyhound> <alpine.LNX.2.00.1201040954000.24984@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58726 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab2ADJSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2012 04:18:54 -0500
In-Reply-To: <alpine.LNX.2.00.1201040954000.24984@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jan Steinhoff <mail@jan-steinhoff.de>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Am Mittwoch, 4. Januar 2012, 09:55:19 schrieb Jiri Kosina:
> On Tue, 3 Jan 2012, Jan Steinhoff wrote:
>=20
> [ ... snip ... ]
> > +static int synusb_setup_iurb(struct synusb *synusb,
> > +                          struct usb_endpoint_descriptor *endpoint=
)
> > +{
> > +     char *buf;
> > +
> > +     if (endpoint->wMaxPacketSize < 8)
> > +             return 0;
> > +     if (synusb->iurb) {
> > +             synusb_warn(synusb, "Found more than one possible "
> > +                                 "int in endpoint");
> > +             return 0;
> > +     }
> > +     synusb->iurb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +     if (synusb->iurb =3D=3D NULL)
> > +             return -ENOMEM;
> > +     buf =3D usb_alloc_coherent(synusb->udev, 8, GFP_ATOMIC,
> > +                              &synusb->iurb->transfer_dma);
> > +     if (buf =3D=3D NULL)
> > +             return -ENOMEM;
>=20
> You seem to leak synusb->iurb here.

Seems so, but doesn't. It gets freed when the refcount hits 0.
Now, whether this is a good technique is another question.

	Regards
		Oliver
--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
