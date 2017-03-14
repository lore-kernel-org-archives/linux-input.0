From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] tps6507x-ts: add DT bindings description
Date: Tue, 14 Mar 2017 16:46:40 +0000
Message-ID: <20170314164640.sebijnp3b7jpgimu@dell>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
 <1487950946-18590-4-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35915 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdCNQqp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 12:46:45 -0400
Received: by mail-wm0-f53.google.com with SMTP id n11so68654995wma.1
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 09:46:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1487950946-18590-4-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com

On Fri, 24 Feb 2017, yegorslists@googlemail.com wrote:

> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Provide description for following properties:
> 
> - ti,poll-period
> - ti,min-pressure
> - ti,vendor
> - ti,product
> - ti,version
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  Documentation/devicetree/bindings/mfd/tps6507x.txt | 30 ++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> index 8fffa3c..eb654ef 100644
> --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
> +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> @@ -1,4 +1,8 @@
> -TPS6507x Power Management Integrated Circuit
> +TPS6507x Multifunctional Device.
> +
> +Features provided by TPS6507x:
> +        1. Power Management Integrated Circuit.
> +        2. Touch-Screen.
>  
>  Required properties:
>  - compatible: "ti,tps6507x"
> @@ -30,6 +34,23 @@ Regulator Optional properties:
>  			1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
>    If this property is not defined, it defaults to 0 (not enabled).
>  
> +Touchscreen Optional properties:
> +- ti,poll-period: Time at which touch input is getting sampled in ms.
> +		  Default value: 30 ms.
> +- ti,min-pressure: Minimum pressure value to trigger touch.
> +		   Default value: 0x30.
> +		   This property has to be a '/bits/ 16' value
> +
> +Entries below describe the input_id structure [1] for the touch device:
> +- ti,vendor: Touchscreen vendor id.
> +	     This property has to be a '/bits/ 16' value
> +- ti,product: Touchscreen product id.
> +	      This property has to be a '/bits/ 16' value
> +- ti,version: Touchscreen version id.
> +	      This property has to be a '/bits/ 16' value
> +
> +[1] include/uapi/linux/input.h
> +

I think this should live in the touchscreen binding doc.

>  Example:
>  
>  	pmu: tps6507x@48 {
> @@ -40,6 +61,12 @@ Example:
>  		vindcdc3-supply = <...>;
>  		vinldo1_2-supply = <...>;
>  
> +		ti,poll-period = <30>;
> +		ti,min-pressure = /bits/ 16 <0x30>;
> +		ti,vendor = /bits/ 16 <0>;
> +		ti,product = /bits/ 16 <65070>;
> +		ti,version = /bits/ 16 <0x100>;
> +
>  		regulators {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -87,5 +114,4 @@ Example:
>  				regulator-boot-on;
>  			};
>  		};
> -
>  	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
