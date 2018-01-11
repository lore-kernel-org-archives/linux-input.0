From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] HID: asus: Fix special function keys on T200TA
Date: Thu, 11 Jan 2018 15:10:47 +0100
Message-ID: <aea8b618-0e9a-8516-fb6a-d3409b361edf@redhat.com>
References: <20180105110919.30399-1-hdegoede@redhat.com>
 <20180105110919.30399-2-hdegoede@redhat.com>
 <CAO-hwJKyO+fWno7OaHBdki3pmCr183wh4NexkjYa73Jqi_ni7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36897 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbeAKOKv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 Jan 2018 09:10:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id f140so5680729wmd.2
        for <linux-input@vger.kernel.org>; Thu, 11 Jan 2018 06:10:50 -0800 (PST)
In-Reply-To: <CAO-hwJKyO+fWno7OaHBdki3pmCr183wh4NexkjYa73Jqi_ni7g@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On 05-01-18 18:00, Benjamin Tissoires wrote:
> On Fri, Jan 5, 2018 at 12:09 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Just like on the T100TA the T200TA HID descriptors for the 0xff32
>> Asus vendor usage page need a small fixup. But on the T200TA the HID
>> descriptors are larger because they have descrriptors for one more
>> (unused) HID report appended.
>>
>> Extend the T100TA descriptor fixup to also check for the T200TA's
>> descriptors size.
> 
> Sigh, both are:
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks. Jiri, what is the status of these ?

Regards,

Hans



>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/hid/hid-asus.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 07525bc99b6a..88b9703318e4 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -715,9 +715,10 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>>                  hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
>>                  rdesc[55] = 0xdd;
>>          }
>> -       /* For the T100TA keyboard dock */
>> +       /* For the T100TA/T200TA keyboard dock */
>>          if (drvdata->quirks & QUIRK_T100_KEYBOARD &&
>> -                *rsize == 76 && rdesc[73] == 0x81 && rdesc[74] == 0x01) {
>> +                (*rsize == 76 || *rsize == 101) &&
>> +                rdesc[73] == 0x81 && rdesc[74] == 0x01) {
>>                  hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
>>                  rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
>>          }
>> --
>> 2.14.3
>>
