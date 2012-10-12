From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] input: gpio-keys: Add runtime support
Date: Fri, 12 Oct 2012 23:09:30 +0200
Message-ID: <CACRpkdb+kWW903VD45i5s_LrZ2BKX=k6enGP2R9v2ptSRkvJ9w@mail.gmail.com>
References: <1349964927-18619-1-git-send-email-lee.jones@linaro.org>
	<1349964927-18619-2-git-send-email-lee.jones@linaro.org>
	<CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43462 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2JLVJb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:09:31 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so3962190vcb.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:09:31 -0700 (PDT)
In-Reply-To: <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Jonas Aaberg <jonas.aberg@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Philippe Langlais <philippe.langlais@linaro.org>

On Thu, Oct 11, 2012 at 4:22 PM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:

>> @@ -526,6 +527,7 @@ static int gpio_keys_open(struct input_dev *input)
>>  {
>>         struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
>>
>> +       pm_runtime_get_sync(input->dev.parent);
>
> I am not an expert of the runtime.
>
> However would be grateful if you explain me what it actually do.

This increase the reference count of the runtime status container
for the device. _sync makes sure it happens now.

Consult:
Documentation/power/runtime_pm.txt

> Also I did not see any runtime suspend/ resume handlers populated.

It is not necessary to handle the power state at the driver level,
it can just as well be handled by the voltage/power domain,
or at the class, type or bus level.

But the individual driver has to notify the system upward if it
needs to be powered on or when it may or must be relaxed.

Yours,
Linus Walleij
