From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] Input: icn8318 - Add support for ACPI enumeration
Date: Sat, 17 Jun 2017 22:09:52 +0200
Message-ID: <1c9f4d8f-9942-c808-c5fe-4b169befe1d3@redhat.com>
References: <20170617105834.16255-1-hdegoede@redhat.com>
 <20170617105834.16255-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbdFQUJ4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 16:09:56 -0400
In-Reply-To: <20170617105834.16255-3-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi,

Self-nack see comment inline.

On 17-06-17 12:58, Hans de Goede wrote:
> The icn8505 variant is found on some x86 tablets, which use ACPI
> enumeration, add support for ACPI enumeration.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/input/touchscreen/Kconfig           |  2 +-
>   drivers/input/touchscreen/chipone_icn8318.c | 67 ++++++++++++++++++++++++++++-
>   2 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index fff1467506e7..e3b52d356e13 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -155,7 +155,7 @@ config TOUCHSCREEN_CHIPONE_ICN8318
>   	tristate "chipone icn8318 touchscreen controller"
>   	depends on GPIOLIB || COMPILE_TEST
>   	depends on I2C
> -	depends on OF
> +	depends on OF || ACPI
>   	help
>   	  Say Y here if you have a ChipOne icn8318 or icn8505 based
>   	  I2C touchscreen.
> diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
> index 993df804883f..b209872954f7 100644
> --- a/drivers/input/touchscreen/chipone_icn8318.c
> +++ b/drivers/input/touchscreen/chipone_icn8318.c
> @@ -12,6 +12,7 @@
>    * Hans de Goede <hdegoede@redhat.com>
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/interrupt.h>
>   #include <linux/i2c.h>
> @@ -232,6 +233,66 @@ static int icn8318_probe_of(struct icn8318_data *data, struct device *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id icn8318_acpi_match[] = {
> +	{ "CHPN0001", ICN8505 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, icn8318_acpi_match);
> +
> +static int icn8318_probe_acpi(struct icn8318_data *data, struct device *dev)
> +{
> +	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
> +	struct input_dev *input = data->input;
> +	const struct acpi_device_id *id;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +	const char *sub;
> +
> +	adev = ACPI_COMPANION(dev);
> +	id = acpi_match_device(icn8318_acpi_match, dev);
> +	if (!adev || !id)
> +		return -ENODEV;
> +
> +	data->model = id->driver_data;
> +
> +	/* The _SUB ACPI object describes the touchscreen model */
> +	status = acpi_evaluate_object_typed(adev->handle, "_SUB", NULL,
> +					    &buf, ACPI_TYPE_STRING);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "ACPI _SUB object not found\n");
> +		return -ENODEV;
> +	}
> +	sub = ((union acpi_object *)buf.pointer)->string.pointer;
> +
> +	if (strcmp(sub, "HAMP0002") == 0) {
> +		input_set_abs_params(input, ABS_MT_POSITION_X, 0, 1199, 0, 0);
> +		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 1919, 0, 0);
> +	} else {
> +		dev_err(dev, "Unknown model _SUB: %s\n", sub);
> +		kfree(buf.pointer);
> +		return -ENODEV;
> +	}
> +	kfree(buf.pointer);
> +
> +	/*
> +	 * Disable ACPI power management the _PS3 method is empty, so
> +	 * there is no powersaving when using ACPI power management.
> +	 * The _PS0 method resets the controller causing it to loose its
> +	 * firmware, which has been loaded by the BIOS and we do not
> +	 * know how to restore the firmware.
> +	 */
> +	adev->flags.power_manageable = 0;

Ok, so unfortunately this is not that easy :|  The ACPI node
has a _CID, "PNP0C50" causing i2c-hid to bind, even though the
device has its own device specific protocol. I had i2c-hid
blacklisted for testing, with the plan to add a quirk to it for this
device, but with the quirk if i2c-hid loads earlier then the icn8318
driver and i2c-hid's probe returns -ENODEV due to the quirk, the
device gets turned off by the ACPI core, causing a reset + loss
of the loaded firmware when the icn8313 driver loads. So there
are 2 solutions here:

1) Set adev->flags.power_manageable earlier, somewhere in the
ACPI core

2) Figure out how to load the firmware to make the controller
functional again

Regards,

Hans


> +
> +	return 0;
> +}
> +#else
> +static int icn8318_probe_acpi(struct icn8318_data *data, struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>   static int icn8318_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> @@ -264,7 +325,10 @@ static int icn8318_probe(struct i2c_client *client)
>   	input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
>   	input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
>   
> -	error = icn8318_probe_of(data, dev);
> +	if (client->dev.of_node)
> +		error = icn8318_probe_of(data, dev);
> +	else
> +		error = icn8318_probe_acpi(data, dev);
>   	if (error)
>   		return error;
>   
> @@ -318,6 +382,7 @@ static struct i2c_driver icn8318_driver = {
>   	.driver = {
>   		.name	= "chipone_icn8318",
>   		.pm	= &icn8318_pm_ops,
> +		.acpi_match_table = ACPI_PTR(icn8318_acpi_match),
>   		.of_match_table = icn8318_of_match,
>   	},
>   	.probe_new = icn8318_probe,
> 
