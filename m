From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: sitronix-st1232: document
 optional reset-gpios property
Date: Mon, 25 Feb 2019 08:43:28 -0600
Message-ID: <20190225144328.GA13518@bogus>
References: <20190129102347.27754-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129102347.27754-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 29, 2019 at 11:23:46AM +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> The st1232 driver reads this via gpiod.

What a driver does is not relevant to the binding. This breaks 
compatibility so you need to mention that and why this is okay.

Either you need to keep 'gpios' as deprecated or you can drop it if 
there aren't any dts files using it.

> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  .../devicetree/bindings/input/touchscreen/sitronix-st1232.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> index e73e826e0f2a..365b32d30d4b 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> @@ -8,7 +8,7 @@ Required properties:
>  - interrupts: interrupt to which the chip is connected
>  
>  Optional properties:
> -- gpios: a phandle to the reset GPIO
> +- reset-gpios: a phandle to the reset GPIO
>  
>  Example:
>  
> @@ -19,7 +19,7 @@ Example:
>  			compatible = "sitronix,st1232";
>  			reg = <0x55>;
>  			interrupts = <2 0>;
> -			gpios = <&gpio1 166 0>;
> +			reset-gpios = <&gpio1 166 0>;
>  		};
>  
>  		/* ... */
> -- 
> 2.20.1
> 
