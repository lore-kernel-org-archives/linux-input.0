From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: sample averaging for imx6ul_tsc
Date: Thu, 1 Dec 2016 10:13:43 -0600
Message-ID: <20161201161343.g7p2maxiatp4m5di@rob-hp-laptop>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480232698-23075-1-git-send-email-guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Nov 27, 2016 at 09:44:57AM +0200, Guy Shapiro wrote:
> The i.MX6UL internal touchscreen controller contains an option to
> average upon samples. This feature reduces noise from the produced
> touch locations.
> 
> This patch introduces a new device tree optional property for this
> feature. It provides control over the amount of averaged samples per
> touch event.
> 
> The property was inspired by a similar property on the
> "brcm,iproc-touchscreen" binding.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
> ---
>  .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> index 853dff9..a66069f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> @@ -17,6 +17,13 @@ Optional properties:
>    This value depends on the touch screen.
>  - pre-charge-time: the touch screen need some time to precharge.
>    This value depends on the touch screen.
> +- average-samples: Number of data samples which are averaged for each read.
> +	Valid values 0-4
> +	0 =  1 sample
> +	1 =  4 samples
> +	2 =  8 samples
> +	3 = 16 samples
> +	4 = 32 samples

Either this needs a vendor prefix or should be documented as a generic 
property. In the latter case, you should use actual number of samples 
(1-32) for the values.

>  
>  Example:
>  	tsc: tsc@02040000 {
> @@ -32,5 +39,6 @@ Example:
>  		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
>  		measure-delay-time = <0xfff>;
>  		pre-charge-time = <0xffff>;
> +		average-samples = <4>;
>  		status = "okay";
>  	};
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
