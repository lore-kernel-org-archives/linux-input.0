From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: cleanup of hiddev
Date: Mon, 03 Nov 2008 20:58:11 +0100
Message-ID: <490F57D3.6060503@gmail.com>
References: <200811031731.38055.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:51071 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbYKCUFN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 15:05:13 -0500
Received: by ey-out-2122.google.com with SMTP id 6so925207eyi.37
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 12:05:03 -0800 (PST)
In-Reply-To: <200811031731.38055.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Oliver Neukum napsal(a):
> Hi Ji=C5=99is,

:)

Hi.

> this is the cleanup of hiddev against current vanilla. What do you th=
ink?

See my comments below.

> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.=
c
> index 3ac3207..78f5a3b 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -317,8 +325,8 @@ static ssize_t hiddev_read(struct file * file, ch=
ar __user * buffer, size_t coun
> =20
>  	while (retval =3D=3D 0) {
>  		if (list->head =3D=3D list->tail) {
> -			add_wait_queue(&list->hiddev->wait, &wait);
>  			set_current_state(TASK_INTERRUPTIBLE);
> +			add_wait_queue(&list->hiddev->wait, &wait);

maybe better to convert to prepare_to_wait()?

> =20
>  			while (list->head =3D=3D list->tail) {

But moved here (or the set_current_state).

>  				if (file->f_flags & O_NONBLOCK) {
> @@ -335,7 +343,6 @@ static ssize_t hiddev_read(struct file * file, ch=
ar __user * buffer, size_t coun
>  				}
> =20
>  				schedule();
> -				set_current_state(TASK_INTERRUPTIBLE);

This is wrong. Schedule ensures state to be TASK_RUNNING. Not setting i=
t
again for the next loop would be a bug (but better to be done right aft=
er
the while statement).

>  			}
> =20
>  			set_current_state(TASK_RUNNING);

and finish_wait()

> @@ -810,13 +817,6 @@ int hiddev_connect(struct hid_device *hid, unsig=
ned int force)
>  	if (!(hiddev =3D kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
>  		return -1;
> =20
> -	retval =3D usb_register_dev(usbhid->intf, &hiddev_class);
> -	if (retval) {
> -		err_hid("Not able to get a minor for this device.");
> -		kfree(hiddev);
> -		return -1;
> -	}
> -
>  	init_waitqueue_head(&hiddev->wait);
>  	INIT_LIST_HEAD(&hiddev->list);
>  	spin_lock_init(&hiddev->list_lock);
> @@ -828,6 +828,14 @@ int hiddev_connect(struct hid_device *hid, unsig=
ned int force)
> =20
>  	hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] =3D hiddev;

usbhid->intf->minor is set even after this call:

> +	retval =3D usb_register_dev(usbhid->intf, &hiddev_class);
> +	if (retval) {
> +		err_hid("Not able to get a minor for this device.");
> +		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] =3D NULL;
> +		kfree(hiddev);
> +		return -1;
> +	}
> +
>  	return 0;
>  }
> =20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
