From: Goffredo Baroncelli <kreijack@libero.it>
Subject: Re: [PATCH] Add driver for mouse logitech M560
Date: Fri, 29 May 2015 18:52:36 +0200
Message-ID: <55689954.9090303@libero.it>
References: <1431276572-3258-1-git-send-email-kreijack@libero.it> <1431276572-3258-2-git-send-email-kreijack@libero.it> <alpine.LNX.2.00.1505291635060.26271@pobox.suse.cz> <CAN+gG=FXiLQYuwP1cFMP6yySUHUOxi2v-x==zYoHNUypEgW5Kg@mail.gmail.com> <alpine.LNX.2.00.1505291642540.26271@pobox.suse.cz>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-33.italiaonline.it ([212.48.25.161]:54243 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756145AbbE2Qwi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 12:52:38 -0400
In-Reply-To: <alpine.LNX.2.00.1505291642540.26271@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>

Hi Jiri,
On 2015-05-29 16:44, Jiri Kosina wrote:
> On Fri, 29 May 2015, Benjamin Tissoires wrote:
> 
>>>> +static u32 hidpp_extract(u8 *report, unsigned offset, unsigned n)
>>>> +{
>>>> +     u64 x;
>>>> +
>>>> +     report += offset >> 3;  /* adjust byte index */
>>>> +     offset &= 7;            /* now only need bit offset into one byte */
>>>> +     x = get_unaligned_le64(report);
>>>> +     x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
>>>> +     return (u32)x;
>>>> +}
>>>
>>> I hate such code duplication. How about we rename it to
>>> hid_field_extract() and make its linkage external?
>>
>> works for me
> 
> Thanks. So I'd prefer this patch to be resent as a two-patch series, first 
> one bringing hid_field_extract(), and the second being the driver making 
> use of it.

I will update the patch on the basis of your request



> 
>>> [ ... snip ... ]
>>>> @@ -1301,6 +1532,10 @@ static const struct hid_device_id hidpp_devices[] = {
>>>>               USB_VENDOR_ID_LOGITECH, 0x4102),
>>>>         .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
>>>>                        HIDPP_QUIRK_CLASS_WTP },
>>>> +     { /* Mouse logitech M560 */
>>>> +       HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>>>> +             USB_VENDOR_ID_LOGITECH, 0x402d),
>>>> +       .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
>>>
>>> Seems like you forgot to add the device id to hid_have_special_driver[]?
>>
>> nope, the device is tagged with HID_GROUP_LOGITECH_DJ_DEVICE, so
>> hid-generic ignores it by default.
> 
> Gah, I keep forgetting about HID_GROUP_LOGITECH_DJ_DEVICE again and again.
> 
> Thanks,
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
