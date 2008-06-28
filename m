From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Sat, 28 Jun 2008 14:53:17 +0200
Message-ID: <200806281453.17896.oliver@neukum.org>
References: <200806261557.19095.oliver@neukum.org> <200806281252.39386.oliver@neukum.org> <20080628112258.GK19430@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080628112258.GK19430-ORSVBvAovxo@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Samstag 28 Juni 2008 13:22:58 schrieb Ville Syrj=E4l=E4:
> Typically when you're testing something you expect a certain result. =
The
> code as it stands adds another very subtle failure point.
>=20
> I don't quite understand why you're so against handling this issue.

In hindsight adding that interface at all was an error. I was in favor
of it and that was a mistake. Maybe it should be removed.
Complicating good drivers for its sake I therefore consider an error.
Possibly we should consider a forcible suspension a form of disconnecti=
on.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
