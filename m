From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 0/3]  da9062: Add DA9062 OnKey support using the
 existing DA9063 OnKey driver
Date: Tue, 28 Jul 2015 09:52:16 +0100
Message-ID: <20150728085216.GP14943@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33807 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbbG1IwV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 04:52:21 -0400
Received: by wibud3 with SMTP id ud3so171096208wib.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2015 01:52:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>

> From: S Twiss <stwiss.opensource@diasemi.com>

Steve,

Can you sort out your git configuration please.  Your name should be
represented in full.  No abbreviations or synonyms please.

I would expect to see: 'Steve Twiss <stwiss.opensource@diasemi.com>'

The mailer is less important, but I suggest 'Steve Twiss' would be
more professional than either 'S Twiss' or 'Opensource [Steve Twiss]'.

I appreciate it might be company policy, but is there any chance of
reversing that to read 'Steve Twiss [Opensource]' instead?

> This patch set adds OnKey support for the Dialog DA9062 Power Managem=
ent IC.
> Changes are made to the existing DA9063 OnKey component so that funct=
ionality
> in this device driver can be re-used to support the DA9062 OnKey.
>=20
> This following patch set re-uses the existing kernel OnKey driver for=
 chips
> whose OnKey blocks are functionally similar to the DA9063 OnKey.
>=20
> The main points for the MFD core and device tree changes are as follo=
ws.
>=20
> - Alteration of the DA9063 OnKey Kconfig needs to be updated to depen=
d on
>   both MFD_DA9063 "or" MFD_DA9062. There is no explicit DA9062 OnKey =
Kconfig.
> - The DA9062 MFD core should add a new OnKey resource as usual and an=
 entry
>   in the mfd_cell to support a component name and of_compatible for
>   "da9062-onkey" and "dlg,da9062-onkey".
> - The device tree binding support should include a compatible string =
for
>   "dlg,da9062-onkey"
>=20
> The main points for the OnKey changes are as follows:
>=20
> A generic structure is used (called da906x_chip_config) to hold all g=
eneric
> registers and bitmasks for use with this type of OnKey component.
>=20
> Functions in the DA9063 OnKey will be refactored to use this compatib=
ility
> struct and all accesses to generic registers/masks will be made throu=
gh
> this table look-up instead of using defines from the register header =
files
> directly
>=20
> Linkage between the DA9062 MFD and the DA9063 OnKey driver is created=
 through
> the use of an of_match_table entry in the platform_driver structure.
> A re-work of da9063_onkey_probe() is necessary to use the of_match_no=
de() and
> dev_get_regmap() functions: this will provide initialisation of the g=
eneric
> registers and masks and allow access to the regmap according to the c=
orrect
> device tree specification.
>=20
> The addition of a of_device_id table for DA9063 and DA9062 default da=
ta
> is created.=20
>=20
> In this patch set the following is provided:
>  - [PATCH V3 1/3]: MFD changes in DA9062 to support OnKey
>  - [PATCH V3 2/3]: Update existing DA9063 OnKey to add DA9062 support
>  - [PATCH V3 3/3]: Device tree bindings for DA9062 OnKey component
>=20
> This patch applies against linux-next and next-20150708=20
>=20
> Thank you,
> Steve Twiss, Dialog Semiconductor Ltd.
>=20
> S Twiss (3):
>   mfd: da9062: Support for the DA9063 OnKey in the DA9062 core
>   onkey: da9063: Add DA9062 OnKey capability to DA9063 OnKey driver
>   devicetree: da9062: Add device tree bindings for DA9062 OnKey
>=20
>  .../devicetree/bindings/input/da9062-onkey.txt     |  36 ++++++
>  Documentation/devicetree/bindings/mfd/da9062.txt   |   3 +
>  drivers/input/misc/Kconfig                         |   8 +-
>  drivers/input/misc/da9063_onkey.c                  | 129 +++++++++++=
++++++----
>  drivers/mfd/da9062-core.c                          |  11 ++
>  5 files changed, 158 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/da9062-on=
key.txt
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
