From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 2/3] tps6507x-ts: add DT support
Date: Wed, 1 Mar 2017 09:21:59 +0100
Message-ID: <CAGm1_kuyT61jc-mkiGcNf+2xK8GVco4y=p1Fmg2mGigc2h3o=g@mail.gmail.com>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
 <1487950946-18590-3-git-send-email-yegorslists@googlemail.com>
 <20170225190827.GC31929@dtor-ws> <CAGm1_kvWLbakjDpY+dUnNyAaHyC-ykgGfyRDiCESksFcntgLxA@mail.gmail.com>
 <m21suj2h77.fsf@baylibre.com> <32104937-2332-9876-0edb-612b149f0509@ti.com> <20170228184135.GF20776@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35225 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdCAI2g (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 03:28:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so5991350wmu.2
        for <linux-input@vger.kernel.org>; Wed, 01 Mar 2017 00:28:22 -0800 (PST)
In-Reply-To: <20170228184135.GF20776@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, Andrey Skvortsov <andrej.skvortzov@gmail.com>

On Tue, Feb 28, 2017 at 7:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Feb 28, 2017 at 03:36:26PM +0530, Sekhar Nori wrote:
>> On Tuesday 28 February 2017 07:46 AM, Kevin Hilman wrote:
>> > + Sekhar for the board-da850-evm questions.
>> >
>> > Yegor Yefremov <yegorslists@googlemail.com> writes:
>> >
>> >> Hi Dmitry,
>> >>
>> >> On Sat, Feb 25, 2017 at 8:08 PM, Dmitry Torokhov
>> >> <dmitry.torokhov@gmail.com> wrote:
>> >>> Hi Yegor,
>> >>>
>> >>> On Fri, Feb 24, 2017 at 04:42:25PM +0100, yegorslists@googlemail.com wrote:
>> >>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>> >>>>
>> >>>> This patch adds support for DT to tps6507x-ts driver.
>> >>>>
>> >>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> >>>> ---
>> >>>>  drivers/input/touchscreen/tps6507x-ts.c | 70 ++++++++++++++++++++-------------
>> >>>>  1 file changed, 42 insertions(+), 28 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
>> >>>> index 5bf1ec6..2d61220 100644
>> >>>> --- a/drivers/input/touchscreen/tps6507x-ts.c
>> >>>> +++ b/drivers/input/touchscreen/tps6507x-ts.c
>> >>>> @@ -22,6 +22,8 @@
>> >>>>  #include <linux/mfd/tps6507x.h>
>> >>>>  #include <linux/input/tps6507x-ts.h>
>> >>>>  #include <linux/delay.h>
>> >>>> +#include <linux/of.h>
>> >>>> +#include <linux/of_device.h>
>> >>>>
>> >>>>  #define TSC_DEFAULT_POLL_PERIOD 30 /* ms */
>> >>>>  #define TPS_DEFAULT_MIN_PRESSURE 0x30
>> >>>> @@ -199,33 +201,52 @@ static void tps6507x_ts_poll(struct input_polled_dev *poll_dev)
>> >>>>       tps6507x_adc_standby(tsc);
>> >>>>  }
>> >>>>
>> >>>> +static void tsc_init_data(struct tps6507x_ts *tsc,
>> >>>> +             struct input_dev *input_dev)
>> >>>> +{
>> >>>> +     struct device_node *node = tsc->dev->of_node;
>> >>>> +     const struct tps6507x_board *tps_board =
>> >>>> +                     dev_get_platdata(tsc->dev);
>> >>>> +     const struct touchscreen_init_data *init_data = NULL;
>> >>>> +
>> >>>> +     if (tps_board)
>> >>>> +             /*
>> >>>> +              * init_data points to array of touchscreen_init structure
>> >>>> +              * coming from the board-evm file.
>> >>>> +              */
>> >>>> +             init_data = tps_board->tps6507x_ts_init_data;
>> >>>> +
>> >>>> +     if (node == NULL && init_data == NULL) {
>> >>>> +             tsc->poll_dev->poll_interval = TSC_DEFAULT_POLL_PERIOD;
>> >>>> +             tsc->min_pressure = TPS_DEFAULT_MIN_PRESSURE;
>> >>>
>> >>> I think you want to always init with defaults, then override with
>> >>> property data.
>> >>
>> >> ACK
>> >>
>> >>>> +     } else if (init_data) {
>> >>>> +             tsc->poll_dev->poll_interval = init_data->poll_period;
>> >>>> +             tsc->min_pressure = init_data->min_pressure;
>> >>>> +             input_dev->id.vendor = init_data->vendor;
>> >>>> +             input_dev->id.product = init_data->product;
>> >>>> +             input_dev->id.version = init_data->version;
>> >>>> +     } else if (node) {
>> >>>> +             of_property_read_u32(node, "ti,poll-period",
>> >>>> +                             &tsc->poll_dev->poll_interval);
>> >>>> +             of_property_read_u16(node, "ti,min-pressure",
>> >>>> +                             &tsc->min_pressure);
>> >>>
>> >>> Anything but u32 is better avoided in DT as it requires special
>> >>> annotation which is easily forgotten.
>> >>
>> >> Will convert to 32-bit values.
>> >>
>> >>> I also would prefer if we switched to generic device properties and
>> >>> retired the static init data.
>> >>
>> >> do you mean converting the driver to DT-only variant?
>
> Not to DT only. device_property_read_* API works on DT, ACPI and legacy
> boards that can be converted to use property sets (see
> device_add_properties() and struct property_entry API).

OK. I have found some examples in the board files.

>> >>
>> >>>> +             of_property_read_u16(node, "ti,vendor",
>> >>>> +                             &input_dev->id.vendor);
>> >>>> +             of_property_read_u16(node, "ti,product",
>> >>>> +                             &input_dev->id.product);
>> >>>
>> >>> Would we not know vendor and product from the compatible string?
>> >>>
>> >>>> +             of_property_read_u16(node, "ti,version",
>> >>>> +                             &input_dev->id.version);
>> >>>
>> >>> I wonder if anyone cares about this.
>> >>
>> >> I've looked at other touchscreen drivers and this structure seems to
>> >> be filled mostly for the RS232 connected drivers. So I'd suggest just
>> >> to leave vendor, product and version at 0 and not provide these values
>> >> via DT.  At least tslib and hence Qt is working without these values
>> >> set.
>> >>
>> >> @Kevin: so far the only user of this touch driver is da850-evm board.
>> >> Can we drop the values for the id structure? Btw. what else is needed
>>
>> It seems like it was mostly added so it can be read through sysfs. But
>> since it has been exposed to userspace, I am not sure if it can simply
>> be dropped. May be used hardcoded values for these in the driver based
>> on compatible string ?
>
> That's what I said. We do know the product and vendor. Version could be
> dropped.

Do you mean this string? compatible = "ti,tps6507x"?

This is our current configuration taken from
arch/arm/mach-davinci/board-da850-evm.c:

        .vendor = 0,            /* /sys/class/input/input?/id/vendor
*/                                               |
ti,version = /bits/ 16 <0x100>;
        .product = 65070,       /* /sys/class/input/input?/id/product
*/                                              |
        .version = 0x100,       /* /sys/class/input/input?/id/version */

We can leave product by 65070, set version to 0, but what to do with
the vendor ID? What is TI's vendor ID? Is this 0x0451 as mentioned in
this forum [1]?

[1] https://e2e.ti.com/support/microcontrollers/msp430/f/166/t/18974

Yegor
