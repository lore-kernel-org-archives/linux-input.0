From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Sat, 13 Mar 2010 16:35:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003131635170.19476-100000@netrider.rowland.org>
References: <20100313203953.0f3436b3@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:35185 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759303Ab0CMVgA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Mar 2010 16:36:00 -0500
In-Reply-To: <20100313203953.0f3436b3@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

On Sat, 13 Mar 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:

> Is something like below acceptable? (from error handling point of vie=
w
> it makes no difference...)
>=20
> Thanks,
> Bruno
>=20
> file: drivers/hid/hid-core.c
>=20
>  int hid_add_device(struct hid_device *hdev)
>  {
>          static atomic_t id =3D ATOMIC_INIT(0);
>          int ret;
> =20
>          if (WARN_ON(hdev->status & HID_STAT_ADDED))
>                  return -EBUSY;
> =20
>          /* we need to kill them here, otherwise they will stay alloc=
ated to
>           * wait for coming driver */
>          if (hid_ignore(hdev))
>                  return -ENODEV;
> =20
>          /* XXX hack, any other cleaner solution after the driver cor=
e
>           * is converted to allow more than 20 bytes as the device na=
me? */
>          dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
>                       hdev->vendor, hdev->product, atomic_inc_return(=
&id));
> =20
> +        hid_debug_register(hdev, dev_name(&hdev->dev));
>          ret =3D device_add(&hdev->dev);
>          if (!ret)
>                  hdev->status |=3D HID_STAT_ADDED;
> =20
> -        hid_debug_register(hdev, dev_name(&hdev->dev));
> =20
>          return ret;
>  }

If the device_add() fails, you should undo the hid_debug_register()=20
call.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
