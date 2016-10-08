From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
Date: Fri, 7 Oct 2016 17:22:09 -0700
Message-ID: <84f51754-cbd4-7a85-6ab6-83e1f47fd936@roeck-us.net>
References: <6ED8E3B22081A4459DAC7699F3695FB7018CCE242C@SW-EX-MBX02.diasemi.com>
 <20161006184927.GB11915@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE2732@SW-EX-MBX02.diasemi.com>
 <20161007170214.GA21349@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE282C@SW-EX-MBX02.diasemi.com>
 <20161007233554.GA21386@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42581 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbcJHAWP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 20:22:15 -0400
In-Reply-To: <20161007233554.GA21386@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Lee Jones <lee.jones@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>

On 10/07/2016 04:35 PM, Dmitry Torokhov wrote:
> On Fri, Oct 07, 2016 at 06:01:23PM +0000, Steve Twiss wrote:
>> On 07 October 2016 18:02, Guenter Roeck wrote:
>>
>>>> On 06 October 2016 19:49, Guenter Roeck wrote:
>>>>> On Thu, Oct 06, 2016 at 04:28:14PM +0000, Steve Twiss wrote:
>>>>>> I am using the compatible string to pick a different configuration .data block:
>>>>>> { .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
>>>>>> { .compatible = "dlg,da9061-watchdog", .data = &da9061_watchdog_info },
>>>>>>
>>>>>> But, it is just my opinion to keep the "name" different.
>>>>>> This will not be my decision if accepted into the Linux kernel, but I would like to
>>>>>> at least be consistent for DA9061 and DA9062 so ... is this an issue?
>>>>>
>>>>> FWIW the driver doesn't really need to be updated in the first place.
>>>>> A compatible statement listing both da9061 and da9062 would do it.
>>>>
>>>> I will make the changes you requested: deprecate the existing compatibility
>>>> for da9062-watchdog and make a new compatibility string which combines both
>>>> da9061 and da9062.
>>>>
>>> That is not what I asked for.
>>
>> Ok. Did you mean separate compatible statements with data sections pointing at
>> the same structure?
>>
>> Like this:
>> { .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
>> { .compatible = "dlg,da9061-watchdog", .data = &da9062_watchdog_info },
>>
>> So this would be the only change needed in the device driver.
>
> If there is no change in IP block then I do not see why we need to
> introduce new names at all. The dts can specify fallback compatible
> stting. Note, it is called *compatible* not "model" or "device id" or
> whatever. So you can just say in DTS:
>
> 	compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
>
> and leave the driver alone. That goes for input part as well. You only
> need to add new compatible to the driver when it in fact is
> *incompatible* with the existing blocks.
>
Yes, exactly.

Thanks,
Guenter

