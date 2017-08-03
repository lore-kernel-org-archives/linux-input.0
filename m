From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Thu, 3 Aug 2017 12:50:13 -0500
Message-ID: <20170803175013.3a4kbotidleipkwe@rob-hp-laptop>
References: <1500510154-6661-1-git-send-email-anthony.kim@hideep.com>
 <1500965607-2446-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1500965607-2446-1-git-send-email-anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anthony Kim <ktyrun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 25, 2017 at 03:53:27PM +0900, Anthony Kim wrote:
> The HiDeep touchscreen device is a capacitive multi-touch controller
> mainly for multi-touch supported devices use. It use I2C interface for
> communication to IC and provide axis X, Y, Z locations for ten finger
> touch through input event interface to userspace.
> 
> It support the Crimson and the Lime two type IC. They are different
> the number of channel supported and FW size. But the working protocol
> is same.
> 
> Signed-off-by: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/hideep.txt          |  35 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +

For the binding,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/touchscreen/Kconfig                  |  11 +
>  drivers/input/touchscreen/Makefile                 |   2 +
>  drivers/input/touchscreen/hideep.h                 | 318 +++++++
>  drivers/input/touchscreen/hideep_core.c            | 916 +++++++++++++++++++++
>  drivers/input/touchscreen/hideep_dbg.c             | 405 +++++++++
>  drivers/input/touchscreen/hideep_dbg.h             |  24 +
>  drivers/input/touchscreen/hideep_isp.c             | 592 +++++++++++++
>  drivers/input/touchscreen/hideep_isp.h             |  96 +++
>  drivers/input/touchscreen/hideep_sysfs.c           | 245 ++++++
>  11 files changed, 2645 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>  create mode 100644 drivers/input/touchscreen/hideep.h
>  create mode 100644 drivers/input/touchscreen/hideep_core.c
>  create mode 100644 drivers/input/touchscreen/hideep_dbg.c
>  create mode 100644 drivers/input/touchscreen/hideep_dbg.h
>  create mode 100644 drivers/input/touchscreen/hideep_isp.c
>  create mode 100644 drivers/input/touchscreen/hideep_isp.h
>  create mode 100644 drivers/input/touchscreen/hideep_sysfs.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
