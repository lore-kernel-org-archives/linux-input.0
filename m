From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v3 1/2] dt: add cap11xx LED documentation
Date: Mon, 15 Jun 2015 10:00:49 -0700
Message-ID: <CAKzfze84_PaPVcfFbbwMqK3pV+qm7vyiO4RM4Bff=z_0rwh+fw@mail.gmail.com>
References: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
	<1434169054-11035-2-git-send-email-mranostay@gmail.com>
	<557E8990.5060702@samsung.com>
	<CAKzfze9Ji73youadk9zzqahN6E4VCJUXOgzmP4wnoynrQSwRMQ@mail.gmail.com>
	<557EA499.2020701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34712 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbFORAu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 13:00:50 -0400
In-Reply-To: <557EA499.2020701@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jun 15, 2015 at 3:10 AM, Jacek Anaszewski
<j.anaszewski@samsung.com> wrote:
> On 06/15/2015 10:48 AM, Matt Ranostay wrote:
>>
>> On Mon, Jun 15, 2015 at 1:15 AM, Jacek Anaszewski
>> <j.anaszewski@samsung.com> wrote:
>>>
>>> Hi Matt,
>>>
>>> On 06/13/2015 06:17 AM, Matt Ranostay wrote:
>>>>
>>>>
>>>> Some cap11xx devices have LEDs that can be controlled from userpace
>>>> and via triggers. Document their use and functionality here.
>>>>
>>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>>> ---
>>>>    .../devicetree/bindings/input/cap11xx.txt          | 23
>>>> ++++++++++++++++++++++
>>>>    1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt
>>>> b/Documentation/devicetree/bindings/input/cap11xx.txt
>>>> index 7d0a300..ef89c27 100644
>>>> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
>>>> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
>>>> @@ -38,6 +38,11 @@ Optional properties:
>>>>                                  defaults. The array must have exactly
>>>> six
>>>>                                  entries.
>>>>
>>>> +       linux,led-brightness:   Defines the ON brightness when the
>>>> optional LED
>>>> +                               functionality is used. Valid values are
>>>> 0-15.
>>>> +                               By default a value of 15 is set.
>>>
>>>
>>>
>>> The ON brightness is controlled with the 'brightness' sysfs property.
>>> The levels start from 1 and 0 turns the LED off. I think that this
>>> property is useless then.
>>>
>>
>> Yes but this defines the brightness for the ON state.. since it can be
>> from 0-100% duty cycle.
>
>
> Doesn't 0 mean that LED is off? If so, then valid values should start
> from 1.
>
Ok makes sense since a 0% duty cycle is useless :)

>
>>>
>>>> +
>>>>    Example:
>>>>
>>>>    i2c_controller {
>>>> @@ -55,5 +60,23 @@ i2c_controller {
>>>>                                   <105>,         /* KEY_LEFT */
>>>>                                   <109>,         /* KEY_PAGEDOWN */
>>>>                                   <104>;         /* KEY_PAGEUP */
>>>> +
>>>> +               linux,led-brightness = <15>;
>>>> +
>>>> +               usr@0 {
>>>> +                       label = "cap11xx:green:usr0";
>>>> +                       reg = <0>;
>>>> +               };
>>>> +
>>>> +               usr@1 {
>>>> +                       label = "cap11xx:green:usr1";
>>>> +                       reg = <1>;
>>>> +               };
>>>> +
>>>> +               alive@2 {
>>>> +                       label = "cap11xx:green:alive";
>>>> +                       reg = <2>;
>>>> +                       linux,default_trigger = "heartbeat";
>>>> +               };
>>>>          };
>>>>    }
>>>>
>>>
>>> --
>>> Best Regards,
>>> Jacek Anaszewski
>>
>>
>
>
> --
> Best Regards,
> Jacek Anaszewski
