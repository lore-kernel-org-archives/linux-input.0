From: Roman Volkov <v1ron@mail.ru>
Subject: Re: [PATCH 5/5] i8042: Add i8042_dt.h glue for DT support
Date: Tue, 3 Feb 2015 22:14:32 +0300
Message-ID: <20150203221432.662461d8@v1ron-s7>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
	<1422913730-12663-5-git-send-email-v1ron@v1ros.org>
	<20150203115249.GB30866@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150203115249.GB30866@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Roman Volkov <v1ron@v1ros.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

=D0=92 Tue, 3 Feb 2015 11:52:50 +0000
Mark Rutland <mark.rutland@arm.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Mon, Feb 02, 2015 at 09:48:50PM +0000, Roman Volkov wrote:
> > This header file designed to be similar to other glue layers found
> > for i8042. The difference is that interrupt numbers, device address=
,
> > and other information should be retrieved from the device tree.
> >=20
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> > ---
> >  drivers/input/serio/i8042-dt.h | 112
> > +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 112
> > insertions(+) create mode 100644 drivers/input/serio/i8042-dt.h
> >=20
> > diff --git a/drivers/input/serio/i8042-dt.h
> > b/drivers/input/serio/i8042-dt.h new file mode 100644
> > index 0000000..0d1a344
> > --- /dev/null
> > +++ b/drivers/input/serio/i8042-dt.h
> > @@ -0,0 +1,112 @@
> > +#ifndef _I8042_DT_H
> > +#define _I8042_DT_H
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or
> > modify it
> > + * under the terms of the GNU General Public License version 2 as
> > published by
> > + * the Free Software Foundation.
> > + */
> > +
> > +static void __iomem *i8042_base;
> > +static unsigned int i8042_command_reg;
> > +static unsigned int i8042_status_reg;
> > +static unsigned int i8042_data_reg;
> > +#define I8042_COMMAND_REG i8042_command_reg
> > +#define I8042_STATUS_REG i8042_status_reg
> > +#define I8042_DATA_REG i8042_data_reg
> > +
> > +/*
> > + * Names.
> > + */
> > +
> > +static const char *i8042_kbd_phys_desc;
> > +static const char *i8042_aux_phys_desc;
> > +static const char *i8042_mux_phys_desc;
> > +#define I8042_KBD_PHYS_DESC i8042_kbd_phys_desc
> > +#define I8042_AUX_PHYS_DESC i8042_aux_phys_desc
> > +#define I8042_MUX_PHYS_DESC i8042_mux_phys_desc
> > +
> > +/*
> > + * IRQs.
> > + */
> > +static int i8042_kbd_irq;
> > +static int i8042_aux_irq;
> > +#define I8042_KBD_IRQ i8042_kbd_irq
> > +#define I8042_AUX_IRQ i8042_aux_irq
>=20
> That's a lot of static values. Surely nothing physically prevents the
> use of multiple i8042 chips?
>=20
> > +
> > +static inline int i8042_read_data(void)
> > +{
> > +	return readb(i8042_base + i8042_data_reg);
> > +}
> > +
> > +static inline int i8042_read_status(void)
> > +{
> > +	return readb(i8042_base + i8042_status_reg);
> > +}
> > +
> > +static inline void i8042_write_data(int val)
> > +{
> > +	writeb(val, i8042_base + i8042_data_reg);
> > +}
> > +
> > +static inline void i8042_write_command(int val)
> > +{
> > +	writeb(val, i8042_base + i8042_command_reg);
> > +}
> > +
> > +static inline int i8042_platform_init(struct platform_device *pdev=
)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	int status;
> > +
> > +	i8042_base =3D of_iomap(np, 0);
> > +	if (!i8042_base)
> > +		return -ENOMEM;
> > +
> > +	status =3D of_property_read_u32(np, "command-reg",
> > &i8042_command_reg);
> > +	if (status)
> > +		return status;
> > +
> > +	status =3D of_property_read_u32(np, "status-reg",
> > &i8042_status_reg);
> > +	if (status)
> > +		return status;
> > +
> > +	status =3D of_property_read_u32(np, "data-reg",
> > &i8042_data_reg);
> > +	if (status)
> > +		return status;
>=20
> You should probably validate that these are within the range provided
> in the reg property.
>=20
> You also need to clean up if you fail. It looks like here and below w=
e
> leak the i8042_base mapping if we decide to fail.
>=20
> > +
> > +	i8042_kbd_irq =3D irq_of_parse_and_map(np, 0);
> > +	i8042_aux_irq =3D irq_of_parse_and_map(np, 1);
>=20
> You can use platform_get_irq(pdev, N) here, the IRQ will already have
> been parsed by the core.
>=20
> > +	status =3D of_property_read_string(np, "linux,kbd_phys_desc",
> > +
> > &i8042_kbd_phys_desc);
> > +	if (status)
> > +		i8042_kbd_phys_desc =3D "i8042/serio0";
> > +
> > +	status =3D of_property_read_string(np, "linux,aux_phys_desc",
> > +
> > &i8042_aux_phys_desc);
> > +	if (status)
> > +		i8042_aux_phys_desc =3D "i8042/serio1";
> > +
> > +	status =3D of_property_read_string(np, "linux,mux_phys_desc",
> > +
> > &i8042_mux_phys_desc);
> > +	if (status)
> > +		i8042_mux_phys_desc =3D "i8042/serio%d";
>=20
> User-provided values as format strings? Not a good idea.
>=20
> What exactly are these used for?
>=20
> > +
> > +	if (of_get_property(np, "init-reset", NULL))
> > +		i8042_reset =3D true;
>=20
> Use of_property_read_bool.
>=20
> Thanks,
> Mark.

Mark, thanks for the good review. The current i8042 driver likely does
not support multiple controllers. Maybe Dmitry will comment something
regarding this and overall idea.

I will check the case when DTS contains multiple i8042-compatible
nodes. Expected behavior is that only the first node will be parsed and
next nodes are silently ignored.

Regards,
Roman.

Regards,
Roman.
