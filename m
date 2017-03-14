From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Tue, 14 Mar 2017 11:21:59 +0100
Message-ID: <CACRpkdbkUGcR7bd5bP18yPYH4FeDmMj6+=kdX4bEtnTQWq24tg@mail.gmail.com>
References: <20170201174257.GE40045@dtor-ws> <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com> <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com> <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
 <20170202131251.GQ2053@lahna.fi.intel.com> <cf8dab24-7aeb-07f1-2018-a96cc3dfc37e@redhat.com>
 <20170202134439.GS2053@lahna.fi.intel.com> <b9a6a4d7-a6c9-ca0e-41d3-98039352471c@redhat.com>
 <20170202141803.GW2053@lahna.fi.intel.com> <8786dd51-de5d-3042-2620-5124eec83359@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:34976 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdCNKWC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 06:22:02 -0400
Received: by mail-it0-f43.google.com with SMTP id m27so44350179iti.0
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 03:22:01 -0700 (PDT)
In-Reply-To: <8786dd51-de5d-3042-2620-5124eec83359@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Linux Input <linux-input@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Thu, Feb 2, 2017 at 3:24 PM, Gregor Riepl <onitake@gmail.com> wrote:

>> I suppose the Windows driver just works everywhere, right?
>
> Not really, no.
> AFAIK every vendor builds their own driver using a special configuration
> utility from Silead.
> All the device-specific data, including panel parameters and calibration
> data, is compiled into this driver.

Isn't that just defeating the whole purpose of ACPI (or any other
hardware description)?

Isn't the idea to describe all this in ACPI tables, and that is what the
vendor should be doing rather than compiling in hardcoded things
into drivers?

I just see this as another sign that the ACPI "ecosystem" is not
really working because vendors choose to arbitrarily bypass it like
this.

Is it too hard for them to use ACPI or is ACPI lacking the right
parameters to tweak or what is the real problem?

Yours,
Linus Walleij
