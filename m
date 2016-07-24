From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/5] mfd: sunxi-gpadc-mfd: probe sunxi-gpadc-ts driver
Date: Sun, 24 Jul 2016 12:26:56 +0100
Message-ID: <11247e4f-d04d-d5bc-6ebf-a637820c011d@kernel.org>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-6-git-send-email-quentin.schulz@free-electrons.com>
 <20160721060812.GA5993@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58767 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcGXL07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jul 2016 07:26:59 -0400
In-Reply-To: <20160721060812.GA5993@lukather>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 21/07/16 07:08, Maxime Ripard wrote:
> Hi Quentin,
> 
> On Wed, Jul 20, 2016 at 10:29:11AM +0200, Quentin Schulz wrote:
>> This probes the touchscreen driver for Allwinner SoCs (A10, A13 and A31)
>> when the property "allwinner,ts-attached" is set in the GPADC (rtp) node of
>> the DT.
>>
>> Some comestic modifications done to shorten and increase readability of the
>> code.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/sunxi-gpadc-mfd.c | 115 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 77 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
>> index 05a000b..9b9ed0b 100644
>> --- a/drivers/mfd/sunxi-gpadc-mfd.c
>> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
>> @@ -21,6 +21,11 @@
>>  #define SUNXI_IRQ_TEMP_DATA	1
>>  #define SUNXI_IRQ_TP_UP		2
>>  
>> +#define SUNXI_GPADC_MFD_CELL(_name, _resources, _num_resources) {	\
>> +	.name = _name,							\
>> +	.resources = _resources,					\
>> +	.num_resources = _num_resources					\
>> +}
>>  
>>  static struct resource adc_resources[] = {
>>  	{
>> @@ -64,33 +69,45 @@ static const struct regmap_irq_chip sunxi_gpadc_mfd_regmap_irq_chip = {
>>  };
>>  
>>  static struct mfd_cell sun4i_gpadc_mfd_cells[] = {
>> -	{
>> -		.name	= "sun4i-a10-gpadc-iio",
>> -		.resources = adc_resources,
>> -		.num_resources = ARRAY_SIZE(adc_resources),
>> -	}, {
>> -		.name = "iio_hwmon",
>> -	}
>> +	SUNXI_GPADC_MFD_CELL("sun4i-a10-gpadc-iio", adc_resources,
>> +			     ARRAY_SIZE(adc_resources)),
>> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>>  };
>>  
>>  static struct mfd_cell sun5i_gpadc_mfd_cells[] = {
>> -	{
>> -		.name	= "sun5i-a13-gpadc-iio",
>> -		.resources = adc_resources,
>> -		.num_resources = ARRAY_SIZE(adc_resources),
>> -	}, {
>> -		.name = "iio_hwmon",
>> -	},
>> +	SUNXI_GPADC_MFD_CELL("sun5i-a13-gpadc-iio", adc_resources,
>> +			     ARRAY_SIZE(adc_resources)),
>> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>>  };
>>  
>>  static struct mfd_cell sun6i_gpadc_mfd_cells[] = {
>> -	{
>> -		.name	= "sun6i-a31-gpadc-iio",
>> -		.resources = adc_resources,
>> -		.num_resources = ARRAY_SIZE(adc_resources),
>> -	}, {
>> -		.name = "iio_hwmon",
>> -	},
>> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
>> +			     ARRAY_SIZE(adc_resources)),
>> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>> +};
> 
> This should be part of a separate patch.
> 
>> +
>> +static struct mfd_cell sun4i_gpadc_mfd_cells_ts[] = {
>> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
>> +			     ARRAY_SIZE(adc_resources)),
>> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
>> +			     ARRAY_SIZE(ts_resources)),
>> +};
>> +
>> +static struct mfd_cell sun5i_gpadc_mfd_cells_ts[] = {
>> +	SUNXI_GPADC_MFD_CELL("sun5i-a13-gpadc-iio", adc_resources,
>> +			     ARRAY_SIZE(adc_resources)),
>> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
>> +			     ARRAY_SIZE(ts_resources)),
>> +};
>> +
>> +static struct mfd_cell sun6i_gpadc_mfd_cells_ts[] = {
>> +	SUNXI_GPADC_MFD_CELL("sun6i-a31-gpadc-iio", adc_resources,
>> +			     ARRAY_SIZE(adc_resources)),
>> +	SUNXI_GPADC_MFD_CELL("iio_hwmon", NULL, 0),
>> +	SUNXI_GPADC_MFD_CELL("sunxi-gpadc-ts", ts_resources,
>> +			     ARRAY_SIZE(ts_resources)),
>>  };
>>  
>>  static const struct regmap_config sunxi_gpadc_mfd_regmap_config = {
>> @@ -142,23 +159,45 @@ static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	if (of_device_is_compatible(pdev->dev.of_node,
>> -				    "allwinner,sun4i-a10-ts"))
>> -		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> -				      sun4i_gpadc_mfd_cells,
>> -				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
>> -				      0, NULL);
>> -	else if (of_device_is_compatible(pdev->dev.of_node,
>> -					 "allwinner,sun5i-a13-ts"))
>> -		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> -				      sun5i_gpadc_mfd_cells,
>> -				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
>> -				      0, NULL);
>> -	else if (of_device_is_compatible(pdev->dev.of_node,
>> -					 "allwinner,sun6i-a31-ts"))
>> -		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> -				      sun6i_gpadc_mfd_cells,
>> -				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
>> -				      0, NULL);
>> +				    "allwinner,sun4i-a10-ts")) {
>> +		if (of_property_read_bool(pdev->dev.of_node,
>> +					  "allwinner,ts-attached"))
>> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +					      sun4i_gpadc_mfd_cells_ts,
>> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells_ts),
>> +					      NULL, 0, NULL);
>> +		else
>> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +					      sun4i_gpadc_mfd_cells,
>> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells),
>> +					      NULL, 0, NULL);
>> +	} else if (of_device_is_compatible(pdev->dev.of_node,
>> +					 "allwinner,sun5i-a13-ts")) {
>> +		if (of_property_read_bool(pdev->dev.of_node,
>> +					  "allwinner,ts-attached"))
>> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +					      sun5i_gpadc_mfd_cells_ts,
>> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells_ts),
>> +					      NULL, 0, NULL);
>> +		else
>> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +					      sun5i_gpadc_mfd_cells,
>> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells),
>> +					      NULL, 0, NULL);
>> +	} else if (of_device_is_compatible(pdev->dev.of_node,
>> +					 "allwinner,sun6i-a31-ts")) {
>> +		if (of_property_read_bool(pdev->dev.of_node,
>> +					  "allwinner,ts-attached"))
>> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +					      sun6i_gpadc_mfd_cells_ts,
>> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells_ts),
>> +					      NULL, 0, NULL);
>> +		else
>> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +					      sun6i_gpadc_mfd_cells,
>> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells),
>> +					      NULL, 0, NULL);
>> +	}
> 
> Please don't use any of_device_is_compatible.
Hi Maxime,

Why?  (Just curious...)

Jonathan
> 
> Thanks,
> Maxime
> 

