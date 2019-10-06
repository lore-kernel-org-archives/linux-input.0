From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V2 1/5] dt-bindings: fsl: scu: add scu power key binding
Date: Sun, 6 Oct 2019 08:32:27 +0800
Message-ID: <20191006003225.GD7150@dragon>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <20190922161415.GD1999@bug>
 <DB3PR0402MB3916F48DA2A16E57C624432BF5850@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916F48DA2A16E57C624432BF5850@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Pavel Machek <pavel@ucw.cz>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "mripard@kernel.org" <mripard@kernel.org>, "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>, jagan@amarulaso
List-Id: linux-input@vger.kernel.org

On Mon, Sep 23, 2019 at 02:34:07AM +0000, Anson Huang wrote:
> Hi, Pavel
> 
> > Subject: Re: [PATCH V2 1/5] dt-bindings: fsl: scu: add scu power key binding
> > 
> > On Tue 2019-09-03 10:03:40, Anson Huang wrote:
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power, clock
> > > and power key event etc. management, Linux kernel has to communicate
> > > with system controller via MU (message unit) IPC to get power key
> > > event, add binding doc for i.MX system controller power key driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V1:
> > > 	- remove "wakeup-source" property, as it is NOT needed for SCU
> > interrupt;
> > > 	- remove "status" in example.
> > > ---
> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt          | 14
> > ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > index c149fad..f93e2e4 100644
> > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > @@ -157,6 +157,15 @@ Required properties:
> > >  Optional properties:
> > >  - timeout-sec: contains the watchdog timeout in seconds.
> > >
> > > +Power key bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible: should be:
> > > +              "fsl,imx8qxp-sc-pwrkey"
> > > +              followed by "fsl,imx-sc-pwrkey";
> > > +- linux,keycodes: See
> > > +Documentation/devicetree/bindings/input/keys.txt
> > 
> > Note you have keycode_s_ here, but keycode in the example and in the dts
> > patch.
> 
> NOT quite understand your point, could you please provide more details?

The property being used in driver, DTS, and DT example in the
bindings are all 'linux,keycode' rather than 'linux,keycodes'.

Shawn
