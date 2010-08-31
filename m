From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 2/5] ARM: pxa168: added keypad support
Date: Tue, 31 Aug 2010 12:56:01 +0800
Message-ID: <AANLkTimZyGdRpQV_ZgJ8TdJzQ=rvpjV3+kPJsU+QKT=g@mail.gmail.com>
References: <1282814339-10934-1-git-send-email-mark.brown314@gmail.com>
	<1282814339-10934-3-git-send-email-mark.brown314@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282814339-10934-3-git-send-email-mark.brown314@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 26, 2010 at 5:18 PM, Mark F. Brown <mark.brown314@gmail.com=
> wrote:
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
> =A0arch/arm/mach-mmp/include/mach/mfp-pxa168.h | =A0 =A07 +++++++
> =A0arch/arm/mach-mmp/include/mach/pxa168.h =A0 =A0 | =A0 =A07 +++++++
> =A0arch/arm/mach-mmp/pxa168.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +++
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A04 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/m=
ach-mmp/include/mach/mfp-pxa168.h
> index ded43c4..4621067 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
> @@ -289,4 +289,11 @@
> =A0#define GPIO86_PWM1_OUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MFP_CFG(GPI=
O86, AF2)
> =A0#define GPIO86_PWM2_OUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MFP_CFG(GPI=
O86, AF3)
>
> +/* Keypad */
> +#define GPIO109_KP_MKIN1 =A0 =A0 =A0 =A0MFP_CFG(GPIO109, AF7)
> +#define GPIO110_KP_MKIN0 =A0 =A0 =A0 =A0MFP_CFG(GPIO110, AF7)
> +#define GPIO111_KP_MKOUT7 =A0 =A0 =A0 MFP_CFG(GPIO111, AF7)
> +#define GPIO112_KP_MKOUT6 =A0 =A0 =A0 MFP_CFG(GPIO112, AF7)
> +#define GPIO121_KP_MKIN4 =A0 =A0 =A0 =A0MFP_CFG(GPIO121, AF7)
> +
> =A0#endif /* __ASM_MACH_MFP_PXA168_H */
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-=
mmp/include/mach/pxa168.h
> index 220738f..f34e663 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -11,6 +11,7 @@ extern void __init pxa168_init_irq(void);
> =A0#include <plat/i2c.h>
> =A0#include <plat/pxa3xx_nand.h>
> =A0#include <video/pxa168fb.h>
> +#include <plat/pxa27x_keypad.h>
>
> =A0extern struct pxa_device_desc pxa168_device_uart1;
> =A0extern struct pxa_device_desc pxa168_device_uart2;
> @@ -27,6 +28,7 @@ extern struct pxa_device_desc pxa168_device_ssp4;
> =A0extern struct pxa_device_desc pxa168_device_ssp5;
> =A0extern struct pxa_device_desc pxa168_device_nand;
> =A0extern struct pxa_device_desc pxa168_device_fb;
> +extern struct pxa_device_desc pxa168_device_keypad;
>
> =A0static inline int pxa168_add_uart(int id)
> =A0{
> @@ -105,4 +107,9 @@ static inline int pxa168_add_fb(struct pxa168fb_m=
ach_info *mi)
> =A0 =A0 =A0 =A0return pxa_register_device(&pxa168_device_fb, mi, size=
of(*mi));
> =A0}
>
> +static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_da=
ta *data)
> +{
> + =A0 =A0 =A0 return pxa_register_device(&pxa168_device_keypad, data,=
 sizeof(*data));
> +}
> +
> =A0#endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index eaebf66..2fa16fb 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -77,6 +77,7 @@ static APBC_CLK(ssp2, PXA168_SSP2, 4, 0);
> =A0static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
> =A0static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
> =A0static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
> +static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
>
> =A0static APMU_CLK(nand, NAND, 0x01db, 208000000);
> =A0static APMU_CLK(lcd, LCD, 0x7f, 312000000);
> @@ -98,6 +99,7 @@ static struct clk_lookup pxa168_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
> =A0};
>
> =A0static int __init pxa168_init(void)
> @@ -150,3 +152,4 @@ PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401=
f000, 0x40, 56, 57);
> =A0PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 5=
9);
> =A0PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 6=
1);
> =A0PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
> +PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c)=
;
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index 9cc488d..aa037fe 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -338,7 +338,7 @@ config KEYBOARD_OPENCORES
>
> =A0config KEYBOARD_PXA27x
> =A0 =A0 =A0 =A0tristate "PXA27x/PXA3xx keypad support"
> - =A0 =A0 =A0 depends on PXA27x || PXA3xx
> + =A0 =A0 =A0 depends on PXA27x || PXA3xx || ARCH_MMP
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Enable support for PXA27x/PXA3xx keypad controller=
=2E
>
> --
> 1.7.0.4
>
It seems good. Acked
