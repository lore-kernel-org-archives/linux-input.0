From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] dt: add cap11xx LED documentation
Date: Mon, 22 Jun 2015 10:59:14 -0700
Message-ID: <20150622175914.GA15851@dtor-ws>
References: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
 <1434599897-22505-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35465 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbbFVR7T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2015 13:59:19 -0400
Content-Disposition: inline
In-Reply-To: <1434599897-22505-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: zonque@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Jun 17, 2015 at 08:58:16PM -0700, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  .../devicetree/bindings/input/cap11xx.txt          | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
> index 7d0a300..09cdc43 100644
> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
> @@ -38,6 +38,11 @@ Optional properties:
>  				defaults. The array must have exactly six
>  				entries.
>  
> +	linux,led-brightness:	Defines the ON brightness when the optional LED
> +				functionality is used. Valid values are 1-15.
> +				By default a value of 15 is set.

Please mention the device does not allow controlling brightness of leds
individually and that is why this property is at device level, not
individual led level.

Also, why does it have "linux" prefix? It does not appear to control
any linux-specific functionality.

> +
> +
>  Example:
>  
>  i2c_controller {
> @@ -55,5 +60,25 @@ i2c_controller {
>  				 <105>,		/* KEY_LEFT */
>  				 <109>,		/* KEY_PAGEDOWN */
>  				 <104>;		/* KEY_PAGEUP */
> +
> +		linux,led-brightness = <15>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usr@0 {
> +			label = "cap11xx:green:usr0";
> +			reg = <0>;
> +		};
> +
> +		usr@1 {
> +			label = "cap11xx:green:usr1";
> +			reg = <1>;
> +		};
> +
> +		alive@2 {
> +			label = "cap11xx:green:alive";
> +			reg = <2>;
> +			linux,default_trigger = "heartbeat";
> +		};
>  	};
>  }
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
