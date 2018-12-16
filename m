From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 6/8] iio: adc: add STMPE ADC devicetree bindings
Date: Sun, 16 Dec 2018 12:28:53 +0000
Message-ID: <20181216122853.31a12016@archlinux>
References: <20181212130649.15146-1-dev@pschenker.ch>
        <20181212130649.15146-6-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212130649.15146-6-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: marcel.ziswiler@toradex.com, stefan@agner.ch, thierry.reding@gmail.com, Max Krummenacher <max.krummenacher@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Alexandre Torgue <alexandre.torgue@st.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-input@vger.kernel.org

On Wed, 12 Dec 2018 14:06:47 +0100
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. And corrects a
> typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

This still conflates a couple of different things but we can argue
about patch separation for ever so never mind.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> Changes in v4:
>  - Put reformatting in a separate precursor patch.
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ++++++++++++
>  .../bindings/input/touchscreen/stmpe.txt      | 32 +++++++++----------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++++++++
>  3 files changed, 51 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> new file mode 100644
> index 000000000000..480e66422625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> @@ -0,0 +1,21 @@
> +STMPE ADC driver
> +----------------
> +
> +Required properties:
> + - compatible: "st,stmpe-adc"
> +
> +Optional properties:
> +Note that the ADC is shared with the STMPE touchscreen. ADC related settings
> +have to be done in the mfd.
> +- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
> +  requestable due to different usage (e.g. touch)
> +
> +Node name must be stmpe_adc and should be child node of stmpe node to
> +which it belongs.
> +
> +Example:
> +
> +	stmpe_adc {
> +		compatible = "st,stmpe-adc";
> +		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
> +	};
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> index 1d3f84308142..8e2b240882fa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -5,18 +5,6 @@ Required properties:
>   - compatible: "st,stmpe-ts"
>  
>  Optional properties:
> -- st,sample-time	: ADC conversion time in number of clock.
> -				0 -> 36 clocks		4 -> 80 clocks (recommended)
> -				1 -> 44 clocks		5 -> 96 clocks
> -				2 -> 56 clocks		6 -> 144 clocks
> -				3 -> 64 clocks
> -- st,mod-12b		: ADC Bit mode
> -				0 -> 10bit ADC		1 -> 12bit ADC
> -- st,ref-sel		: ADC reference source
> -				0 -> internal		1 -> external
> -- st,adc-freq		: ADC Clock speed
> -				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> -				1 -> 3.25 MHz
>  - st,ave-ctrl		: Sample average control
>  				0 -> 1 sample
>  				1 -> 2 samples
> @@ -40,17 +28,29 @@ Optional properties:
>  				0 -> 20 mA (typical 35mA max)
>  				1 -> 50 mA (typical 80 mA max)
>  
> +Optional properties common with MFD (deprecated):
> + - st,sample-time	: ADC conversion time in number of clock.
> +				0 -> 36 clocks		4 -> 80 clocks (recommended)
> +				1 -> 44 clocks		5 -> 96 clocks
> +				2 -> 56 clocks		6 -> 124 clocks
> +				3 -> 64 clocks
> + - st,mod-12b		: ADC Bit mode
> +				0 -> 10bit ADC		1 -> 12bit ADC
> + - st,ref-sel		: ADC reference source
> +				0 -> internal		1 -> external
> + - st,adc-freq		: ADC Clock speed
> +				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +				1 -> 3.25 MHz
> +
>  Node name must be stmpe_touchscreen and should be child node of stmpe node to
>  which it belongs.
>  
> +Note that common ADC settings of stmpe_touchscreen will take precedence.
> +
>  Example:
>  
>  	stmpe_touchscreen {
>  		compatible = "st,stmpe-ts";
> -		st,sample-time = <4>;
> -		st,mod-12b = <1>;
> -		st,ref-sel = <0>;
> -		st,adc-freq = <1>;
>  		st,ave-ctrl = <1>;
>  		st,touch-det-delay = <2>;
>  		st,settling = <2>;
> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index a46e7177195d..d4408a417193 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -14,6 +14,20 @@ Optional properties:
>   - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
>   - irq-gpio			: If present, which GPIO to use for event IRQ
>  
> +Optional properties for devices with touch and ADC (STMPE811|STMPE610):
> + - st,sample-time		: ADC conversion time in number of clock.
> +					0 -> 36 clocks		4 -> 80 clocks (recommended)
> +					1 -> 44 clocks		5 -> 96 clocks
> +					2 -> 56 clocks		6 -> 124 clocks
> +					3 -> 64 clocks
> + - st,mod-12b			: ADC Bit mode
> +					0 -> 10bit ADC		1 -> 12bit ADC
> + - st,ref-sel			: ADC reference source
> +					0 -> internal		1 -> external
> + - st,adc-freq			: ADC Clock speed
> +					0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +					1 -> 3.25 MHz
> +
>  Example:
>  
>  	stmpe1601: stmpe1601@40 {
