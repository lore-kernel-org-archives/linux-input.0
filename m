From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Fri, 1 Apr 2016 17:03:08 +0300
Message-ID: <56FE7F9C.9050902@ti.com>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
 <1766024.riJEdmHPZI@ws-stein>
 <CACRpkdaynNEFGhCSkd7qAgxtNoRT=pRWbB0dJmjM89UM4NG_xQ@mail.gmail.com>
 <3233696.TZ7kbb7G3F@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <3233696.TZ7kbb7G3F@ws-stein>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Linux Input <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

On 04/01/2016 04:42 PM, Alexander Stein wrote:
> On Friday 01 April 2016 15:03:40, Linus Walleij wrote:
>> On Fri, Apr 1, 2016 at 2:16 PM, Alexander Stein
>>
>> <alexander.stein@systec-electronic.com> wrote:
>>> I noticed you fiddle with late_initcall_sync. Sorry, I did not mention it:
>>> gpio_mcp23s08 as well as gpio_keys are loaded as modules, so
>>> late_initcall_* should not affect it.
>>
>> I don't get this. I think probe deferral is only used to defer
>> initcalls used for built-in drivers.

It doesn't. Deferred probing expected to work for modules also.

> 
> To my understanding probe deferral is for the case when the parent or some
> other required resource like DT nodes (e.g. panel node for graphics driver) is
> not available yet. IIRC all deffered device are probed once a device was
> probed sucessfully, no?

true.

> So in my case, I would expect that gpio-keys probe fails due to missing IRQ
> parent and gets deferred. Once the IRQ parent happen to be probed successfully
> at some point gpio-keys is probed again and succeeds.

I assume in your case It's devm_gpio_request_one() first of all, which
follows by gpio_to_irq.

> 
>> If there are dependencies among things compiled as modules,
>> doesn't depmod/modprobe make sure that they are probed in
>> the right order? Could it be that some module alias thingofabob
>> is missing?
>>
>> Or is modprobe failing because it (correctly) see that there is
>> no symbol dependencies between the gpio_mcp23s08 and
>> gpio-keys modules? (Not that I know how depmod works...)
> 
> I don't think modprobe can or even should do any dependencies here.
> Consider the following cascading GPIO chips:
> 
>   /-------\                /---------\                 /--------\
> |         |               |         |                |          |
> |MCP23S17 + Pin1 <--> IRQ-+ PCA9555 + Pin 1 <--> IRQ + MCP23S17 +
> |         |               |         |                |          |
>   \-------/                 \-------/                  \--------/
> 
> Probing should still work for this scenario. This is something modprobe cannot
> fix.

What I can see from my boot log is that at module loading time log output 
from many drivers is mixed which makes me think that this parallel process
(udev) - and no I've not hit this issue..yet.

> 
>> If nothing else works, I guess marking mcp23s08 as bool
>> and building it into the kernel will work, right?
> 
> This would merely be a workaround and I guess there might be scenarios and/or
> random device probing where even this fails.
> 


-- 
regards,
-grygorii
