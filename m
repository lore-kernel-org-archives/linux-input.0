From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/PATCH 0/5] Support children for legacy device properties
Date: Mon, 17 Sep 2018 11:15:58 -0700
Message-ID: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

The generic device properties APIs are very helpful as they allow abstracting
away details of the platform (whether it is ACPI, device tree, or legacy board
file), so that individual driver does not need separate code paths to support
all variants. However there are drivers that currently can not use generic
device properties API as they need notion of children properties, for example
gpio_keys driver, that expects every button to be described as a sub-node of
main device.

This patch series introduces notion of sub-nodes for static properties and ties
it up with GPIO lookup tables so that they are usable with sub-nodes as well.

Thanks.

-- 
Dmitry
