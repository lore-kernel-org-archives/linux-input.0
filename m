From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [RFC] Simple but effective way of changing HID device
 descriptors (resent)
Date: Thu, 24 Dec 2009 09:39:18 +0100
Message-ID: <20091224093918.1fe7e32a.ospite@studenti.unina.it>
References: <4B32D21B.9090800@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Dec_2009_09_39_18_+0100_oV.mrp2ErluvgjS9"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out13.alice.it ([85.33.2.18]:4802 "EHLO
	smtp-out13.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbZLXIjg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2009 03:39:36 -0500
In-Reply-To: <4B32D21B.9090800@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Tolysz <tolysz@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Thu__24_Dec_2009_09_39_18_+0100_oV.mrp2ErluvgjS9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Dec 2009 02:29:47 +0000
Marcin Tolysz <tolysz@gmail.com> wrote:

> Simple but effective way of changing HID device descriptors using=20
> firmware loading mechanism.
> Just place your new descriptor in a location specified by driver
> i.e. somewhere in /lib/firmware/hid/
> If it is there it will replace HID descriptor from the device.
> I do not do any parsing or checking, as it is done by hid driver.
>=20
> Signed-off-by: Marcin Tolysz <tolysz@gmail.com>
>

Only some style comments below, I haven't tested the patch. Plus, try
running the patch through scripts/checkpatch.pl to spot all the other
style issues.

> ---
>   drivers/hid/hid-core.c |   26 +++++++++++++++++++++++++-
>   1 files changed, 25 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 80792d3..5d8d656 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -27,6 +27,7 @@
>   #include <linux/wait.h>
>   #include <linux/vmalloc.h>
>   #include <linux/sched.h>
> +#include <linux/firmware.h>
>=20
>   #include <linux/hid.h>
>   #include <linux/hiddev.h>
> @@ -640,6 +641,10 @@ int hid_parse_report(struct hid_device *device,=20
> __u8 *start,
>   	struct hid_item item;
>   	__u8 *end;
>   	int ret;
> +	const struct firmware *fw;
> +	int succ;

success? Can't you init fw to NULL and derive this info checking
(fw !=3D NULL) before releasing firmware?

> +	char *file;
> +
>   	static int (*dispatch_type[])(struct hid_parser *parser,
>   				      struct hid_item *item) =3D {
>   		hid_parser_main,
> @@ -650,10 +655,27 @@ int hid_parse_report(struct hid_device *device,=20
> __u8 *start,
>=20
>   	if (device->driver->report_fixup)
>   		device->driver->report_fixup(device, start, size);
> +	/* Now load a hid descriptor from a file firmware
> +	ignoring this fixup thing */
> +	file=3Dkmalloc(29, GFP_KERNEL);
> +=20
> sprintf(file,"hid/%04X:%04X:%04X:%04X.bin",device->bus,device->vendor,dev=
ice->product,device->version);
> +

What about removing this 29?
#define NEW_HID_DESCRIPTOR_PATH_FMT "hid/%04X:%04X:%04X:%04X.bin"
and use it in kmalloc with strlen and in sprintf.

> +	succ =3D request_firmware(&fw, file, &device->dev);
> +
> +	if (succ)
> +		printk(KERN_INFO "To relace HID descriptor place it in=20
> /lib/firmaware/%s\n", file);

pr_info() could be used or maybe even dev_info()

> +	else{
> +		start =3D fw->data;
> +		size =3D fw->size;
> +		printk(KERN_INFO "HID descriptor relaced with /lib/firmaware/%s\n",=20
> file);
> +	}
> +	kfree(file);
>=20
>   	device->rdesc =3D kmalloc(size, GFP_KERNEL);
> -	if (device->rdesc =3D=3D NULL)
> +	if (device->rdesc =3D=3D NULL){
> +		if(!succ)release_firmware(fw);
>   		return -ENOMEM;
> +	}
>   	memcpy(device->rdesc, start, size);
>   	device->rsize =3D size;
>=20
> @@ -690,6 +712,7 @@ int hid_parse_report(struct hid_device *device, __u8=
=20
> *start,
>   				dbg_hid("unbalanced delimiter at end of report description\n");
>   				goto err;
>   			}
> +			if(!succ)release_firmware(fw);
>   			vfree(parser);
>   			return 0;
>   		}
> @@ -697,6 +720,7 @@ int hid_parse_report(struct hid_device *device, __u8=
=20
> *start,
>=20
>   	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
>   err:
> +	if(!succ)release_firmware(fw);
>   	vfree(parser);
>   	return ret;
>   }
> -- 1.6.5.7

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Thu__24_Dec_2009_09_39_18_+0100_oV.mrp2ErluvgjS9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkszKLYACgkQ5xr2akVTsAHPXQCfZ54jb2sK7NsN+YGLfKPyGkQQ
xlEAoJx9jxJcaFZAi9FWeIA2No9o+S0V
=zDiA
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Dec_2009_09_39_18_+0100_oV.mrp2ErluvgjS9--
