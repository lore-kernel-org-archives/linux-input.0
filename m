From: Grant Grundler <grundler@chromium.org>
Subject: Re: Input: add Atmel Atmegaxx captouch driver
Date: Wed, 4 May 2016 09:43:35 -0700
Message-ID: <CANEJEGvZyU6-P8FcR7Z7GriJw3Pj32f5hnJRkbYxoE-t0yXy7g@mail.gmail.com>
References: <1462295611-49684-1-git-send-email-grundler@chromium.org>
	<20160504135123.GA4567@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35247 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbcEDQnh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 12:43:37 -0400
Received: by mail-yw0-f180.google.com with SMTP id g133so92138090ywb.2
        for <linux-input@vger.kernel.org>; Wed, 04 May 2016 09:43:36 -0700 (PDT)
In-Reply-To: <20160504135123.GA4567@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Hung-yu Wu <hywu@google.com>

On Wed, May 4, 2016 at 6:51 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, May 03, 2016 at 10:13:31AM -0700, Grant Grundler wrote:
>> Add I2C driver for AtmegaXX capacitive touch device.
>>
>> Signed-off-by: Hung-yu Wu <hywu@google.com>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>> ---
>>  .../bindings/input/atmel,atmegaxx_captouch.txt     |  34 +++
>
> It is generally preferred that bindings are a separate patch.

ACK - I just discovered Documentation/devicetree/bindings/submitting-patches.txt
(which explains this in more detail)

>>  drivers/input/misc/Kconfig                         |  11 +
>>  drivers/input/misc/Makefile                        |   1 +
>>  drivers/input/misc/atmegaxx_captouch.c             | 278 +++++++++++++++++++++
>>  4 files changed, 324 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt
>>  create mode 100644 drivers/input/misc/atmegaxx_captouch.c
>>
>> For those that like to know how sausage is made, ChromeOS code review history here:
>>    https://chromium-review.googlesource.com/339950
>>
>> Driver was tested with prototype HW and it reliably reports events correctly.
>> Manual testing was just using "evtest /dev/input/event0" and watch for events.
>>
>> diff --git a/Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt b/Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt
>> new file mode 100644
>> index 0000000..07a4b0b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt
>> @@ -0,0 +1,34 @@
>> +Device tree bindings for Atmel AtmegaXX capacitive touch sensor
>> +
>> +The node for this device must be a child of a I2C controller node, as the
>> +device communicates via I2C.
>> +
>> +Required properties:
>> +
>> +     compatible:     Must be "atmel,atmegaxx_captouch".
>
> No wildcards in the compatible strings. Use the specific devices.

Sorry, I don't understand - What is a wildcard in this context?

I also just discovered
Documentation/devicetree/bindings/submitting-patches.txt and the "5)
the wildcard" text doesn't seem to match the usage here.

> Also, use hyphen rather than underscore.

ACK - I have no clue why - I've been scrounging around in
Documentation and haven't stumbled across "coding style" for device
tree document.


> However, if the device is only a touch controller, then '_captouch' is not needed.
> The part number is sufficient to identify the device.

atmegaxx is an Atmel microcontroller series and in this particular
case used to drive a capacitive touch input device (just buttons).
Since the microcontroller can be used for "anything", "captouch" is
sort of the "model" of this implementation.


>> +     reg:            The I2C slave address of the device.
>> +     interrupts:     Property describing the interrupt line the device
>> +                     is connected to. The device only has one interrupt
>> +                     source.
>> +     linux,keycodes: Specifies an array of numeric keycode values to
>> +                     be used for reporting button presses. The array can
>> +                     contain up to 8 entries.
>> +
>> +Optional properties:
>> +
>> +     autorepeat:     Enables the Linux input system's autorepeat
>> +                     feature on the input device.
>> +
>> +Example:
>> +
>> +     atmegaxx_captouch@51 {
>
> atmegaxx@51 (with actual part number)

atmegaxx_captouch (or -captouch) is how Atmel has been referring to
this implementation. I'm not aware of any other part number or model
number.

>> +             compatible = "atmel,atmegaxx_captouch";
>> +             reg = <0x51>;
>> +             interrupt-parent = <&tlmm>;
>> +             interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
>> +             linux,keycodes = <BTN_0>, <BTN_1>,
>> +                     <BTN_2>, <BTN_3>,
>> +                     <BTN_4>, <BTN_5>,
>> +                     <BTN_6>, <BTN_7>;
>> +             autorepeat;
>> +     };

Thanks for the feedback!
I'll repost with s/_/-/ fix after naming is clear.

thanks,
grant
