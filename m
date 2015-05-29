From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add driver for mouse logitech M560
Date: Fri, 29 May 2015 10:41:40 -0400
Message-ID: <CAN+gG=FXiLQYuwP1cFMP6yySUHUOxi2v-x==zYoHNUypEgW5Kg@mail.gmail.com>
References: <1431276572-3258-1-git-send-email-kreijack@libero.it>
	<1431276572-3258-2-git-send-email-kreijack@libero.it>
	<alpine.LNX.2.00.1505291635060.26271@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36606 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbbE2Oll (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 10:41:41 -0400
Received: by wgbgq6 with SMTP id gq6so64666376wgb.3
        for <linux-input@vger.kernel.org>; Fri, 29 May 2015 07:41:40 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1505291635060.26271@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Goffredo Baroncelli <kreijack@libero.it>, linux-input <linux-input@vger.kernel.org>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>, Jiri Kosina <jikos@jikos.cz>

On Fri, May 29, 2015 at 10:38 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 10 May 2015, Goffredo Baroncelli wrote:
>
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> The Logitech M560 is a wireless mouse designed for windows 8 which uses
>> the unifying receiver.
>> Compared to a standard one, some buttons (the middle one and the
>> two ones placed on the side) are bound to a key combination
>> instead of a generating classic "mouse" button events.
>>
>> The device shows up as a mouse and keyboard combination: when the middle
>> button is pressed it sends a key (as keyboard) combination, the same
>> happens for the two side button. The left/right/wheel work as expected
>> from a mouse. To complicate things further, the middle button sends
>> different keys combinations between odd and even presses.
>> In the "even" press it also sends a left click. But the worst thing
>> is that no event is generated when the middle button is released.
>>
>> It is possible to re-configure the mouse sending a command (see function
>> m560_send_config_command()). After this command the mouse sends some
>> useful data when the buttons are pressed and/or released.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>  drivers/hid/hid-logitech-hidpp.c | 241 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 238 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>> index b3cf6fd..2275f2a 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -40,8 +40,9 @@ MODULE_PARM_DESC(disable_raw_mode,
>>  #define HIDPP_REPORT_LONG_LENGTH             20
>>
>>  #define HIDPP_QUIRK_CLASS_WTP                        BIT(0)
>> +#define HIDPP_QUIRK_CLASS_M560                       BIT(1)
>>
>> -/* bits 1..20 are reserved for classes */
>> +/* bits 2..20 are reserved for classes */
>>  #define HIDPP_QUIRK_DELAYED_INIT             BIT(21)
>>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS     BIT(22)
>>  #define HIDPP_QUIRK_MULTI_INPUT                      BIT(23)
>> @@ -941,6 +942,221 @@ static int wtp_connect(struct hid_device *hdev, bool connected)
>>                       true, true);
>>  }
>>
>> +/*
>> + * copied from hid-core.c
>> + */
>> +static u32 hidpp_extract(u8 *report, unsigned offset, unsigned n)
>> +{
>> +     u64 x;
>> +
>> +     report += offset >> 3;  /* adjust byte index */
>> +     offset &= 7;            /* now only need bit offset into one byte */
>> +     x = get_unaligned_le64(report);
>> +     x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
>> +     return (u32)x;
>> +}
>
> I hate such code duplication. How about we rename it to
> hid_field_extract() and make its linkage external?

works for me

>
> [ ... snip ... ]
>> @@ -1301,6 +1532,10 @@ static const struct hid_device_id hidpp_devices[] = {
>>               USB_VENDOR_ID_LOGITECH, 0x4102),
>>         .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
>>                        HIDPP_QUIRK_CLASS_WTP },
>> +     { /* Mouse logitech M560 */
>> +       HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>> +             USB_VENDOR_ID_LOGITECH, 0x402d),
>> +       .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
>
> Seems like you forgot to add the device id to hid_have_special_driver[]?

nope, the device is tagged with HID_GROUP_LOGITECH_DJ_DEVICE, so
hid-generic ignores it by default.

Cheers,
Benjamin
