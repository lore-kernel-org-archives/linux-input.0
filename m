From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 03/10] Documentation: devicetree: thermal: da9062/61
 TJUNC temperature binding
Date: Mon, 28 Nov 2016 16:59:28 -0800
Message-ID: <20161129005927.GA1848@localhost.localdomain>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <d8c986e39bafc2b8a1c5c23e722f61cdd021e9be.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d8c986e39bafc2b8a1c5c23e722f61cdd021e9be.1477501000.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 26, 2016 at 05:56:37PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> Device tree binding information for DA9062 and DA9061 thermal junction
> temperature monitor.
> 
> Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
> device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for
> a configurable polling period for over-temperature polling.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 08/10] to [PATCH V2 03/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - A second example for DA9061 is provided to highlight the use of a
>    fall-back compatible option for the DA9062 watchdog driver
> 
> Hi,
> 
> This patch depends on acceptance of the main code for the thermal device
> driver:
>   [PATCH V2 09/10] thermal: da9061: TJUNC temperature driver 
> 
> The previous [PATCH V1 08/10] was acked-by: Rob Herring, however this has
> not been added because changes have been made to add a new binding
> example. This describes the use of DA9061.
> This addition was made after alterations to the device driver meant that a
> fall-back compatible string could reuse the DA9062 device driver.
>  
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  .../devicetree/bindings/thermal/da9062-thermal.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> new file mode 100644
> index 0000000..fb207ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> @@ -0,0 +1,37 @@
> +* Dialog DA9062/61 TJUNC Thermal Module
> +
> +This module is part of the DA9061/DA9062. For more details about entire
> +DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
> +
> +Junction temperature thermal module uses an interrupt signal to identify
> +high THERMAL_TRIP_HOT temperatures for the PMIC device.
> +
> +Required properties:
> +
> +- compatible: should be one of:
> +        dlg,da9061-thermal
> +        dlg,da9062-thermal
> +
> +Optional properties:
> +
> +- dlg,tjunc-temp-polling-period-ms : Specify the polling period, measured
> +    in milliseconds, between thermal zone device update checks.


Can you please elaborate on why you need this chip manufacture specific property?

Can we use the polling property of already existing in the 
Documentation/devicetree/bindings/thermal/thermal.txt

See the polling properties.

> +
> +Example: DA9061
> +
> +	pmic0: da9062@58 {
> +		thermal {
> +			compatible = "dlg,da9062-thermal";
> +			dlg,tjunc-temp-polling-period-ms = <3000>;

Same

> +		};
> +	};
> +
> +Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
> +
> +	pmic0: da9061@58 {
> +		thermal {
> +			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
> +			dlg,tjunc-temp-polling-period-ms = <3000>;

Same 
> +		};
> +	};
> +
> -- 
> end-of-patch for PATCH V2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
