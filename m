From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Wed, 8 Mar 2017 18:05:08 +0100
Message-ID: <654981a1-2493-01d6-13e6-1287b70e22f2@redhat.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
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
 <1488973582.20145.125.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2B178A2C319D0FDC5E78707D"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbdCHRFj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 8 Mar 2017 12:05:39 -0500
In-Reply-To: <1488973582.20145.125.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

This is a multi-part message in MIME format.
--------------2B178A2C319D0FDC5E78707D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08-03-17 12:46, Andy Shevchenko wrote:
> On Wed, 2017-03-08 at 12:27 +0100, Hans de Goede wrote:
>> On 08-03-17 11:30, Andy Shevchenko wrote:
>>> On Wed, 2017-03-08 at 10:08 +0100, Hans de Goede wrote:
>>>> On 07-03-17 14:55, Hans de Goede wrote:
>
>
>>>> I did not get around
>>>> to actually test if the fix the silead issue (I believe they will)
>>>> as
>>>> I
>>>> started testing on a cht device and looking if soc_button_array
>>>> still
>>>> works with your patches applied.
>>>>
>>>> Unfortunately it no longer works, there are 2 problems:
>>>>
>>>> 1) "Input: soc_button_array - Add GPIO ACPI mapping table" should
>>>> also replace:
>>>>
>>>> 	desc = gpiod_get_index(dev, info->name, info->acpi_index,
>>>> GPIOD_ASIS);
>>>>
>>>> with:
>>>>
>>>> 	desc = gpiod_get(dev, info->name, GPIOD_ASIS);
>>>>
>>>> At which point we can also drop the acpi_index field from the
>>>> buttoninfo struct
>>>> altogether.
>>>>
>>>
>>> I was thinking about passing NULL as connection ID there as it's
>>> done
>>> for surface3 button array driver. In current soc-button-array we
>>> have
>>> file name passed for all of the pins, which is slightly informative.
>>
>> No currently the button name, so "power", "volume-up", "volume-down"
>> gets passed.
>
> Because of my WIP patches? They have FIXME: in commit message where I'm
> in doubt on the way to go.

Ah yes that is changed in your WIP patches I did not notice before.

>>  The only place where the file-name used to get passed
>> is in the gpiod_count call, but you've replaced it with NULL there.
>
> Yes.
>
>
>> But passing NULL and removing the need for a mapping table is fine
>> with me.
>
> NULL sounds to me a bit clearer in this case, since the original name of
> connection IDs with underscores, not dashes.

Ok, so pass NULL and then drop the patch to add the mapping table,
because with a NULL con-id that won't be necessary right ?

I've just given this a spin (patch to pass NULl attached), your
patch to add the GPIO ACPI mapping table dropped and this works well
I agree just passing NULL as con-id is the better solution for
soc_button_array.

>>>> I think that "extcon: int3496: Add GPIO ACPI mapping table" will
>>>> need
>>>> a similar change (I haven't tested it yet).

So I assume you want to do the same (pass NULL as con-id to
gpiod_get_index()) for the extcon-in3496 driver or do you want
to keep the GPIO ACPI mapping table there?

>>>
>>> The mapping table converts Linux index, which you pass via
>>> gpiod_get_index(), and _CRS index pair (resource, index in a list).
>>>
>>> If it doesn't work that way, there is another bug then.
>>
>> Hmm, so maybe this:
>>
>> static const struct acpi_gpio_params power_gpios = { 0, 0, false };
>> static const struct acpi_gpio_params home_gpios = { 1, 0, false };
>
>> Needs to be like this then? :
>>
>> static const struct acpi_gpio_params power_gpios = { 0, 0, false };
>> static const struct acpi_gpio_params home_gpios = { 1, 1, false };
>
> Obviously not.
>
> Just really small pseudo ASL to consider:
>
> _CRS:
>
> GpioIo(...)  { pin #5 }
> GpioIo(...)  { pin #3, pin #4, pin #2 }
> GpioIo(...)  { pin #15 }
>
> In Linux (for example) [index, connection ID]:
>
> index 0  "reset"  (pin #2)
> index 1  "func1"  (pin #4)
> index 2  "func2"  (pin #3)
> index 3  "enable" (pin #5)
> index 4  "ready"  (pin #15)
>
> Mapping Linux <-> _CRS (either from _DSD or hard coded mapping table):
>
> index 0  pin #2    to 1,2
> index 1  pin #4    to 1,1
> index 2  pin #3    to 1,0
> index 3  pin #5    to 0,0
> index 4  pin #15   to 2,0
>
>> In order for gpiod_get_index() to work ? Note that if we are going
>> to use the mapping table I believe we really should just use
>> gpiod_get (instead of gpiod_get_index) as the map also provides a
>> name so the index is not necessary (I've tested that using
>> gpiod_get() works fine with your current code).
>
> See above, I think it makes picture clearer to understand the problems
> we have.

Yes it does, now I understand why there are 2 indexes in
struct acpi_gpio_params.

Regards,

Hans


--------------2B178A2C319D0FDC5E78707D
Content-Type: text/x-patch;
 name="0001-Input-soc_button_array-use-NULL-for-GPIO-connection-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Input-soc_button_array-use-NULL-for-GPIO-connection-.pa";
 filename*1="tch"

>From 26f2b4ef3c867c7a7c9a17738219a1f7cc656bb7 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 8 Mar 2017 18:00:08 +0100
Subject: [PATCH v3] Input: soc_button_array: use NULL for GPIO connection ID

The gpiolib-acpi code is becoming more strict and connection-IDs
may only be used with devices which have a _DSD with matching IDs
in there. Since the soc_button_array ACPI binding is pure index
based pass in NULL as connection-ID to avoid the more strict cheks
resulting in gpiod_get_infex not returning any gpios.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 8d1c5f4..c9c492e 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -48,7 +48,7 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
 	struct gpio_desc *desc;
 	int gpio;
 
-	desc = gpiod_get_index(dev, KBUILD_MODNAME, acpi_index, GPIOD_ASIS);
+	desc = gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.9.3


--------------2B178A2C319D0FDC5E78707D--
