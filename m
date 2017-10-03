From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] HID: i2c-hid: Allow ACPI systems to specify
 "post-power-on-delay-ms"
Date: Tue, 03 Oct 2017 12:28:55 +0300
Message-ID: <1507022935.16112.237.camel@linux.intel.com>
References: <1506874730.16112.194.camel@linux.intel.com>
         <20171002213215.32201-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002213215.32201-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-input@vger.kernel.org

+ Cc: Jarkko, he spent a lot of nice hours to debug i2c HID touchscreen
devices on x86 ACPI enabled platforms, so, he might have a better idea
or some comments.

On Mon, 2017-10-02 at 14:32 -0700, Rajat Jain wrote:
> The property "post-power-on-delay-ms"" allows a platform to specify
> the delay needed after power-on, but only via device trees. Thus
> allow ACPI systems to also provide the same information.

This one is even less acceptable (in given form), see below why.

> +	if (!device_property_read_u32(&client->dev, "post-power-on-
> delay-ms",
> +				      &val))

The main idea behind unified device properties API is to provide a way
which will be resource provider agnostic, i.e. callers will get data in
some kind of generic way independently on the source of it.

Since I2C HID protocol is well defined by Microsoft and it doesn't
involve _DSD, you make here even more gnostic solution.

Besides the fact, each property must be registered in Device Tree
bindings (yes, even if it's going to be used for ACPI enabled platforms
initially).

Thus, _if_ (and only if) we have no other solution, you need to clean up
your first version and send it as v3.

Don't forget to add a version to the patch (git-format-patch has a
command line option to make this simpler).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
