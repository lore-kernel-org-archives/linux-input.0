From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: multitouch: Add quirk for N-trig (1b96:1B05)
Date: Thu, 17 Sep 2015 11:26:39 -0400
Message-ID: <CAN+gG=GP=VNkwXxNOkQPCzr1iPcmVNbQZRTo7ApakhT7dvXiVg@mail.gmail.com>
References: <1442502394-21214-1-git-send-email-daniel.martin@secunet.com>
	<CAN+gG=GLa_0wJTtp8JUaT7k_Ddv-GLbkpAwvnWMpxBODVw37BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34162 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbIQP0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 11:26:41 -0400
Received: by wicfx3 with SMTP id fx3so28931474wic.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2015 08:26:40 -0700 (PDT)
In-Reply-To: <CAN+gG=GLa_0wJTtp8JUaT7k_Ddv-GLbkpAwvnWMpxBODVw37BQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <daniel.martin@secunet.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Daniel Martin <consume.noise@gmail.com>

On Thu, Sep 17, 2015 at 11:25 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi Daniel,
>
> On Thu, Sep 17, 2015 at 11:06 AM, Daniel Martin
> <daniel.martin@secunet.com> wrote:
>> The N-trig (1b96:1B05) is an I2C device. It can be found in a
>> Microsoft Surface Pro 3. Users reported that sometimes the touschscreen
>> gets stuck during work - not responding to touches anymore.
>>
>> Under certain circumstances the touschscreen sends "ghost" reports.
>> Reports for contacts that have been lifted prior and with suspicious
>> data (ContactID == X == Y == W == H == 0xffff and Tipswitch == true). In
>> such a case evemu-record would report something like:
>>
>>   E: 44.290448 0003 002f 0006 # EV_ABS / ABS_MT_SLOT          6
>>   E: 44.290448 0003 0039 0024 # EV_ABS / ABS_MT_TRACKING_ID   24
>>   E: 44.290448 0003 0035 65535    # EV_ABS / ABS_MT_POSITION_X    65535
>>   E: 44.290448 0003 0036 65535    # EV_ABS / ABS_MT_POSITION_Y    65535
>>   E: 44.290448 0003 003c 65535    # EV_ABS / ABS_MT_TOOL_X        65535
>>   E: 44.290448 0003 003d 65535    # EV_ABS / ABS_MT_TOOL_Y        65535
>>   E: 44.290448 0003 0034 0000 # EV_ABS / ABS_MT_ORIENTATION   0
>>   E: 44.290448 0003 0030 32767    # EV_ABS / ABS_MT_TOUCH_MAJOR   32767
>>   E: 44.290448 0003 0031 32767    # EV_ABS / ABS_MT_TOUCH_MINOR   32767
>>
>> We never see that such a contact gets lifted (Tipswitch == false) and
>> therefore have an active unused slot. If we keep processing we end up
>> with all slots active, but none in use. Then input_mt_get_slot_by_key()
>> always returns -1 (can't get a slot) and we never send any event
>> anymore. MT_QUIRK_NOT_SEEN_MEANS_UP could fix this, but we don't want
>> to send such suspicious values to user-land.
>> Instead, we add MT_QUIRK_INVALID_CONTACTID_FFFF for this device and
>> don't try to get a slot for a report with ContactID=0xffff. Though, now,
>> we may miss a one valid contact (per input descriptor a contact id of
>> 0xffff is valid, that's its logic maximum).
>
> Facepalm. How did they managed to have such a bug in their protocol on
> their own device???? This is really depressing.
>
> This fix is fine IMO. 0xffff seems unlikely to be used before long
> after boot, and I wouldn't be surprised if they just roll back to 0
> when they arrive at 0xff for the contact ID.
>
> Small remark, we may not need to add the device ID to hid-ids.h given
> that it is not used anywhere else than in hid-multitouch.c.
>
> Besides this:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

You forgot to CC Jiri, which is mandatory if you want your patch to
end up in a timely manner in his tree :)

>
> Thanks for the analysis and the patch!
>
> Cheers,
> Benjamin
>
>>
>> Lets look at input reports unveiling the problem. First 3 bytes
>> (Length=29 and ReportId=3) and last 4 bytes (ScanTime) have been
>> stripped.
>>
>> 1. frame - 10 reports (10 contacts active):
>>     ca 01 e7 31 00 3b 12 3b 12 15 05 15 05 69 02 76 03 ff ff ff ff 0a
>>     ca 01 e7 32 00 ba 0c ba 0c a1 01 a1 01 d3 01 c5 02 ff ff ff ff 00
>>     ca 01 e7 33 00 a8 07 a8 07 5b 03 5b 03 d3 01 14 02 ff ff ff ff 00
>>     ca 01 e7 37 00 92 0f 92 0f 79 01 79 01 d3 01 77 03 ff ff ff ff 00
>>     ca 01 e7 3d 00 82 09 82 09 2b 18 2b 18 cf 04 72 03 ff ff ff ff 00
>>     ca 01 e7 38 00 a9 21 a9 21 80 07 80 07 6f 02 14 02 ff ff ff ff 00
>>     ca 01 e7 39 00 c0 1c c0 1c 2c 05 2c 05 6f 02 c5 02 ff ff ff ff 00
>>     ca 01 e7 3a 00 a7 19 a7 19 55 05 55 05 e0 01 22 02 ff ff ff ff 00
>>     ca 01 e7 3b 00 bd 15 bd 15 80 09 80 09 db 01 1d 02 ff ff ff ff 00
>>     ca 01 e7 3c 00 f2 16 f2 16 56 13 56 13 76 01 a4 01 ff ff ff ff 00
>>     v---- v- v---- v---- v---- v---- v---- v---- v---- v---------- v-
>>     V1    CT CID   X     X     Y     Y     W     H     V2          CC
>>
>>   V1 ... Usage Page (Vendor Defined 0xFF00), Usage (0x01) [1x2 bytes]
>>          Frame sequence id?
>>   TC ... Tipswitch (bit 0) and Confidence (bit 2)
>>          (Confidence bit is always set)
>>   CID .. ContactID
>>   X/Y .. X/Y coordinate (yes, always twice the same value)
>>   W/H .. Width/Height
>>   V2 ... Usage Page (Vendor Defined 0xFF00), Usage (0x02) [4x1 byte]
>>          (always ff, not const, valid from 0 to 255?)
>>   CC ... ContactCount
>>
>>   We see that initially ContactCount is 10 and we get 10 reports. Each
>>   report shows an active slot (Tipswitch bit in TC is set, TC=e7).
>>   The contact ids are 31, 32, 33, 37, 38, 39, 3a, 3b, 3c and 3d.
>>
>> 2. frame - 10 reports (5 contacts active, 5 becoming inactive):
>>     cb 01 e4 31 00 3b 12 3b 12 15 05 15 05 69 02 76 03 ff ff ff ff 0a
>>     cb 01 e4 32 00 ba 0c ba 0c a1 01 a1 01 d3 01 c5 02 ff ff ff ff 00
>>     cb 01 e4 33 00 a8 07 a8 07 5b 03 5b 03 d3 01 14 02 ff ff ff ff 00
>>     cb 01 e4 37 00 92 0f 92 0f 79 01 79 01 d3 01 77 03 ff ff ff ff 00
>>     cb 01 e4 3d 00 82 09 82 09 2b 18 2b 18 cf 04 72 03 ff ff ff ff 00
>>     cb 01 e7 38 00 a9 21 a9 21 80 07 80 07 6f 02 14 02 ff ff ff ff 00
>>     cb 01 e7 39 00 c0 1c c0 1c 2c 05 2c 05 6f 02 c5 02 ff ff ff ff 00
>>     cb 01 e7 3a 00 a7 19 a7 19 57 05 57 05 e0 01 25 02 ff ff ff ff 00
>>     cb 01 e7 3b 00 bd 15 bd 15 81 09 81 09 dd 01 1f 02 ff ff ff ff 00
>>     cb 01 e7 3c 00 f6 16 f6 16 53 13 53 13 7e 01 ad 01 ff ff ff ff 00
>>
>>   5 contacts (31, 32, 33, 37 and 3d) become inactive (Tipswitch bit
>>   in TC is not set, TC=e4). Remaining contacts (38 to 3c) stay active.
>>
>> 3. frame - 10 reports (5 contacts active, 5 "ghosts"???)
>>     cc 01 e7 38 00 a9 21 a9 21 80 07 80 07 6f 02 14 02 ff ff ff ff 0a
>>     cc 01 e7 39 00 c0 1c c0 1c 2c 05 2c 05 6f 02 c5 02 ff ff ff ff 00
>>     cc 01 e7 3a 00 a6 19 a6 19 58 05 58 05 e2 01 27 02 ff ff ff ff 00
>>     cc 01 e7 3b 00 bc 15 bc 15 83 09 83 09 df 01 21 02 ff ff ff ff 00
>>     cc 01 e7 3c 00 f8 16 f8 16 4f 13 4f 13 85 01 b5 01 ff ff ff ff 00
>>     cc 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
>>     cc 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
>>     cc 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
>>     cc 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
>>     cc 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
>>
>>   The 5 active contacts (38 to 3c) from the previous frame stay active.
>>   Though, we get 5 suspicious reports! Ghosts from the last frame?
>>
>> 4. frame - 5 reports (5 contacts active)
>>     cd 01 e7 38 00 a9 21 a9 21 80 07 80 07 6f 02 14 02 ff ff ff ff 05
>>     cd 01 e7 39 00 c0 1c c0 1c 2c 05 2c 05 6f 02 c5 02 ff ff ff ff 00
>>     cd 01 e7 3a 00 a6 19 a6 19 5a 05 5a 05 e2 01 29 02 ff ff ff ff 00
>>     cd 01 e7 3b 00 bc 15 bc 15 84 09 84 09 df 01 24 02 ff ff ff ff 00
>>     cd 01 e7 3c 00 fb 16 fb 16 4c 13 4c 13 8b 01 bd 01 ff ff ff ff 00
>>
>>   Next frame and we're back to normal mode/data.
>>
>> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
>> ---
>>  drivers/hid/hid-ids.h        |  1 +
>>  drivers/hid/hid-multitouch.c | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index b3b225b..f297416 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -708,6 +708,7 @@
>>  #define USB_DEVICE_ID_NOVATEK_MOUSE    0x1602
>>
>>  #define USB_VENDOR_ID_NTRIG            0x1b96
>> +#define I2C_DEVICE_ID_NTRIG_TOUCH_SCREEN   0x1B05
>>  #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN   0x0001
>>  #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1   0x0003
>>  #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_2   0x0004
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 7c81125..8547b2e 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -67,6 +67,7 @@ MODULE_LICENSE("GPL");
>>  #define MT_QUIRK_HOVERING              (1 << 11)
>>  #define MT_QUIRK_CONTACT_CNT_ACCURATE  (1 << 12)
>>  #define MT_QUIRK_FORCE_GET_FEATURE     (1 << 13)
>> +#define MT_QUIRK_INVALID_CONTACTID_FFFF        (1 << 14)
>>
>>  #define MT_INPUTMODE_TOUCHSCREEN       0x02
>>  #define MT_INPUTMODE_TOUCHPAD          0x03
>> @@ -155,6 +156,7 @@ static void mt_post_parse(struct mt_device *td);
>>  #define MT_CLS_GENERALTOUCH_TWOFINGERS         0x0108
>>  #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS     0x0109
>>  #define MT_CLS_VTL                             0x0110
>> +#define MT_CLS_NTRIG                           0x0111
>>
>>  #define MT_DEFAULT_MAXCONTACT  10
>>  #define MT_MAX_MAXCONTACT      250
>> @@ -265,6 +267,10 @@ static struct mt_class mt_classes[] = {
>>                         MT_QUIRK_CONTACT_CNT_ACCURATE |
>>                         MT_QUIRK_FORCE_GET_FEATURE,
>>         },
>> +       { .name = MT_CLS_NTRIG,
>> +               .quirks = MT_QUIRK_ALWAYS_VALID |
>> +                       MT_QUIRK_INVALID_CONTACTID_FFFF,
>> +       },
>>         { }
>>  };
>>
>> @@ -546,6 +552,10 @@ static int mt_compute_slot(struct mt_device *td, struct input_dev *input)
>>         if (quirks & MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE)
>>                 return td->curdata.contactid - 1;
>>
>> +       if (quirks & MT_QUIRK_INVALID_CONTACTID_FFFF &&
>> +           td->curdata.contactid == 0xffff)
>> +               return -1;
>> +
>>         return input_mt_get_slot_by_key(input, td->curdata.contactid);
>>  }
>>
>> @@ -1277,6 +1287,12 @@ static const struct hid_device_id mt_devices[] = {
>>                 MT_USB_DEVICE(USB_VENDOR_ID_TURBOX,
>>                         USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART) },
>>
>> +       /* N-trig */
>> +       { .driver_data = MT_CLS_NTRIG,
>> +               HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>> +                       USB_VENDOR_ID_NTRIG,
>> +                       I2C_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
>> +
>>         /* Panasonic panels */
>>         { .driver_data = MT_CLS_PANASONIC,
>>                 MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
>> --
>> 2.1.4
>>
