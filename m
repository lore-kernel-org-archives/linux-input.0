From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] Input: Add new driver for GPIO beeper
Date: Tue, 12 Nov 2013 12:23:46 -0700
Message-ID: <52828042.4050501@wwwdotorg.org>
References: <1384250833-4600-1-git-send-email-shc_work@mail.ru> <20131112101544.GD2976@e106331-lin.cambridge.arm.com> <1384253277.731839001@f27.i.mail.ru> <20131112105930.GE2976@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55977 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab3KLTX4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 14:23:56 -0500
In-Reply-To: <20131112105930.GE2976@e106331-lin.cambridge.arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

On 11/12/2013 03:59 AM, Mark Rutland wrote:
> On Tue, Nov 12, 2013 at 10:47:57AM +0000, Alexander Shiyan wrote:
>> Hello.
>>
>>> On Tue, Nov 12, 2013 at 10:07:13AM +0000, Alexander Shiyan wrote:
>>>> This patch adds a new driver for the beeper controlled via GPIO pin.
>>>> The driver does not depend on the architecture and is positioned as
>>>> a replacement for the specific drivers that are used for this function.
>>>>
>>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> ...
>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-beeper.txt b/Documentation/devicetree/bindings/input/gpio-beeper.txt
>> ...
>>>> +Example:
>>>> +
>>>> +beeper: input@0 {
>>>> +	compatible = "gpio-beeper";
>>>> +	reg = <0>;
>>>> +	gpios = <&gpio3 23 0>;
>>>> +};
>>>
>>> What are the reg / unit-address for?
>>
>> Just an example from "simple-bus" container.
> 
> If they have no meaning, they should go. They're unnecessary and make
> things more confusing.
> 
> I'd expect the example to be:
> 
> beeper: beeper {
> 	compatible = "gpio-beeper";
> 	gpios - <&gpio3 23 0>;
> };
> 
> And if we have multiple beepers, something like:
> 
> beeper0: beeper0 { ... };
> beeper1: beeper1 { ... };

DT node names aren't meant to encode identity though. What we've done in
the past for nodes without a reg where multiple instances were desired
is to put them into simple-bus and add a reg, so:

beeper0: beeper@0 { reg = <0>; ... };
beeper1: beeper@1 { reg = <1>; ... };

Of course, if there's only one of them, then it could just be "beeper"
with no reg. The binding and example should probably reflect that simple
case.
