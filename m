From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/3] Input: gpio-keys - allow setting wakeup interrupt
 trigger type in DT
Date: Sat, 10 Feb 2018 08:06:39 +0800
Message-ID: <5A7E378F.4060100@rock-chips.com>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com> <20180209115510.11868-3-jeffy.chen@rock-chips.com> <20180209234246.GA252335@ban.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180209234246.GA252335-1WoqFLEneaORBCj4nEdE8WJtCfot02Oa@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Brian,

Thanks for your reply.

On 02/10/2018 07:42 AM, Brian Norris wrote:
> Hi Jeffy,
>
> On Fri, Feb 09, 2018 at 07:55:09PM +0800, Jeffy Chen wrote:
>> Allow specifying a different interrupt trigger type for wakeup when
>> using the gpio-keys input device as a wakeup source.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>>   Documentation/devicetree/bindings/input/gpio-keys.txt | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index a94940481e55..61926cef708f 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -26,6 +26,15 @@ Optional subnode-properties:
>>   	  If not specified defaults to 5.
>>   	- wakeup-source: Boolean, button can wake-up the system.
>>   			 (Legacy property supported: "gpio-key,wakeup")
>> +	- wakeup-trigger-type: Specifies the interrupt trigger type for wakeup.
>> +		 The value is defined in <dt-bindings/interrupt-controller/irq.h>
>
> Do you really want to codify interrupt triggers here? It seems like most
> of the information about edge vs. level is already codified elsewhere,
> so this becomes a little redundant. And in fact, some bindings may be
> specifying a "gpio", not technically an interrupt (at least not
> directly), so it feels weird to apply IRQ_* flags to them right here.
> Anyway, I think he only piece you really want to describe here is, do we
> wake on "event asserted", "event deasserted", or both. (The "none" case
> would just mean you shouldn't have the "wakeup-source" property.)
>
> So maybe:
>
> 	wakeup-trigger-type: Specifies whether the key should wake the
> 	system when asserted, when deasserted, or both. This property is
> 	only valid for keys that wake up the system (e.g., when the
> 	"wakeup-source" property is also provided). Supported values
> 	are:
> 	  1: asserted
> 	  2: deasserted
> 	  3: both asserted and deasserted
>
> ? We could still make macros out of those, if we want
> (input/linux-event-codes.h?). And then leave it up to the driver to
> determine how to translate that into the appropriate edge or level
> triggers.
make sense, will do it in the next version.
>
> Brian
>
>> +		 Only the following flags are supported:
>> +			IRQ_TYPE_NONE
>> +			IRQ_TYPE_EDGE_RISING
>> +			IRQ_TYPE_EDGE_FALLING
>> +			IRQ_TYPE_EDGE_BOTH
>> +			IRQ_TYPE_LEVEL_HIGH
>> +			IRQ_TYPE_LEVEL_LOW
>>   	- linux,can-disable: Boolean, indicates that button is connected
>>   	  to dedicated (not shared) interrupt which can be disabled to
>>   	  suppress events from the button.
>> --
>> 2.11.0
>>
>>
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
