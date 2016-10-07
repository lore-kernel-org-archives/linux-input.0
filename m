From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] hid-led.c: remove unneccessary underscores
Date: Fri, 7 Oct 2016 20:46:26 +0200
Message-ID: <87cd7be4-286e-a664-9111-e71975e6a30e@gmail.com>
References: <20161003081626.GA18553@amd> <20161003094503.GC9131@amd>
 <20161007162556.GH30411@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34252 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbcJGSqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 14:46:44 -0400
In-Reply-To: <20161007162556.GH30411@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: j.anaszewski@samsung.com, linux-leds@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, jikos@kernel.org, linux-input@vger.kernel.org, trivial@kernel.org

Am 07.10.2016 um 18:25 schrieb Benjamin Tissoires:
> On Oct 03 2016 or thereabouts, Pavel Machek wrote:
>> On Mon 2016-10-03 10:16:26, Pavel Machek wrote:
>>>
>>> u8 (and friends) can be used directly in kernel sources (not kernel
>>> headers).
>>>
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> Zero day bot warned me that this is not quiet correct.
>>
>> This would be needed on top. Is there interest in fixed patch?
> 
> Having both __ and not __ in the same driver would be a little bit
> weird. So I'd say we just continue with the existing code. Thanks for
> the submission BTW!
> 
Reason for me to choose the __ types here was that hid_hw_raw_request
defines the buffer argument as "__u8 *buf" and I wanted to be in line
with that.

> Cheers,
> Benjamin
> 
>>
>> diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
>> index cd208ca..be659ca 100644
>> --- a/drivers/hid/hid-led.c
>> +++ b/drivers/hid/hid-led.c
>> @@ -57,8 +57,8 @@ union delcom_packet {
>>  		u8 cmd;
>>  	} rx;
>>  	struct {
>> -		le16 family_code;
>> -		le16 security_code;
>> +		__le16 family_code;
>> +		__le16 security_code;
>>  		u8 fw_version;
>>  	} fw;
>>  };
>>
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

