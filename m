From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Register debugfs entries before adding device
Date: Mon, 15 Mar 2010 14:48:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003151448190.18642@pobox.suse.cz>
References: <20100313203953.0f3436b3@neptune.home> <Pine.LNX.4.44L0.1003131635170.19476-100000@netrider.rowland.org> <20100313231355.61c75c30@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100313231355.61c75c30@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>
List-Id: linux-input@vger.kernel.org

On Sat, 13 Mar 2010, Bruno Pr=C3=A9mont wrote:

> > If the device_add() fails, you should undo the hid_debug_register()=
=20
> > call.
>=20
> Well I was wondering why hid_debug_register() was called no matter wh=
at
> device_add() returned but didn't dig around what happened when
> hid_add_device() would return an error.
>=20
> Looking a few lines further, hid_remove_device() just unregisters deb=
ugfs
> entries when status has HID_STAT_ADDED so it definitely makes sense t=
o
> do the proper cleanup (and hid_remove_device() is the only once calli=
ng
> hid_debug_unregister())
>=20
> So patch for both below:
>=20
>=20
>=20
>=20
> Register debugfs entries before calling device_add() so debugfs entri=
es
> are already present when HID driver's probe function gets called on d=
evice
> hotplug.
> Also undo debugfs entry registration if device_add() fails so status
> HID_STAT_ADDED and debugfs registration status remain consistent and
> we don't leak the debugfs entries.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>=20
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index eabe5f8..709b4d0 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1759,11 +1759,12 @@ int hid_add_device(struct hid_device *hdev)
>  	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
>  		     hdev->vendor, hdev->product, atomic_inc_return(&id));
> =20
> +	hid_debug_register(hdev, dev_name(&hdev->dev));
>  	ret =3D device_add(&hdev->dev);
>  	if (!ret)
>  		hdev->status |=3D HID_STAT_ADDED;
> -
> -	hid_debug_register(hdev, dev_name(&hdev->dev));
> +	else
> +		hid_debug_unregister(hdev);
> =20
>  	return ret;

Applied, thank you Bruno.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
