From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] input: soc_button_array for newer surface devices
Date: Tue, 16 Jul 2019 09:21:35 +0200
Message-ID: <20190716072135.GA806@penguin>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-3-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702003740.75970-3-luzmaximilian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Maximilian,

On Tue, Jul 02, 2019 at 02:37:40AM +0200, Maximilian Luz wrote:
> Power and volume button support for 5th and 6th genration Microsoft
> Surface devices via soc_button_array.
> 
> Note that these devices use the same MSHW0040 device as on the Surface
> Pro 4, however the implementation is different (GPIOs vs. ACPI
> notifications). Thus some checking is required to ensure we only load
> this driver on the correct devices.

When you are saying that Pro 4 and later models use different
notifications, does this mean that Pro 4 does not define any GPIOs? If
so can we use their presence as indicator whether we should be using
this driver or not. I would like to avoid repeating the ACPI parsing
code that you have in the platform driver.

> +static int soc_device_check_MSHW0040(struct device *dev)
> +{
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +	union acpi_object *result;
> +	u64 oem_platform_rev = 0;
> +	int gpios;
> +
> +	// get OEM platform revision
> +	result = acpi_evaluate_dsm_typed(handle, &MSHW0040_DSM_UUID,
> +					 MSHW0040_DSM_REVISION,
> +					 MSHW0040_DSM_GET_OMPR, NULL,
> +					 ACPI_TYPE_INTEGER);
> +
> +	if (result) {
> +		oem_platform_rev = result->integer.value;
> +		ACPI_FREE(result);
> +	}
> +
> +	if (oem_platform_rev == 0)
> +		return -ENODEV;
> +
> +	dev_dbg(dev, "OEM Platform Revision %llu\n", oem_platform_rev);
> +
> +	/*
> +	 * We are _really_ expecting GPIOs here. If we do not get any, this
> +	 * means the GPIO driver has not been loaded yet (which can happen).
> +	 * Try again later.
> +	 */
> +	gpios = gpiod_count(dev, NULL);
> +	if (gpios < 0)
> +		return -EAGAIN;

I do not believe -EAGAIN has any special meaning in the driver core;
also when the GPIO controller is not ready gpiod_get() will return
-EPROBE_DEFER, which is the prober way if signalling that some resource
is not yet available and probe should be retries at a later time.

Moreover, I do not believe that gpiod_count() needs GPIO controller to
be ready, the count is taken from board firmware or static board file
definition, so if gpiod_count() returns 0 it should be clear indication
that the driver should not be used with the device.

Thanks.

-- 
Dmitry
