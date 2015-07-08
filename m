From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/3] Input: of_touchscreen - fix setting max values on
 X/Y axis
Date: Wed, 8 Jul 2015 10:59:04 +0300
Message-ID: <559CD848.1050707@ti.com>
References: <1436228849-29530-1-git-send-email-dmitry.torokhov@gmail.com> <1436228849-29530-2-git-send-email-dmitry.torokhov@gmail.com> <559B9DDB.6080606@ti.com> <20150707162535.GA12491@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150707162535.GA12491@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry,

On 07/07/15 19:25, Dmitry Torokhov wrote:
> Hi Roger,
>
> On Tue, Jul 07, 2015 at 12:37:31PM +0300, Roger Quadros wrote:
>> Hi Dmitry,
>>
>> On 07/07/15 03:27, Dmitry Torokhov wrote:
>>> The binding specification says that "touchscreen-size-x" and "-y" specify
>>> horizontal and vertical resolution of the touchscreen and therefore maximum
>>> absolute coordinates should be reduced by 1 since we are starting with 0.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> ---
>>>   drivers/input/touchscreen/of_touchscreen.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
>>> index 759cf4b..50bc0f2 100644
>>> --- a/drivers/input/touchscreen/of_touchscreen.c
>>> +++ b/drivers/input/touchscreen/of_touchscreen.c
>>> @@ -71,23 +71,25 @@ void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch)
>>>
>>>   	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
>>>   	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-x",
>>> -						input_abs_get_max(dev, axis),
>>> +						input_abs_get_max(dev,
>>> +								  axis) + 1,
>>
>> Why do we need to pass default_value to touchscreen_get_prop_u32()?
>> If the property doesn't exist we are not updating the parameter
>> anyway right?
>
> The binding can specify max, fuzz, both, or neither. If only one is
> specified we do not want to "undo" whatever the driver did (for example

why not? At least that is not what touchscreen_parse_properties() does.
It will update the touchscreen params if any one of the DT property is 
present.

> tsc2005 sets up the default maximums before trying to parse OF), so we
> fetch the current value and pass it on as default one.

This is what would happen in tsc2005 case

-driver first sets ABS_X_max to 0xfff and ABS_Y_max to 0xfff.
-calls touchscreen_parse_properties()
-which calls touchscreen_get_prop_u32(dev, "touchscreen-size-x", 
0xfff+1, &maximum)
-if DT properties are missing, touchscreen_get_prop_u32() changes
ABS_X_max to 0x1000 and returns false.
- as data_present is false we don't do a -1 and so we have ABS_X_max 
changed to 0x1000.

This doesn't look right.

So IMO default_value parameter can be removed from 
touchscreen_get_prop_u32() to make things simpler.

If the property doesn't exist it will not change *value and return false.

cheers,
-roger
-
>
>>
>>>   						&maximum) |
>>>   		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-x",
>>>   						input_abs_get_fuzz(dev, axis),
>>>   						&fuzz);
>>>   	if (data_present)
>>> -		touchscreen_set_params(dev, axis, maximum, fuzz);
>>> +		touchscreen_set_params(dev, axis, maximum - 1, fuzz);
>>>
>>>   	axis = multitouch ? ABS_MT_POSITION_Y : ABS_Y;
>>>   	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-y",
>>> -						input_abs_get_max(dev, axis),
>>> +						input_abs_get_max(dev,
>>> +								  axis) + 1,
>>>   						&maximum) |
>>>   		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-y",
>>>   						input_abs_get_fuzz(dev, axis),
>>>   						&fuzz);
>>>   	if (data_present)
>>> -		touchscreen_set_params(dev, axis, maximum, fuzz);
>>> +		touchscreen_set_params(dev, axis, maximum - 1, fuzz);
>>>
>>>   	axis = multitouch ? ABS_MT_PRESSURE : ABS_PRESSURE;
>>>   	data_present = touchscreen_get_prop_u32(np, "touchscreen-max-pressure",
>>>
>>
>
> Thanks.
>
