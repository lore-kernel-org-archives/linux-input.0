From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/6 v2] input: Add support for VIA VT8500 and compatibles
 in i8042
Date: Fri, 12 Nov 2010 15:30:13 -0800
Message-ID: <20101112233013.GA30946@core.coreip.homeip.net>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
 <1289147348-31969-3-git-send-email-alchark@gmail.com>
 <AANLkTi=zvGxpukjAv-XFAMLpKYiqqKD=p9S5FtGowdDu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43709 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932958Ab0KLXaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 18:30:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=zvGxpukjAv-XFAMLpKYiqqKD=p9S5FtGowdDu@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, vt8500-wm8505-linux-kernel@googlegroups.com, Tony Lindgren <tony@atomide.com>, Feng Tang <feng.tang@intel.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Nov 13, 2010 at 01:54:14AM +0300, Alexey Charkov wrote:
> 2010/11/7 Alexey Charkov <alchark@gmail.com>:
> > VIA and WonderMedia Systems-on-Chip feature a standard i8042-compat=
ible
> > keyboard and mouse controller. This adds necessary glue to enable u=
se
> > of the standard driver with these systems.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >
> > Please review and (if appropriate) commit to a relevant git tree fo=
r
> > further integration in 2.6.38.
> >
> > Previous version of this code was 'Acked-by: Dmitry Torokhov <dtor@=
mail.ru>'
> > This one only differs by using runtime-selected IRQ definitions ins=
tead
> > of static compile-time preprocessor macros.
> >
> > Relevant register and interrupt definitions are provided by PATCH 1=
/6 in
> > this series, so one would need that to make use of this code.
> >
> > =A0drivers/input/serio/Kconfig =A0 =A0 =A0 =A0| =A0 =A03 +-
> > =A0drivers/input/serio/i8042-vt8500.h | =A0 74 ++++++++++++++++++++=
++++++++++++++++
> > =A0drivers/input/serio/i8042.h =A0 =A0 =A0 =A0| =A0 =A02 +
> > =A03 files changed, 78 insertions(+), 1 deletions(-)
> > =A0create mode 100644 drivers/input/serio/i8042-vt8500.h
> >
> > diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kcon=
fig
> > index 6256233..ff799f3 100644
> > --- a/drivers/input/serio/Kconfig
> > +++ b/drivers/input/serio/Kconfig
> > @@ -21,7 +21,8 @@ if SERIO
> > =A0config SERIO_I8042
> > =A0 =A0 =A0 =A0tristate "i8042 PC Keyboard controller" if EMBEDDED =
|| !X86
> > =A0 =A0 =A0 =A0default y
> > - =A0 =A0 =A0 depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRID=
GE_HOST) && \
> > + =A0 =A0 =A0 depends on !PARISC && \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!ARM || ARCH_SHARK || ARCH_VT850=
0 || FOOTBRIDGE_HOST) && \
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!SUPERH || SH_CAYMAN) && !M68K=
 && !BLACKFIN
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0i8042 is the chip over which the standard AT key=
board and PS/2
> > diff --git a/drivers/input/serio/i8042-vt8500.h b/drivers/input/ser=
io/i8042-vt8500.h
> > new file mode 100644
> > index 0000000..4ff9e1c
> > --- /dev/null
> > +++ b/drivers/input/serio/i8042-vt8500.h
> > @@ -0,0 +1,74 @@
> > +#ifndef _I8042_VT8500_H
> > +#define _I8042_VT8500_H
> > +
> > +#include <mach/mmio_regs.h>
> > +#include <mach/irq_defs.h>
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or m=
odify it
> > + * under the terms of the GNU General Public License version 2 as =
published by
> > + * the Free Software Foundation.
> > + */
> > +
> > +static void __iomem *regbase;
> > +
> > +/*
> > + * Names.
> > + */
> > +
> > +#define I8042_KBD_PHYS_DESC "vt8500ps2/serio0"
> > +#define I8042_AUX_PHYS_DESC "vt8500ps2/serio1"
> > +#define I8042_MUX_PHYS_DESC "vt8500ps2/serio%d"
> > +
> > +/*
> > + * IRQs.
> > + */
> > +
> > +#define I8042_KBD_IRQ =A0(wmt_current_irqs->ps2kbd)
> > +#define I8042_AUX_IRQ =A0(wmt_current_irqs->ps2mouse)
> > +
> > +
> > +/*
> > + * Register numbers.
> > + */
> > +
> > +#define I8042_COMMAND_REG =A0 =A0 =A0(regbase + 0x4)
> > +#define I8042_STATUS_REG =A0 =A0 =A0 (regbase + 0x4)
> > +#define I8042_DATA_REG =A0 =A0 =A0 =A0 (regbase + 0x0)
> > +
> > +static inline int i8042_read_data(void)
> > +{
> > + =A0 =A0 =A0 return readl(I8042_DATA_REG);
> > +}
> > +
> > +static inline int i8042_read_status(void)
> > +{
> > + =A0 =A0 =A0 return readl(I8042_STATUS_REG);
> > +}
> > +
> > +static inline void i8042_write_data(int val)
> > +{
> > + =A0 =A0 =A0 writel(val, I8042_DATA_REG);
> > +}
> > +
> > +static inline void i8042_write_command(int val)
> > +{
> > + =A0 =A0 =A0 writel(val, I8042_COMMAND_REG);
> > +}
> > +
> > +static inline int i8042_platform_init(void)
> > +{
> > + =A0 =A0 =A0 i8042_reset =3D true;
> > + =A0 =A0 =A0 regbase =3D ioremap(wmt_current_regs->ps2, SZ_1K);
> > + =A0 =A0 =A0 if (!regbase)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static inline void i8042_platform_exit(void)
> > +{
> > + =A0 =A0 =A0 iounmap(regbase);
> > +}
> > +
> > +#endif /* _I8042_VT8500_H */
> > diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i804=
2.h
> > index cbc1beb..bdb2aeb 100644
> > --- a/drivers/input/serio/i8042.h
> > +++ b/drivers/input/serio/i8042.h
> > @@ -16,6 +16,8 @@
> >
> > =A0#if defined(CONFIG_MACH_JAZZ)
> > =A0#include "i8042-jazzio.h"
> > +#elif defined(CONFIG_ARCH_VT8500)
> > +#include "i8042-vt8500.h"
> > =A0#elif defined(CONFIG_SGI_HAS_I8042)
> > =A0#include "i8042-ip22io.h"
> > =A0#elif defined(CONFIG_SNI_RM)
> > --
> > 1.7.3.2
> >
> >
>=20
> Any comments about this?
>=20

Looks good to me (ignoring the fact that whole i8042 initialization
needs to be reworked and pushed into arch/board code which is out of
scope of these series).

I expect it will be merged with the rest of VT8500 patches through
whatever tree takes them.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
