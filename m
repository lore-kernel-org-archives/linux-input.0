From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v5 1/2] dt: add cap11xx LED documentation
Date: Thu, 18 Jun 2015 08:49:01 +0200
Message-ID: <558269DD.1060901@samsung.com>
References: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
 <1434599897-22505-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:25884 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbFRGtF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jun 2015 02:49:05 -0400
In-reply-to: <1434599897-22505-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: zonque@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org

Hi Matt,

On 06/18/2015 05:58 AM, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>   .../devicetree/bindings/input/cap11xx.txt          | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
> index 7d0a300..09cdc43 100644
> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
> @@ -38,6 +38,11 @@ Optional properties:
>   				defaults. The array must have exactly six
>   				entries.
>
> +	linux,led-brightness:	Defines the ON brightness when the optional LED
> +				functionality is used. Valid values are 1-15.
> +				By default a value of 15 is set.
> +
> +
>   Example:
>
>   i2c_controller {
> @@ -55,5 +60,25 @@ i2c_controller {
>   				 <105>,		/* KEY_LEFT */
>   				 <109>,		/* KEY_PAGEDOWN */
>   				 <104>;		/* KEY_PAGEUP */
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
>   	};
>   }
>

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski
