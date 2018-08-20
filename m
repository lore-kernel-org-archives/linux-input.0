From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: input: pwm-vibrator: correct pwm-names in
 example
Date: Mon, 20 Aug 2018 17:38:10 -0500
Message-ID: <20180820223810.GA1780@bogus>
References: <20180818195855.13429-1-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180818195855.13429-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk, mark.rutland@arm.com
List-Id: linux-input@vger.kernel.org

On Sat, Aug 18, 2018 at 03:58:55PM -0400, Brian Masney wrote:
> In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
> and pwm9 is the enable pin. The pwm-names on the vibrator node has these
> two values swapped. This patch corrects the values for pwm-names.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> arch/arm/boot/dts/omap4-droid4-xt894.dts is actual implementation for
> the example and it is correct.
> 
>  Documentation/devicetree/bindings/input/pwm-vibrator.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> index 09145d18491d..2731cbb7e8d7 100644
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> @@ -60,7 +60,7 @@ Example from Motorola Droid 4:
>  		compatible = "pwm-vibrator";
>  		pwms = <&pwm8 0 1000000000 0>,
>  		       <&pwm9 0 1000000000 0>;
> -		pwm-names = "enable", "direction";
> +		pwm-names = "direction", "enable";

As enable is required and direction is optional, enable should come 
first. So fix the pwms property instead. (And perhaps make the binding 
more explicit as to what the order should be.

>  		direction-duty-cycle-ns = <1000000000>;
>  	};
>  };
> -- 
> 2.17.1
> 
