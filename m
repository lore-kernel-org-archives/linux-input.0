From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Wed, 8 Mar 2017 10:08:46 +0100
Message-ID: <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
 <20170201174257.GE40045@dtor-ws> <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
 <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com>
 <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
 <20170202131251.GQ2053@lahna.fi.intel.com>
 <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
 <3f433773-27ba-8d07-3209-6df71d6d4b33@redhat.com>
 <1487778778.20145.22.camel@linux.intel.com>
 <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
 <1488454727.20145.71.camel@linux.intel.com>
 <e4dfd35b-cf7f-93bb-fb88-fb8d412d922a@redhat.com>
 <1488553076.20145.79.camel@linux.intel.com>
 <3be3837a-a57c-e6bf-538b-e135c1b37ff0@redhat.com>
 <1488554609.20145.81.camel@linux.intel.com>
 <693ce7b3-99e9-eb60-b164-50b27294a239@redhat.com>
 <1488887470.20145.108.camel@linux.intel.com>
 <015d1f87-fcfe-b08d-6934-732145d534ca@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbdCHJI5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 8 Mar 2017 04:08:57 -0500
In-Reply-To: <015d1f87-fcfe-b08d-6934-732145d534ca@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 07-03-17 14:55, Hans de Goede wrote:
> Hi,

<more snip>

> Ok, since it seems clear that I'm not going to be able to change your
> mind on this, I will give your patches a try and see if they fix the
> silead ts problems.

So I've cherry picked all the gpio related patches from your topic/uart/rpm
branch into my wip branch and then ran some tests. I did not get around
to actually test if the fix the silead issue (I believe they will) as I
started testing on a cht device and looking if soc_button_array still
works with your patches applied.

Unfortunately it no longer works, there are 2 problems:

1) "Input: soc_button_array - Add GPIO ACPI mapping table" should
also replace:

	desc = gpiod_get_index(dev, info->name, info->acpi_index, GPIOD_ASIS);

with:

	desc = gpiod_get(dev, info->name, GPIOD_ASIS);

At which point we can also drop the acpi_index field from the buttoninfo struct
altogether.

I think that "extcon: int3496: Add GPIO ACPI mapping table" will need
a similar change (I haven't tested it yet).

2) acpi_gpio_count() does not seem to work right in combination with the
new patches. It returns -ENOENT rather then the number of gpios specified
in the table passed to devm_acpi_dev_add_driver_gpios. It seems to only
check for gpios actually in the acpi-properties without looking at
adev->driver_gpios, where as acpi_can_fallback_to_crs() does check for
that and disallows fallback to counting the gpios in the _CRS causing
acpi_gpio_count() to not find any gpios. I believe the right fix for
this is to make acpi_gpio_count() also count the number of entries
in the adev->driver_gpios table.

For now I've just removed the acpi_gpio_count() check from soc_button_array,
with that removed and 1) fixed soc_button_array does work.

I will try to do some more testing later today, but all my cht work is
a side project and I first need to finish some stuff for my actual
main $dayjob project.

Regards,

Hans
