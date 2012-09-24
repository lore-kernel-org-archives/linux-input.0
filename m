From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Mon, 24 Sep 2012 18:22:33 +0200
Message-ID: <506088C9.8030002@metafoo.de>
References: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de> <5060584A.80305@gmail.com> <20120924155639.GA1440@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-052.synserver.de ([212.40.185.52]:1059 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab2IXQVr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 12:21:47 -0400
In-Reply-To: <20120924155639.GA1440@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de

On 09/24/2012 05:56 PM, Dmitry Torokhov wrote:
> On Mon, Sep 24, 2012 at 07:55:38AM -0500, Rob Herring wrote:
>> On 09/24/2012 02:37 AM, Sascha Hauer wrote:
>>> A very simple binding, the only property is the phandle to the PWM.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>
>>> ---
>>>  Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 +++++++
>>>  drivers/input/misc/pwm-beeper.c                        |   11 ++++++++++-
>>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>> new file mode 100644
>>> index 0000000..7388b82
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>> @@ -0,0 +1,7 @@
>>> +* PWM beeper device tree bindings
>>> +
>>> +Registers a PWM device as beeper.
>>> +
>>> +Required properties:
>>> +- compatible: should be "pwm-beeper"
>>> +- pwms: phandle to the physical pwm device
>>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>>> index fc84c8a..a6aa48c 100644
>>> --- a/drivers/input/misc/pwm-beeper.c
>>> +++ b/drivers/input/misc/pwm-beeper.c
>>> @@ -75,7 +75,10 @@ static int __devinit pwm_beeper_probe(struct platform_device *pdev)
>>>  	if (!beeper)
>>>  		return -ENOMEM;
>>>  
>>> -	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
>>> +	if (pdev->dev.platform_data)
>>> +		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
>>> +	else
>>> +		beeper->pwm = pwm_get(&pdev->dev, NULL);
> 
> Hmm, pwm_id == 0 is a valid ID I think, but your change makes it go into
> DT branch, potentially breaking it.

Yes, this a bit tricky, but we only have a single in-tree user of the
pwm-beeper which uses a id != 0. And now that all the PWM providers have
been converted to the new generic PWM framework the old legacy API will go
away soon anyway. So this if () else branch should hopefully only be
necessary for a transitional period of 1-2 releases. So I think this change
should be OK.

But I think the patch is missing a change to the Kconfig entry to allow the
driver to be selected if the generic PWM framework is available.

--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -444,7 +444,7 @@ config INPUT_PCF8574

 config INPUT_PWM_BEEPER
 	tristate "PWM beeper support"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM
 	help
 	  Say Y here to get support for PWM based beeper devices.


- Lars

