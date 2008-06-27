From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [rft]power management for usbtouch
Date: Fri, 27 Jun 2008 16:17:35 +0300
Message-ID: <20080627131735.GC19430@sci.fi>
References: <200806261557.19095.oliver@neukum.org> <20080626144545.GF22310@sci.fi> <200806261656.06457.oliver@neukum.org> <200806271050.02579.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:33260 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757866AbYF0NRg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2008 09:17:36 -0400
Content-Disposition: inline
In-Reply-To: <200806271050.02579.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jun 27, 2008 at 10:50:00AM +0200, Oliver Neukum wrote:
> Hi,
>=20
> this patch should fix everything you complained about. As I don't hav=
e
> the hardware, please test.

I don't have the hardware either so can't help you there.
 =20
>  static void usbtouch_close(struct input_dev *input)
>  {
>  	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
> =20
> +	mutex_lock(&usbtouch->lock);
> +	usbtouch->open =3D 0;
> +	mutex_unlock(&usbtouch->lock);
>  	usb_kill_urb(usbtouch->irq);

usb_kill_urb() is still not protected by the mutex but a resume
happening here wouldn't resubmit the urb so I suppose it's OK to leave
it like that.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
