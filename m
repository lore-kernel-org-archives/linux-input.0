From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 03/63] Input: atmel_mxt_ts - only read messages in
 mxt_acquire_irq() when necessary
Date: Wed, 21 Aug 2019 22:26:31 +0900
Message-ID: <558e1227-7671-0838-d4e0-f234833c0973@mentor.com>
References: <20190816082952.17985-1-jiada_wang@mentor.com>
 <20190816082952.17985-4-jiada_wang@mentor.com>
 <20190816171622.GF121898@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816171622.GF121898@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry

On 2019/08/17 2:16, Dmitry Torokhov wrote:
> On Fri, Aug 16, 2019 at 05:28:52PM +0900, Jiada Wang wrote:
>> From: Nick Dyer <nick.dyer@itdev.co.uk>
>>
>> The workaround of reading all messages until an invalid is received is a
>> way of forcing the CHG line high, which means that when using
>> edge-triggered interrupts the interrupt can be acquired.
>>
>> With level-triggered interrupts the workaround is unnecessary.
>>
>> Also, most recent maXTouch chips have a feature called RETRIGEN which, when
>> enabled, reasserts the interrupt line every cycle if there are messages
>> waiting. This also makes the workaround unnecessary.
>>
>> Note: the RETRIGEN feature is only in some firmware versions/chips, it's
>> not valid simply to enable the bit.
> 
> Instead of trying to work around of misconfiguration for IRQ/firmware,
> can we simply error out of probe if we see a level interrupt with
> !RETRIGEN firmware?
> 
I think for old firmwares, which doesn't support RETRIGEN feature, this 
workaround is needed, otherwise we will break all old firmwares, which 
configured with edge-triggered IRQ

for recent firmwares which support RETRIGEN feature, we can fail probe, 
if RETRIGEN is not enabled, and configured with edge-triggered IRQ.

what is your thought?

Thanks,
Jiada
> Thanks.
> 
