From: Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Allow ACPI systems to specify "post-power-on-delay-ms"
Date: Tue, 3 Oct 2017 11:24:28 -0700
Message-ID: <CAA93t1oYQLBG0+5BxQnNmB4umL1g2Etpa-6dC5+uO22+HZBTRg@mail.gmail.com>
References: <1506874730.16112.194.camel@linux.intel.com> <20171002213215.32201-1-rajatja@google.com>
 <1507022935.16112.237.camel@linux.intel.com>
Reply-To: rajatxjain@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507022935.16112.237.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rajat Jain <rajatja@google.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 3, 2017 at 2:28 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> + Cc: Jarkko, he spent a lot of nice hours to debug i2c HID touchscreen
> devices on x86 ACPI enabled platforms, so, he might have a better idea
> or some comments.

Thanks Andy, I'll look out for any suggestions on inputs from Jarkko.

>
> On Mon, 2017-10-02 at 14:32 -0700, Rajat Jain wrote:
>> The property "post-power-on-delay-ms"" allows a platform to specify
>> the delay needed after power-on, but only via device trees. Thus
>> allow ACPI systems to also provide the same information.
>
> This one is even less acceptable (in given form), see below why.
>
>> +     if (!device_property_read_u32(&client->dev, "post-power-on-
>> delay-ms",
>> +                                   &val))
>
> The main idea behind unified device properties API is to provide a way
> which will be resource provider agnostic, i.e. callers will get data in
> some kind of generic way independently on the source of it.
>
> Since I2C HID protocol is well defined by Microsoft and it doesn't
> involve _DSD, you make here even more gnostic solution.

Agree. Since I don't understand the HID protocol (or _DSD for that
matter) that well, and hence I want to solve my problem without
disturbing any other code. I've sent yet another iteration (v3) that
introduces a new function to parse the common properties, please let
me know if this is any good.

>
> Besides the fact, each property must be registered in Device Tree
> bindings (yes, even if it's going to be used for ACPI enabled platforms
> initially).

The property was already documented, however, thanks for reminding, I
cleaned up the doc to indicate that regulator property is not a
requirement for the delay property.

Thanks & Best Regards,

Rajat

>
> Thus, _if_ (and only if) we have no other solution, you need to clean up
> your first version and send it as v3.
>
> Don't forget to add a version to the patch (git-format-patch has a
> command line option to make this simpler).
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
