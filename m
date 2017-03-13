From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] tps6507x-ts: add DT bindings description
Date: Mon, 13 Mar 2017 19:45:24 +0530
Message-ID: <36b582dd-be14-8936-8dbb-304e2e97fc36@ti.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
 <1489069869-3849-4-git-send-email-yegorslists@googlemail.com>
 <CAL_Jsq+bvWVi=8-HjBZ+O5R6SRHL1NuQkA9ZAhFUZmt8VAf+Sw@mail.gmail.com>
 <CAGm1_kvdVFK9F_A3PrD8PLtrnno9pikg2RxENLqkPUe3vE_zkA@mail.gmail.com>
 <20170309175530.GC20077@dtor-ws>
 <edc8ab93-b2da-2567-eb41-ebf27cf5336f@ti.com>
 <20170310180018.GB21811@dtor-ws>
 <CAGm1_ktpq9e-xK3Uv1W3Zr2VZyV9Be2ftx6O22=CWRdJH07xWA@mail.gmail.com>
 <20170310200817.GA35542@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:52332 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdCMOPl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 10:15:41 -0400
In-Reply-To: <20170310200817.GA35542@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, Kevin Hilman <khilman@baylibre.com>

Hi Dmitry,

On Saturday 11 March 2017 01:38 AM, Dmitry Torokhov wrote:
> On Fri, Mar 10, 2017 at 08:54:51PM +0100, Yegor Yefremov wrote:
>> On Fri, Mar 10, 2017 at 7:00 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> On Fri, Mar 10, 2017 at 12:11:08PM +0530, Sekhar Nori wrote:
>>>> On Thursday 09 March 2017 11:25 PM, Dmitry Torokhov wrote:
>>>>> On Thu, Mar 09, 2017 at 04:18:40PM +0100, Yegor Yefremov wrote:
>>>>>> On Thu, Mar 9, 2017 at 3:49 PM, Rob Herring <robh@kernel.org> wrote:
>>>>>>> On Thu, Mar 9, 2017 at 8:31 AM,  <yegorslists@googlemail.com> wrote:
>>>>>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>>>>
>>>>>>> This needs to go to DT list.
>>>>>>
>>>>>> Will do.
>>>>>>
>>>>>>>>
>>>>>>>> Provide description for following properties:
>>>>>>>>
>>>>>>>> - ti,poll-period
>>>>>>>> - ti,min-pressure
>>>>>>>>
>>>>>>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>>>>>>> ---
>>>>>>>>  Documentation/devicetree/bindings/mfd/tps6507x.txt | 16 ++++++++++++++--
>>>>>>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
>>>>>>>> index 8fffa3c..8875662 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
>>>>>>>> +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
>>>>>>>> @@ -1,4 +1,8 @@
>>>>>>>> -TPS6507x Power Management Integrated Circuit
>>>>>>>> +TPS6507x Multifunctional Device.
>>>>>>>> +
>>>>>>>> +Features provided by TPS6507x:
>>>>>>>> +        1. Power Management Integrated Circuit.
>>>>>>>> +        2. Touch-Screen.
>>>>>>>>
>>>>>>>>  Required properties:
>>>>>>>>  - compatible: "ti,tps6507x"
>>>>>>>> @@ -30,6 +34,12 @@ Regulator Optional properties:
>>>>>>>>                         1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
>>>>>>>>    If this property is not defined, it defaults to 0 (not enabled).
>>>>>>>>
>>>>>>>> +Touchscreen Optional properties:
>>>>>>>> +- ti,poll-period: Time at which touch input is getting sampled in ms.
>>>>>>>> +                 Default value: 30 ms.
>>>>>>>
>>>>>>> Isn't there a standard property for this?
>>>>>>
>>>>>> Such a value will be already used in [1]. I've looked at [2], but it
>>>>>> doesn't have such a field.
>>>>>>
>>>>>> [1] Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>>>>>> [2] Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>>>>
>>>>> I think the bigger question (since we are adding this to DT I assume it
>>>>> is not longer "toy" driver) can we convert it to a proper
>>>>> interrupt-driven scheme? Polling for real shipping devices is not
>>>>> efficient, I do not think we should even try to allow this mode in DTS
>>>>> bindings (note that tsc2007 use is different: it allows to specify
>>>>> sampling interval once touch is detected).
>>>>
>>>> Unfortunately, the only current user of tps6507x in kernel (da850-evm)
>>>> does not have the touch interrupt connected to the processor. So if we
>>>> dont support polled mode in when using device-tree, da850-evm.dts wont
>>>> be able to use this driver.
>>>
>>> Do we care? Right now the driver is unusable for any practical
>>> application I think as it burns CPU cycles by constantly polling the
>>> touch controller.
>>>
>>> Yegor, your conversion to device tree: is it done because you have a
>>> real product using this?
>>
>> Yes. It is VS-860 device http://www.visionsystems.de/produkte/vs-860.html
>>
>> It even seems to have interrupt pin connected. So we have to support both modes.
> 
> Well, I'd rather supported interrupt only. Polling is a toy mode.

On my DA850 EVM, running

$ evtest /dev/input/event0  > /dev/null &

and monitoring cpu load using top while continuously touching the screen
takes the CPU to about 90% idle. This is against 98% idle with no touch.
This running on ARM9 at 300Mhz. The processor can do about 450Mhz.

So, while I agree polling mode is not ideal, its not completely useless
as well. It will help the EVM to move to DT completely. Also, this
should not affect any core infrastructure or even interrupt driven users
of this driver.

Please do reconsider the stance on interrupt-only DT mode.

Thanks,
Sekhar
