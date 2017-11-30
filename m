From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/5] Make gpio_keys accept board descriptors
Date: Thu, 30 Nov 2017 16:44:05 +0100
Message-ID: <CACRpkdYCn0EuJSXgzEq3+OFpxPtSkO8AEECnusXympAvmdE9cA@mail.gmail.com>
References: <20171124093045.5961-1-linus.walleij@linaro.org> <20171125233324.afdt4netamvkrkm2@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:45051 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdK3PoG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Nov 2017 10:44:06 -0500
Received: by mail-it0-f68.google.com with SMTP id b5so8805880itc.3
        for <linux-input@vger.kernel.org>; Thu, 30 Nov 2017 07:44:06 -0800 (PST)
In-Reply-To: <20171125233324.afdt4netamvkrkm2@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sun, Nov 26, 2017 at 12:33 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I think this is a worthy goal, but I wonder if we could get static GPIO
> descriptors work with fwnode_get_named_gpiod()

I think that will just work, I can try it on something and see.

> so we could retire the
> platform data parsing altogether. We'd need to extend static device
> properties to have notion of children though.

So we are talking about these static device properties I assume?

/**
 * struct gpiod_lookup - lookup table
 * @chip_label: name of the chip the GPIO belongs to
 * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
 * @con_id: name of the GPIO from the device's point of view
 * @idx: index of the GPIO in case several GPIOs share the same name
 * @flags: mask of GPIO_* values
 *
 * gpiod_lookup is a lookup table for associating GPIOs to specific devices and
 * functions using platform data.
 */
struct gpiod_lookup {
        const char *chip_label;
        u16 chip_hwnum;
        const char *con_id;
        unsigned int idx;
        enum gpio_lookup_flags flags;
};

struct gpiod_lookup_table {
        struct list_head list;
        const char *dev_id;
        struct gpiod_lookup table[];
};

The fact that keys are modeled as children in DTS/ACPI DSDT
more of a pecularity to these description languages
providing opaque configuration nodes.

E.g. these children reflects struct gpio_keys_button being a child of
struct gpio_keys_platform_data in the board files. But
it is only one device, "gpio-keys" in the Linux device
model. The buttons/keys are not devices.

Likewise, in device tree the buttons are not really
devices under the "gpio-keys" device, they are just property
nodes in the device tree conveniently set in a hierarchy to
contain the information. I bet ACPI works the same.

Since GPIO descriptors (like clocks, regulators ...) are
associated with the device, this becomes problematic: these
children are not devices. So they need to be associated
with the device to begin with.

In that case, I would opt to just use the
unsigned int idx field for determining child number from
the descriptor table, use con_id for naming the child and
we are back at essentially the same structure as a backend
for fwnode.

Due to the complexity of fwnode requireing an entire
parser for fwnode_operations etc it's a bit of heavy lifting
so I need to think and experiment some more.

Yours,
Linus Walleij
