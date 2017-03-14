From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] gpio: acpi: Don't return 0 on acpi_gpio_count()
Date: Tue, 14 Mar 2017 10:43:02 +0100
Message-ID: <CACRpkdYcPnh-2JLA658RW1RmTcMtRORkDrWe8pgEtmKXE-XSWQ@mail.gmail.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com> <20170220161549.39490-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35046 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdCNJnE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 05:43:04 -0400
Received: by mail-it0-f54.google.com with SMTP id m27so43865652iti.0
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 02:43:03 -0700 (PDT)
In-Reply-To: <20170220161549.39490-2-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Feb 20, 2017 at 5:15 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It's unusual to have error checking like (ret <= 0) in cases when
> counting GPIO resources. In case when it's mandatory we propagate the
> error (-ENOENT), otherwise we don't use the result.
>
> This makes consistent behaviour across all possible variants called in
> gpiod_count().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Mika/Rafael, can you look at this patch?

(Andy: sorry for late reply, busy merge window...)

Yours,
Linus Walleij
