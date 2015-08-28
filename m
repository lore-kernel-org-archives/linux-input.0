From: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Subject: Re: [PATCH 1/1] input: ff-memless: Allow negative attack / fade ramps
Date: Fri, 28 Aug 2015 17:41:12 +0300
Message-ID: <55E07308.6040007@jolla.com>
References: <1440673422-12279-1-git-send-email-kalle.jokiniemi@jolla.com> <1440673422-12279-2-git-send-email-kalle.jokiniemi@jolla.com> <55E06A65.3060001@jolla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp64.ord1c.emailsrvr.com ([108.166.43.64]:60516 "EHLO
	smtp64.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106AbbH1OlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 10:41:14 -0400
In-Reply-To: <55E06A65.3060001@jolla.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi,

On 28.08.2015 17:04, Kalle Jokiniemi wrote:
> Hi,
>
> Please disregard this patch, the math doesn't really change with this. I
> need to dig deeper what really was the issue, as I could see the
> negative ramp not working.

It seems the mis-interpretation of negative ramps not working was my 
personal user error of trying to do it with too short effects and 
FF_ENVELOPE_INTERVAL being 50ms.

Sorry for the noise.

- Kalle


>
> - Kalle
>
> On 27.08.2015 14:03, Kalle Jokiniemi wrote:
>> Currently the ff-memless force feedback periodic effects can only
>> have rising attack periods and declining fade periods. E.g. setting
>> a attack ramp that starts high to lower to normal magnitude, will
>> just cause the effect to rumble at high static speed for duration
>> of the attack period and then abruptly lower back to normal
>> magnitude instead of linearly declining the effect during attack
>> phase.
>>
>> To fix this, a check has been added to see if the envelope_level
>> of the attack or fade period is higher than default magnitude or
>> vise versa, and then adjusting the difference value calculation
>> accordingly.
>>
>> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
>> ---
>>   drivers/input/ff-memless.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
>> index 0723e0d..487df7e 100644
>> --- a/drivers/input/ff-memless.c
>> +++ b/drivers/input/ff-memless.c
>> @@ -190,7 +190,10 @@ static int apply_envelope(struct ml_effect_state
>> *state, int value,
>>       } else
>>           return value;
>>
>> -    difference = abs(value) - envelope_level;
>> +    if (abs(value) >= envelope_level)
>> +        difference = abs(value) - envelope_level;
>> +    else
>> +        difference = -(envelope_level - abs(value));
>>
>>       pr_debug("difference = %d\n", difference);
>>       pr_debug("time_from_level = 0x%x\n", time_from_level);
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
