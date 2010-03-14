From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC/RFT 3/5] USB: usbtouch: Prevent possible deadlock
Date: Sun, 14 Mar 2010 10:12:23 +0100
Message-ID: <201003141012.23924.oliver@neukum.org>
References: <201003121542.53537.oliver@neukum.org> <20100314085949.GC8226@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100314085949.GC8226-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Sonntag, 14. M=E4rz 2010 09:59:49 schrieb Dmitry Torokhov:
> > For autosuspend memory in suspend/resume must be allocated with
> > GFP_NOIO.
>=20
> I'd prefer if this change was folded into previous patch - there was =
no
> deadlock condition before you added reset_resume.

Rafael is working on automatically going to GFP_NOIO in case the system
is resumed. The change will be needed for patch #4, not #2.
=20
> > @@ -806,19 +806,19 @@ static int nexio_init(struct usbtouch_usb *us=
btouch)
> >       /* prepare ACK URB */
> >       ret =3D -ENOMEM;
> > =20
> > -     usbtouch->priv =3D kmalloc(sizeof(struct nexio_priv), GFP_KER=
NEL);
> > +     usbtouch->priv =3D kmalloc(sizeof(struct nexio_priv), GFP_NOI=
O);
> >       if (!usbtouch->priv)
> >               goto out_buf;
> > =20
>=20
> Remind me, how does ->exit() gets called in case of reset_resume?
> Otherwise it looks like ne are leaking memory...

Oh, I overlooked that they only free buf, not priv. I'll have to add a =
hook.

	Thanks
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
