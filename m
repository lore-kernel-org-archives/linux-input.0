From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Add no-irq-after-reset quirk for 0911:5288
 device
Date: Mon, 6 Nov 2017 21:26:19 +0100
Message-ID: <27f7f4cd-cb6a-b5bd-8c2e-6cd7f136c108@redhat.com>
References: <20171106150041.13933-1-hdegoede@redhat.com>
 <20171106175040.GN9728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65441 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754654AbdKFU0Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 15:26:24 -0500
In-Reply-To: <20171106175040.GN9728@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On 06-11-17 18:50, Benjamin Tissoires wrote:
> On Nov 06 2017 or thereabouts, Hans de Goede wrote:
>> Several cheap Apollo Lake based laptops / 2-in-1s use an i2c-hid mt
>> touchpad which is advertised by the DSDT with an ACPI HID of "SYNA3602",
>> this touchpad can be found on e.g. the Cube Thinker and the EZBook 3 Pro.
>>
>> On my "T-bao Tbook air" the i2c-hid driver fails to bind to this touchpad:
>> "i2c_hid i2c-SYNA3602:00: failed to reset device.".
>>
>> After some debuging this it seems that this touchpad simply never sends
>> an interrupt after a reset as expected by the i2c hid driver. This commit
>> adds a quirk for this device, making i2c_hid_command sleep 100ms after
>> a reset instead of waiting for an irq, fixing i2c-hid failing to bind to
>> this touchpad.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/hid/hid-ids.h         | 7 +++++++
>>   drivers/hid/i2c-hid/i2c-hid.c | 7 ++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index be2e005c3c51..47c5e709c2fd 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -1003,6 +1003,13 @@
>>   #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
>>   #define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
>>   
>> +/*
>> + * These are from i2c-hid mt touchpads found in several cheap Apollo Lake
>> + * based laptops which advertise the touchpad with an ACPI HID of "SYNA3602".
>> + */
>> +#define I2C_VENDOR_ID_SYNAPTICS		0x0911
> 
> Is this really a Synaptics device? What is the Windows driver
> advertising?

I'm afraid I've wiped the Windows partition on the device,
looking at the driver zip which is available for the device,
there is no specific driver for the touchpad, so I assume it
just works with the windows default driver.

> Because I am having a hard time Synaptics would do such
> thing. The USB Vendor ID for 0x0911 is "Philips Speech Processing"
> https://usb-ids.gowdy.us/read/UD/0911, and I doubt HID over I2C devices
> are supposed to use anything but USB managed vendor IDs...

Agreed, I guess that the hardware vendor just took the
first touchpad entry in the DSDT and edited the i2c
address in there to match the touchpad (and set status
to present) without changing the HID in the DSDT entry.

So I've opened up the device, the touchpad PCB is marked as:

Hantick

HTX9848TI+EFSA

And has a Hantick HTT5288 controller on there
(and an EM85F690 fingerprint reader IC).

So the 5288 matches with the product id and it
seems that Hantick has decided to use 0x0911 as
vendor id for them.

So for v2 of this patch I will change the defines
to I2C_VENDOR_ID_HANTICK and I2C_PRODUCT_ID_HANTICK5288.

>> +#define I2C_PRODUCT_ID_SYNA3602		0x5288
>> +
>>   #define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
>>   #define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA	0x0855
>>   
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index 7f701772edfe..9ceef884a4b3 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -46,6 +46,7 @@
>>   
>>   /* quirks to control the device */
>>   #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
>> +#define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
>>   
>>   /* flags */
>>   #define I2C_HID_STARTED		0
>> @@ -168,6 +169,8 @@ static const struct i2c_hid_quirks {
>>   		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>>   	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
>>   		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>> +	{ I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNA3602,
>> +		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
>>   	{ 0, 0 }
>>   };
>>   
>> @@ -252,7 +255,9 @@ static int __i2c_hid_command(struct i2c_client *client,
>>   
>>   	ret = 0;
>>   
>> -	if (wait) {
>> +	if (wait && (ihid->quirks & I2C_HID_QUIRK_NO_IRQ_AFTER_RESET)) {
>> +		msleep(100);
> 
> This is a sad thing to add, but if we do not have the choice... Does the
> Windows driver requires any changes or the Windows shipped one just
> works?

As said, looking at the driver zip it appears this just works with the
driver included in Windows.

Regards,

Hans


> 
> Cheers,
> Benjamin
> 
>> +	} else if (wait) {
>>   		i2c_hid_dbg(ihid, "%s: waiting...\n", __func__);
>>   		if (!wait_event_timeout(ihid->wait,
>>   				!test_bit(I2C_HID_RESET_PENDING, &ihid->flags),
>> -- 
>> 2.14.3
>>
