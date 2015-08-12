From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH v2 0/5] Add imx6ul touch screen controller support
Date: Wed, 12 Aug 2015 07:26:21 +0000
Message-ID: <BY1PR03MB13883A9E89CE57A8A1CE02A19A7E0@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>, "hadess@hadess.net" <hadess@hadess.net>, "mchehab@osg.samsung.com" <mchehab@osg.samsung.com>, "mamlinav@gmail.com" <mamlinav@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "jonathar@broadcom.com" <jonathar@broadcom.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>, "scott.liu@emc.com.tw" <scott.liu@emc.com.tw>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "sebastien.szymanski@armadeus.com" <sebastien.szymanski@armadeus.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kern
List-Id: linux-input@vger.kernel.org


Hi all,

Any suggestion about these patch set? Since half month passed without any response.



> -----Original Message-----
> From: Haibo Chen [mailto:haibo.chen@freescale.com]
> Sent: Tuesday, July 28, 2015 5:59 PM
> To: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; shawnguo@kernel.org;
> kernel@pengutronix.de; linux@arm.linux.org.uk; dmitry.torokhov@gmail.com
> Cc: Chen Haibo-B51421; hans.verkuil@cisco.com; hadess@hadess.net;
> mchehab@osg.samsung.com; mamlinav@gmail.com; arnd@arndb.de;
> jonathar@broadcom.com; hdegoede@redhat.com; christian.gmeiner@gmail.com;
> scott.liu@emc.com.tw; geert@linux-m68k.org; benjamin.tissoires@redhat.com;
> sebastien.szymanski@armadeus.com; sbranden@broadcom.com;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-input@vger.kernel.org
> Subject: [PATCH v2 0/5] Add imx6ul touch screen controller support
> 
> i.MX6UL contains a touch screen controller. This patch set add imx6ul
> touch screen controller driver support.
> 
> Changes for v2:
> -Add property in devicetree Documentation.
> -Add tsc disable code in tsc_remove function.
> -Remove some redundant code.
> 
> 
> Haibo Chen (5):
>   input: touchscreen: add imx6ul_tsc driver support
>   Documentation: Detail permitted DT properties for the imx6ul_tsc
>   ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
>   ARM: dts: imx6ul.dtsi: add TSC support
>   ARM: dts: imx6ul-14x14-evk.dts: add tsc support
> 
>  .../bindings/input/touchscreen/imx6ul_tsc.txt      |  36 ++
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  18 +
>  arch/arm/boot/dts/imx6ul.dtsi                      |  11 +
>  arch/arm/configs/imx_v6_v7_defconfig               |   1 +
>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/imx6ul_tsc.c             | 504
> +++++++++++++++++++++
>  7 files changed, 583 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
>  create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c
> 
> --
> 1.9.1
