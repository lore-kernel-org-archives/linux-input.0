From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/4] devicetree: bindings: Add header file with evdev type
 and abs/rel code defines
Date: Thu, 10 Sep 2015 20:50:10 +0200
Message-ID: <55F1D0E2.6010805@redhat.com>
References: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
 <1441789886-5868-2-git-send-email-hdegoede@redhat.com>
 <55F1BCFA.5010404@kernel.org>
 <CAKdAkRRFcn5+SXNfU4J+v4tcFyA1mZR1hMhT2y3QJeQJ1tTDYQ@mail.gmail.com>
 <55F1CE8B.5050302@redhat.com>
 <CAKdAkRSpsze_EjaQ3Rre_wjN7dWJ3XNvkt9S=CMktEsNXGYg_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbbIJSuN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 14:50:13 -0400
In-Reply-To: <CAKdAkRSpsze_EjaQ3Rre_wjN7dWJ3XNvkt9S=CMktEsNXGYg_w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

Hi,

On 10-09-15 20:42, Dmitry Torokhov wrote:
> On Thu, Sep 10, 2015 at 11:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 10-09-15 20:34, Dmitry Torokhov wrote:
>>>
>>> On Thu, Sep 10, 2015 at 10:25 AM, Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On 09/09/2015 04:11 AM, Hans de Goede wrote:
>>>>>
>>>>> This header provides evdev constants for linux,code, and linux,input-*
>>>>> properties.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>    include/dt-bindings/input/evdev.h | 76
>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>
>>>>
>>>> This looks fine, but please just add to input/input.h.
>>>>
>>>> Rob
>>>>
>>>>>    1 file changed, 76 insertions(+)
>>>>>    create mode 100644 include/dt-bindings/input/evdev.h
>>>>>
>>>>> diff --git a/include/dt-bindings/input/evdev.h
>>>>> b/include/dt-bindings/input/evdev.h
>>>>> new file mode 100644
>>>>> index 0000000..c1f7e0d
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/input/evdev.h
>>>>> @@ -0,0 +1,76 @@
>>>>> +/*
>>>>> + * This header provides evdev constants for linux,code, and
>>>>> linux,input-*
>>>>> + * properties.
>>>>> + */
>>>>> +
>>>>> +#ifndef _DT_BINDINGS_INPUT_LINUX_H
>>>>> +#define _DT_BINDINGS_INPUT_LINUX_H
>>>>> +
>>>>> +/*
>>>>> + * Event types
>>>>> + */
>>>>> +
>>>>> +#define EV_SYN                       0x00
>>>>> +#define EV_KEY                       0x01
>>>>> +#define EV_REL                       0x02
>>>>> +#define EV_ABS                       0x03
>>>>> +#define EV_MSC                       0x04
>>>>> +#define EV_SW                        0x05
>>>>> +#define EV_LED                       0x11
>>>>> +#define EV_SND                       0x12
>>>>> +#define EV_REP                       0x14
>>>>> +#define EV_FF                        0x15
>>>>> +#define EV_PWR                       0x16
>>>>> +#define EV_FF_STATUS         0x17
>>>>> +#define EV_MAX                       0x1f
>>>>> +
>>>>> +/*
>>>>> + * Relative axes
>>>>> + */
>>>>> +
>>>>> +#define REL_X                        0x00
>>>>> +#define REL_Y                        0x01
>>>>> +#define REL_Z                        0x02
>>>>> +#define REL_RX                       0x03
>>>>> +#define REL_RY                       0x04
>>>>> +#define REL_RZ                       0x05
>>>>> +#define REL_HWHEEL           0x06
>>>>> +#define REL_DIAL             0x07
>>>>> +#define REL_WHEEL            0x08
>>>>> +#define REL_MISC             0x09
>>>>> +#define REL_MAX                      0x0f
>>>>> +
>>>>> +/*
>>>>> + * Absolute axes
>>>>> + */
>>>>> +
>>>>> +#define ABS_X                        0x00
>>>>> +#define ABS_Y                        0x01
>>>>> +#define ABS_Z                        0x02
>>>>> +#define ABS_RX                       0x03
>>>>> +#define ABS_RY                       0x04
>>>>> +#define ABS_RZ                       0x05
>>>>> +#define ABS_THROTTLE         0x06
>>>>> +#define ABS_RUDDER           0x07
>>>>> +#define ABS_WHEEL            0x08
>>>>> +#define ABS_GAS                      0x09
>>>>> +#define ABS_BRAKE            0x0a
>>>>> +#define ABS_HAT0X            0x10
>>>>> +#define ABS_HAT0Y            0x11
>>>>> +#define ABS_HAT1X            0x12
>>>>> +#define ABS_HAT1Y            0x13
>>>>> +#define ABS_HAT2X            0x14
>>>>> +#define ABS_HAT2Y            0x15
>>>>> +#define ABS_HAT3X            0x16
>>>>> +#define ABS_HAT3Y            0x17
>>>>> +#define ABS_PRESSURE         0x18
>>>>> +#define ABS_DISTANCE         0x19
>>>>> +#define ABS_TILT_X           0x1a
>>>>> +#define ABS_TILT_Y           0x1b
>>>>> +#define ABS_TOOL_WIDTH               0x1c
>>>>> +
>>>>> +#define ABS_VOLUME           0x20
>>>>> +
>>>>> +#define ABS_MISC             0x28
>>>>> +
>>>>> +#endif /* _DT_BINDINGS_INPUT_LINUX_H */
>>>>>
>>>>
>>>
>>> Actually I'd rather we removed include/dt-bindings/input/input.h and
>>> instead used the header file from uapi. As it is now we already
>>> duplicating definitions and the copy in dt-bindings is missing several
>>> key codes. Until we split DT bindings form the kernel code I'd rather
>>> have definitions in one place.
>>
>>
>> AFAIK we cannot do that as the uapi header also contains things like:
>>
>> struct input_event {
>>          struct timeval time;
>>          __u16 type;
>>          __u16 code;
>>          __s32 value;
>> };
>>
>> Which is not valid device tree syntax.
>>
>> If you want this we need to split the uapi headers in one with only
>> defines and one with all the rest.
>
> That would be fine by me. event-codes.h?

Since this will live in the generic include/linux namespace (for userspace)
maybe input-event-codes ?

Rob are you ok with including uapi headers from dts files if those uapi
headers are guaranteed to have only #define-s in them?

I currently have a bit too much on my plate. So if someone else can take
care of this (assuming Rob acks it) that would be great.

Regards,

Hans
