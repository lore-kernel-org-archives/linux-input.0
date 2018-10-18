From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
Date: Thu, 18 Oct 2018 10:51:44 +0200
Message-ID: <4a81a5d1-39c8-60f3-16be-559d43c0116a@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com>
 <20181017201522.GA26525@bogus>
 <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
 <1fb98946-a518-d7d7-3bec-8944be95b91c@redhat.com>
 <CAO-hwJKXBvuGLensAQv82SoPh-vrt9UFgoC3_XeTA78EHCOANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKXBvuGLensAQv82SoPh-vrt9UFgoC3_XeTA78EHCOANA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: robh@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 18-10-18 10:44, Benjamin Tissoires wrote:
> On Thu, Oct 18, 2018 at 10:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 18-10-18 10:10, Benjamin Tissoires wrote:
>>> On Wed, Oct 17, 2018 at 10:15 PM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
>>>>> Some new touchpads IC are connected through PS/2 and I2C. On some of these
>>>>> new IC, the I2C part doesn't have all of the information available.
>>>>> We need to be able to forward the touchpad parameters from PS/2 and
>>>>> thus, we need those new optional properties.
>>>>>
>>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
>>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
>>>>> index 797607460735..ace6bcb0b4eb 100644
>>>>> --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
>>>>> +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
>>>>> @@ -13,6 +13,14 @@ Optional properties:
>>>>>      pinctrl binding [1]).
>>>>>    - vcc-supply: a phandle for the regulator supplying 3.3V power.
>>>>>    - elan,trackpoint: touchpad can support a trackpoint (boolean)
>>>>> +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
>>>>
>>>>> +- elan,max_x: the maximum reported value on the X axis
>>>>> +- elan,max_y: the maximum reported value on the Y axis
>>>>> +- elan,min_x: the minimum reported value on the X axis
>>>>> +- elan,min_y: the minimum reported value on the Y axis
>>>>> +- elan,x_res: the resolution of the X axis (in units per mm)
>>>>> +- elan,y_res: the resolution of the Y axis (in units per mm)
>>>>> +- elan,width: max reported width of a blob
>>>>
>>>> Can't we use standard touchscreen properties here? (Yes, I get this is a
>>>> touchpad, not touchscreen).
>>>
>>> Hey Rob,
>>>
>>> Well, there is that (it's a touchpad driver) and we can't also really
>>> use the of_touchscreen.c implementation.
>>> If both concerns are not an issue, we can then move the [min/max/res]
>>> properties to the touchscreen ones.
>>>
>>> Regarding 'elan,width', this is something missing from the standard ts
>>> properties, and AFAICT, this controls the maximum reported
>>> width/height of a touch.
>>> I should probably rename them to max_width, max_height.
>>>
>>> Hans, do you think we should add such properties to of_touchscreen.c
>>> too? (the width/height ones)
>>
>> Are there touchscreens which report finger/touch width / height ? if so
>> then it probably does make sense.
> 
> Well, it's pretty common for hid-multitouch touchscreens to report
> such properties (it's a way to indicate the palm). Don't know about
> the touchscreens that rely on of_touchscreen though.

Now that you mention it I think some may also have some sort of
pressure/weight value, but at least for the ones I wrote I do not
think we do anything with it, since the actual meaning of the
field is somewhat vague. This is all IIRC.

>> Note that for historical reasons
>> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Looks like your sentence is not finished here :)

I actually deleted it, but not those 2 lines, what I had written there
was that for historical reasons it uses touchscreen-size-x rather then
max-x and that that might be a bit confusing vs max-width, but I could
not come up with something better then max-width, so I deleted my
rambling, but ended up not deleting all of it :)

>> Also the touchscreen bindings have: touchscreen-x-mm and touchscreen-y-mm
>> rather then res, which can then be used to calculate the resolution.
>>
> 
> yeah, that's fine, I would need to convert to mm, then go back to res.
> Extra effort, but that's the price to pay.

Ack.

Regards,

Hans
