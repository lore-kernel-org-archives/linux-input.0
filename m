From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC/PATCH 0/5] Support children for legacy device properties
Date: Tue, 18 Sep 2018 22:05:24 +0200
Message-ID: <5ab2968e-8ba5-adea-7862-3e9114623d63@intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On 9/17/2018 8:15 PM, Dmitry Torokhov wrote:
> The generic device properties APIs are very helpful as they allow abstracting
> away details of the platform (whether it is ACPI, device tree, or legacy board
> file), so that individual driver does not need separate code paths to support
> all variants. However there are drivers that currently can not use generic
> device properties API as they need notion of children properties, for example
> gpio_keys driver, that expects every button to be described as a sub-node of
> main device.
>
> This patch series introduces notion of sub-nodes for static properties and ties
> it up with GPIO lookup tables so that they are usable with sub-nodes as well.

I don't have any objections against this series.

Thanks,
Rafael
