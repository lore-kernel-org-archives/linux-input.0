From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Thu, 09 Mar 2017 16:03:16 +0200
Message-ID: <1489068196.20145.169.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
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
         <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
         <1488969002.20145.119.camel@linux.intel.com>
         <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
         <1488973582.20145.125.camel@linux.intel.com>
         <654981a1-2493-01d6-13e6-1287b70e22f2@redhat.com>
         <1488997525.20145.161.camel@linux.intel.com>
         <114fa24e-b726-28e1-66c7-aa90bcf5c966@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41605 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753861AbdCIOIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 09:08:10 -0500
In-Reply-To: <114fa24e-b726-28e1-66c7-aa90bcf5c966@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Thu, 2017-03-09 at 14:57 +0100, Hans de Goede wrote:
> Hi,
> 
> On 08-03-17 19:25, Andy Shevchenko wrote:
> > On Wed, 2017-03-08 at 18:05 +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 08-03-17 12:46, Andy Shevchenko wrote:
> > > > On Wed, 2017-03-08 at 12:27 +0100, Hans de Goede wrote:
> > > > > On 08-03-17 11:30, Andy Shevchenko wrote:
> > > > > > On Wed, 2017-03-08 at 10:08 +0100, Hans de Goede wrote:
> > > > > > On 07-03-17 14:55, Hans de Goede wrote:

> > Yeah. The attached patch you sent is fine by me.
> 
> Ok, I've slighty modified it to also change the KBUILD_MODNAME
> passed to gpiod_count to NULL, I know that your:
> "Input: soc_button_array - Propagate error from gpiod_count()"
> patch: https://bitbucket.org/andy-shev/linux/commits/13b5b3e1b178fbc9b
> 2ecaa915715f3bb8a024f88
> 
> Also does that, but that depends on the rest of your gpiolib changes,
> where as this patch can be merged right now, to prepare things
> for your gpiolib changes landing. So I'm going to send the
> patch with the extra s/KBUILD_MODNAME/NULL/ to Dmitry for
> merging into input/next. You may want to rebase your
> "Input: soc_button_array - Propagate error from gpiod_count()"
> patch on top, that also will make it cleaner as now it
> no longer needs to do the s/KBUILD_MODNAME/NULL/.

Go ahead!

I pushed few hours ago updated version of the branch where I applied
that your previous patch and reverted mine regarding to soc-button-array 
and surface3_button drivers.

I will rebase my stuff on your new patch.

> > > > > > > I think that "extcon: int3496: Add GPIO ACPI mapping
> > > > > > > table"
> > > > > > > will
> > > > > > > need
> > > > > > > a similar change (I haven't tested it yet).
> > > 
> > > So I assume you want to do the same (pass NULL as con-id to
> > > gpiod_get_index()) for the extcon-in3496 driver or do you want
> > > to keep the GPIO ACPI mapping table there?
> > 
> > A slightly preferable table variant (needs to be fixed I guess)
> > because
> > initial one used to have different labels.
> 
> Ok, I will test with the acpi-mapping table then and if necessary
> create a fixup patch for it and send that to you.

Sounds like a plan!

Since extcon patches are landed already mainstream it might make sense
to send it as usual to all maintainers.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
