From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Wed, 21 Apr 2010 10:07:50 -0700
Message-ID: <20100421170750.GA10566@core.coreip.homeip.net>
References: <20100329233257.GA85504@jhz.name>
 <20100421070158.GM4364@core.coreip.homeip.net>
 <20100421081048.GA22357@core.coreip.homeip.net>
 <201004211035.38264.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52932 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab0DURH6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 13:07:58 -0400
Received: by vws18 with SMTP id 18so146004vws.19
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 10:07:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004211035.38264.bjorn.helgaas@hp.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jan-Hendrik Zab <jan@jhz.name>, torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Wed, Apr 21, 2010 at 10:35:37AM -0600, Bjorn Helgaas wrote:
> On Wednesday 21 April 2010 02:10:48 am Dmitry Torokhov wrote:
> > @@ -169,11 +182,17 @@ static int __init pnpacpi_add_device(struct a=
cpi_device *device)
> > =A0=A0=A0=A0=A0=A0=A0=A0 * driver should not be loaded.
> > =A0=A0=A0=A0=A0=A0=A0=A0 */
> > =A0=A0=A0=A0=A0=A0=A0=A0status =3D acpi_get_handle(device->handle, =
"_CRS", &temp);
> > -=A0=A0=A0=A0=A0=A0=A0if (ACPI_FAILURE(status) || !ispnpidacpi(acpi=
_device_hid(device)) ||
> > -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0is_exclusive_device(device) || (!devi=
ce->status.present))
> > +=A0=A0=A0=A0=A0=A0=A0if (ACPI_FAILURE(status))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0pnpid =3D pnpacpi_get_id(device);
> > +=A0=A0=A0=A0=A0=A0=A0if (!pnpid)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
>=20
> I think this makes sense, but I think we should also adjust the loop
> at the end of pnpacpi_add_device() that adds all the CIDs.  As it
> currently works, I think your patch will cause this device to have
> two copies of the CID, e.g.,
>=20
>   PNP0F13 PNP0F13
>=20

Yep, you are right. I will adjust it after I hear from Jan whether it
fixes his issue.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
