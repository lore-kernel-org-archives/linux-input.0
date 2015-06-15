From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v3 1/2] dt: add cap11xx LED documentation
Date: Mon, 15 Jun 2015 10:15:12 +0200
Message-ID: <557E8990.5060702@samsung.com>
References: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
 <1434169054-11035-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <1434169054-11035-2-git-send-email-mranostay@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: zonque@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Matt,

On 06/13/2015 06:17 AM, Matt Ranostay wrote:
> Some cap11xx devices have LEDs that can be controlled from userpace
> and via triggers. Document their use and functionality here.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>   .../devicetree/bindings/input/cap11xx.txt          | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
> index 7d0a300..ef89c27 100644
> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
> @@ -38,6 +38,11 @@ Optional properties:
>   				defaults. The array must have exactly six
>   				entries.
>
> +	linux,led-brightness:	Defines the ON brightness when the optional LED
> +				functionality is used. Valid values are 0-15.
> +				By default a value of 15 is set.

The ON brightness is controlled with the 'brightness' sysfs property.
The levels start from 1 and 0 turns the LED off. I think that this
property is useless then.

> +
>   Example:
>
>   i2c_controller {
> @@ -55,5 +60,23 @@ i2c_controller {
>   				 <105>,		/* KEY_LEFT */
>   				 <109>,		/* KEY_PAGEDOWN */
>   				 <104>;		/* KEY_PAGEUP */
> +
> +		linux,led-brightness = <15>;
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

-- 
Best Regards,
Jacek Anaszewski
