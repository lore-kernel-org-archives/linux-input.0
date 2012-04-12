From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v7] input: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Thu, 12 Apr 2012 17:48:50 +0300
Message-ID: <4F86EB52.2030206@compulab.co.il>
References: <1333890051.55712.YahooMailClassic@web29020.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:35922
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964991Ab2DLOs7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Apr 2012 10:48:59 -0400
In-Reply-To: <1333890051.55712.YahooMailClassic@web29020.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, philipp.zabel@gmail.com

Hi Paul,

On 04/08/12 16:00, Paul Parsons wrote:
> This driver adds support for the Synaptics NavPoint touchpad connected
> to a PXA27x SSP port in SPI slave mode. The driver implements a simple
> navigation pad. The four raised dots are mapped to UP/DOWN/LEFT/RIGHT
> buttons and the centre of the touchpad is mapped to the ENTER button.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> 
> V7:
> Separated arch/arm/mach-pxa/include/mach/mfp-pxa27x.h changes into a
> separate patch, to avoid crossing maintainer boundaries.
> This patch now submitted to linux-input instead of linux-arm-kernel.
> Improved dev_warn() messages.
> navpoint_hardint() now correctly returns IRQ_HANDLED in cases where
> reading SSDR does not return IRQ_WAKE_THREAD.
> Folded in "Input: navpoint: add clk_prepare/clk_unprepare calls" patch.
> Added calls to gpio_is_valid(), gpio_request(), gpio_direction_output().
> Rebased from linux-3.2 to linux-3.4-rc2.
> 
>  drivers/input/mouse/Kconfig    |   12 ++
>  drivers/input/mouse/Makefile   |    1 +
>  drivers/input/mouse/navpoint.c |  415 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/input/navpoint.h |   12 ++
>  4 files changed, 440 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/mouse/navpoint.c
>  create mode 100644 include/linux/input/navpoint.h

[...]

> diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
> new file mode 100644
> index 0000000..3f09c95
> --- /dev/null
> +++ b/drivers/input/mouse/navpoint.c
> @@ -0,0 +1,415 @@

[...]

> +static int __devinit navpoint_probe(struct platform_device *pdev)
> +{
> +	struct navpoint_platform_data *pdata = pdev->dev.platform_data;
> +	int ret;
> +	struct ssp_device *ssp;
> +	struct input_dev *input;
> +	struct driver_data *drv_data;
> +
> +	if (gpio_is_valid(pdata->gpio)) {

If there is no platform_data provided, you will crash the kernel here.
Is it really desired? I mean, you need the SSP port, right?
But still, should we just check if platform_data is provided and if not,
call dev_err() and return -ENODEV?

> +		ret = gpio_request(pdata->gpio, "SYNAPTICS_ON");
> +		if (ret)
> +			goto ret0;
> +		ret = gpio_direction_output(pdata->gpio, 0);
> +		if (ret)
> +			goto ret1;

Can we please, have gpio_request_one() instead of the above 2 calls?
This will also remove the need for ret1 and just return ret;

> +	}
> +
> +	ssp = pxa_ssp_request(pdata->port, pdev->name);
> +	if (!ssp) {
> +		ret = -ENODEV;
> +		goto ret1;

If no need for ret1, then here it can be just return -ENODEV;

> +	}
> +
> +	/* HaRET does not disable devices before jumping into Linux */
> +	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
> +		pxa_ssp_write_reg(ssp, SSCR0, 0);
> +		dev_warn(&pdev->dev, "ssp%d already enabled\n", pdata->port);
> +	}
> +
> +	input = input_allocate_device();
> +	if (!input) {
> +		ret = -ENOMEM;
> +		goto ret2;
> +	}
> +	input->name = pdev->name;
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(KEY_ENTER, input->keybit);
> +	__set_bit(KEY_UP, input->keybit);
> +	__set_bit(KEY_LEFT, input->keybit);
> +	__set_bit(KEY_RIGHT, input->keybit);
> +	__set_bit(KEY_DOWN, input->keybit);
> +	input->open = navpoint_open;
> +	input->close = navpoint_close;
> +	input->dev.parent = &pdev->dev;
> +
> +	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
> +	if (!drv_data) {
> +		ret = -ENOMEM;
> +		goto ret3;
> +	}
> +	drv_data->ssp = ssp;
> +	drv_data->gpio = pdata->gpio;
> +	drv_data->input = input;
> +	platform_set_drvdata(pdev, drv_data);
> +
> +	ret = request_threaded_irq(ssp->irq, navpoint_hardint, navpoint_softint,
> +		0, pdev->name, &pdev->dev);
> +	if (ret)
> +		goto ret4;
> +
> +	ret = input_register_device(input);
> +	if (ret)
> +		goto ret5;
> +
> +	dev_info(&pdev->dev, "ssp%d, irq %d\n", pdata->port, ssp->irq);
> +
> +	return 0;
> +
> +ret5:
> +	free_irq(ssp->irq, &pdev->dev);
> +ret4:
> +	kfree(drv_data);
> +ret3:
> +	input_free_device(input);
> +ret2:
> +	pxa_ssp_free(ssp);
> +ret1:
> +	if (gpio_is_valid(pdata->gpio))
> +		gpio_free(pdata->gpio);
> +ret0:
> +	return ret;
> +}

[...]


-- 
Regards,
Igor.
