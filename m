From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/4] gpio: make gpiod_count() API consistent
Date: Tue, 14 Mar 2017 10:49:37 +0100
Message-ID: <CACRpkdbrPf0Tomq7PWWoTbAUss+D8qVWctE_mPg9SkZu=JtLkQ@mail.gmail.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
 <20170227082735.GA2373@mail.corp.redhat.com> <1488275286.20145.49.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37511 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdCNJtt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 05:49:49 -0400
Received: by mail-it0-f43.google.com with SMTP id g138so47925699itb.0
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 02:49:43 -0700 (PDT)
In-Reply-To: <1488275286.20145.49.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Feb 28, 2017 at 10:48 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2017-02-27 at 09:27 +0100, Benjamin Tissoires wrote:
>> On Feb 20 2017 or thereabouts, Andy Shevchenko wrote:
>> > There are three possibilities in gpiod_count(): ACPI, OF, and
>> > platform data.
>> >
>> > Some of them return 0, which requires to be handled separately,
>> > though
>> > developers rather lazy and just shadow an actual error code.
>> >
>> > Let's make this API consistent by not allowing 0 in returned value.
>> >
>> > There are luckily only 3 users right now, one of them handles this
>> > properly, the rest is converted in this series.
>> >
>> > Series is supposed to go through GPIO tree.
>> >
>> > Andy Shevchenko (4):
>> >   gpio: acpi: Don't return 0 on acpi_gpio_count()
>> >   gpio: of: Don't return 0 on dt_gpio_count()
>> >   platform/x86: surface3_button: Propagate error from gpiod_count()
>> >   Input: soc_button_array - Propagate error from gpiod_count()
>>
>> Not sure if this still matters, but still:
>> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> I'm sure it is.
>
> Linus, is your plan to go through queue after merge window is closed?

Yes sorry for the delay, it was a busy merge window etc.

I'd like to have some nod from Mika/Rafael that this is what
we want to do. If I don't hear anything I guess I will just
merge them, it looks right to me.

Yours,
Linus Walleij
