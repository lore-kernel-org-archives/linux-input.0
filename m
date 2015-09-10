From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] devicetree: bindings: Add header file with evdev type
 and abs/rel code defines
Date: Thu, 10 Sep 2015 20:40:11 +0200
Message-ID: <55F1CE8B.5050302@redhat.com>
References: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
 <1441789886-5868-2-git-send-email-hdegoede@redhat.com>
 <55F1BCFA.5010404@kernel.org>
 <CAKdAkRRFcn5+SXNfU4J+v4tcFyA1mZR1hMhT2y3QJeQJ1tTDYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRRFcn5+SXNfU4J+v4tcFyA1mZR1hMhT2y3QJeQJ1tTDYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 10-09-15 20:34, Dmitry Torokhov wrote:
> On Thu, Sep 10, 2015 at 10:25 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On 09/09/2015 04:11 AM, Hans de Goede wrote:
>>> This header provides evdev constants for linux,code, and linux,input-*
>>> properties.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   include/dt-bindings/input/evdev.h | 76 +++++++++++++++++++++++++++++++++++++++
>>
>> This looks fine, but please just add to input/input.h.
>>
>> Rob
>>
>>>   1 file changed, 76 insertions(+)
>>>   create mode 100644 include/dt-bindings/input/evdev.h
>>>
>>> diff --git a/include/dt-bindings/input/evdev.h b/include/dt-bindings/input/evdev.h
>>> new file mode 100644
>>> index 0000000..c1f7e0d
>>> --- /dev/null
>>> +++ b/include/dt-bindings/input/evdev.h
>>> @@ -0,0 +1,76 @@
>>> +/*
>>> + * This header provides evdev constants for linux,code, and linux,input-*
>>> + * properties.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_INPUT_LINUX_H
>>> +#define _DT_BINDINGS_INPUT_LINUX_H
>>> +
>>> +/*
>>> + * Event types
>>> + */
>>> +
>>> +#define EV_SYN                       0x00
>>> +#define EV_KEY                       0x01
>>> +#define EV_REL                       0x02
>>> +#define EV_ABS                       0x03
>>> +#define EV_MSC                       0x04
>>> +#define EV_SW                        0x05
>>> +#define EV_LED                       0x11
>>> +#define EV_SND                       0x12
>>> +#define EV_REP                       0x14
>>> +#define EV_FF                        0x15
>>> +#define EV_PWR                       0x16
>>> +#define EV_FF_STATUS         0x17
>>> +#define EV_MAX                       0x1f
>>> +
>>> +/*
>>> + * Relative axes
>>> + */
>>> +
>>> +#define REL_X                        0x00
>>> +#define REL_Y                        0x01
>>> +#define REL_Z                        0x02
>>> +#define REL_RX                       0x03
>>> +#define REL_RY                       0x04
>>> +#define REL_RZ                       0x05
>>> +#define REL_HWHEEL           0x06
>>> +#define REL_DIAL             0x07
>>> +#define REL_WHEEL            0x08
>>> +#define REL_MISC             0x09
>>> +#define REL_MAX                      0x0f
>>> +
>>> +/*
>>> + * Absolute axes
>>> + */
>>> +
>>> +#define ABS_X                        0x00
>>> +#define ABS_Y                        0x01
>>> +#define ABS_Z                        0x02
>>> +#define ABS_RX                       0x03
>>> +#define ABS_RY                       0x04
>>> +#define ABS_RZ                       0x05
>>> +#define ABS_THROTTLE         0x06
>>> +#define ABS_RUDDER           0x07
>>> +#define ABS_WHEEL            0x08
>>> +#define ABS_GAS                      0x09
>>> +#define ABS_BRAKE            0x0a
>>> +#define ABS_HAT0X            0x10
>>> +#define ABS_HAT0Y            0x11
>>> +#define ABS_HAT1X            0x12
>>> +#define ABS_HAT1Y            0x13
>>> +#define ABS_HAT2X            0x14
>>> +#define ABS_HAT2Y            0x15
>>> +#define ABS_HAT3X            0x16
>>> +#define ABS_HAT3Y            0x17
>>> +#define ABS_PRESSURE         0x18
>>> +#define ABS_DISTANCE         0x19
>>> +#define ABS_TILT_X           0x1a
>>> +#define ABS_TILT_Y           0x1b
>>> +#define ABS_TOOL_WIDTH               0x1c
>>> +
>>> +#define ABS_VOLUME           0x20
>>> +
>>> +#define ABS_MISC             0x28
>>> +
>>> +#endif /* _DT_BINDINGS_INPUT_LINUX_H */
>>>
>>
>
> Actually I'd rather we removed include/dt-bindings/input/input.h and
> instead used the header file from uapi. As it is now we already
> duplicating definitions and the copy in dt-bindings is missing several
> key codes. Until we split DT bindings form the kernel code I'd rather
> have definitions in one place.

AFAIK we cannot do that as the uapi header also contains things like:

struct input_event {
         struct timeval time;
         __u16 type;
         __u16 code;
         __s32 value;
};

Which is not valid device tree syntax.

If you want this we need to split the uapi headers in one with only
defines and one with all the rest.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
