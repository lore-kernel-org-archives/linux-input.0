From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/4] Add device tree support to the cyttsp driver
Date: Wed, 27 Jan 2016 14:36:20 -0800
Message-ID: <20160127223620.GA3482@dtor-ws>
References: <cover.1453414661.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1453414661.git.oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 21, 2016 at 11:21:28PM +0100, Oreste Salerno wrote:
> Implement a number of updates for the cyttsp driver to be able to parse generic
> ACPI/of/static properties and drop support for platform data (no platform data
> user is present in the kernel tree).
> 

Applied all 4, thank you.

> ---
> Changes in v5:
>   Use custom devm action to turn off the chip
>   Make reset gpio and touchscreen size properties optional
> Changes in v4:
>   Major rework based on Dmitry's review:
>   - Use device_property_read() functions instead of of_property()
>   - Use touchscreen_parse_properties to parse common properties
>   - Drop support for platform data
>   - Used devres managed allocations
> Changes in v3:
>   - Rework binding names and descriptions
> Changes in v2:
>   - Fix err_cast.cocci warning in patch 2/3
> Oreste Salerno (4):
>   Input: cyttsp - use devres managed resource allocations
>   Input: cyttsp - check return value of input_mt_init_slots
>   Input: cyttsp - switch to using device properties
>   Input: cyttsp - perform hard reset of the chip during probe
> 
>  .../bindings/input/touchscreen/cyttsp.txt          |  95 ++++++++++
>  drivers/input/touchscreen/cyttsp_core.c            | 193 +++++++++++++--------
>  drivers/input/touchscreen/cyttsp_core.h            |  10 +-
>  drivers/input/touchscreen/cyttsp_i2c.c             |  10 --
>  drivers/input/touchscreen/cyttsp_spi.c             |  10 --
>  include/linux/input/cyttsp.h                       |  15 --
>  6 files changed, 228 insertions(+), 105 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> 
> -- 
> 1.9.1
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
