From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] input: pwm-beeper: add documentation for volume
 devicetree bindings
Date: Tue, 11 Oct 2016 08:39:57 -0500
Message-ID: <CAL_JsqLGY+6eWb4dN-TMmt+PJSK6zm6gPgO3SCPa4esSpTzW8w@mail.gmail.com>
References: <fe6349a5-7935-5be7-6dc1-7e80fa9dceeb@exceet.de>
 <1475831223-6006-1-git-send-email-frieder.schrempf@exceet.de>
 <1475831223-6006-3-git-send-email-frieder.schrempf@exceet.de>
 <20161010152055.GA6868@rob-hp-laptop> <24e35d49-7c3d-b094-f0b7-96367389f249@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753623AbcJKNkX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Oct 2016 09:40:23 -0400
In-Reply-To: <24e35d49-7c3d-b094-f0b7-96367389f249@exceet.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@exceet.de>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "luis@debethencourt.com" <luis@debethencourt.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Oct 11, 2016 at 3:17 AM, Schrempf Frieder
<frieder.schrempf@exceet.de> wrote:
> On 10.10.2016 17:20, Rob Herring wrote:
>> On Fri, Oct 07, 2016 at 09:08:17AM +0000, Schrempf Frieder wrote:
>>> This patch adds the documentation for the devicetree bindings to set
>>> the volume levels.
>>>
>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>>> ---
>>> Changes in v2:
>>>  - split into 3 separate patches
>>>  - make volume properties optional
>>>
>>>  .../devicetree/bindings/input/pwm-beeper.txt       | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>> index be332ae..6d8ba4e 100644
>>> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>>> @@ -5,3 +5,25 @@ Registers a PWM device as beeper.
>>>  Required properties:
>>>  - compatible: should be "pwm-beeper"
>>>  - pwms: phandle to the physical PWM device
>>> +
>>> +Optional properties:
>>> +- volume-levels: Array of distinct volume levels. These need to be in the
>>> +      range of 0 to 500, while 0 means 0% duty cycle (mute) and 500 means
>>> +      50% duty cycle (max volume).
>>> +      Please note that the actual volume of most beepers is highly
>>> +      non-linear, which means that low volume levels are probably somewhere
>>> +      in the range of 1 to 30 (0.1-3% duty cycle).
>>
>> What does the index correspond to? The linear volume?
>
> In most cases users probably need linear volume levels (e.g. 0%, 25%,
> 50%, 75%, 100%) and in this case the index would indeed correspond to
> the linear perceived volume.
>
> But also non-linear relations are possible (e.g. 0%, 20%, 100%), if the
> user needs for example "mute", "low", "high" as volume levels.

Exclude off/mute and this is still linear. Also, the user exposed
levels could be a subset of the defined h/w levels. That should be
independent of DT.

> The linearization (defining the corresponding duty cycle for each index)
> depends on the beeper and the perception of the user.

This has to be a consistent interface across h/w to have a userspace
that can work across h/w. For that, you have to define the binding as
linear. Of course, it's all measured by perception and not completely
accurate which is fine.

> For the example array definition below, I tried different duty cycles
> and found values of 0.8%, 2%, 4%, 50% to be approximately correspondent
> to perceived volume levels of 25%, 50%, 75%, 100% in my case.
>
>>
>>> +- default-volume-level: the default volume level (index into the
>>> +      array defined by the "volume-levels" property)
>>> +
>>> +The volume level can be set via sysfs under /sys/class/input/inputX/volume.
>>> +The maximum volume level index can be read from /sys/class/input/inputX/max_volume_level.

Also, drop this. Not relevant to the binding.

Rob
