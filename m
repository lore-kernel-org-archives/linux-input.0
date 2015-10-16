From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [RFC 1/4] Input: edt-ft5x06 - Use max support points to determine
 how much to read
Date: Thu, 15 Oct 2015 19:44:04 -0500
Message-ID: <56204854.9050503@ti.com>
References: <1444220501-23623-1-git-send-email-fcooper@ti.com>
 <1444220501-23623-2-git-send-email-fcooper@ti.com>
 <20151014233904.GA3673@dtor-ws> <561F0848.7040408@ti.com>
 <20151016001632.GB1794@dtor-ws> <5620481B.5050709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbbJPAo0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 20:44:26 -0400
In-Reply-To: <5620481B.5050709@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, lw@karo-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com



On 10/15/2015 07:43 PM, Franklin S Cooper Jr. wrote:
>
> On 10/15/2015 07:16 PM, Dmitry Torokhov wrote:
>> On Wed, Oct 14, 2015 at 08:58:32PM -0500, Franklin S Cooper Jr. wrote:
>>> On 10/14/2015 06:39 PM, Dmitry Torokhov wrote:
>>>> On Wed, Oct 07, 2015 at 07:21:38AM -0500, fcooper@ti.com wrote:
>>>>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>
>>>>> Calculate the amount of data that needs to be read for the specified max
>>>>> number of support points. If the maximum number of support points changes
>>>>> then the amount that is read from the touch screen controller should
>>>>> reflect this.
>>>>>
>>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>>> ---
>>>>>  drivers/input/touchscreen/edt-ft5x06.c | 6 ++++--
>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
>>>>> index 7239c31..1e0ed6e 100644
>>>>> --- a/drivers/input/touchscreen/edt-ft5x06.c
>>>>> +++ b/drivers/input/touchscreen/edt-ft5x06.c
>>>>> @@ -178,14 +178,16 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>>>>>  		cmd = 0xf9; /* tell the controller to send touch data */
>>>>>  		offset = 5; /* where the actual touch data starts */
>>>>>  		tplen = 4;  /* data comes in so called frames */
>>>>> -		datalen = 26; /* how much bytes to listen for */
>>>>> +
>>>>> +		/* how many bytes to listen for */
>>>>> +		datalen = tplen * MAX_SUPPORT_POINTS + offset + 1;
>>>>>  		break;
>>>>>  
>>>>>  	case M09:
>>>>>  		cmd = 0x02;
>>>>>  		offset = 1;
>>>>>  		tplen = 6;
>>>>> -		datalen = 29;
>>>>> +		datalen = tplen * MAX_SUPPORT_POINTS - cmd + 1;
>>>>>  		break;
>>>> Hmm, why would formulae for datalen be different depending on the
>>>> firmware? And I think original 29 it too low: we need 30 bytes for 5
>>>> contacts + 1 to account for offset.
>>> So based on the current ISR we don't care about the touch weight and
>>> which are the last two registers for each touch point. So for the last
>>> touchpoint we really don't need to read the extra two registers (-2).
>> This is really not obvious. I do not think we'd see any performance
>> degradation if we actually read the whole last touchpoint.
> Yeah that shouldn't be a problem. I'll fix that.
>>> We need +1 simply for the fact that we read the register at location
>>> cmd.
>> I am not sure I follow this. We do not reference anything past
>> rdbuf[(MAX_SUPPORT_POINTS - 1) * tplen + offset] and
>> our offset takes care of the start position, so why exactly we need the
>> +1? Ah, CRC is in the extra byte.
> Sorry your right the +1 isn't needed.
>> Can we unify the calculation to be:
>>
>> 	datalen = tplen * MAX_SUPPORT_POINTS + offset + crc_len;
> Why do we need the crc_len? M06 is the only one that uses the CRC
> and the offset insures we are reading the necessary crc registers.
>
> Unless I'm missing something it would simply be:
>
> datalen = tplen * MAX_SUPPORT_POINTS + offset
>
>> By the way, what version of firmware you tested your changes with?
Forgot to add. I'm using the M09 version.
>>
>>> So 6 * 5 - 2 + 1 which is how we get to 29. The formula looks slightly
>>> different because the registers we are reading are very close to zero
>>> so the math works out to equal the equation I used for M09.
>>>
>>> M06 since tplen = 4 then all four registers are used in the ISR per touch
>>> point. Plus the offset and plus 1 again to account for the fact we are reading
>>> the cmd register. But once again it would be nice if someone can confirm this.
>>>> I also wonder why we need extra 1 byte in M06 case.
>>>>
>>>> Lothar?
>>>>
>>>> Thanks.
>>>>
>> Thanks.
>>

