From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] i8042: Add i8042_dt.h glue for DT support
Date: Tue, 3 Feb 2015 11:26:55 -0800
Message-ID: <20150203192655.GA20256@dtor-ws>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
 <1422913730-12663-5-git-send-email-v1ron@v1ros.org>
 <20150203115249.GB30866@leverpostej>
 <20150203221432.662461d8@v1ron-s7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33115 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbbBCT1C (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 14:27:02 -0500
Content-Disposition: inline
In-Reply-To: <20150203221432.662461d8@v1ron-s7>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roman Volkov <v1ron@mail.ru>
Cc: Mark Rutland <mark.rutland@arm.com>, Roman Volkov <v1ron@v1ros.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Prisk <linux@prisktech.co.nz>

On Tue, Feb 03, 2015 at 10:14:32PM +0300, Roman Volkov wrote:
> =D0=92 Tue, 3 Feb 2015 11:52:50 +0000
> Mark Rutland <mark.rutland@arm.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> > On Mon, Feb 02, 2015 at 09:48:50PM +0000, Roman Volkov wrote:
> > > This header file designed to be similar to other glue layers foun=
d
> > > for i8042. The difference is that interrupt numbers, device addre=
ss,
> > > and other information should be retrieved from the device tree.
> > >=20
> > > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > > Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> > > ---
> > >  drivers/input/serio/i8042-dt.h | 112
> > > +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 112
> > > insertions(+) create mode 100644 drivers/input/serio/i8042-dt.h
> > >=20
> > > diff --git a/drivers/input/serio/i8042-dt.h
> > > b/drivers/input/serio/i8042-dt.h new file mode 100644
> > > index 0000000..0d1a344
> > > --- /dev/null
> > > +++ b/drivers/input/serio/i8042-dt.h
> > > @@ -0,0 +1,112 @@
> > > +#ifndef _I8042_DT_H
> > > +#define _I8042_DT_H
> > > +
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_irq.h>
> > > +
> > > +/*
> > > + * This program is free software; you can redistribute it and/or
> > > modify it
> > > + * under the terms of the GNU General Public License version 2 a=
s
> > > published by
> > > + * the Free Software Foundation.
> > > + */
> > > +
> > > +static void __iomem *i8042_base;
> > > +static unsigned int i8042_command_reg;
> > > +static unsigned int i8042_status_reg;
> > > +static unsigned int i8042_data_reg;
> > > +#define I8042_COMMAND_REG i8042_command_reg
> > > +#define I8042_STATUS_REG i8042_status_reg
> > > +#define I8042_DATA_REG i8042_data_reg
> > > +
> > > +/*
> > > + * Names.
> > > + */
> > > +
> > > +static const char *i8042_kbd_phys_desc;
> > > +static const char *i8042_aux_phys_desc;
> > > +static const char *i8042_mux_phys_desc;
> > > +#define I8042_KBD_PHYS_DESC i8042_kbd_phys_desc
> > > +#define I8042_AUX_PHYS_DESC i8042_aux_phys_desc
> > > +#define I8042_MUX_PHYS_DESC i8042_mux_phys_desc
> > > +
> > > +/*
> > > + * IRQs.
> > > + */
> > > +static int i8042_kbd_irq;
> > > +static int i8042_aux_irq;
> > > +#define I8042_KBD_IRQ i8042_kbd_irq
> > > +#define I8042_AUX_IRQ i8042_aux_irq
> >=20
> > That's a lot of static values. Surely nothing physically prevents t=
he
> > use of multiple i8042 chips?

i8042 is currently is a singleton and I do not really see it changing.
That said I would like at some point to decouple setting up of the
platform device from the driver itself and maybe getting rig of all
these statics.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
