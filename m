From: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] HID: i2c-hid: Use device properties (instead of device tree)
Date: Mon, 2 Oct 2017 12:23:25 -0700
Message-ID: <CACK8Z6EWPmV5FOmrC=0M3afi2gGxj4CETPhMOZ7=SxO_Gq5iGw@mail.gmail.com>
References: <20170929224441.98176-1-rajatja@google.com> <1506874730.16112.194.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:45506 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdJBTYH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Oct 2017 15:24:07 -0400
Received: by mail-qt0-f170.google.com with SMTP id b21so3000482qte.2
        for <linux-input@vger.kernel.org>; Mon, 02 Oct 2017 12:24:07 -0700 (PDT)
In-Reply-To: <1506874730.16112.194.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@google.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajat Jain <rajatxjain@gmail.com>

OK, I think my patch changes more than what is needed (to solve my
problem), and in the process creates concerns. Please allow me to step
back and elaborate on the problem I'm trying to solve.

The hardware I am working on (Wacom touchscreen) does require a good
100ms delay after the reset, which I wanted to be able to specify via
the ACPI (this is an x86 platform). I only wanted to address the
problem of ACPI not being able to specify "post-power-on-delay-ms",
and I did not have the intention of changing any thing other than
that. So I'd gladly welcome any suggestions that I may get.

On Sun, Oct 1, 2017 at 9:18 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2017-09-29 at 15:44 -0700, Rajat Jain wrote:
>> Use the device properties (that can be provided by ACPI systems
>> as well as non ACPI systems) instead of device tree properties
>> (that are not provided ACPI systems). This required some minor
>> code restructuring.
>>
>
>> I don't think its a big deal, but just FYI, this changes the order in
>> which we
>> look for HID register address from
>> (device tree -> platform_data -> ACPI) to
>> (platform data -> device tree -> ACPI)
>
> I do.
>
> We would like to discourage use of legacy platform data in favour
> of Device Tree / ACPI.

Sure, I can prioritize both ACPI/device tree data over platform_data
if that is more desirable. I was just trying to retain the past
behavior where it falls back to ACPI only if there is no
platform_data, and (wrongly) assumed that we might want the same for
device tree data.

>
>> +static int i2c_hid_fwnode_probe(struct i2c_client *client,
>>               struct i2c_hid_platform_data *pdata)
>>  {
>>       struct device *dev = &client->dev;
>>       u32 val;
>>       int ret;
>>
>> -     ret = of_property_read_u32(dev->of_node, "hid-descr-addr",
>> &val);
>> -     if (ret) {
>> -             dev_err(&client->dev, "HID register address not
>> provided\n");
>> -             return -ENODEV;
>> -     }
>> -     if (val >> 16) {
>> -             dev_err(&client->dev, "Bad HID register address:
>> 0x%08x\n",
>> -                     val);
>> -             return -EINVAL;
>> +     ret = device_property_read_u32(dev, "hid-descr-addr", &val);
>> +     if (ret || val >> 16) {
>> +             /* Couldn't read using fwnode, try ACPI next */
>> +             if (!i2c_hid_acpi_pdata(client, pdata)) {
>> +                     dev_err(dev, "Bad/Not provided HID register
>> address\n");
>> +                     return -ENODEV;
>> +             }
>
> Why not just replace of_ calls by device_ ones?

I assume you mean why not just replace

ret = of_property_read_u32(dev->of_node, "post-power-on-delay-ms", &val);
with
ret = device_property_read_u32(dev, "post-power-on-delay-ms", &val);

in the function i2c_hid_of_probe()

Sure, that was the original idea that I started with. But I also
needed to make sure that the i2c_hid_of_probe() function does get
called for ACPI case. Then it made sense to rename it to "fwnode", and
then to do things more generically in that function. So I ended up
changing the i2c_hid_of_probe() to more generic i2c_hid_fwnode_probe()
to end up with what I have. I think I acknowledge that this is
changing more than what is needed, so I think yes, dumping this plan
makes sense.


The other plan that I had pondered over was to simply read this
property from the ACPI using device_property_read_u32 in
i2c_hid_acpi_pdata() without changing anything else. Note that this
would mean that we'd retain the of_property_read_*() call for the
device tree case. Now that I think about it again, this looks like a
more simpler, easier, and acceptable to do? Please let me know if this
sounds reasonable to do, or if there are any other suggestions?

>>       }
>>       pdata->hid_descriptor_address = val;
>>
>> -     ret = of_property_read_u32(dev->of_node, "post-power-on-
>> delay-ms",
>> -                                &val);
>> +     ret = device_property_read_u32(dev, "post-power-on-delay-ms",
>> &val);
>>       if (!ret)
>>               pdata->post_power_delay_ms = val;
>>
>>       return 0;
>>  }
>>
>
> Looking how ACPI support is established in the driver, I would rather
> NAK this change. Is there any _actual_ hardware on the wild with such
> properties?

As I mentioned above, I think my patch changed the _DSD and the HID
register address asignment, which I did not want to do roiginally.
Yes, I do have (fairly new) wacom touchscreen hardware, that wants a
delay after the reset, that I want to be able to specify using the
"post-power-on-delay-ms".

Thanks & Best Regards,

Rajat


>
> HID protocol for ACPI is described in [1] where nothing is about _DSD.
>
> [1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/plug-
> and-play-support-and-power-management
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
