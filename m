From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/3] iio: adc: mxs-lradc: Add support for adc driver
Date: Fri, 29 Apr 2016 15:21:13 +0200
Message-ID: <57235FC9.1090709@denx.de>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com> <eef892ac7b6e1efa0dcbff50f9b3e8f9a9489fbc.1461930102.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eef892ac7b6e1efa0dcbff50f9b3e8f9a9489fbc.1461930102.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, harald@ccbib.org
List-Id: linux-input@vger.kernel.org

On 04/29/2016 01:48 PM, Ksenija Stanojevic wrote:
> Add mxs-lradc adc driver.

Commit message could use some improvement ;-)

> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
>  drivers/iio/adc/Kconfig         |  37 +-
>  drivers/iio/adc/Makefile        |   1 +
>  drivers/iio/adc/mxs-lradc-adc.c | 832 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 858 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 82c718c..50847b8 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -233,6 +233,19 @@ config IMX7D_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called imx7d_adc.
>  
> +config MXS_LRADC_ADC
> +	tristate "Freescale i.MX23/i.MX28 LRADC ADC"
> +	depends on MFD_MXS_LRADC
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for the ADC functions of the
> +	  i.MX23/i.MX28 LRADC. This includes general-purpose ADC readings,
> +	  battery voltage measurement, and die temperature measurement.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called mxs-lradc-adc.
> +
>  config LP8788_ADC
>  	tristate "LP8788 ADC driver"
>  	depends on MFD_LP8788
> @@ -306,18 +319,18 @@ config MEN_Z188_ADC
>  	  called men_z188_adc.
>  
>  config MXS_LRADC
> -        tristate "Freescale i.MX23/i.MX28 LRADC"
> -        depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
> -        depends on INPUT
> -        select STMP_DEVICE
> -        select IIO_BUFFER
> -        select IIO_TRIGGERED_BUFFER
> -        help
> -          Say yes here to build support for i.MX23/i.MX28 LRADC convertor
> -          built into these chips.
> -
> -          To compile this driver as a module, choose M here: the
> -          module will be called mxs-lradc.
> +	tristate "Freescale i.MX23/i.MX28 LRADC"
> +	depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
> +	depends on INPUT
> +	select STMP_DEVICE
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for i.MX23/i.MX28 LRADC convertor
> +	  built into these chips.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mxs-lradc.
>  
>  config NAU7802
>  	tristate "Nuvoton NAU7802 ADC driver"
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 0cb7921..ca7d6aa 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
> +obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> new file mode 100644
> index 0000000..793c369
> --- /dev/null
> +++ b/drivers/iio/adc/mxs-lradc-adc.c

[...]

> +	if (lradc->soc == IMX28_LRADC)
> +		mxs_lradc_reg_clear(
> +			lradc,
> +			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
> +			LRADC_CTRL1);

Can you tweak the formatting here ?

if (lradc->soc == IMX28_LRADC) {
	mxs_lradc_reg_clear(lradc,
		lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
		LRADC_CTRL1);
}

might look at least a bit less odd.

> +	mxs_lradc_reg_clear(lradc, lradc->buffer_vchans, LRADC_CTRL0);
> +
> +	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
> +		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
> +		ctrl4_clr |= LRADC_CTRL4_LRADCSELECT_MASK(ofs);
> +		ctrl1_irq |= LRADC_CTRL1_LRADC_IRQ_EN(ofs);
> +		mxs_lradc_reg_wrt(lradc, chan_value, LRADC_CH(ofs));
> +		bitmap_set(&enable, ofs, 1);
> +		ofs++;
> +	}
> +
> +	mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
> +			    LRADC_DELAY_KICK, LRADC_DELAY(0));
> +	mxs_lradc_reg_clear(lradc, ctrl4_clr, LRADC_CTRL4);
> +	mxs_lradc_reg_set(lradc, ctrl4_set, LRADC_CTRL4);
> +	mxs_lradc_reg_set(lradc, ctrl1_irq, LRADC_CTRL1);
> +	mxs_lradc_reg_set(lradc, enable << LRADC_DELAY_TRIGGER_LRADCS_OFFSET,
> +			  LRADC_DELAY(0));
> +
> +	return 0;
> +
> +err_mem:
> +	mutex_unlock(&adc->lock);
> +	return ret;
> +}

[...]

> +
> +static int mxs_lradc_adc_buffer_postdisable(struct iio_dev *iio)
> +{
> +	struct mxs_lradc_adc *adc = iio_priv(iio);
> +	struct mxs_lradc *lradc = adc->lradc;
> +
> +	mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
> +			    LRADC_DELAY_KICK, LRADC_DELAY(0));
> +
> +	mxs_lradc_reg_clear(lradc, lradc->buffer_vchans, LRADC_CTRL0);
> +	if (lradc->soc == IMX28_LRADC)
> +		mxs_lradc_reg_clear(
> +			lradc,
> +			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
> +			LRADC_CTRL1);

Same here, this is horrible :)

> +	kfree(adc->buffer);
> +	mutex_unlock(&adc->lock);
> +
> +	return 0;
> +}
[...]

Looks good otherwise :)


-- 
Best regards,
Marek Vasut
