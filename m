From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] Input: icn8318 - Add support for ACPI enumeration
Date: Mon, 19 Jun 2017 16:01:09 +0200
Message-ID: <90798705-404c-3678-2897-325a4dd6b90f@redhat.com>
References: <20170617105834.16255-1-hdegoede@redhat.com>
 <20170617105834.16255-3-hdegoede@redhat.com>
 <1c9f4d8f-9942-c808-c5fe-4b169befe1d3@redhat.com>
 <389d8076-b951-24f0-9a00-b3bd426a0cfd@redhat.com>
 <20170619085100.GA17802@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdFSOBO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 10:01:14 -0400
In-Reply-To: <20170619085100.GA17802@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On 19-06-17 10:51, Benjamin Tissoires wrote:
> On Jun 18 2017 or thereabouts, Hans de Goede wrote:
>> Hi,
>>
>> On 17-06-17 22:09, Hans de Goede wrote:
>>> Hi,
>>>
>>> Self-nack see comment inline.
>>>
>>> On 17-06-17 12:58, Hans de Goede wrote:
>>>> The icn8505 variant is found on some x86 tablets, which use ACPI
>>>> enumeration, add support for ACPI enumeration.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/input/touchscreen/Kconfig           |  2 +-
>>>>    drivers/input/touchscreen/chipone_icn8318.c | 67 ++++++++++++++++++++++++++++-
>>>>    2 files changed, 67 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>>>> index fff1467506e7..e3b52d356e13 100644
>>>> --- a/drivers/input/touchscreen/Kconfig
>>>> +++ b/drivers/input/touchscreen/Kconfig
>>>> @@ -155,7 +155,7 @@ config TOUCHSCREEN_CHIPONE_ICN8318
>>>>        tristate "chipone icn8318 touchscreen controller"
>>>>        depends on GPIOLIB || COMPILE_TEST
>>>>        depends on I2C
>>>> -    depends on OF
>>>> +    depends on OF || ACPI
>>>>        help
>>>>          Say Y here if you have a ChipOne icn8318 or icn8505 based
>>>>          I2C touchscreen.
>>>> diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
>>>> index 993df804883f..b209872954f7 100644
>>>> --- a/drivers/input/touchscreen/chipone_icn8318.c
>>>> +++ b/drivers/input/touchscreen/chipone_icn8318.c
>>>> @@ -12,6 +12,7 @@
>>>>     * Hans de Goede <hdegoede@redhat.com>
>>>>     */
>>>> +#include <linux/acpi.h>
>>>>    #include <linux/gpio/consumer.h>
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/i2c.h>
>>>> @@ -232,6 +233,66 @@ static int icn8318_probe_of(struct icn8318_data *data, struct device *dev)
>>>>    }
>>>>    #endif
>>>> +#ifdef CONFIG_ACPI
>>>> +static const struct acpi_device_id icn8318_acpi_match[] = {
>>>> +    { "CHPN0001", ICN8505 },
>>>> +    { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, icn8318_acpi_match);
>>>> +
>>>> +static int icn8318_probe_acpi(struct icn8318_data *data, struct device *dev)
>>>> +{
>>>> +    struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
>>>> +    struct input_dev *input = data->input;
>>>> +    const struct acpi_device_id *id;
>>>> +    struct acpi_device *adev;
>>>> +    acpi_status status;
>>>> +    const char *sub;
>>>> +
>>>> +    adev = ACPI_COMPANION(dev);
>>>> +    id = acpi_match_device(icn8318_acpi_match, dev);
>>>> +    if (!adev || !id)
>>>> +        return -ENODEV;
>>>> +
>>>> +    data->model = id->driver_data;
>>>> +
>>>> +    /* The _SUB ACPI object describes the touchscreen model */
>>>> +    status = acpi_evaluate_object_typed(adev->handle, "_SUB", NULL,
>>>> +                        &buf, ACPI_TYPE_STRING);
>>>> +    if (ACPI_FAILURE(status)) {
>>>> +        dev_err(dev, "ACPI _SUB object not found\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>> +    sub = ((union acpi_object *)buf.pointer)->string.pointer;
>>>> +
>>>> +    if (strcmp(sub, "HAMP0002") == 0) {
>>>> +        input_set_abs_params(input, ABS_MT_POSITION_X, 0, 1199, 0, 0);
>>>> +        input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 1919, 0, 0);
>>>> +    } else {
>>>> +        dev_err(dev, "Unknown model _SUB: %s\n", sub);
>>>> +        kfree(buf.pointer);
>>>> +        return -ENODEV;
>>>> +    }
>>>> +    kfree(buf.pointer);
>>>> +
>>>> +    /*
>>>> +     * Disable ACPI power management the _PS3 method is empty, so
>>>> +     * there is no powersaving when using ACPI power management.
>>>> +     * The _PS0 method resets the controller causing it to loose its
>>>> +     * firmware, which has been loaded by the BIOS and we do not
>>>> +     * know how to restore the firmware.
>>>> +     */
>>>> +    adev->flags.power_manageable = 0;
>>>
>>> Ok, so unfortunately this is not that easy :|  The ACPI node
>>> has a _CID, "PNP0C50" causing i2c-hid to bind, even though the
>>> device has its own device specific protocol. I had i2c-hid
>>> blacklisted for testing, with the plan to add a quirk to it for this
>>> device, but with the quirk if i2c-hid loads earlier then the icn8318
>>> driver and i2c-hid's probe returns -ENODEV due to the quirk, the
>>> device gets turned off by the ACPI core, causing a reset + loss
>>> of the loaded firmware when the icn8313 driver loads. So there
>>> are 2 solutions here:
>>>
>>> 1) Set adev->flags.power_manageable earlier, somewhere in the
>>> ACPI core
>>>
>>> 2) Figure out how to load the firmware to make the controller
>>> functional again
>>
>> While working on a 3th option, I did a web-search for "CHPN0001"
>> instead of for icn8505 which found me this:
>>
>> https://github.com/Dax89/chuwi-dev/tree/master/drivers/chipone_ts
>>
>> Which seemed to be based on the same android code as I already
>> found, but which claims to have firmware loading working again,
>> so assuming that is true (I've not tested) that gives is us
>> 2 options, either avoid the controller reset, or load the
>> firmware.
>>
>> As said I've been working on a 3th option:
>>
>> 3) Still add a quirk to i2c-hid but do the check at module_init
>> time, rather then add probe time, so that the i2c-hid driver never
>> registers avoiding the problem of the APCI PS3 / PS0 methods
>> getting called after the failed i2c-hid probe / before the icn8318
>> probe.
>>
>> I've implemented this now and it works well. Although not pretty, it
>> is only 2 lines of code (and a 5 line block comment), so I hope that
>> Jiri and Benjamin can live with this.
>>
>>
>> I personally prefer this 3th option (avoiding controller reset)
>> over adding firmware upload support for 3 reasons:
>>
>> 1) It is a lot less code it requires the following in i2c-hid:
>>
>>   static int __init i2c_hid_init(void)
>>   {
>> +       /*
>> +        * The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID
>> +        * compatible, just probing it puts the device in an unusable state due
>> +        * to it also have ACPI power management issues.
>> +        */
>> +       if (acpi_dev_present("CHPN0001", NULL, -1))
>> +               return -ENODEV;
>> +
>>          return i2c_add_driver(&i2c_hid_driver);
>>   }
> 
> I am not a big fan of this for several reasons (most can be worked
> around):
> - it's a hack for a specific device and is not generic enough

? It is for all devices with a CHPN0001 touchscreen according to
the alternative driver I found that covers at least the Chuwi Vi 10
Ultimate, Chuwi Vi10 plus and the Chuwi Hi 10. Note the match is
on an ACPI HID, which is (usually) not machine specific. Or with
"for a specific device", do you mean for a specific touchscreen
controller ?

> - it prevents i2c-hid to be loaded on a platform that exports such
>    device, even if other devices are legitimately using i2c-hid

The chances of a tablet like this having another HID device
attached through i2c are very very small. At first I tried to
avoid this problem by doing the check for CHPN0001 in i2c_hid_probe,
but as explained that is too late.

> - what if the chipone_icn8318 is not compiled in? Or in other words,
>    does the touchscreen works somehow with i2c-hid?

No it does not work at all with i2c-hid, AFAICT it is not doing
HID at all and the _CID advertising HID support is bogus, to get
touch data on an interrupt you need to do an i2c write of 2 bytes
to select the 0x1000 register address and then you read 37 bytes
for the touch data, which has this structure:

struct icn8318_touch {
         __u8 slot;
         __be16 x;
         __be16 y;
         __u8 pressure;  /* Seems more like finger width then pressure really */
         __u8 event;
/* The difference between 2 and 3 is unclear */
#define ICN8318_EVENT_NO_DATA   1 /* No finger seen yet since wakeup */
#define ICN8318_EVENT_UPDATE1   2 /* New or updated coordinates */
#define ICN8318_EVENT_UPDATE2   3 /* New or updated coordinates */
#define ICN8318_EVENT_END       4 /* Finger lifted */
} __packed;

struct icn8318_touch_data {
         __u8 softbutton;
         __u8 touch_count;
         struct icn8318_touch touches[ICN8318_MAX_TOUCHES];
} __packed;

Before doing these patches I've taken a quick look at i2c-hid and
AFAICT this has very little to do with I2C-hid, so I believe the
_CID with "PNP0C50" is simply bogus and we are going to need
to blacklist this in i2c-hid one way or the other anyway, even if
I do add firmware loading to the icn8505 specific driver.

> I think the biggest issue is that you are blacklisting a driver based on
> a single peripheral while other devices might want to use it.

I understand that that is not how we would normally do this, but:

1) Doing so allows the controller to keep its firmware which as
explained is a good thing for a number of reasons

2) The only hardware we know to has this peripheral is known to
not have any other i2c-HId peripherals, so although we would not
normally do this, it is not a problem.

> I have a couple of questions for you:
> - is the device working with i2c-hid (in degraded mode)?

Not sure what you mean by that, do you mean mouse emulation mode
or some such ? Anyways I've not had the device work in any way,
if I comment out the fix_up_power call which also triggers the
controller reset -> firmware gone thing, then I get a:

"unexpected HID descriptor bcdVersion (0x0000)" error instead
of the hid_descr_cmd failed error which happens when the
controller has lost its firmware, causing the i2c-hid driver
to not attach.

> - assuming the devices works with i2c-hid, will an rmmod/modprobe of
>    hid-generic/hid-chipony-icn8318 (to be written) introduce the PS3/PS0
>    issues?

If possible, yes I believe it will cause the PS3/PS0 issue,
but I don't think doing so is possible at all.

> If both are yes, I think we better have a hid specific driver for it
> (which could reuse part of the current input driver).

See above.

Regards,

Hans
