From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] input: Fix autosuspend on bcm5974
Date: Mon, 12 Mar 2012 23:27:39 +0100
Message-ID: <201203122327.39546.oneukum@suse.de>
References: <1331596278-2495-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331596278-2495-1-git-send-email-mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Dienstag, 13. M=E4rz 2012, 00:51:18 schrieb Matthew Garrett:
> @@ -767,8 +777,10 @@ static int bcm5974_open(struct input_dev *input)
> =20
>         mutex_unlock(&dev->pm_mutex);
> =20
> +       usb_autopm_put_interface(dev->intf);
> +
>         if (error)
> -               usb_autopm_put_interface(dev->intf);
> +               dev->intf->needs_remote_wakeup =3D 0;
> =20
>         return error;

Hi,

optimally you'd drop the requirement for remote wakeup before
you do the put operation. You might save an unneeded wakeup.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
