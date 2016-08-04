From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v4 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 04 Aug 2016 18:10:37 +0200
Message-ID: <2721285.1CS7CJCgc7@ws-stein>
References: <cover.1470316956.git.ksenija.stanojevic@gmail.com> <0a60a10b249062d305237f04fdb9aea05b128b85.1470316956.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0a60a10b249062d305237f04fdb9aea05b128b85.1470316956.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On Thursday 04 August 2016 15:28:18, Ksenija Stanojevic wrote:
> Add core files for mxs-lradc MFD driver.
> 
> Note:  this patch won't compile in iio/testing without this patch:
> a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
> [...]
> +static int mxs_lradc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct mxs_lradc *lradc;
> +	struct resource *iores;
> +	struct mfd_cell *cells = NULL;
> +	int ret = 0;
> +	u32 ts_wires = 0;
> +
> +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> +	if (!lradc)
> +		return -ENOMEM;
> +
> +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	lradc->base = devm_ioremap_resource(dev, iores);

Out of couriosity: Is it common to pass already ioremapped addresses to (MFD 
cell) platform drivers? I would have expected, and done myself, that ioremap 
is done in the driver itself, same as the IRQ.

Best regards,
Alexander
