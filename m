From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v2 2/2] input: soc_button_array for newer surface devices
Date: Thu, 4 Jul 2019 17:31:42 +0200
Message-ID: <1d384979-38e8-ccb3-6462-0a8a5380f50d@gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-3-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702003740.75970-3-luzmaximilian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 7/2/19 2:37 AM, Maximilian Luz wrote:
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
> +
> +	return 0;
> +}

Just had another look at this: Shouldn't the EAGAIN here be
EPROBE_DEFER?

The reasoning is that we would want to defer probing of the driver if we
can't get any GPIO pins, since we know that MSHW0040 should have some.
It has in the past been reported that the driver didn't load properly
(without this check), since it could happen that the GPIO subsystem
wasn't quite ready yet when probing.

Best,
Maximilian
