From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] input: ti_am335x_tsc: Add open delay parameter
Date: Thu, 20 Aug 2015 17:41:30 +0530
Message-ID: <55D5C3F2.80900@ti.com>
References: <1439318705-18601-1-git-send-email-mwelling@ieee.org> <55CAE71C.4060505@ti.com> <20150812184420.GA2442@deathstar> <20150819180835.GB29773@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55137 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbHTMLl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 08:11:41 -0400
In-Reply-To: <20150819180835.GB29773@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "Griffis, Brad" <bgriffis@ti.com>



On 08/19/2015 11:38 PM, Michael Welling wrote:
> On Wed, Aug 12, 2015 at 01:44:22PM -0500, Michael Welling wrote:
>> On Wed, Aug 12, 2015 at 11:56:36AM +0530, Vignesh R wrote:
>>> Hi Michael,
>>>
>>> + Dmitry
>>>
>>> On 08/12/2015 12:15 AM, Michael Welling wrote:
>>>> Adds a device tree parameter to set the open delay on the touchscreen
>>>> conversion steps. Increasing this parameter helps the touch accuracy on
>>>> some screens.
>>>>
>>>> Signed-off-by: Michael Welling <mwelling@ieee.org>
>>>> ---
>>>>  .../bindings/input/touchscreen/ti-tsc-adc.txt          |  5 +++++
>>>>  drivers/input/touchscreen/ti_am335x_tsc.c              | 18 ++++++++++++++----
>>>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>>>> index b1163bf..cb11fda 100644
>>>> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>>>> @@ -41,6 +41,11 @@ Optional properties:
>>>>  			 charge step, so this does in fact function as a
>>>>  			 hardware knob for adjusting the amount of "settling
>>>>  			 time".
>>>> +	ti,open-delay: Open delay applied to all touchscreen conversion steps.
>>>> +			The value corresponds to the number of ADC clock
>>>> +			cycles to wait after applying the step configuration
>>>> +			registers and before sending the start of ADC
>>>> +			conversion. Maximum value is 0x3FFFF.
>>>>  
>>>
>>> Since open-delay is per step, is it not better to allow specifying
>>> open-delay per step like ti,chan-step-opendelay of adc? This will help
>>> control open-delay for all the four wires.
>>
>> Do you see any reason why you would want a different delay for each step of
>> the conversion on the same touchscreen?


Sorry for the delay,

I haven't seen different delays being used for different channels on
4-wire TSC ( not sure of 5-wire or 8 wire designs). Since this is DT
change, I just wanted to make sure more flexibility is provided.

>>
>> The user would need to know the number of steps what each of the steps do.
>>


What I was thinking was making open-delay configurable per channel (one
entry for X+, X-, Y+, Y-).

For example, for a 4-wire TSC:
ti,chan-open-delay = <0x30 0x100 0x20 0x10>; /* for X+, X-, Y+, Y- */


>>>
>>>>  - child "adc"
>>>>  	ti,chan-step-opendelay: List of open delays for each channel of
>>>> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
>>>> index 191a1b8..37a9729 100644
>>>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>>>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>>>> @@ -54,6 +54,7 @@ struct titsc {
>>>>  	u32			inp_xp, inp_xn, inp_yp, inp_yn;
>>>>  	u32			step_mask;
>>>>  	u32			charge_delay;
>>>> +	u32			open_delay;
>>>>  };
>>>>  
>>>>  static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
>>>> @@ -148,7 +149,7 @@ static void titsc_step_config(struct titsc *ts_dev)
>>>>  	end_step = first_step + tsc_steps;
>>>>  	for (i = end_step - ts_dev->coordinate_readouts; i < end_step; i++) {
>>>>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
>>>> -		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
>>>> +		titsc_writel(ts_dev, REG_STEPDELAY(i), ts_dev->open_delay);
>>>>  	}
>>>>  
>>>>  	config = 0;
>>>> @@ -172,7 +173,7 @@ static void titsc_step_config(struct titsc *ts_dev)
>>>>  	end_step = first_step + ts_dev->coordinate_readouts;
>>>>  	for (i = first_step; i < end_step; i++) {
>>>>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
>>>> -		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
>>>> +		titsc_writel(ts_dev, REG_STEPDELAY(i), ts_dev->open_delay);
>>>>  	}
>>>>  
>>>>  	/* Make CHARGECONFIG same as IDLECONFIG */
>>>> @@ -188,13 +189,13 @@ static void titsc_step_config(struct titsc *ts_dev)
>>>>  			STEPCONFIG_INP(ts_dev->inp_xp);
>>>>  	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
>>>>  	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
>>>> -			STEPCONFIG_OPENDLY);
>>>> +			ts_dev->open_delay);
>>>>  
>>>>  	end_step++;
>>>>  	config |= STEPCONFIG_INP(ts_dev->inp_yn);
>>>>  	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
>>>>  	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
>>>> -			STEPCONFIG_OPENDLY);
>>>> +			ts_dev->open_delay);
>>>>  
>>>>  	/* The steps end ... end - readouts * 2 + 2 and bit 0 for TS_Charge */
>>>>  	stepenable = 1;
>>>> @@ -392,6 +393,15 @@ static int titsc_parse_dt(struct platform_device *pdev,
>>>>  		dev_warn(&pdev->dev, "ti,charge-delay not specified\n");
>>>>  	}
>>>>  
>>>> +	err = of_property_read_u32(node, "ti,open-delay",
>>>> +				   &ts_dev->open_delay);
>>>> +	/*
>>>> +	 * If ti,open-delay value is not specified, then use
>>>> +	 * STEPCONFIG_OPENDLY as the default value.
>>>> +	 */
>>>> +	if (err < 0)
>>>> +		ts_dev->open_delay = STEPCONFIG_OPENDLY;
>>>> +
>>>>  	return of_property_read_u32_array(node, "ti,wire-config",
>>>>  			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
>>>>  }
>>>>
>>>
>>> -- 
>>> Regards
>>> Vignesh

-- 
Regards
Vignesh
