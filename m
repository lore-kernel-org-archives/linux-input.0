From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Fri, 9 Mar 2018 17:27:21 -0600
Message-ID: <20180309232720.pmqaulifiqa5czul@rob-hp-laptop>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
 <20180308073213.8419-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308073213.8419-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de, dtor@google.com, dianders@google.com, devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 08, 2018 at 03:32:11PM +0800, Jeffy Chen wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
> 
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> Remove unneeded irq_wake flag as Andy suggested.
> 
> Changes in v4:
> Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.
> 
> Changes in v3:
> Adding more comments as Brian suggested.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  drivers/input/keyboard/gpio_keys.c    | 63 +++++++++++++++++++++++++++++++++--
>  include/dt-bindings/input/gpio-keys.h | 13 ++++++++

This file should be in the binding patch.

>  include/linux/gpio_keys.h             |  2 ++
>  3 files changed, 75 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/input/gpio-keys.h
