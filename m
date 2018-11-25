From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/4] iio: adc: add STMPE ADC devicetree bindings
Date: Sun, 25 Nov 2018 10:04:13 +0000
Message-ID: <20181125100413.73bc729f@archlinux>
References: <20181123142411.8921-1-dev@pschenker.ch>
        <20181123142411.8921-3-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123142411.8921-3-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: marcel.ziswiler@toradex.com, stefan@agner.ch, Max Krummenacher <max.krummenacher@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Alexandre Torgue <alexandre.torgue@st.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-input@vger.kernel.org

On Fri, 23 Nov 2018 15:24:10 +0100
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Clearly this will need review from input and mfd.

I've suggested inline that you split the realignment out to a
separate patch for reviewability reasons.

> ---
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
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++++
>  .../bindings/input/touchscreen/stmpe.txt      | 60 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 28 ++++++---
>  3 files changed, 80 insertions(+), 29 deletions(-)
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

Can we use adc { here to match standard naming?

> +		compatible = "st,stmpe-adc";
> +		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
> +	};
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> index 127baa31a77a..414586513a02 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -5,36 +5,52 @@ Required properties:
>   - compatible: "st,stmpe-ts"
>  
>  Optional properties:
> -- st,sample-time: ADC converstion time in number of clock.  (0 -> 36 clocks, 1 ->
> -  44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks, 5 -> 96 clocks, 6
> -  -> 144 clocks), recommended is 4.  
> -- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> -- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
> -  reference)
> -- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> -- st,ave-ctrl: Sample average control (0 -> 1 sample, 1 -> 2 samples, 2 -> 4
> -  samples, 3 -> 8 samples)
> -- st,touch-det-delay: Touch detect interrupt delay (0 -> 10 us, 1 -> 50 us, 2 ->
> -  100 us, 3 -> 500 us, 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms) recommended
> -  is 3
> -- st,settling: Panel driver settling time (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3
> -  -> 1 ms, 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms) recommended is 2  
> -- st,fraction-z: Length of the fractional part in z (fraction-z ([0..7]) = Count of
> -  the fractional part) recommended is 7
> -- st,i-drive: current limit value of the touchscreen drivers (0 -> 20 mA typical 35
> -  mA max, 1 -> 50 mA typical 80 mA max)
> +- st,ave-ctrl		: Sample average control
> +				0 -> 1 sample
> +				1 -> 2 samples
> +				2 -> 4 samples
> +				3 -> 8 samples
> +- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
> +				0 -> 10 us		5 -> 5 ms
> +				1 -> 50 us		6 -> 10 ms
> +				2 -> 100 us		7 -> 50 ms
> +				3 -> 500 us
> +				4-> 1 ms
> +- st,settling		: Panel driver settling time (recommended is 2)
> +				0 -> 10 us		5 -> 10 ms
> +				1 -> 100 us		6 for 50 ms
> +				2 -> 500 us		7 -> 100 ms
> +				3 -> 1 ms
> +				4 -> 5 ms
> +- st,fraction-z		: Length of the fractional part in z (recommended is 7)
> +			  (fraction-z ([0..7]) = Count of the fractional part)
> +- st,i-drive		: current limit value of the touchscreen drivers
> +				0 -> 20 mA (typical 35mA max)
> +				1 -> 50 mA (typical 80 mA max)
> +
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
>  
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
> index c797c05cd3c2..d4408a417193 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -4,15 +4,29 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
>  keypad, touchscreen, adc, pwm, rotator.
>  
>  Required properties:
> - - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
> - - reg                          : I2C/SPI address of the device
> + - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
> + - reg				: I2C/SPI address of the device

Nothing wrong with correcting alignment, but it shouldn't be in the same patch
as a fundamental change lie this.  Just adds noise.

If that means you first have to introduce the new block missaligned, then
fix up the alignment in a follow up patch, then do that as we can then
effectively ignore the realignment as obviously correct and focus on
the real changes.

>  
>  Optional properties:
> - - interrupts                   : The interrupt outputs from the controller
> - - interrupt-controller         : Marks the device node as an interrupt controller
> - - wakeup-source                : Marks the input device as wakable
> - - st,autosleep-timeout         : Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
> - - irq-gpio                     : If present, which GPIO to use for event IRQ
> + - interrupts			: The interrupt outputs from the controller
> + - interrupt-controller		: Marks the device node as an interrupt controller
> + - wakeup-source		: Marks the input device as wakable
> + - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
> + - irq-gpio			: If present, which GPIO to use for event IRQ
> +
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
>  
>  Example:
>  
