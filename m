From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v2 1/2] platform: Fix device check for surfacepro3_button
Date: Tue, 2 Jul 2019 03:25:51 +0200
Message-ID: <91349d00-e7e2-887b-45e5-4689a401aa2f@gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-2-luzmaximilian@gmail.com>
 <20190702011443.GA19902@chenyu-office.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702011443.GA19902@chenyu-office.sh.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 7/2/19 3:14 AM, Yu Chen wrote:
> On Tue, Jul 02, 2019 at 02:37:39AM +0200, Maximilian Luz wrote:
>> +/*
>> + * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
>> + * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
>> + * device by checking for the _DSM method and OEM Platform Revision.
>> + */
>> +static int surface_button_check_MSHW0040(struct acpi_device *dev)
>> +{
>> +	acpi_handle handle = dev->handle;
>> +	union acpi_object *result;
>> +	u64 oem_platform_rev = 0;
>> +
>> +	// get OEM platform revision
>> +	result = acpi_evaluate_dsm_typed(handle, &MSHW0040_DSM_UUID,
>> +					 MSHW0040_DSM_REVISION,
>> +					 MSHW0040_DSM_GET_OMPR,
>> +					 NULL, ACPI_TYPE_INTEGER);
>> +
> Does it mean, only 5th, 6th and newer platforms have OEM platform revision?
> 3rd/4th will get NULL result? Or the opposite?

Correct, from my testing (with limited sample size) and AML code: 5th
and 6th generation devices have a non-zero OEM platform revision,
whereas 3rd and 4th gen. devices do not have any (i.e. result will be
NULL).

>> +	if (result) {
>> +		oem_platform_rev = result->integer.value;
>> +		ACPI_FREE(result);
>> +	}
>> +
>> +	dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
>> +
>> +	return oem_platform_rev == 0 ? 0 : -ENODEV;
> if 3rd/4th do not have this oem rev information while 5th/newer have,
> why the latter returns NODEV(it actually has this info)?

Since we always expect a non-zero platform revision (for 5th/6th gen.),
we can initialize it to zero and use that as "unknown"/"not available".
So if it can not be determined, we return NODEV.

>> +}

Cheers,
Maximilian
