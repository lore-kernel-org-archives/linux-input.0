From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: Fix BTN_LEFT 0-1-0-1 events on
 Novatek mt touchpad
Date: Mon, 6 Nov 2017 15:58:04 +0100
Message-ID: <4e3268e9-08ea-2aae-a41b-ad93c921236e@redhat.com>
References: <20171102202339.9225-1-hdegoede@redhat.com>
 <20171102202339.9225-2-hdegoede@redhat.com>
 <20171103095655.GE1738@mail.corp.redhat.com>
 <66af0076-464f-8011-ebd5-062cbbe2e780@redhat.com>
 <20171103130940.GA9728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932129AbdKFO6J (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 09:58:09 -0500
In-Reply-To: <20171103130940.GA9728@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Robert McQueen <robert@endlessm.com>

Hi,

On 03-11-17 14:09, Benjamin Tissoires wrote:
> On Nov 03 2017 or thereabouts, Hans de Goede wrote:
>> Hi,
>>
>> On 03-11-17 10:56, Benjamin Tissoires wrote:
>>> On Nov 02 2017 or thereabouts, Hans de Goede wrote:
>>>> The Novatek 0603:0002 mt clickpad / keyboard combo found in some budget
>>>> Cherry Trail laptops, only reports the clickpad's button status in the
>>>> report for finger / slot 0. In the other reports the button field value
>>>> is always 0.
>>>>
>>>> This leads to BTN_LEFT 0-1-0-1 events being reported to userspace when
>>>> the button is pressed and 2 fingers or more are down. Making it impossible
>>>> to (left)click with one finger and drag with another to e.g. select text.
>>>>
>>>> This commit adds a quirk for this, ignoring the button field from reports
>>>> for the other fingers, fixing this.
>>>
>>> Hi Hans,
>>>
>>> may I have a look at the hid-record output when you press the button
>>> with one and with two fingers?
>>>
>>> Because the quirk is pretty awful, and I wonder if there is not
>>> something fishy in our implementation.
>>
>> Ok, recording of:
>>
>> 1) Clicking left-bottom of touchpad (left-button click on clickpad)
>> 2) Dragging with a 2nd finger from left to right to select some text
>> 3) Releasing 2nd finger
>> 4) Releasing left-bottom / the click-button and the 1st finger
>>
>> Attached.
>>
>> Note AFAICT what is happening is really simply, the touchpad
>> sends reports containing data for 1 finger, so once 2 fingers
>> are down it alternately sends report for contactid 0 and contactid 1
>> and only the reports with contactid 0 contain a valid value for
>> the BTN_LEFT field, in the reports with contactid 1 the field
>> which we map to BTN_LEFT is always 0, so I really see no other
>> solution then ignoring that field for contactid != 0.
> 
> Thanks. So this is more or less what I expected, we are not fully
> "compliant" with how Windows handle the touchpads:
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-precision-touchpad-required-hid-top-level-collections
> 
> This touchpad is using "single finger hybrid mode". The first report is
> marked with Contact Count > 0 and the subsequent ones have a contact
> count of 0.
> Given that the button is exported in all reports, it makes "sense" to
> actually only rely on the first report of the button, but not in the
> subsequent ones.
> 
> So I think we should fix the general protocol handling, not add a quirk
> for this one particular model. On top of that, you assume the contact ID
> 0 will always be reported with the button flags, while my guess is that
> if you press one finger to reach the button threshold, put a second
> finger, keeping the force hard enough, release the first, still keeping
> the button down, and then releasing the second finger, you might get the
> button stuck because at one point, the button information will be
> relayed through the second finger (contact ID 1). It might also simply
> release it too soon.
> 
> Anyway, a proper fix should be to tag which reports are primary (with
> contact count > 0, or with only buttons information, and/or that are
> not sharing the same scan time than the previous report), and only take
> into account buttons for these primary reports.
> 
> Of course, this should only apply to Win8 touchpads, given that Win7
> ones are dying or need special quirks.

Ok.

So I ended up hitting a related bug on a different Chinese laptop
(yeah cheap hardware) and I came up with a single fix for both issues.

The commit message of the new version explains this, so I will let
that one speak for itself.

Regards,

Hans



> 
> Cheers,
> Benjamin
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>>
>>> Cheers,
>>> Benjamin
>>>
>>>>
>>>> Cc: Daniel Drake <drake@endlessm.com>
>>>> Cc: Carlo Caione <carlo@endlessm.com>
>>>> Cc: Robert McQueen <robert@endlessm.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/hid/hid-ids.h        |  1 +
>>>>    drivers/hid/hid-multitouch.c | 25 +++++++++++++++++++++++++
>>>>    2 files changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>>> index be2e005c3c51..45bc5d81208c 100644
>>>> --- a/drivers/hid/hid-ids.h
>>>> +++ b/drivers/hid/hid-ids.h
>>>> @@ -797,6 +797,7 @@
>>>>    #define USB_DEVICE_ID_NINTENDO_WIIMOTE2	0x0330
>>>>    #define USB_VENDOR_ID_NOVATEK		0x0603
>>>> +#define USB_DEVICE_ID_NOVATEK_MT_TP	0x0002
>>>>    #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
>>>>    #define USB_DEVICE_ID_NOVATEK_MOUSE	0x1602
>>>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>>>> index bb939f6990f1..28a58cfd2d3e 100644
>>>> --- a/drivers/hid/hid-multitouch.c
>>>> +++ b/drivers/hid/hid-multitouch.c
>>>> @@ -73,6 +73,7 @@ MODULE_LICENSE("GPL");
>>>>    #define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
>>>>    #define MT_QUIRK_STICKY_FINGERS		BIT(16)
>>>>    #define MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)
>>>> +#define MT_QUIRK_BUTTON_IN_SLOT0_ONLY	BIT(18)
>>>>    #define MT_INPUTMODE_TOUCHSCREEN	0x02
>>>>    #define MT_INPUTMODE_TOUCHPAD		0x03
>>>> @@ -135,6 +136,7 @@ struct mt_device {
>>>>    	bool is_buttonpad;	/* is this device a button pad? */
>>>>    	bool serial_maybe;	/* need to check for serial protocol */
>>>>    	bool curvalid;		/* is the current contact valid? */
>>>> +	int curslot;		/* current linux mt slot */
>>>>    	unsigned mt_flags;	/* flags to pass to input-mt */
>>>>    };
>>>> @@ -173,6 +175,7 @@ static void mt_post_parse(struct mt_device *td);
>>>>    #define MT_CLS_ASUS				0x010b
>>>>    #define MT_CLS_VTL				0x0110
>>>>    #define MT_CLS_GOOGLE				0x0111
>>>> +#define MT_CLS_NOVATEK				0x0112
>>>>    #define MT_DEFAULT_MAXCONTACT	10
>>>>    #define MT_MAX_MAXCONTACT	250
>>>> @@ -307,6 +310,14 @@ static struct mt_class mt_classes[] = {
>>>>    			MT_QUIRK_SLOT_IS_CONTACTID |
>>>>    			MT_QUIRK_HOVERING
>>>>    	},
>>>> +	{ .name = MT_CLS_NOVATEK,
>>>> +		.quirks = MT_QUIRK_ALWAYS_VALID |
>>>> +			MT_QUIRK_IGNORE_DUPLICATES |
>>>> +			MT_QUIRK_HOVERING |
>>>> +			MT_QUIRK_CONTACT_CNT_ACCURATE |
>>>> +			MT_QUIRK_STICKY_FINGERS |
>>>> +			MT_QUIRK_BUTTON_IN_SLOT0_ONLY
>>>> +	},
>>>>    	{ }
>>>>    };
>>>> @@ -676,6 +687,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>>>>    		active = (s->touch_state || s->inrange_state) &&
>>>>    							s->confidence_state;
>>>> +		td->curslot = slotnum;
>>>>    		input_mt_slot(input, slotnum);
>>>>    		input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
>>>>    		if (active) {
>>>> @@ -794,6 +806,13 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
>>>>    			break;
>>>>    		default:
>>>> +			if ((quirks & MT_QUIRK_BUTTON_IN_SLOT0_ONLY) &&
>>>> +			    td->curslot != 0 &&
>>>> +			    usage->type == EV_KEY &&
>>>> +			    usage->code >= BTN_MOUSE &&
>>>> +			    usage->code < BTN_JOYSTICK)
>>>> +				return;
>>>> +
>>>>    			if (usage->type)
>>>>    				input_event(input, usage->type, usage->code,
>>>>    						value);
>>>> @@ -1605,6 +1624,12 @@ static const struct hid_device_id mt_devices[] = {
>>>>    		MT_USB_DEVICE(USB_VENDOR_ID_TURBOX,
>>>>    			USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART) },
>>>> +	/* Novatek multi-touch touchpad / keyboard combo */
>>>> +	{ .driver_data = MT_CLS_NOVATEK,
>>>> +		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
>>>> +			USB_VENDOR_ID_NOVATEK,
>>>> +			USB_DEVICE_ID_NOVATEK_MT_TP) },
>>>> +
>>>>    	/* Novatek Panel */
>>>>    	{ .driver_data = MT_CLS_NSMU,
>>>>    		MT_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
>>>> -- 
>>>> 2.14.3
>>>>
> 
> 
