From: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v7 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Sun, 14 Jun 2015 01:46:49 +0200
Message-ID: <557CC0E9.107@gmx.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de> <1425369498-25541-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425369498-25541-5-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Eric_B=c3=a9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Markus Pargmann schrieb am 03.03.2015 um 08:58:
> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpose
> ADC but one is meant to be used for touchscreens.
> 
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> the correct components.
> 
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> 

Hi Markus,
I would recommend to make use of GENMASK for many of the masks you define below.
That makes it better readable from which to which bitnumber that mask applies.
Thanks,

Hartmut

<...>
> diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx25-tsadc.h
> new file mode 100644
> index 000000000000..da348ac34a41
> --- /dev/null
> +++ b/include/linux/mfd/imx25-tsadc.h
> @@ -0,0 +1,141 @@
> +#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +
> +struct regmap;
> +struct device;
> +struct clk;
> +
> +struct mx25_tsadc {
> +	struct regmap *regs;
> +	struct irq_domain *domain;
> +	struct clk *clk;
> +};
> +
> +#define MX25_TSC_TGCR			0x00
> +#define MX25_TSC_TGSR			0x04
> +#define MX25_TSC_TICR			0x08
> +
> +/* The same register layout for TC and GC queue */
> +#define MX25_ADCQ_FIFO			0x00
> +#define MX25_ADCQ_CR			0x04
> +#define MX25_ADCQ_SR			0x08
> +#define MX25_ADCQ_MR			0x0c
> +#define MX25_ADCQ_ITEM_7_0		0x20
> +#define MX25_ADCQ_ITEM_15_8		0x24
> +#define MX25_ADCQ_CFG(n)		(0x40 + ((n) * 0x4))
> +
> +#define MX25_ADCQ_MR_MASK		0xffffffff
> +
> +/* TGCR */
> +#define MX25_TGCR_PDBTIME(x)		((x) << 25)
> +#define MX25_TGCR_PDBTIME_MASK		MX25_TGCR_PDBTIME(0x7f)
> +#define MX25_TGCR_PDBEN			BIT(24)
> +#define MX25_TGCR_PDEN			BIT(23)
> +#define MX25_TGCR_ADCCLKCFG(x)		((x) << 16)
> +#define MX25_TGCR_GET_ADCCLK(x)		(((x) >> 16) & 0x1f)
> +#define MX25_TGCR_INTREFEN		BIT(10)
> +#define MX25_TGCR_POWERMODE_MASK	(3 << 8)
> +#define MX25_TGCR_POWERMODE_SAVE	(1 << 8)
> +#define MX25_TGCR_POWERMODE_ON		(2 << 8)
> +#define MX25_TGCR_STLC			BIT(5)
> +#define MX25_TGCR_SLPC			BIT(4)
> +#define MX25_TGCR_FUNC_RST		BIT(2)
> +#define MX25_TGCR_TSC_RST		BIT(1)
> +#define MX25_TGCR_CLK_EN		BIT(0)
> +
> +/* TGSR */
> +#define MX25_TGSR_SLP_INT		BIT(2)
> +#define MX25_TGSR_GCQ_INT		BIT(1)
> +#define MX25_TGSR_TCQ_INT		BIT(0)
> +
> +/* ADCQ_ITEM_* */
> +#define _MX25_ADCQ_ITEM(item, x)	((x) << ((item) * 4))
> +#define MX25_ADCQ_ITEM(item, x)		((item) >= 8 ? \
> +		_MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (x)))
> +
> +/* ADCQ_FIFO (TCQFIFO and GCQFIFO) */
> +#define MX25_ADCQ_FIFO_DATA(x)		(((x) >> 4) & 0xfff)
> +#define MX25_ADCQ_FIFO_ID(x)		((x) & 0xf)
> +
> +/* ADCQ_CR (TCQR and GCQR) */
> +#define MX25_ADCQ_CR_PDCFG_LEVEL	BIT(19)
> +#define MX25_ADCQ_CR_PDMSK		BIT(18)
> +#define MX25_ADCQ_CR_FRST		BIT(17)
> +#define MX25_ADCQ_CR_QRST		BIT(16)
> +#define MX25_ADCQ_CR_RWAIT_MASK		(0xf << 12)
> +#define MX25_ADCQ_CR_RWAIT(x)		((x) << 12)
> +#define MX25_ADCQ_CR_WMRK_MASK		(0xf << 8)
> +#define MX25_ADCQ_CR_WMRK(x)		((x) << 8)
> +#define MX25_ADCQ_CR_LITEMID_MASK	(0xf << 4)
> +#define MX25_ADCQ_CR_LITEMID(x)		((x) << 4)
> +#define MX25_ADCQ_CR_RPT		BIT(3)
> +#define MX25_ADCQ_CR_FQS		BIT(2)
> +#define MX25_ADCQ_CR_QSM_MASK		0x3
> +#define MX25_ADCQ_CR_QSM_PD		0x1
> +#define MX25_ADCQ_CR_QSM_FQS		0x2
> +#define MX25_ADCQ_CR_QSM_FQS_PD		0x3
> +
> +/* ADCQ_SR (TCQSR and GCQSR) */
> +#define MX25_ADCQ_SR_FDRY		BIT(15)
> +#define MX25_ADCQ_SR_FULL		BIT(14)
> +#define MX25_ADCQ_SR_EMPT		BIT(13)
> +#define MX25_ADCQ_SR_FDN(x)		(((x) >> 8) & 0x1f)
> +#define MX25_ADCQ_SR_FRR		BIT(6)
> +#define MX25_ADCQ_SR_FUR		BIT(5)
> +#define MX25_ADCQ_SR_FOR		BIT(4)
> +#define MX25_ADCQ_SR_EOQ		BIT(1)
> +#define MX25_ADCQ_SR_PD			BIT(0)
> +
> +/* ADCQ_MR (TCQMR and GCQMR) */
> +#define MX25_ADCQ_MR_FDRY_DMA		BIT(31)
> +#define MX25_ADCQ_MR_FER_DMA		BIT(22)
> +#define MX25_ADCQ_MR_FUR_DMA		BIT(21)
> +#define MX25_ADCQ_MR_FOR_DMA		BIT(20)
> +#define MX25_ADCQ_MR_EOQ_DMA		BIT(17)
> +#define MX25_ADCQ_MR_PD_DMA		BIT(16)
> +#define MX25_ADCQ_MR_FDRY_IRQ		BIT(15)
> +#define MX25_ADCQ_MR_FER_IRQ		BIT(6)
> +#define MX25_ADCQ_MR_FUR_IRQ		BIT(5)
> +#define MX25_ADCQ_MR_FOR_IRQ		BIT(4)
> +#define MX25_ADCQ_MR_EOQ_IRQ		BIT(1)
> +#define MX25_ADCQ_MR_PD_IRQ		BIT(0)
> +
> +/* ADCQ_CFG (TICR, TCC0-7,GCC0-7) */
> +#define MX25_ADCQ_CFG_SETTLING_TIME(x)	((x) << 24)
> +#define MX25_ADCQ_CFG_IGS		(1 << 20)
> +#define MX25_ADCQ_CFG_NOS_MASK		(0xf << 16)
> +#define MX25_ADCQ_CFG_NOS(x)		(((x) - 1) << 16)
> +#define MX25_ADCQ_CFG_WIPER		(1 << 15)
> +#define MX25_ADCQ_CFG_YNLR		(1 << 14)
> +#define MX25_ADCQ_CFG_YPLL_HIGH		(0 << 12)
> +#define MX25_ADCQ_CFG_YPLL_OFF		(1 << 12)
> +#define MX25_ADCQ_CFG_YPLL_LOW		(3 << 12)
> +#define MX25_ADCQ_CFG_XNUR_HIGH		(0 << 10)
> +#define MX25_ADCQ_CFG_XNUR_OFF		(1 << 10)
> +#define MX25_ADCQ_CFG_XNUR_LOW		(3 << 10)
> +#define MX25_ADCQ_CFG_XPUL_HIGH		(0 << 9)
> +#define MX25_ADCQ_CFG_XPUL_OFF		(1 << 9)
> +#define MX25_ADCQ_CFG_REFP(sel)		((sel) << 7)
> +#define MX25_ADCQ_CFG_REFP_YP		(0 << 7)
> +#define MX25_ADCQ_CFG_REFP_XP		(1 << 7)
> +#define MX25_ADCQ_CFG_REFP_EXT		(2 << 7)
> +#define MX25_ADCQ_CFG_REFP_INT		(3 << 7)
> +#define MX25_ADCQ_CFG_REFP_MASK		(3 << 7)
> +#define MX25_ADCQ_CFG_IN(sel)		((sel) << 4)
> +#define MX25_ADCQ_CFG_IN_XP		(0 << 4)
> +#define MX25_ADCQ_CFG_IN_YP		(1 << 4)
> +#define MX25_ADCQ_CFG_IN_XN		(2 << 4)
> +#define MX25_ADCQ_CFG_IN_YN		(3 << 4)
> +#define MX25_ADCQ_CFG_IN_WIPER		(4 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX0		(5 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX1		(6 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX2		(7 << 4)
> +#define MX25_ADCQ_CFG_REFN(sel)		((sel) << 2)
> +#define MX25_ADCQ_CFG_REFN_XN		(0 << 2)
> +#define MX25_ADCQ_CFG_REFN_YN		(1 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND		(2 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND2	(3 << 2)
> +#define MX25_ADCQ_CFG_REFN_MASK		(3 << 2)
> +#define MX25_ADCQ_CFG_PENIACK		(1 << 1)
> +
> +#endif  /* _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_ */
> 
