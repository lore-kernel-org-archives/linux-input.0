From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/10 v4] Input: ep93xx_keypad: Fix platform_get_irq's
 error checking
Date: Mon, 20 Nov 2017 08:48:40 -0800
Message-ID: <CAKdAkRQwuTgupMtSs_BmDNDDnW78z8vm9s41BcOHmDiKR3uPHw@mail.gmail.com>
References: <987ac156e9590cbe2f667f9782b56515d7a991a4.1511194239.git.arvind.yadav.cs@gmail.com>
 <20171120162941.GD31757@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37503 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdKTQsm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Nov 2017 11:48:42 -0500
In-Reply-To: <20171120162941.GD31757@n2100.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Wan ZongShun <mcuos.com@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, Nov 20, 2017 at 8:29 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Nov 20, 2017 at 09:56:21PM +0530, Arvind Yadav wrote:
>> The platform_get_irq() function returns negative if an error occurs.
>> zero or positive number on success. platform_get_irq() error checking
>> for zero is not correct.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>> changes in v2 :
>>               Return keypad->irq insted of -ENXIO.
>> changes in v3 :
>>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
>> changes ib v4 :
>>               Return -ENXIO insted of keypad->irq. Which was not correct in v3.
>>
>>  drivers/input/keyboard/ep93xx_keypad.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
>> index f77b295..c6eb31a 100644
>> --- a/drivers/input/keyboard/ep93xx_keypad.c
>> +++ b/drivers/input/keyboard/ep93xx_keypad.c
>> @@ -257,7 +257,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>>       }
>>
>>       keypad->irq = platform_get_irq(pdev, 0);
>> -     if (!keypad->irq) {
>> +     if (keypad->irq <= 0) {
>>               err = -ENXIO;
>
> Still not right.
>
>                 err = keypad->irq < 0 ? keypad->irq : -ENXIO;
>
> would have the right effect.
>
> However, I disagree with the idea of making platform_get_irq() return
> an error if there is a zero irq specified as suggested in a previous
> review - zero means "not present" and that is not necessarily an error -
> it's up to the driver to decide whether it can proceed without an
> interrupt, or whether it should error out on the probe function.

We used to return 0 from platform_get_irq() in early 2.6 days on
errors but not anymore and I do not think keeping treating 0 there as
special makes much sense.

We already return -ENXIO for missing resources, and I do not think
that anyone actually defines IRQ resource with 0 number and attaches
it to devices in home that drivers would recognize it as missing
interrupt and work without it. Also, in case of DT we do not recognize
IRQ 0 as valid and try to fetch it from other sources (static board
data), I think ACPI is similar.

I think we should also return -ENXIO in case of res->start == 0 and
leave it to the driver to check and decide if it wants to deal with
missing interrupt. Most of them do not.


Thanks.

-- 
Dmitry
