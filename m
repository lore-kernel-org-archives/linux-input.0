From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 01/10] Documentation: devicetree: input: additions for
 da9061 onkey driver
Date: Sun, 30 Oct 2016 23:15:55 -0500
Message-ID: <20161031041555.y5l3qxo6b774hxfz@rob-hp-laptop>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <e85c9e4723ea7e7bff32d7a4c92807439b438c6d.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e85c9e4723ea7e7bff32d7a4c92807439b438c6d.1477501000.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 26, 2016 at 05:56:37PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> Add binding information for DA9061 onkey.
> 
> This patch updates the compatible string "dlg,da9061-onkey" to support
> DA9061, removes the reference to KEY_SLEEP (which the driver no longer
> supports) and fixes a typo in the example for DA9063.
> 
> It also adds two new examples, one for DA9062 and one for DA9061. The
> DA9061 examples uses a fall-back compatible string for the DA9062 onkey
> driver.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 06/10] to [PATCH V2 01/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Typo s/ther/the/ in commit message
>  - Explanation about why KEY_SLEEP was removed (see below)
>  - Addition of DA9062 example
>  - Addition of a DA9061 example to follow the driver fall-back compatible
>    convention being applied for this device driver
> 
> Hi,
> 
> This patch depends on the acceptance of the main code for the onkey:
>   [PATCH V2 07/10] Input: da9061: onkey driver.

Just FYI, not really. While common practice is we take the whole series 
together bindings could come first without a driver.

> The device driver no longer supports KEY_SLEEP. It only supports
> KEY_POWER. This change was sent a while ago for the DA9063 ONKEY driver,
> but the docs were not updated.
> 
> Supporting KEY_SLEEP was not the general convention and the typical
> solution should have been for KEY_POWER to support both cases of suspend
> and S/W power off.

This info will be lost when applied. You should add it to the commit 
message.

> 
> There is also new binding examples for DA9062 and DA9061. Importantly,
> the Linux device driver changes for DA9061 were rejected because the
> DA9062 device driver can be reused. For this reason, the DA9061 example
> uses a fall-back compatible string.
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  .../devicetree/bindings/input/da9062-onkey.txt     | 39 +++++++++++++++-------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
> index ab0e048..e5a0469 100644
> --- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
> +++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
> @@ -1,32 +1,47 @@
> -* Dialog DA9062/63 OnKey Module
> +* Dialog DA9061/62/63 OnKey Module
>  
> -This module is part of the DA9062/DA9063. For more details about entire
> -chips see Documentation/devicetree/bindings/mfd/da9062.txt and
> -Documentation/devicetree/bindings/mfd/da9063.txt
> +This module is part of the DA9061/DA9062/DA9063. For more details about entire
> +DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
> +For DA9063 see Documentation/devicetree/bindings/mfd/da9063.txt
>  
> -This module provides KEY_POWER, KEY_SLEEP and events.
> +This module provides the KEY_POWER event.
>  
>  Required properties:
>  
>  - compatible: should be one of:
> +	dlg,da9061-onkey

This needs to list the fallback too. It's below, but each line should be 
valid combinations of compatible strings.

>  	dlg,da9062-onkey
>  	dlg,da9063-onkey
>  
>  Optional properties:
>  
> -  - dlg,disable-key-power : Disable power-down using a long key-press. If this
> +- dlg,disable-key-power : Disable power-down using a long key-press. If this
>      entry exists the OnKey driver will remove support for the KEY_POWER key
> -    press. If this entry does not exist then by default the key-press
> -    triggered power down is enabled and the OnKey will support both KEY_POWER
> -    and KEY_SLEEP.
> +    press when triggered using a long press of the OnKey.
>  
> -Example:
> -
> -	pmic0: da9062@58 {
> +Example: DA9063
>  
> +	pmic0: da9063@58 {
>  		onkey {
>  			compatible = "dlg,da9063-onkey";
>  			dlg,disable-key-power;
>  		};
> +	};
> +
> +Example: DA9062
> +
> +	pmic0: da9062@58 {
> +		onkey {
> +			compatible = "dlg,da9062-onkey";
> +			dlg,disable-key-power;
> +		};
> +	};
> +
> +Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
>  
> +	pmic0: da9061@58 {
> +		onkey {
> +			compatible = "dlg,da9061-onkey", "dlg,da9062-onkey";
> +			dlg,disable-key-power;
> +		};
>  	};
> -- 
> end-of-patch for PATCH V2
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
