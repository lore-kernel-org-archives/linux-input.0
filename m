From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Wed, 08 Mar 2017 13:46:22 +0200
Message-ID: <1488973582.20145.125.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
         <20170202104130.GJ2053@lahna.fi.intel.com>
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
         <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
         <1488969002.20145.119.camel@linux.intel.com>
         <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33102 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbdCHPed (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 8 Mar 2017 10:34:33 -0500
In-Reply-To: <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Wed, 2017-03-08 at 12:27 +0100, Hans de Goede wrote:
> On 08-03-17 11:30, Andy Shevchenko wrote:
> > On Wed, 2017-03-08 at 10:08 +0100, Hans de Goede wrote:
> > > On 07-03-17 14:55, Hans de Goede wrote:


> > > I did not get around
> > > to actually test if the fix the silead issue (I believe they will)
> > > as
> > > I
> > > started testing on a cht device and looking if soc_button_array
> > > still
> > > works with your patches applied.
> > > 
> > > Unfortunately it no longer works, there are 2 problems:
> > > 
> > > 1) "Input: soc_button_array - Add GPIO ACPI mapping table" should
> > > also replace:
> > > 
> > > 	desc = gpiod_get_index(dev, info->name, info->acpi_index,
> > > GPIOD_ASIS);
> > > 
> > > with:
> > > 
> > > 	desc = gpiod_get(dev, info->name, GPIOD_ASIS);
> > > 
> > > At which point we can also drop the acpi_index field from the
> > > buttoninfo struct
> > > altogether.
> > > 
> > 
> > I was thinking about passing NULL as connection ID there as it's
> > done
> > for surface3 button array driver. In current soc-button-array we
> > have
> > file name passed for all of the pins, which is slightly informative.
> 
> No currently the button name, so "power", "volume-up", "volume-down"
> gets passed.

Because of my WIP patches? They have FIXME: in commit message where I'm
in doubt on the way to go. 

>  The only place where the file-name used to get passed
> is in the gpiod_count call, but you've replaced it with NULL there.

Yes.


> But passing NULL and removing the need for a mapping table is fine
> with me.

NULL sounds to me a bit clearer in this case, since the original name of
connection IDs with underscores, not dashes.

> > > I think that "extcon: int3496: Add GPIO ACPI mapping table" will
> > > need
> > > a similar change (I haven't tested it yet).
> > 
> > The mapping table converts Linux index, which you pass via
> > gpiod_get_index(), and _CRS index pair (resource, index in a list).
> > 
> > If it doesn't work that way, there is another bug then.
> 
> Hmm, so maybe this:
> 
> static const struct acpi_gpio_params power_gpios = { 0, 0, false };
> static const struct acpi_gpio_params home_gpios = { 1, 0, false };

> Needs to be like this then? :
> 
> static const struct acpi_gpio_params power_gpios = { 0, 0, false };
> static const struct acpi_gpio_params home_gpios = { 1, 1, false };

Obviously not.

Just really small pseudo ASL to consider:

_CRS:

GpioIo(...)  { pin #5 }
GpioIo(...)  { pin #3, pin #4, pin #2 }
GpioIo(...)  { pin #15 }

In Linux (for example) [index, connection ID]:

index 0  "reset"  (pin #2)
index 1  "func1"  (pin #4)
index 2  "func2"  (pin #3)
index 3  "enable" (pin #5)
index 4  "ready"  (pin #15)

Mapping Linux <-> _CRS (either from _DSD or hard coded mapping table):

index 0  pin #2    to 1,2
index 1  pin #4    to 1,1
index 2  pin #3    to 1,0
index 3  pin #5    to 0,0
index 4  pin #15   to 2,0

> In order for gpiod_get_index() to work ? Note that if we are going
> to use the mapping table I believe we really should just use
> gpiod_get (instead of gpiod_get_index) as the map also provides a
> name so the index is not necessary (I've tested that using
> gpiod_get() works fine with your current code).

See above, I think it makes picture clearer to understand the problems
we have.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
