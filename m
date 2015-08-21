From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] input: ti_am335x_tsc: Add open delay parameter
Date: Fri, 21 Aug 2015 17:41:41 +0530
Message-ID: <55D7157D.4080800@ti.com>
References: <1439318705-18601-1-git-send-email-mwelling@ieee.org> <55CAE71C.4060505@ti.com> <20150812184420.GA2442@deathstar> <20150819180835.GB29773@deathstar> <55D5C3F2.80900@ti.com> <20150820221740.GA28249@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52634 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbbHUMLv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 08:11:51 -0400
In-Reply-To: <20150820221740.GA28249@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "Griffis, Brad" <bgriffis@ti.com>



On 08/21/2015 03:47 AM, Michael Welling wrote:
> On Thu, Aug 20, 2015 at 05:41:30PM +0530, Vignesh R wrote:
>>
>>
>> On 08/19/2015 11:38 PM, Michael Welling wrote:
>>> On Wed, Aug 12, 2015 at 01:44:22PM -0500, Michael Welling wrote:
>>>> On Wed, Aug 12, 2015 at 11:56:36AM +0530, Vignesh R wrote:
>>>>> Hi Michael,
>>>>>
>>>>> + Dmitry
>>>>>
>>>>> On 08/12/2015 12:15 AM, Michael Welling wrote:
>>>>>> Adds a device tree parameter to set the open delay on the touchscreen
>>>>>> conversion steps. Increasing this parameter helps the touch accuracy on
>>>>>> some screens.
>>>>>>
>>>>>> Signed-off-by: Michael Welling <mwelling@ieee.org>
>>>>>> ---
>>>>>>  .../bindings/input/touchscreen/ti-tsc-adc.txt          |  5 +++++
>>>>>>  drivers/input/touchscreen/ti_am335x_tsc.c              | 18 ++++++++++++++----
>>>>>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>>>>>> index b1163bf..cb11fda 100644
>>>>>> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>>>>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>>>>>> @@ -41,6 +41,11 @@ Optional properties:
>>>>>>  			 charge step, so this does in fact function as a
>>>>>>  			 hardware knob for adjusting the amount of "settling
>>>>>>  			 time".
>>>>>> +	ti,open-delay: Open delay applied to all touchscreen conversion steps.
>>>>>> +			The value corresponds to the number of ADC clock
>>>>>> +			cycles to wait after applying the step configuration
>>>>>> +			registers and before sending the start of ADC
>>>>>> +			conversion. Maximum value is 0x3FFFF.
>>>>>>  
>>>>>
>>>>> Since open-delay is per step, is it not better to allow specifying
>>>>> open-delay per step like ti,chan-step-opendelay of adc? This will help
>>>>> control open-delay for all the four wires.
>>>>
>>>> Do you see any reason why you would want a different delay for each step of
>>>> the conversion on the same touchscreen?
>>
>>
>> Sorry for the delay,
>>
>> I haven't seen different delays being used for different channels on
>> 4-wire TSC ( not sure of 5-wire or 8 wire designs). Since this is DT
>> change, I just wanted to make sure more flexibility is provided.
>>
>>>>
>>>> The user would need to know the number of steps what each of the steps do.
>>>>
>>
>>
>> What I was thinking was making open-delay configurable per channel (one
>> entry for X+, X-, Y+, Y-).
>>
>> For example, for a 4-wire TSC:
>> ti,chan-open-delay = <0x30 0x100 0x20 0x10>; /* for X+, X-, Y+, Y- */
>>
> 
> What about the readings for the pressure?

Sorry, I was confused with channels and co-ordinate readouts.

Each of X, Y and pressure(Z) readouts will correspond to certain tscadc
steps. So, what I have in mind is:

ti,open-delay = <0x30 0x100 0x20>; /* for X, Y, Z */

For Steps that represents X co-ordinate readouts set opendelay = 0x30.
For Steps that correspond to Y co-ordinate readouts set opendelay =
0x100 and similarly for 0x20 for Z.

This is will provide flexibility to configure open-delay independently
for X, Y and Z


-- 
Regards
Vignesh
