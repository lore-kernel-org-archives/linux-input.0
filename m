From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Thu, 09 Mar 2017 17:03:30 +0200
Message-ID: <1489071810.20145.173.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
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
         <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
         <1488969002.20145.119.camel@linux.intel.com>
         <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
         <1488973582.20145.125.camel@linux.intel.com>
         <654981a1-2493-01d6-13e6-1287b70e22f2@redhat.com>
         <1488997525.20145.161.camel@linux.intel.com>
         <114fa24e-b726-28e1-66c7-aa90bcf5c966@redhat.com>
         <1489068196.20145.169.camel@linux.intel.com>
         <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26227 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbdCIPGx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 10:06:53 -0500
In-Reply-To: <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Thu, 2017-03-09 at 15:45 +0100, Hans de Goede wrote:

> > Sounds like a plan!
> > 
> > Since extcon patches are landed already mainstream it might make
> > sense
> > to send it as usual to all maintainers.
> 
> Ack, so to be clear we should use gpiod_get not gpiod_get_index with
> the acpi mapping table, right ? The reason I'm asking is that my
> test devices only have the id pin which has index 0 so in my
> experience with soc_button_array it will work with both
> (the button with index 0 would even work with gpiod_get_index).

TL;DR -- right.


So, now simple and clean example:

_CRS:

GpioIo(...)  { pin #5 }
GpioIo(...)  { pin #3, pin #4, pin #2 }
GpioIo(...)  { pin #15 }

If we assume each line represents one function (connection ID):
"func0"
"func1"
"func2"

we would see that index is needed only when we would like to get access
to pin #4 or pin #2 of "func1".

Was:

gpiod_get_index(..., NULL, <index_in_CRS>);

where index is 0,1, or 2 *with second index assumed 0*!

Now, what we actually is doing we mapping connection ID to the first
index and can use index to access mentioned above pins:

gpiod_get_index(..., "<funcX>", <secondary_index_in_CRS>);

For example, for pin #2 or #4
gpiod_get_index(..., "func1", 2); // pin #2
gpiod_get_index(..., "func1", 1); // pin #4

Thus,
gpiod_get_index(..., "func1", 0); // pin #3


Or just for the first (virtual) column:

gpiod_get(..., "<funcX>");

where pin #5, #3 or #15 is accessible.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
