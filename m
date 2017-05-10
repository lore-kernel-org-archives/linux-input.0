From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] HID: Add mapping for Microsoft Win8 Wireless Radio
 Controls extensions
Date: Wed, 10 May 2017 18:19:45 +0200
Message-ID: <e72c84cf-4793-9616-b193-6b42ef3a5e63@redhat.com>
References: <20170510151253.30324-1-hdegoede@redhat.com>
 <20170510154107.GA30987@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbdEJQUF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 May 2017 12:20:05 -0400
In-Reply-To: <20170510154107.GA30987@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On 10-05-17 17:41, Benjamin Tissoires wrote:
> On May 10 2017 or thereabouts, Hans de Goede wrote:
>> Microsoft has defined some extra HUT codes for the Generic Desktop Page
>> for Wireless Radio controls, see:
>>
>> https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
>> https://web.archive.org/web/20170509144631/https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
>>
>> I've 3 2-in-1 keyboard docks: Dell Venue Pro 11 keyboard dock,
>> HP pavilion x2 keyboard dock and a PEAQ C1010 keyboard dock which have
>> a wireless radio toggle hotkey, which uses the 0x000100c6 HUT code
>> defined in these extensions.
>>
>> This commit adds a mapping for this key, this makes the rfkill toggle
>> hotkey work on the Dell Venue Pro 11 and HP Pavilion X2 keyboards,
>> the PEAQ C1010 keyboard does generate events for the 0x000100c6 HUT
>> code when pressed, but the reported value is always 0.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/hid/hid-input.c |  9 +++++++++
>>   include/linux/hid.h     | 10 ++++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index d05f903c7614..79aa2f7d0482 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -656,6 +656,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>>   		case HID_GD_START:	map_key_clear(BTN_START);	break;
>>   		case HID_GD_SELECT:	map_key_clear(BTN_SELECT);	break;
>>   
>> +		case HID_GD_RFKILL_BTN:
>> +			/* MS wireless radio ctl extension, also check CA */
>> +			if (field->application == 0x0001000c) {
> 
> Nitpicking, but you should probably use HID_GD_WIRELESS_RADIO_CTLS
> instead of the constant.

Yeah that is actually why I defined it in the first place, my bad.
> 
>> +				map_key_clear(KEY_RFKILL);
>> +				/* We need to simulate the btn release */
>> +				field->flags |= HID_MAIN_ITEM_RELATIVE;
>> +				break;
>> +			}
>> +
>>   		default: goto unknown;
>>   		}
>>   
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index 28f38e2b8f30..8a259c6ea8a1 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -182,6 +182,12 @@ struct hid_item {
>>   #define HID_GD_KEYBOARD		0x00010006
>>   #define HID_GD_KEYPAD		0x00010007
>>   #define HID_GD_MULTIAXIS	0x00010008
>> +/*
>> + * Microsoft Win8 Wireless Radio Controls extensions CA, see (checked 09052017):
>> + * https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
>> + * https://web.archive.org/web/20170509144631/https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
> 
> Better linking the HUT directly:
> http://www.usb.org/developers/hidpage/HUTRR40RadioHIDUsagesFinal.pdf
> 
> We probably just need the full link in the commit message, and here only
> a reference to HUTRR40.

Ah I did not know about that version, I added the web.archive.org version
because using URLs usually is a bad idea because they tend to go stale.

I will do as you suggested and send a v2 tomorrow.

>> + */
>> +#define HID_GD_WIRELESS_RADIO_CTLS	0x0001000c
>>   #define HID_GD_X		0x00010030
>>   #define HID_GD_Y		0x00010031
>>   #define HID_GD_Z		0x00010032
>> @@ -210,6 +216,10 @@ struct hid_item {
>>   #define HID_GD_DOWN		0x00010091
>>   #define HID_GD_RIGHT		0x00010092
>>   #define HID_GD_LEFT		0x00010093
>> +/* Microsoft Win8 Wireless Radio Controls CA usage codes */
>> +#define HID_GD_RFKILL_BTN	0x000100c6
>> +#define HID_GD_RFKILL_LED	0x000100c7
>> +#define HID_GD_RFKILL_SWITCH	0x000100c8
> 
> In the HID usage table extension, they are called "Wireless Radio *".
> I wonder if we should have a closer name.

Then we would end up with HID_GD_WIRELESS_RADIO_* ?
Which is a bit long, RFKILL is linux-speak for this,
and nice and short, but if you prefer the long version
let me know and I'll change it for v2.

Regards,

Hans

