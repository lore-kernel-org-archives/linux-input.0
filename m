From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Wed, 21 Apr 2010 10:35:37 -0600
Message-ID: <201004211035.38264.bjorn.helgaas@hp.com>
References: <20100329233257.GA85504@jhz.name> <20100421070158.GM4364@core.coreip.homeip.net> <20100421081048.GA22357@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:2910 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab0DUQfk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 12:35:40 -0400
In-Reply-To: <20100421081048.GA22357@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jan-Hendrik Zab <jan@jhz.name>, torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Wednesday 21 April 2010 02:10:48 am Dmitry Torokhov wrote:
> PNPACPI: cope with invalid device IDs
>=20
> If primary ID (HID) is invalid try locating first valid ID on compati=
ble
> ID list before giving up.
>=20
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>=20
> =A0drivers/pnp/pnpacpi/core.c =A0 =A0 =A0| =A0 27 +++++++++++++++++++=
++++----
> =A0include/linux/mod_devicetable.h | =A0 =A01 +
> =A02 files changed, 24 insertions(+), 4 deletions(-)
>=20
>=20
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index f7ff628..1bf1677 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -28,7 +28,7 @@
> =A0#include "../base.h"
> =A0#include "pnpacpi.h"
> =A0
> -static int num =3D 0;
> +static int num;
> =A0
> =A0/* We need only to blacklist devices that have already an acpi dri=
ver that
> =A0 * can't use pnp layer. We don't need to blacklist device that are=
 directly
> @@ -157,11 +157,24 @@ struct pnp_protocol pnpacpi_protocol =3D {
> =A0};
> =A0EXPORT_SYMBOL(pnpacpi_protocol);
> =A0
> +static char *pnpacpi_get_id(struct acpi_device *device)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct acpi_hardware_id *id;
> +
> +=A0=A0=A0=A0=A0=A0=A0list_for_each_entry(id, &device->pnp.ids, list)=
 {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ispnpidacpi(id->id)=
)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
return id->id;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0return NULL;
> +}
> +
> =A0static int __init pnpacpi_add_device(struct acpi_device *device)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0acpi_handle temp =3D NULL;
> =A0=A0=A0=A0=A0=A0=A0=A0acpi_status status;
> =A0=A0=A0=A0=A0=A0=A0=A0struct pnp_dev *dev;
> +=A0=A0=A0=A0=A0=A0=A0char *pnpid;
> =A0=A0=A0=A0=A0=A0=A0=A0struct acpi_hardware_id *id;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/*
> @@ -169,11 +182,17 @@ static int __init pnpacpi_add_device(struct acp=
i_device *device)
> =A0=A0=A0=A0=A0=A0=A0=A0 * driver should not be loaded.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0=A0status =3D acpi_get_handle(device->handle, "_=
CRS", &temp);
> -=A0=A0=A0=A0=A0=A0=A0if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_d=
evice_hid(device)) ||
> -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0is_exclusive_device(device) || (!device=
->status.present))
> +=A0=A0=A0=A0=A0=A0=A0if (ACPI_FAILURE(status))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0pnpid =3D pnpacpi_get_id(device);
> +=A0=A0=A0=A0=A0=A0=A0if (!pnpid)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;

I think this makes sense, but I think we should also adjust the loop
at the end of pnpacpi_add_device() that adds all the CIDs.  As it
currently works, I think your patch will cause this device to have
two copies of the CID, e.g.,

  PNP0F13 PNP0F13

Bjorn

> +
> +=A0=A0=A0=A0=A0=A0=A0if (!is_exclusive_device(device) || !device->st=
atus.present)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0dev =3D pnp_alloc_dev(&pnpacpi_protocol, num, a=
cpi_device_hid(device));
> +=A0=A0=A0=A0=A0=A0=A0dev =3D pnp_alloc_dev(&pnpacpi_protocol, num, p=
npid);
> =A0=A0=A0=A0=A0=A0=A0=A0if (!dev)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> =A0


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
