From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Mon, 24 Sep 2012 21:05:59 +0200
Message-ID: <5060AF17.7070409@metafoo.de>
References: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de> <5060584A.80305@gmail.com> <20120924155639.GA1440@core.coreip.homeip.net> <506088C9.8030002@metafoo.de> <20120924184938.GQ1322@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:63578 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757699Ab2IXTGH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 15:06:07 -0400
In-Reply-To: <20120924184938.GQ1322@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robherring2@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de, Thierry Reding <thierry.reding@avionic-design.de>

On 09/24/2012 08:49 PM, Sascha Hauer wrote:
> On Mon, Sep 24, 2012 at 06:22:33PM +0200, Lars-Peter Clausen wrote:
>> On 09/24/2012 05:56 PM, Dmitry Torokhov wrote:
>>> On Mon, Sep 24, 2012 at 07:55:38AM -0500, Rob Herring wrote:
>>>> On 09/24/2012 02:37 AM, Sascha Hauer wrote:
>>>>> A very simple binding, the only property is the phandle to the PWM.
>>>>>
>>>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>>>
>>>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 +++++++
>>>>>  drivers/input/misc/pwm-beeper.c                        |   11 ++++++++++-
>>>>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>>>> new file mode 100644
>>>>> index 0000000..7388b82
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>>>> @@ -0,0 +1,7 @@
>>>>> +* PWM beeper device tree bindings
>>>>> +
>>>>> +Registers a PWM device as beeper.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: should be "pwm-beeper"
>>>>> +- pwms: phandle to the physical pwm device
>>>>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>>>>> index fc84c8a..a6aa48c 100644
>>>>> --- a/drivers/input/misc/pwm-beeper.c
>>>>> +++ b/drivers/input/misc/pwm-beeper.c
>>>>> @@ -75,7 +75,10 @@ static int __devinit pwm_beeper_probe(struct platform_device *pdev)
>>>>>  	if (!beeper)
>>>>>  		return -ENOMEM;
>>>>>  
>>>>> -	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
>>>>> +	if (pdev->dev.platform_data)
>>>>> +		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
>>>>> +	else
>>>>> +		beeper->pwm = pwm_get(&pdev->dev, NULL);
>>>
>>> Hmm, pwm_id == 0 is a valid ID I think, but your change makes it go into
>>> DT branch, potentially breaking it.
> 
> My bad, I missed that platform_data is casted to an unsigned long. I
> thought I would test for a pointer.
> The obvious clean way would be to use a pointer for platform_data, but
> given that this will vanish anyway soon, I think we could just test for
> existence of dev->of_node instead of dev->platform_data.

I think the plan is to convert the existing board file platforms to pwm_table
and then remove the old pwm_request API. So this wouldn't work too well if we'd
test for of_node. Maybe we can just run pwm_get unconditionally and fallback to
pwm_request if it failed. That's also what the PWM backlight driver currently does.

> 
>>
>> Yes, this a bit tricky, but we only have a single in-tree user of the
>> pwm-beeper which uses a id != 0. And now that all the PWM providers have
>> been converted to the new generic PWM framework the old legacy API will go
>> away soon anyway. So this if () else branch should hopefully only be
>> necessary for a transitional period of 1-2 releases. So I think this change
>> should be OK.
>>
>> But I think the patch is missing a change to the Kconfig entry to allow the
>> driver to be selected if the generic PWM framework is available.
>>
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -444,7 +444,7 @@ config INPUT_PCF8574
>>
>>  config INPUT_PWM_BEEPER
>>  	tristate "PWM beeper support"
>> -	depends on HAVE_PWM
>> +	depends on HAVE_PWM || PWM
> 
> Is this the preferred way to do this? Instead of doing the above I added
> a 'select HAVE_PWM' to the pwm framework instead. I found a patch for that,
> but there were comments to it that this is not good
> 

Thierry said that this is his preferred solution. Given that HAVE_PWM will be
extinct soon anyway I think it is fine.

- Lars


