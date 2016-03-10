From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 01/10] Input: synaptics-rmi4: Add support for
 Synaptics RMI4 devices
Date: Thu, 10 Mar 2016 15:43:10 -0800
Message-ID: <20160310234310.GA22661@dtor-ws>
References: <1455143005-10060-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455143005-10060-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 10, 2016 at 02:23:25PM -0800, Andrew Duggan wrote:
> Synaptics uses the Register Mapped Interface (RMI) protocol as a
> communications interface for their devices. This driver adds the core
> functionality needed to interface with RMI4 devices.
> 
> RMI devices can be connected to the host via several transport protocols
> and can supports a wide variety of functionality defined by RMI functions.
> Support for transport protocols and RMI functions are implemented in
> individual drivers. The RMI4 core driver uses a bus architecture to
> facilitate the various combinations of transport and function drivers
> needed by a particular device.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> ---
>  drivers/input/Kconfig           |    2 +
>  drivers/input/Makefile          |    2 +
>  drivers/input/rmi4/Kconfig      |   10 +
>  drivers/input/rmi4/Makefile     |    2 +
>  drivers/input/rmi4/rmi_bus.c    |  375 ++++++++++++++
>  drivers/input/rmi4/rmi_bus.h    |  186 +++++++
>  drivers/input/rmi4/rmi_driver.c | 1027 +++++++++++++++++++++++++++++++++++++++
>  drivers/input/rmi4/rmi_driver.h |  103 ++++
>  drivers/input/rmi4/rmi_f01.c    |  574 ++++++++++++++++++++++
>  include/linux/rmi.h             |  209 ++++++++
>  include/uapi/linux/input.h      |    1 +
>  11 files changed, 2491 insertions(+)
>  create mode 100644 drivers/input/rmi4/Kconfig
>  create mode 100644 drivers/input/rmi4/Makefile
>  create mode 100644 drivers/input/rmi4/rmi_bus.c
>  create mode 100644 drivers/input/rmi4/rmi_bus.h
>  create mode 100644 drivers/input/rmi4/rmi_driver.c
>  create mode 100644 drivers/input/rmi4/rmi_driver.h
>  create mode 100644 drivers/input/rmi4/rmi_f01.c
>  create mode 100644 include/linux/rmi.h
> 
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index a35532e..6261874 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -201,6 +201,8 @@ source "drivers/input/touchscreen/Kconfig"
>  
>  source "drivers/input/misc/Kconfig"
>  
> +source "drivers/input/rmi4/Kconfig"
> +
>  endif
>  
>  menu "Hardware I/O ports"
> diff --git a/drivers/input/Makefile b/drivers/input/Makefile
> index 0c9302c..595820b 100644
> --- a/drivers/input/Makefile
> +++ b/drivers/input/Makefile
> @@ -26,3 +26,5 @@ obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
>  obj-$(CONFIG_INPUT_MISC)	+= misc/
>  
>  obj-$(CONFIG_INPUT_APMPOWER)	+= apm-power.o
> +
> +obj-$(CONFIG_RMI4_CORE)		+= rmi4/
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> new file mode 100644
> index 0000000..5ea60e3
> --- /dev/null
> +++ b/drivers/input/rmi4/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# RMI4 configuration
> +#
> +config RMI4_CORE
> +	tristate "Synaptics RMI4 bus support"
> +	help
> +	  Say Y here if you want to support the Synaptics RMI4 bus.  This is
> +	  required for all RMI4 device support.
> +
> +	  If unsure, say Y.
> diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
> new file mode 100644
> index 0000000..12f2197
> --- /dev/null
> +++ b/drivers/input/rmi4/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_RMI4_CORE) += rmi_core.o
> +rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> new file mode 100644
> index 0000000..78922a6
> --- /dev/null
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -0,0 +1,375 @@
> +/*
> + * Copyright (c) 2011-2016 Synaptics Incorporated
> + * Copyright (c) 2011 Unixphere
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/kconfig.h>
> +#include <linux/list.h>
> +#include <linux/pm.h>
> +#include <linux/rmi.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include "rmi_bus.h"
> +#include "rmi_driver.h"
> +
> +int debug_flags;

Changed to static.

> +module_param(debug_flags, int, 0444);

Changed to 0644 - there is no reason why we can't change flags at
runtime.

Thanks.

-- 
Dmitry
