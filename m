From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 20/26] Input: synaptics-rmi4: Create common functions for
 2D sensors
Date: Mon, 9 Nov 2015 14:25:13 +0100
Message-ID: <CACRpkdb6VVrL3dndo5BB3VtfGQzEVoff=MN=7QYo8=K8a7NskA@mail.gmail.com>
References: <1446766925-31123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766925-31123-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> RMI4 defines two functions for 2D sensors. This patch moves some of the
> code which is shared between the two functions into a new file to avoid
> duplicating the code on rmi_f11.c and rmi_f12.c.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

>  .../bindings/input/rmi4/rmi_2d_sensor.txt          |  55 +++

Split off and send to devicetree@vger.kernel.org
I see you augmented the binding as I wanted it so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

>  drivers/input/rmi4/Kconfig                         |  11 +
>  drivers/input/rmi4/Makefile                        |   2 +
>  drivers/input/rmi4/rmi_2d_sensor.c                 | 370 ++++++++++++++++
>  drivers/input/rmi4/rmi_2d_sensor.h                 |  87 ++++
>  drivers/input/rmi4/rmi_f11.c                       | 487 +++++----------------
>  include/linux/rmi.h                                |  30 +-

Should this be squashed into the F11 and F12 driver patches and a big
F11+F12 patch come out instead? I think that is the best.

> +config RMI4_2D_SENSOR
> +       bool "RMI4 2D Sensors"
> +       depends on RMI4_CORE
> +       default y if RMI4_CORE
> +       help
> +         Say Y here if you want to add support for 2D Sensors.
> +
> +         Provides core functionality for 2D multifinger pointing for
> +         touchscreens and touchpads using RMI4 functions 11 and 12. This
> +         feature is needed is the device contains either F11 or F12.
> +
>  config RMI4_F11
>         bool "RMI4 Function 11 (2D pointing)"
>         depends on RMI4_CORE

Shouldn't F11 and F12 depend on RMI4_2D_SENSOR, or even select
it?

I think RMI4_2D_SENSOR should be hidden, i.e. just:

> +config RMI4_2D_SENSOR
> +       bool
> +       depends on RMI4_CORE

And then F11 and F12 select this hidden option.

Yours,
Linus Walleij
