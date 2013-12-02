From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: hid-sensors: Fix power and report state
Date: Mon, 02 Dec 2013 17:11:16 +0000
Message-ID: <d48a86d5-b6a0-494e-9de2-a09afc02a695@email.android.com>
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1385590783-27604-2-git-send-email-srinivas.pandruvada@linux.intel.com> <5299CBD0.4030403@kernel.org> <529CB329.2020101@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529CB329.2020101-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org



Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>On 11/30/2013 03:28 AM, Jonathan Cameron wrote:
>> On 11/27/13 22:19, Srinivas Pandruvada wrote:
>>> In the original HID sensor hub firmwares all Named array enums were
>>> to 0-based. But the most recent hub implemented as 1-based,
>>> because of the implementation by one of the major OS vendor.
>>> Using logical minimum for the field as the base of enum. So we add
>>> logical minimum to the selector values before setting those fields.
>>> Some sensor hub FWs already changed logical minimum from 0 to 1
>>> to reflect this and hope every other vendor will follow.
>>> There is no easy way to add a common HID quirk for NAry elements,
>>> even if the standard specifies these field as NAry, the collection
>>> used to describe selectors is still just "logical".
>>>
>>> Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Looks like a good solution to me.
>>
>> This one is a little interesting.  Technically I 'believe' we don't
>have
>> a bug as it is possible to make these devices work via the kconfig
>option
>> and it definitely isn't a regression.  As such I have applied this to
>the
>> branch intended for the next kernel cycled (togreg) rather than to
>the
>> fixes branch.
>The intention of the patch (originally submitted with a quirk and
>module 
>param, which was commented on by you and Jiri),
>is also to bring report state enumeration also under the quirk to have 
>"1" based same as power state.
>So there is a fix to include reporting state enum also. So if possible,
>
>I would like to treat as bug fix.

Will do then.
>
>Thanks,
>Srinivas
>> If people have a very strong feeling about this then shout reasonably
>quickly - I'll
>> probably hold off sending that branch to Greg for a few days anyway.
>>
>> I've cc'd GregKH to see if he has any input on the path this should
>take.
>>
>> Jonathan
>>
>>> ---
>>>   drivers/iio/common/hid-sensors/Kconfig              |  9 ---------
>>>   drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 20
>+++++++++++++++-----
>>>   include/linux/hid-sensor-ids.h                      | 12
>++++++++++++
>>>   3 files changed, 27 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/iio/common/hid-sensors/Kconfig
>b/drivers/iio/common/hid-sensors/Kconfig
>>> index 1178121..39188b7 100644
>>> --- a/drivers/iio/common/hid-sensors/Kconfig
>>> +++ b/drivers/iio/common/hid-sensors/Kconfig
>>> @@ -25,13 +25,4 @@ config HID_SENSOR_IIO_TRIGGER
>>>   	  If this driver is compiled as a module, it will be named
>>>   	  hid-sensor-trigger.
>>>
>>> -config HID_SENSOR_ENUM_BASE_QUIRKS
>>> -	bool "ENUM base quirks for HID Sensor IIO drivers"
>>> -	depends on HID_SENSOR_IIO_COMMON
>>> -	help
>>> -	  Say yes here to build support for sensor hub FW using
>>> -	  enumeration, which is using 1 as base instead of 0.
>>> -	  Since logical minimum is still set 0 instead of 1,
>>> -	  there is no easy way to differentiate.
>>> -
>>>   endmenu
>>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>> index b6e77e0..781d3fa 100644
>>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>> @@ -33,24 +33,34 @@ static int
>hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>>   {
>>>   	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
>>>   	int state_val;
>>> +	int report_val;
>>>
>>>   	if (state) {
>>>   		if (sensor_hub_device_open(st->hsdev))
>>>   			return -EIO;
>>> -	} else
>>> +		state_val =
>>> +		HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
>>> +		report_val =
>>> +		HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
>>> +
>>> +	} else {
>>>   		sensor_hub_device_close(st->hsdev);
>>> +		state_val =
>>> +		HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM;
>>> +		report_val =
>>> +		HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM;
>>> +	}
>>>
>>> -	state_val = state ? 1 : 0;
>>> -	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
>>> -		++state_val;
>>>   	st->data_ready = state;
>>> +	state_val += st->power_state.logical_minimum;
>>> +	report_val += st->report_state.logical_minimum;
>>>   	sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
>>>   					st->power_state.index,
>>>   					(s32)state_val);
>>>
>>>   	sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
>>>   					st->report_state.index,
>>> -					(s32)state_val);
>>> +					(s32)report_val);
>>>
>>>   	return 0;
>>>   }
>>> diff --git a/include/linux/hid-sensor-ids.h
>b/include/linux/hid-sensor-ids.h
>>> index 4f945d3..8323775 100644
>>> --- a/include/linux/hid-sensor-ids.h
>>> +++ b/include/linux/hid-sensor-ids.h
>>> @@ -117,4 +117,16 @@
>>>   #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
>>>   #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
>>>
>>> +/* Power state enumerations */
>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM		0x00
>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM		0x01
>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D1_LOW_POWER_ENUM		0x02
>>> +#define
>HID_USAGE_SENSOR_PROP_POWER_STATE_D2_STANDBY_WITH_WAKE_ENUM	0x03
>>> +#define
>HID_USAGE_SENSOR_PROP_POWER_STATE_D3_SLEEP_WITH_WAKE_ENUM	0x04
>>> +#define HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM		0x05
>>> +
>>> +/* Report State enumerations */
>>> +#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM		0x00
>>> +#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM		0x01
>>> +
>>>   #endif
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>linux-input" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
