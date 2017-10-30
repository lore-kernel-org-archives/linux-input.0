From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] HID: i2c-hid: add reset gpio property
Date: Mon, 30 Oct 2017 14:16:37 -0700
Message-ID: <20171030211635.GA28190@google.com>
References: <1509331789-1949-1-git-send-email-hl@rock-chips.com>
 <20171030165753.GA10752@google.com>
 <CAL_JsqKQw7UubSRALsPMUw7rR16xwcSWUzN5wEAqckN7D61Kkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKQw7UubSRALsPMUw7rR16xwcSWUzN5wEAqckN7D61Kkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 30, 2017 at 03:15:19PM -0500, Rob Herring wrote:
> On Mon, Oct 30, 2017 at 11:57 AM, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > On Mon, Oct 30, 2017 at 10:49:49AM +0800, Lin Huang wrote:
> >> --- a/drivers/hid/i2c-hid/i2c-hid.c
> >> +++ b/drivers/hid/i2c-hid/i2c-hid.c

> >> @@ -793,6 +794,34 @@ struct hid_ll_driver i2c_hid_ll_driver = {
> >>  };
> >>  EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
> >>
> >> +static int i2c_hid_hw_power_on(struct i2c_hid *ihid)
> >> +{
> >> +     int ret;
> >> +
> >> +     ret = regulator_enable(ihid->pdata.supply);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     if (ihid->pdata.post_power_delay_ms)
> >> +             msleep(ihid->pdata.post_power_delay_ms);
> >> +
> >> +     gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
> >> +     usleep_range(ihid->pdata.assert_reset_us,
> >> +                  ihid->pdata.assert_reset_us);
> 
> You already ensure that reset is asserted before power on, so why does
> the post_power_delay_ms not work for you? IIRC, there's already a
> property for it.

That would be more like the equivalent of the "deassert" delay used a
few lines below. The "assert" delay would be a different property,
unless we want to guess at a reasonable value, or else key off something
like 'compatible'.

But otherwise, sure, we could reuse it. We'd then want to modify the
binding documentation to be less specific to the "vdd-supply" though.

> > What's the point of using the same value on both ends of the range? Does
> > it make sense to give some padding to this? e.g., from X to X + 10% ?
> > (Note that reasonable values for this are on the order of a few
> > milliseconds.)
> >
> > Also, the above msleep() has a 'if non-zero' condition on it...but
> > that's not actually necessary now that I look again, since msleep() and
> > usleep_range() both handle zero times OK... But it feels a little
> > inconsistent. We should probably change one or the other sometime.
> >
> >> +     gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 0);
> >> +     usleep_range(ihid->pdata.deassert_reset_us,
> >> +                  ihid->pdata.deassert_reset_us);
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static int i2c_hid_hw_power_off(struct i2c_hid *ihid)
> >> +{
> >> +     gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
> >> +
> >> +     return regulator_disable(ihid->pdata.supply);
> >> +}
> >> +
> >>  static int i2c_hid_init_irq(struct i2c_client *client)
> >>  {
> >>       struct i2c_hid *ihid = i2c_get_clientdata(client);
> >> @@ -934,6 +963,12 @@ static int i2c_hid_of_probe(struct i2c_client *client,
> >>       if (!ret)
> >>               pdata->post_power_delay_ms = val;
> >>
> >> +     ret = of_property_read_u32(dev->of_node, "assert-reset-us",
> >> +                                &pdata->assert_reset_us);
> >> +
> >> +     ret = of_property_read_u32(dev->of_node, "deassert-reset-us",
> >> +                                &pdata->deassert_reset_us);
> >
> > You need to document these.
> 
> I'm not inclined to accept these. Sure, it's only 2 properties. No big
> deal on their own. However, what about the next device that needs some
> other delay. Or has another control signal with timing constraints. Or
> has a clock with specific enable timing. The list goes on... If we
> wanted to handle all cases of power sequencing in DT, then we'd write
> something flexible to handle any case. But we don't because DT is not
> a scripting language. This is why we have compatibles for each
> specific chip.

I feel like we've had this discussion. I think the essence of the
disagreement was that the maintainer of this driver did not want to
support a long list of 'compatible' properties for stuff that's
otherwise all hidden by the ACPI model -- the DT binding doc even refers
to a Windows/ACPI spec. (A secondary concern was that the I2C subsystem
still doesn't support multiple compatible strings with modules
correctly, IIRC.)

I don't really know how to bridge that gap. DT-based platforms are
inherently not ACPI, and all the device "power on" logic just has to be
done in the kernel. Unfortunately, some ways of slicing this require
more burden on driver maintainers...

> How many devices need this? Do you have cases needing different times?
> Why can't this time just be fixed in the driver? Is this really timing
> critical or have really long delays?

I don't know how many devices need something like this, but this is a
pretty common model. I don't see why the next device with a reset pin
wouldn't be able to reuse the same timing knobs.

And FWIW, this is still the same "wacom,w9013", just different board
design. We could theoretically key off the compatible, and list the
datasheet numbers in the driver; but see my comment above.

Not sure what you mean about "timing critical"; in this case the values
are 1ms and 30ms respectively, and they are used at power-on and
(potentially) system resume. I'm not sure there would be much harm if
these timings were significantly longer than the datasheet recommends,
but at some point, excessive delay would cause boot or suspend/resume
inefficiencies. (Asynchronous probe and suspend/resume can often
mitigate these inefficiencies.)

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
