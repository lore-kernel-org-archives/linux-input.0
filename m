From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [PATCH] Input: cyttsp4 - fix potential NULL pointer dereference
 in cyttsp4_watchdog_timer()
Date: Mon, 26 Aug 2013 08:54:30 +0300
Message-ID: <521AED96.7030804@cypress.com>
References: <CAPgLHd9YkK2-nqympYoKb+OTWfkND+3SJYGw_vCRbN6VpXWZog@mail.gmail.com> <2cac6f3b-3107-4ead-95e3-f4070b894dc6@email.android.com>
Reply-To: <fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay-s04-hub004.domainlocalhost.com ([74.115.207.103]:8070
	"EHLO relay-S04-HUB004.domainlocalhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755334Ab3HZGAI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 02:00:08 -0400
In-Reply-To: <2cac6f3b-3107-4ead-95e3-f4070b894dc6@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, javier@dowhile0.org, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On 08/26/2013 08:26 AM, Dmitry Torokhov wrote:
> Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> The dereference should be moved below the NULL test.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>> drivers/input/touchscreen/cyttsp4_core.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/cyttsp4_core.c
>> b/drivers/input/touchscreen/cyttsp4_core.c
>> index 963da05..ffa8e35 100644
>> --- a/drivers/input/touchscreen/cyttsp4_core.c
>> +++ b/drivers/input/touchscreen/cyttsp4_core.c
>> @@ -1244,11 +1244,11 @@ static void cyttsp4_watchdog_timer(unsigned
>> long handle)
>> {
>>      struct cyttsp4 *cd = (struct cyttsp4 *)handle;
>>
>> -    dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
>> -
>>      if (!cd)
>>              return;
>>
> Actually this test does not make any sense and we should rather remove it.
Agreed on removing it. For cases "cd" can be NULL/invalid, watchdog
already stopped:
1- in probe(), when timer set, cd allocated and NULL check done.
2- in probe(), in error path after timer set, watchdog stopped before
"cd" freed
3- in cyttsp4_remove(), watchdog stopped before "cd" freed

>
>> +    dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
>> +
>>      if (!work_pending(&cd->watchdog_work))
>>              schedule_work(&cd->watchdog_work);
>>
> Hi Wei,
> Thanks.
>

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
