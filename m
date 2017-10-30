From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: i2c-hid: add reset gpio property
Date: Mon, 30 Oct 2017 15:15:19 -0500
Message-ID: <CAL_JsqKQw7UubSRALsPMUw7rR16xwcSWUzN5wEAqckN7D61Kkg@mail.gmail.com>
References: <1509331789-1949-1-git-send-email-hl@rock-chips.com> <20171030165753.GA10752@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171030165753.GA10752-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 30, 2017 at 11:57 AM, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> + devicetree list
>
> Hi,
>
> On Mon, Oct 30, 2017 at 10:49:49AM +0800, Lin Huang wrote:
>> some i2c hid devices have reset gpio, need to control
>> it in the driver.
>>
>> Change-Id: I87bca954bffc7eb7b35711406f522cb3d0fc2ded
>
> You should be removing these Gerrit ID lines from patches before sending
> them to these mailing lists.
>
>> Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>  drivers/hid/i2c-hid/i2c-hid.c         | 63 +++++++++++++++++++++++++++--------
>>  include/linux/platform_data/i2c-hid.h |  4 +++
>>  2 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index 9145c21..a0e3a8e 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/acpi.h>
>>  #include <linux/of.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/regulator/consumer.h>
>>
>>  #include <linux/platform_data/i2c-hid.h>
>> @@ -793,6 +794,34 @@ struct hid_ll_driver i2c_hid_ll_driver = {
>>  };
>>  EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
>>
>> +static int i2c_hid_hw_power_on(struct i2c_hid *ihid)
>> +{
>> +     int ret;
>> +
>> +     ret = regulator_enable(ihid->pdata.supply);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     if (ihid->pdata.post_power_delay_ms)
>> +             msleep(ihid->pdata.post_power_delay_ms);
>> +
>> +     gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
>> +     usleep_range(ihid->pdata.assert_reset_us,
>> +                  ihid->pdata.assert_reset_us);

You already ensure that reset is asserted before power on, so why does
the post_power_delay_ms not work for you? IIRC, there's already a
property for it.

>
> What's the point of using the same value on both ends of the range? Does
> it make sense to give some padding to this? e.g., from X to X + 10% ?
> (Note that reasonable values for this are on the order of a few
> milliseconds.)
>
> Also, the above msleep() has a 'if non-zero' condition on it...but
> that's not actually necessary now that I look again, since msleep() and
> usleep_range() both handle zero times OK... But it feels a little
> inconsistent. We should probably change one or the other sometime.
>
>> +     gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 0);
>> +     usleep_range(ihid->pdata.deassert_reset_us,
>> +                  ihid->pdata.deassert_reset_us);
>> +
>> +     return ret;
>> +}
>> +
>> +static int i2c_hid_hw_power_off(struct i2c_hid *ihid)
>> +{
>> +     gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
>> +
>> +     return regulator_disable(ihid->pdata.supply);
>> +}
>> +
>>  static int i2c_hid_init_irq(struct i2c_client *client)
>>  {
>>       struct i2c_hid *ihid = i2c_get_clientdata(client);
>> @@ -934,6 +963,12 @@ static int i2c_hid_of_probe(struct i2c_client *client,
>>       if (!ret)
>>               pdata->post_power_delay_ms = val;
>>
>> +     ret = of_property_read_u32(dev->of_node, "assert-reset-us",
>> +                                &pdata->assert_reset_us);
>> +
>> +     ret = of_property_read_u32(dev->of_node, "deassert-reset-us",
>> +                                &pdata->deassert_reset_us);
>
> You need to document these.

I'm not inclined to accept these. Sure, it's only 2 properties. No big
deal on their own. However, what about the next device that needs some
other delay. Or has another control signal with timing constraints. Or
has a clock with specific enable timing. The list goes on... If we
wanted to handle all cases of power sequencing in DT, then we'd write
something flexible to handle any case. But we don't because DT is not
a scripting language. This is why we have compatibles for each
specific chip.

How many devices need this? Do you have cases needing different times?
Why can't this time just be fixed in the driver? Is this really timing
critical or have really long delays?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
