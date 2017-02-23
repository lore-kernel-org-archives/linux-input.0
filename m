From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Documentation: Add SPI example
Date: Thu, 23 Feb 2017 00:42:05 -0800
Message-ID: <20170223084205.GI18639@dtor-ws>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
 <1487780078-18510-4-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487780078-18510-4-git-send-email-michael.hennerich@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 22, 2017 at 05:14:37PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Applied, thank you.

> ---
>  .../devicetree/bindings/input/touchscreen/ad7879.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
> index 323b609..3c8614c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
> @@ -52,3 +52,21 @@ Example:
>  		adi,averaging = /bits/ 8 <1>;
>  		adi,conversion-interval = /bits/ 8 <255>;
>  	};
> +
> +	ad7879@1 {
> +		compatible = "adi,ad7879";
> +		spi-max-frequency = <5000000>;
> +		reg = <1>;
> +		spi-cpol;
> +		spi-cpha;
> +		gpio-controller;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-max-pressure = <4096>;
> +		adi,resistance-plate-x = <120>;
> +		adi,first-conversion-delay = /bits/ 8 <3>;
> +		adi,acquisition-time = /bits/ 8 <1>;
> +		adi,median-filter-size = /bits/ 8 <2>;
> +		adi,averaging = /bits/ 8 <1>;
> +		adi,conversion-interval = /bits/ 8 <255>;
> +	};
> -- 
> 2.7.4
> 

-- 
Dmitry
