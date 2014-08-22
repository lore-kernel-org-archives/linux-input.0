From: vichy <vichy.kuo@gmail.com>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Fri, 22 Aug 2014 18:43:23 +0800
Message-ID: <CAOVJa8F5HoS48wYn5-yHCeioYNOOGEKwXg6WujCQH0QxA44o=Q@mail.gmail.com>
References: <1408692913-12336-1-git-send-email-vichy.kuo@gmail.com>
	<alpine.LNX.2.00.1408220240430.23162@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51322 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbaHVKnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2014 06:43:24 -0400
In-Reply-To: <alpine.LNX.2.00.1408220240430.23162@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

hi Jiri:

2014-08-22 15:45 GMT+08:00 Jiri Kosina <jkosina@suse.cz>:
> On Fri, 22 Aug 2014, CheChun Kuo wrote:
>
>>       HID IR device will not response to any command send from host when
>> it is finishing paring and tring to reset itself. During this period of
>> time, usb_cleaer_halt will be fail and if hid_start_in soon again, we
>> has the possibility trap in infinite loop.
>>
>> Signed-off-by: CheChun Kuo <vichy.kuo@gmail.com>
>> ---
>>  drivers/hid/usbhid/hid-core.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> index 79cf503..256b102 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -122,7 +122,8 @@ static void hid_reset(struct work_struct *work)
>>               dev_dbg(&usbhid->intf->dev, "clear halt\n");
>>               rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
>>               clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
>> -             hid_start_in(hid);
>> +             if (rc == 0)
>> +                     hid_start_in(hid);
>>       }
>
> I'd need a more detailed explanation for this patch, as I don't understand
> neither the text in the changelog nor the patch itself. Namely:
>
> - which IR devices are showing this behavior?
The USB hid device that will transform IR signal to usb command when
user press "volume up/down", "voice recording", etc.

> - where does the infinite loop come from? hid_reset() should error out
>   properly if usb_clear_halt() fails and HID_IN_RUNNING flag is not set
Below I briefly draw the timing when this issue happen

i) hid_irq_in get URB status as -EPIPE
ii) set HID_CLEAR_HALT flag and schedule hid_reset work
iii) hid_reset call usb_clear_halt and hid_start_in again
iv) if device still doesn't response host command, it will go to i)
above and keep looping

thanks for your help,
