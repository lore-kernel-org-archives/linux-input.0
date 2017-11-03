From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: Fix BTN_LEFT 0-1-0-1 events on
 Novatek mt touchpad
Date: Fri, 3 Nov 2017 13:17:27 +0100
Message-ID: <66af0076-464f-8011-ebd5-062cbbe2e780@redhat.com>
References: <20171102202339.9225-1-hdegoede@redhat.com>
 <20171102202339.9225-2-hdegoede@redhat.com>
 <20171103095655.GE1738@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1D0331CA267E7A5FF14B0BB3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdKCMRd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 3 Nov 2017 08:17:33 -0400
In-Reply-To: <20171103095655.GE1738@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Robert McQueen <robert@endlessm.com>

This is a multi-part message in MIME format.
--------------1D0331CA267E7A5FF14B0BB3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 03-11-17 10:56, Benjamin Tissoires wrote:
> On Nov 02 2017 or thereabouts, Hans de Goede wrote:
>> The Novatek 0603:0002 mt clickpad / keyboard combo found in some budget
>> Cherry Trail laptops, only reports the clickpad's button status in the
>> report for finger / slot 0. In the other reports the button field value
>> is always 0.
>>
>> This leads to BTN_LEFT 0-1-0-1 events being reported to userspace when
>> the button is pressed and 2 fingers or more are down. Making it impossible
>> to (left)click with one finger and drag with another to e.g. select text.
>>
>> This commit adds a quirk for this, ignoring the button field from reports
>> for the other fingers, fixing this.
> 
> Hi Hans,
> 
> may I have a look at the hid-record output when you press the button
> with one and with two fingers?
> 
> Because the quirk is pretty awful, and I wonder if there is not
> something fishy in our implementation.

Ok, recording of:

1) Clicking left-bottom of touchpad (left-button click on clickpad)
2) Dragging with a 2nd finger from left to right to select some text
3) Releasing 2nd finger
4) Releasing left-bottom / the click-button and the 1st finger

Attached.

Note AFAICT what is happening is really simply, the touchpad
sends reports containing data for 1 finger, so once 2 fingers
are down it alternately sends report for contactid 0 and contactid 1
and only the reports with contactid 0 contain a valid value for
the BTN_LEFT field, in the reports with contactid 1 the field
which we map to BTN_LEFT is always 0, so I really see no other
solution then ignoring that field for contactid != 0.

Regards,

Hans




> 
> Cheers,
> Benjamin
> 
>>
>> Cc: Daniel Drake <drake@endlessm.com>
>> Cc: Carlo Caione <carlo@endlessm.com>
>> Cc: Robert McQueen <robert@endlessm.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/hid/hid-ids.h        |  1 +
>>   drivers/hid/hid-multitouch.c | 25 +++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index be2e005c3c51..45bc5d81208c 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -797,6 +797,7 @@
>>   #define USB_DEVICE_ID_NINTENDO_WIIMOTE2	0x0330
>>   
>>   #define USB_VENDOR_ID_NOVATEK		0x0603
>> +#define USB_DEVICE_ID_NOVATEK_MT_TP	0x0002
>>   #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
>>   #define USB_DEVICE_ID_NOVATEK_MOUSE	0x1602
>>   
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index bb939f6990f1..28a58cfd2d3e 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -73,6 +73,7 @@ MODULE_LICENSE("GPL");
>>   #define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
>>   #define MT_QUIRK_STICKY_FINGERS		BIT(16)
>>   #define MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)
>> +#define MT_QUIRK_BUTTON_IN_SLOT0_ONLY	BIT(18)
>>   
>>   #define MT_INPUTMODE_TOUCHSCREEN	0x02
>>   #define MT_INPUTMODE_TOUCHPAD		0x03
>> @@ -135,6 +136,7 @@ struct mt_device {
>>   	bool is_buttonpad;	/* is this device a button pad? */
>>   	bool serial_maybe;	/* need to check for serial protocol */
>>   	bool curvalid;		/* is the current contact valid? */
>> +	int curslot;		/* current linux mt slot */
>>   	unsigned mt_flags;	/* flags to pass to input-mt */
>>   };
>>   
>> @@ -173,6 +175,7 @@ static void mt_post_parse(struct mt_device *td);
>>   #define MT_CLS_ASUS				0x010b
>>   #define MT_CLS_VTL				0x0110
>>   #define MT_CLS_GOOGLE				0x0111
>> +#define MT_CLS_NOVATEK				0x0112
>>   
>>   #define MT_DEFAULT_MAXCONTACT	10
>>   #define MT_MAX_MAXCONTACT	250
>> @@ -307,6 +310,14 @@ static struct mt_class mt_classes[] = {
>>   			MT_QUIRK_SLOT_IS_CONTACTID |
>>   			MT_QUIRK_HOVERING
>>   	},
>> +	{ .name = MT_CLS_NOVATEK,
>> +		.quirks = MT_QUIRK_ALWAYS_VALID |
>> +			MT_QUIRK_IGNORE_DUPLICATES |
>> +			MT_QUIRK_HOVERING |
>> +			MT_QUIRK_CONTACT_CNT_ACCURATE |
>> +			MT_QUIRK_STICKY_FINGERS |
>> +			MT_QUIRK_BUTTON_IN_SLOT0_ONLY
>> +	},
>>   	{ }
>>   };
>>   
>> @@ -676,6 +687,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>>   		active = (s->touch_state || s->inrange_state) &&
>>   							s->confidence_state;
>>   
>> +		td->curslot = slotnum;
>>   		input_mt_slot(input, slotnum);
>>   		input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
>>   		if (active) {
>> @@ -794,6 +806,13 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
>>   			break;
>>   
>>   		default:
>> +			if ((quirks & MT_QUIRK_BUTTON_IN_SLOT0_ONLY) &&
>> +			    td->curslot != 0 &&
>> +			    usage->type == EV_KEY &&
>> +			    usage->code >= BTN_MOUSE &&
>> +			    usage->code < BTN_JOYSTICK)
>> +				return;
>> +
>>   			if (usage->type)
>>   				input_event(input, usage->type, usage->code,
>>   						value);
>> @@ -1605,6 +1624,12 @@ static const struct hid_device_id mt_devices[] = {
>>   		MT_USB_DEVICE(USB_VENDOR_ID_TURBOX,
>>   			USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART) },
>>   
>> +	/* Novatek multi-touch touchpad / keyboard combo */
>> +	{ .driver_data = MT_CLS_NOVATEK,
>> +		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
>> +			USB_VENDOR_ID_NOVATEK,
>> +			USB_DEVICE_ID_NOVATEK_MT_TP) },
>> +
>>   	/* Novatek Panel */
>>   	{ .driver_data = MT_CLS_NSMU,
>>   		MT_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
>> -- 
>> 2.14.3
>>

--------------1D0331CA267E7A5FF14B0BB3
Content-Type: application/gzip;
 name="log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="log.gz"

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
7I4p7On+PVv/B1FemP+kWAAA
--------------1D0331CA267E7A5FF14B0BB3--
