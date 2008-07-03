From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: disconnect in ati_remote2
Date: Fri, 4 Jul 2008 01:49:50 +0300
Message-ID: <20080703224949.GB7132@sci.fi>
References: <200807022331.44288.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200807022331.44288.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 02, 2008 at 11:31:43PM +0200, Oliver Neukum wrote:
> Hi,
>=20
> this doesn't look quite right. Somebody might use sysfs or usbfs to
> disconnect only one interface. In that case you should give up the ot=
her
> interface, not depending on the first interface being disconnected.

I never considered the possibility of disconnecting just one interface.
I'll put it on my TODO list for the future.

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
