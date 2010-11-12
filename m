From: Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 3/6 v2] input: Add support for VIA VT8500 and compatibles
 in i8042
Date: Sat, 13 Nov 2010 01:54:14 +0300
Message-ID: <AANLkTi=zvGxpukjAv-XFAMLpKYiqqKD=p9S5FtGowdDu@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-3-git-send-email-alchark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64891 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab0KLWyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 17:54:15 -0500
In-Reply-To: <1289147348-31969-3-git-send-email-alchark@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: vt8500-wm8505-linux-kernel@googlegroups.com, Alexey Charkov <alchark@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Feng Tang <feng.tang@intel.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

2010/11/7 Alexey Charkov <alchark@gmail.com>:
> VIA and WonderMedia Systems-on-Chip feature a standard i8042-compatib=
le
> keyboard and mouse controller. This adds necessary glue to enable use
> of the standard driver with these systems.
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>
> Please review and (if appropriate) commit to a relevant git tree for
> further integration in 2.6.38.
>
> Previous version of this code was 'Acked-by: Dmitry Torokhov <dtor@ma=
il.ru>'
> This one only differs by using runtime-selected IRQ definitions inste=
ad
> of static compile-time preprocessor macros.
>
> Relevant register and interrupt definitions are provided by PATCH 1/6=
 in
> this series, so one would need that to make use of this code.
>
> =C2=A0drivers/input/serio/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A03 +-
> =C2=A0drivers/input/serio/i8042-vt8500.h | =C2=A0 74 ++++++++++++++++=
++++++++++++++++++++
> =C2=A0drivers/input/serio/i8042.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A02 +
> =C2=A03 files changed, 78 insertions(+), 1 deletions(-)
> =C2=A0create mode 100644 drivers/input/serio/i8042-vt8500.h
>
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfi=
g
> index 6256233..ff799f3 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -21,7 +21,8 @@ if SERIO
> =C2=A0config SERIO_I8042
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "i8042 PC Keyboard controller" if=
 EMBEDDED || !X86
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default y
> - =C2=A0 =C2=A0 =C2=A0 depends on !PARISC && (!ARM || ARCH_SHARK || F=
OOTBRIDGE_HOST) && \
> + =C2=A0 =C2=A0 =C2=A0 depends on !PARISC && \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!ARM || AR=
CH_SHARK || ARCH_VT8500 || FOOTBRIDGE_HOST) && \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!SUPE=
RH || SH_CAYMAN) && !M68K && !BLACKFIN
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i8042 is the chip over which the st=
andard AT keyboard and PS/2
> diff --git a/drivers/input/serio/i8042-vt8500.h b/drivers/input/serio=
/i8042-vt8500.h
> new file mode 100644
> index 0000000..4ff9e1c
> --- /dev/null
> +++ b/drivers/input/serio/i8042-vt8500.h
> @@ -0,0 +1,74 @@
> +#ifndef _I8042_VT8500_H
> +#define _I8042_VT8500_H
> +
> +#include <mach/mmio_regs.h>
> +#include <mach/irq_defs.h>
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + */
> +
> +static void __iomem *regbase;
> +
> +/*
> + * Names.
> + */
> +
> +#define I8042_KBD_PHYS_DESC "vt8500ps2/serio0"
> +#define I8042_AUX_PHYS_DESC "vt8500ps2/serio1"
> +#define I8042_MUX_PHYS_DESC "vt8500ps2/serio%d"
> +
> +/*
> + * IRQs.
> + */
> +
> +#define I8042_KBD_IRQ =C2=A0(wmt_current_irqs->ps2kbd)
> +#define I8042_AUX_IRQ =C2=A0(wmt_current_irqs->ps2mouse)
> +
> +
> +/*
> + * Register numbers.
> + */
> +
> +#define I8042_COMMAND_REG =C2=A0 =C2=A0 =C2=A0(regbase + 0x4)
> +#define I8042_STATUS_REG =C2=A0 =C2=A0 =C2=A0 (regbase + 0x4)
> +#define I8042_DATA_REG =C2=A0 =C2=A0 =C2=A0 =C2=A0 (regbase + 0x0)
> +
> +static inline int i8042_read_data(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return readl(I8042_DATA_REG);
> +}
> +
> +static inline int i8042_read_status(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return readl(I8042_STATUS_REG);
> +}
> +
> +static inline void i8042_write_data(int val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 writel(val, I8042_DATA_REG);
> +}
> +
> +static inline void i8042_write_command(int val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 writel(val, I8042_COMMAND_REG);
> +}
> +
> +static inline int i8042_platform_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 i8042_reset =3D true;
> + =C2=A0 =C2=A0 =C2=A0 regbase =3D ioremap(wmt_current_regs->ps2, SZ_=
1K);
> + =C2=A0 =C2=A0 =C2=A0 if (!regbase)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static inline void i8042_platform_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 iounmap(regbase);
> +}
> +
> +#endif /* _I8042_VT8500_H */
> diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.=
h
> index cbc1beb..bdb2aeb 100644
> --- a/drivers/input/serio/i8042.h
> +++ b/drivers/input/serio/i8042.h
> @@ -16,6 +16,8 @@
>
> =C2=A0#if defined(CONFIG_MACH_JAZZ)
> =C2=A0#include "i8042-jazzio.h"
> +#elif defined(CONFIG_ARCH_VT8500)
> +#include "i8042-vt8500.h"
> =C2=A0#elif defined(CONFIG_SGI_HAS_I8042)
> =C2=A0#include "i8042-ip22io.h"
> =C2=A0#elif defined(CONFIG_SNI_RM)
> --
> 1.7.3.2
>
>

Any comments about this?

Thanks,
Alexey
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
