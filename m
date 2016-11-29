From: Hans Verkuil <hansverk@cisco.com>
Subject: Re: [PATCH] HID: change KEY_DATA from 0x275 to 0x277
Date: Tue, 29 Nov 2016 08:09:53 +0100
Message-ID: <861f8e1e-c785-1078-0a27-699b0c8bb5aa@cisco.com>
References: <1480366164-18706-1-git-send-email-pingc@wacom.com>
 <20161128212036.GA37762@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aer-iport-3.cisco.com ([173.38.203.53]:22132 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753188AbcK2HJ5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 02:09:57 -0500
In-Reply-To: <20161128212036.GA37762@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Kamil Debski <kamil@wypas.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On 11/28/2016 10:20 PM, Dmitry Torokhov wrote:
> On Mon, Nov 28, 2016 at 12:49:24PM -0800, Ping Cheng wrote:
>> 0x275 is used by KEY_FASTREVERSE. Or, was that on purpose to use
>> the same value as KEY_FASTREVERSE for KEY_DATA?
>>
>> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
>
> Ugh, that's not good. I guess we should indeed change this and make sure
> it goes to stable.
>
> Hans, Kamil, I do not suppose anyone actually been using KEY_DATA as it
> would have been clashing with KEY_FASTREVERSE?

No problem. These CEC event defines are only used by the CEC framework which
as of 4.9 is still in staging (will go out of staging in 4.10). So it is no
problem changing this. Nor has anyone been using this.

So:

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans

>
> Thanks.
>
>> ---
>>  include/uapi/linux/input-event-codes.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
>> index d6d071f..3af60ee 100644
>> --- a/include/uapi/linux/input-event-codes.h
>> +++ b/include/uapi/linux/input-event-codes.h
>> @@ -640,7 +640,7 @@
>>   * Control a data application associated with the currently viewed channel,
>>   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
>>   */
>> -#define KEY_DATA			0x275
>> +#define KEY_DATA			0x277
>>
>>  #define BTN_TRIGGER_HAPPY		0x2c0
>>  #define BTN_TRIGGER_HAPPY1		0x2c0
>> --
>> 2.7.4
>>
>

