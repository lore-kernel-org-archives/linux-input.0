From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv4 2/5] Input: edt-ft5x06: Add DT support
Date: Thu, 20 Mar 2014 12:44:18 +0100
Message-ID: <20140320124418.55b79a3e@ipc1.ka-ro>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
	<1395234563-11034-3-git-send-email-LW@KARO-electronics.de>
	<c9718f7215eb41439606b0107a8e2a02@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <c9718f7215eb41439606b0107a8e2a02@BLUPR03MB373.namprd03.prod.outlook.com>
Sender: linux-doc-owner@vger.kernel.org
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Budig <simon.budig@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

Hi,

fugang.duan@freescale.com wrote:
> From: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Data: Wednesday, March 19, 2014 9:09 PM
>=20
> >To: Dmitry Torokhov; Duan Fugang-B38611; Grant Likely; Henrik Rydber=
g; Ian
> >Campbell; Jingoo Han; Kumar Gala; Mark Rutland; Pawel Moll; Rob Herr=
ing; Rob
> >Landley; Sachin Kamat; devicetree@vger.kernel.org; linux-doc@vger.ke=
rnel.org;
> >linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Simon Bud=
ig; Lothar
> >Wa=C3=9Fmann
> >Subject: [PATCHv4 2/5] Input: edt-ft5x06: Add DT support
> >
> >
No need to quote the mail headers here.

[...]
> >diff --git a/drivers/input/touchscreen/edt-ft5x06.c
> >b/drivers/input/touchscreen/edt-ft5x06.c
> >index 7b4470d..257a1c8 100644
> >--- a/drivers/input/touchscreen/edt-ft5x06.c
> >+++ b/drivers/input/touchscreen/edt-ft5x06.c
> >@@ -33,6 +33,7 @@
> > #include <linux/debugfs.h>
> > #include <linux/slab.h>
> > #include <linux/gpio.h>
> >+#include <linux/of_gpio.h>
> > #include <linux/input/mt.h>
> > #include <linux/input/edt-ft5x06.h>
> >
> [...]
> >+#ifdef CONFIG_OF
> >+static int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
> >+				struct edt_ft5x06_ts_data *tsdata)
> >+{
> >+	struct device_node *np =3D dev->of_node;
> >+
> >+	if (!np)
> >+		return -ENODEV;
> Don't need to check the device node valid. If the device node is not =
existed, the driver don't run probe.
>=20
Perfectly right. I'll drop this in the next version.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
