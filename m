From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] input: touchscreen: Add support for Elan eKTF2127
 touchscreen controller
Date: Fri, 2 Sep 2016 09:09:35 -0500
Message-ID: <20160902140935.GA19453@rob-hp-laptop>
References: <20160828160005.20415-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160828160005.20415-1-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Siebren Vroegindeweij <siebren.vroegindeweij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, Aug 28, 2016 at 06:00:05PM +0200, Hans de Goede wrote:
> From: Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
> 
> This adds a driver for the Elan eKTF2127 touchscreen controller,
> which speaks an i2c protocol which is distinctly different from
> the already supported eKTH controllers.
> 
> Signed-off-by: Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> -Improve devicetree bindings document
> -Use touchscreen_parse_properties and touchscreen_report_pos instead of DIY
> -Remove a bunch of unused defines (copy and paste leftover from chipone driver)
> -Some other minor cleanups and review comments addressed
> -Add defines for some command / address hex-values
> -Check packet header in interrupt handler
> ---
>  .../bindings/input/touchscreen/ektf2127.txt        |  27 ++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/ektf2127.c               | 333 +++++++++++++++++++++
>  4 files changed, 373 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
>  create mode 100644 drivers/input/touchscreen/ektf2127.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
