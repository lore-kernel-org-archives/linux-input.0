From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH] HID: hid-sony: Fix DS4 controller reporting rate issues
Date: Wed, 29 Jul 2015 10:28:28 -0400
Message-ID: <55B8E30C.5070903@gmail.com>
References: <1438069127-24710-1-git-send-email-atomnuker@gmail.com> <alpine.LNX.2.00.1507291419110.925@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36694 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbG2O2l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 10:28:41 -0400
In-Reply-To: <alpine.LNX.2.00.1507291419110.925@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Rostislav Pehlivanov <atomnuker@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>

On 7/29/2015 08:19, Jiri Kosina wrote:
> On Tue, 28 Jul 2015, Rostislav Pehlivanov wrote:
>
>>   This commit removes the cap on the DualShock 4 controller reporting
>> rate when connected using Bluetooth. The previous value of '0xB0'
>> capped the rate to only 20.83 Hz which many userspace utilities
>> mistook as a sign of a bad signal. Since a 'B' and an '8' can look
>> similar it's possible that someone mistook the one for another.
>> The new value of '0x80' enables the full 1000 Hz peak reporting
>> rate that the controller is capable of.
>>
>> Signed-off-by: Rostislav Pehlivanov <atomnuker@gmail.com>
>> ---
>>   drivers/hid/hid-sony.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
>> index ed2f008..3a6b6a9 100644
>> --- a/drivers/hid/hid-sony.c
>> +++ b/drivers/hid/hid-sony.c
>> @@ -1836,7 +1836,7 @@ static void dualshock4_state_worker(struct work_struct *work)
>>   	} else {
>>   		memset(buf, 0, DS4_REPORT_0x11_SIZE);
>>   		buf[0] = 0x11;
>> -		buf[1] = 0xB0;
>> +		buf[1] = 0x80;
>>   		buf[3] = 0x0F;
>>   		offset = 6;
> This got added by Frank in commit fdcf105d3d ("HID: sony: Add Dualshock 4
> Bluetooth output report formatting"). Adding him to CC to double-check.
>

I had some private communication with Rostislav about this fix and it 
looks good to me.  Back when the original code was written the purpose 
of that value was unknown and 0xB0 seemed to work so that's what ended 
up being used.  Now that we know what it actually does and that 0x80 is 
a better choice I support this patch.

Acked-by: Frank Praznik <frank.praznik@gmail.com>
