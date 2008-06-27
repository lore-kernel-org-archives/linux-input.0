From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [rft]power management for usbtouch
Date: Fri, 27 Jun 2008 19:10:36 +0300
Message-ID: <20080627161036.GE19430@sci.fi>
References: <200806261557.19095.oliver@neukum.org> <20080626144545.GF22310@sci.fi> <200806261656.06457.oliver@neukum.org> <200806271050.02579.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:41229 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbYF0QKi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2008 12:10:38 -0400
Content-Disposition: attachment
In-Reply-To: <200806271050.02579.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jun 27, 2008 at 10:50:00AM +0200, Oliver Neukum wrote:
> @@ -820,20 +824,34 @@ exit:
>  static int usbtouch_open(struct input_dev *input)
>  {
>  	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
> +	int rv;
> =20
> +	rv =3D usb_autopm_get_interface(usbtouch->intf);
> +	if (rv < 0)
> +		goto bail;
> +	mutex_lock(&usbtouch->lock);
>  	usbtouch->irq->dev =3D usbtouch->udev;
> =20
> -	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
> -		return -EIO;
> -
> -	return 0;
> +	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
> +		rv =3D -EIO;
> +		usb_autopm_put_interface(usbtouch->intf);
> +	} else {
> +		usbtouch->open =3D 1;
> +	}
> +	mutex_unlock(&usbtouch->lock);
> +bail:
> +	return rv;
>  }

What if the device is already suspended when open() is called?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
