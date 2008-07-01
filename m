From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 20:39:37 +0300
Message-ID: <20080701173937.GA7132@sci.fi>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <200807011108.48556.oliver@neukum.org> <20080701085504.ZZRA012@mailhub.coreip.homeip.net> <200807011857.02259.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200807011857.02259.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 01, 2008 at 06:57:01PM +0200, Oliver Neukum wrote:
> Am Dienstag 01 Juli 2008 14:56:30 schrieb Dmitry Torokhov:
> > On Tue, Jul 01, 2008 at 11:08:47AM +0200, Oliver Neukum wrote:
> > > Am Dienstag 01 Juli 2008 09:59:01 schrieb Jiri Kosina:
>=20
> > > > I really don't think we want to return error in such cases. Eit=
her resume=20
> > > > the device, or queue some requests (maybe depending on the type=
 of=20
> > > > requests), right?
> > >=20
> > > We are talking about forcibly suspended devices, so they cannot b=
e
> > > resumed. We could queue, but where would we end queuing? And we
> > > have to decide to stop it at some point, or we create a DoS probl=
em.
> > >=20
> > > The user has decided to put the device in a state in which the dr=
iver
> > > cannot properly function. If the user wanted the driver to work, =
he should
> > > select autosuspend.
> > >
> >=20
> > That is the thing with the forced suspend - it leaves device out of
> > sync with the rest of the system. If user really does not want to u=
se
> > the device it should probably be completely disconnected?
>=20
> Yes, therefore I suggested doing the logical disconnect.

Would the persistence flag affect this? That is would the forced
suspend cause a reset_resume instead if the driver supports it?

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
