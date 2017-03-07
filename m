From: =?UTF-8?Q?Matja=c5=be_Hegedi=c4=8d?= <matjaz.hegedic@gmail.com>
Subject: Re: [PATCH] HID: asus: fix special key support for ASUS I2C keyboards
Date: Tue, 7 Mar 2017 12:56:12 +0100
Message-ID: <89d42448-01af-055c-877b-3ed0896b6ae6@gmail.com>
References: <1488675034-7220-1-git-send-email-matjaz.hegedic@gmail.com>
 <20170306084701.GV7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35219 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755284AbdCGL4i (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 06:56:38 -0500
Received: by mail-wr0-f196.google.com with SMTP id u108so21370660wrb.2
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 03:56:16 -0800 (PST)
In-Reply-To: <20170306084701.GV7064@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, Daniel Drake <drake@endlessm.com>

Hi Benjamin, Daniel, thanks for the quick response.

On 2017-03-06 09:47, Benjamin Tissoires wrote:
> Hi,
>
> [Adding Daniel in CC, he is also curerntly working on Asus keyboards]

That's good - I see our patches are very similar (also referring to the 
same Usage Page) and might feasibly be merged.

Really the only differences are set_bit before the switch statement 
(which shouldn't affect I2C keyboards) and the default statement (which 
needs to return -1 for I2C, since that one returns dummy data that makes 
the system treat it as a pointer device).

>
> On Mar 05 2017 or thereabouts, Matjaz Hegedic wrote:
>> On some ASUS notebooks (EeeBook X205TA, VivoBook E200HA) the built-in
>> keyboard uses a vendor-specific HID Usage Page for its special keys
>> (airplane mode, brightness, volume, etc.) which require remapping.
>> This cannot be resolved without a kernel driver (eg. udev/hwdb).
>> In addition, sloppy vendor implementation produces two tables
>> almost full of dummy usages, which misrepresent this devices'
>> capabilities and causes X to see it as a pointer/joystick device.
>> This patch adds the appropriate re-mappings and ignores the incorrect
>> dummy values.
>
> Shouldn't the quirk QUIRK_NO_CONSUMER_USAGES be set on a per-device
> basis, not globally for each keyboard?

If I understand correctly, you are bothered by the 'KEYBOARD_QUIRKS' 
phrasing: up until now, this driver handled I2C devices only (despite 
including no transport specific code) and therefore the only ASUS I2C 
keyboard device, which is present in X205TA and X200HA (possibly X206HA, 
as well), so it's technically only global because there's only one I2C 
keyboard device.

With Daniel expanding the driver to support USB keyboards, I understand 
it would be practical to perhaps rename KEYBOARD_QUIRKS to 
I2C_KEYBOARD_QUIRKS and USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD to 
USB_DEVICE_ID_ASUSTEK_NOTEBOOK_I2C_KEYBOARD.

>
> Also, is this quirk really needed since v4.9 with
> 1989dada7ce07848196991c9ebf25ff9c5f14d4e ("HID: input: ignore System
> Control application usages if not System Controls")?
>

Unfortunately, yes. Probably because field->application != 
HID_GD_SYSTEM_CONTROL with I2C keyboard. I will investigate what the 
actual value is further, but as it stands with both 4.9 and 4.10 the 
keyboard is still detected as a pointer device if the dummy usages are 
not ignored.

> One nitpick inlined below:
>
>>
>> Signed-off-by: Matjaz Hegedic <matjaz.hegedic@gmail.com>
>> ---
>>  drivers/hid/hid-asus.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 70b12f8..a6492ec 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -1,12 +1,14 @@
>>  /*
>>   *  HID driver for Asus notebook built-in keyboard.
>> - *  Fixes small logical maximum to match usage maximum.
>> + *  Fixes small logical maximum to match usage maximum,
>> + *  adds special key support, and ignores dummy usages.
>>   *
>>   *  Currently supported devices are:
>>   *    EeeBook X205TA
>>   *    VivoBook E200HA
>>   *
>>   *  Copyright (c) 2016 Yusuke Fujimaki <usk.fujimaki@gmail.com>
>> + *  Copyright (c) 2017 Matjaz Hegedic <matjaz.hegedic@gmail.com>
>>   *
>>   *  This module based on hid-ortek by
>>   *  Copyright (c) 2010 Johnathon Harris <jmharris@gmail.com>
>> @@ -36,8 +38,11 @@ MODULE_AUTHOR("Yusuke Fujimaki <usk.fujimaki@gmail.com>");
>>  MODULE_AUTHOR("Brendan McGrath <redmcg@redmandi.dyndns.org>");
>>  MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
>>  MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
>> +MODULE_AUTHOR("Matjaz Hegedic <matjaz.hegedic@gmail.com>");
>>  MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>
>> +#define HID_UP_ASUSVENDOR    0xff310000
>> +
>>  #define FEATURE_REPORT_ID 0x0d
>>  #define INPUT_REPORT_ID 0x5d
>>
>> @@ -63,15 +68,20 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>  #define QUIRK_NO_INIT_REPORTS		BIT(1)
>>  #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
>>  #define QUIRK_IS_MULTITOUCH		BIT(3)
>> +#define QUIRK_NO_CONSUMER_USAGES	BIT(4)
>>
>>  #define KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>> -						 QUIRK_NO_INIT_REPORTS)
>> +						 QUIRK_NO_INIT_REPORTS | \
>> +						 QUIRK_NO_CONSUMER_USAGES)
>>  #define TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
>>  						 QUIRK_SKIP_INPUT_MAPPING | \
>>  						 QUIRK_IS_MULTITOUCH)
>>
>>  #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
>>
>> +#define asus_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, \
>> +		max, EV_KEY, (c))
>> +
>>  struct asus_drvdata {
>>  	unsigned long quirks;
>>  	struct input_dev *input;
>> @@ -213,6 +223,42 @@ static int asus_input_mapping(struct hid_device *hdev,
>>  		return -1;
>>  	}
>>
>> +	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
>> +		switch (usage->hid & HID_USAGE) {
>> +		case 0x10:
>> +			asus_map_key_clear(KEY_BRIGHTNESSDOWN); break;
>
> Please put "break" in a separate line. Otherwise, I just feel like there
> is a fall-through and I got confused. Same applies to the rest of the
> cases.
>
> Cheers,
> Benjamin
>

No problem. Will fix in v2 (as soon as we work out how to resolve the 
merge with Daniel's patch).

>> +		case 0x20:
>> +			asus_map_key_clear(KEY_BRIGHTNESSUP); break;
>> +		case 0x35:
>> +			asus_map_key_clear(KEY_DISPLAY_OFF); break;
>> +		case 0x6b:
>> +			asus_map_key_clear(KEY_F21); break;
>> +		case 0x6c:
>> +			asus_map_key_clear(KEY_SLEEP); break;
>> +		case 0x88:
>> +			asus_map_key_clear(KEY_RFKILL);	break;
>> +		default:
>> +			/* ASUS lazily declares 256 usages, ignore the rest */
>> +			return -1;
>> +		}
>> +		return 1;
>> +	}
>> +
>> +	if (drvdata->quirks & QUIRK_NO_CONSUMER_USAGES &&
>> +		(usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
>> +		switch (usage->hid & HID_USAGE) {
>> +		case 0xe2: /* Mute */
>> +		case 0xe9: /* Volume up */
>> +		case 0xea: /* Volume down */
>> +			return 0;
>> +		default:
>> +			/* Ignore dummy Consumer usages which make the
>> +			 * keyboard incorrectly appear as a pointer device.
>> +			 */
>> +			return -1;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> --
>> 2.7.4
>>

Thanks!
