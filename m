From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: [patch]fix race between disconnect and open in usbtouch
Date: Thu, 26 Jun 2008 16:41:10 +0300
Message-ID: <20080626134110.GE22310@sci.fi>
References: <200806261532.06544.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806261532.06544.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 26, 2008 at 03:32:05PM +0200, Oliver Neukum wrote:
> Hi,
>=20
> if you kill the URB before you unregister, open can come in between
> and resubmit the urb. This patch reverses the order.
>=20
> 	Regards
> 		Oliver
>=20
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
>=20
> ---
>=20
> --- linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c.al=
t	2008-06-26 15:23:34.000000000 +0200
> +++ linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c	20=
08-06-26 15:23:38.000000000 +0200
> @@ -973,8 +973,8 @@ static void usbtouch_disconnect(struct u
> =20
>  	dbg("%s - usbtouch is initialized, cleaning up", __FUNCTION__);
>  	usb_set_intfdata(intf, NULL);
> -	usb_kill_urb(usbtouch->irq);
>  	input_unregister_device(usbtouch->input);
> +	usb_kill_urb(usbtouch->irq);
>  	usb_free_urb(usbtouch->irq);
>  	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
>  	kfree(usbtouch);

I think you can just remove that usb_kill_urb() call since
usbtouch_close() has already called it by that time.

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
