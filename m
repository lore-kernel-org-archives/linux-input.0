From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 06/10] Documentation: dt: input: temperature driver
Date: Mon, 10 Oct 2016 08:37:18 -0500
Message-ID: <20161010133718.GA9643@rob-hp-laptop>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <313a15d14dd20a8cb8ac99a4cd423798343c5b65.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <313a15d14dd20a8cb8ac99a4cd423798343c5b65.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 06, 2016 at 09:43:30AM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>

The subject is wrong.

> 
> Add binding information for DA9061 onkey.
> 
> This patch updates the compatible string "dlg,da9061-onkey" to support
> DA9061, removes ther reference to KEY_SLEEP (which the driver no longer

s/ther/the/

> supports) and fixes a typo in the example.

Why is KEY_SLEEP being removed?

> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> Hi,
> 
> This patch depends on the acceptance of the main code for the onkey:
>   [PATCH V1 3/10] Input: da9061: onkey driver.
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  .../devicetree/bindings/input/da9062-onkey.txt        | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
> index ab0e048..ce45436 100644
> --- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
> +++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
> @@ -1,28 +1,27 @@
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
>  Example:
>  
> -	pmic0: da9062@58 {
> +	pmic0: da9063@58 {
>  
>  		onkey {
>  			compatible = "dlg,da9063-onkey";
> -- 
> end-of-patch for PATCH V1
> 
