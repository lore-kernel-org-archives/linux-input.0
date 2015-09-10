From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] devicetree: bindings: Add header file with evdev type
 and abs/rel code defines
Date: Thu, 10 Sep 2015 11:34:03 -0700
Message-ID: <CAKdAkRRFcn5+SXNfU4J+v4tcFyA1mZR1hMhT2y3QJeQJ1tTDYQ@mail.gmail.com>
References: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
	<1441789886-5868-2-git-send-email-hdegoede@redhat.com>
	<55F1BCFA.5010404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35901 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbbIJSeF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 14:34:05 -0400
In-Reply-To: <55F1BCFA.5010404@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Thu, Sep 10, 2015 at 10:25 AM, Rob Herring <robh@kernel.org> wrote:
> On 09/09/2015 04:11 AM, Hans de Goede wrote:
>> This header provides evdev constants for linux,code, and linux,input-*
>> properties.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  include/dt-bindings/input/evdev.h | 76 +++++++++++++++++++++++++++++++++++++++
>
> This looks fine, but please just add to input/input.h.
>
> Rob
>
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 include/dt-bindings/input/evdev.h
>>
>> diff --git a/include/dt-bindings/input/evdev.h b/include/dt-bindings/input/evdev.h
>> new file mode 100644
>> index 0000000..c1f7e0d
>> --- /dev/null
>> +++ b/include/dt-bindings/input/evdev.h
>> @@ -0,0 +1,76 @@
>> +/*
>> + * This header provides evdev constants for linux,code, and linux,input-*
>> + * properties.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_INPUT_LINUX_H
>> +#define _DT_BINDINGS_INPUT_LINUX_H
>> +
>> +/*
>> + * Event types
>> + */
>> +
>> +#define EV_SYN                       0x00
>> +#define EV_KEY                       0x01
>> +#define EV_REL                       0x02
>> +#define EV_ABS                       0x03
>> +#define EV_MSC                       0x04
>> +#define EV_SW                        0x05
>> +#define EV_LED                       0x11
>> +#define EV_SND                       0x12
>> +#define EV_REP                       0x14
>> +#define EV_FF                        0x15
>> +#define EV_PWR                       0x16
>> +#define EV_FF_STATUS         0x17
>> +#define EV_MAX                       0x1f
>> +
>> +/*
>> + * Relative axes
>> + */
>> +
>> +#define REL_X                        0x00
>> +#define REL_Y                        0x01
>> +#define REL_Z                        0x02
>> +#define REL_RX                       0x03
>> +#define REL_RY                       0x04
>> +#define REL_RZ                       0x05
>> +#define REL_HWHEEL           0x06
>> +#define REL_DIAL             0x07
>> +#define REL_WHEEL            0x08
>> +#define REL_MISC             0x09
>> +#define REL_MAX                      0x0f
>> +
>> +/*
>> + * Absolute axes
>> + */
>> +
>> +#define ABS_X                        0x00
>> +#define ABS_Y                        0x01
>> +#define ABS_Z                        0x02
>> +#define ABS_RX                       0x03
>> +#define ABS_RY                       0x04
>> +#define ABS_RZ                       0x05
>> +#define ABS_THROTTLE         0x06
>> +#define ABS_RUDDER           0x07
>> +#define ABS_WHEEL            0x08
>> +#define ABS_GAS                      0x09
>> +#define ABS_BRAKE            0x0a
>> +#define ABS_HAT0X            0x10
>> +#define ABS_HAT0Y            0x11
>> +#define ABS_HAT1X            0x12
>> +#define ABS_HAT1Y            0x13
>> +#define ABS_HAT2X            0x14
>> +#define ABS_HAT2Y            0x15
>> +#define ABS_HAT3X            0x16
>> +#define ABS_HAT3Y            0x17
>> +#define ABS_PRESSURE         0x18
>> +#define ABS_DISTANCE         0x19
>> +#define ABS_TILT_X           0x1a
>> +#define ABS_TILT_Y           0x1b
>> +#define ABS_TOOL_WIDTH               0x1c
>> +
>> +#define ABS_VOLUME           0x20
>> +
>> +#define ABS_MISC             0x28
>> +
>> +#endif /* _DT_BINDINGS_INPUT_LINUX_H */
>>
>

Actually I'd rather we removed include/dt-bindings/input/input.h and
instead used the header file from uapi. As it is now we already
duplicating definitions and the copy in dt-bindings is missing several
key codes. Until we split DT bindings form the kernel code I'd rather
have definitions in one place.

Thanks.

-- 
Dmitry
