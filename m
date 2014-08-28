From: "Murphy, Dan" <dmurphy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] doc: dt/bindings: input: introduce TI DRV2667
 haptic driver description
Date: Thu, 28 Aug 2014 19:51:30 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49E1B3F6@DFLE09.ent.ti.com>
References: <1408980413-8763-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Bump

On 08/25/2014 10:26 AM, Murphy, Dan wrote:
> DRV2667 is a haptic/vibrator driver for Linear Resonant Actuators.
> Adding dt binding for this part
> 
> Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
> ---
> 
> v2 - Removed extra tabs, changed node to function not device
> added vbat-supply, and removed confusing description - https://patchwork.kernel.org/patch/4759381/
> 
>  .../devicetree/bindings/input/ti,drv2667.txt       |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ti,drv2667.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/ti,drv2667.txt b/Documentation/devicetree/bindings/input/ti,drv2667.txt
> new file mode 100644
> index 0000000..996382c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,drv2667.txt
> @@ -0,0 +1,17 @@
> +* Texas Instruments - drv2667 Haptics driver
> +
> +Required properties:
> +	- compatible - "ti,drv2667" - DRV2667
> +	- reg -  I2C slave address
> +	- vbat-supply - Required supply regulator
> +
> +Example:
> +
> +haptics: haptics@59 {
> +	compatible = "ti,drv2667";
> +	reg = <0x59>;
> +	vbat-supply = <&vbat>;
> +};
> +
> +For more product information please see the link below:
> +http://www.ti.com/product/drv2667
> 


-- 
------------------
Dan Murphy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
