From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCHv4 1/3] Input: twl4030-pwrbutton - add device tree support
Date: Thu, 24 Oct 2013 11:16:22 +0200
Message-ID: <5268E566.2060309@epfl.ch>
References: <1382550852-11508-1-git-send-email-sre@debian.org> <1382550852-11508-2-git-send-email-sre@debian.org> <5268D095.3060302@epfl.ch> <20131024083837.GA28938@earth.universe>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:46777 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab3JXJQ0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 05:16:26 -0400
In-Reply-To: <20131024083837.GA28938@earth.universe>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hello,

On 10/24/2013 10:38 AM, Sebastian Reichel wrote:
> Hi Florian,
>
> On Thu, Oct 24, 2013 at 09:47:33AM +0200, Florian Vaussard wrote:
>>> +Required SoC Specific Properties:
>>> +- compatible: should be one of the following
>>> +   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
>>> +- interrupt: should be one of the following
>>> +   - <8>: For controllers compatible with twl4030
>>
>> This is <8> for your particular case, but it will depend on your
>> SoC, won't it?  Moreover, this property will be most likely
>> inherited from the root twl node, so I do not see the need to
>> document it here. See:
>>
>> Documentation/devicetree/bindings/mfd/twl-familly.txt
>
> No. This is an internal twl4030 interrupt. TWL4030 functions
> itself as an interrupt controller.
>

So if it does not belong to the TWL parent, where is it used in your code?
You should be parsing this property, so you can set up the IRQ properly.
I am a bit confused here. If it is fixed, no need for a OF property.

>>> +
>>> +Example:
>>> +	twl_pwrbutton: pwrbutton {
>>> +		compatible = "ti,twl4030-pwrbutton";
>>> +		interrupts = <8>;
>>> +	};
>>
>> You are missing the root twl node here, no?
>
> So should I document it like this?
>

IMHO it is more clear for the user.

> twl4030 {
>     compatible = "ti,twl4030";
>
>     pwrbutton {
>         compatible = "ti,twl4030-pwrbutton";
>         interrupts = <8>;
>     };
> };

Nit, but existing documentations follow the "name@address"
form for the root node, as the TWL is on an I2C bus.
Either it is already defined, thus you should use "&twl4030"
to reference it, or you create the TWL node and something like
"twl4030@48" should be used.

For an example, you can refer to existing bindings, like
Documentation/devicetree/bindings/mfd/twl4030-audio.txt.

Best regards,

Florian
