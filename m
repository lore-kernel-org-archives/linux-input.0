From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/4] iio: adc: add STMPE ADC devicetree bindings
Date: Wed, 28 Nov 2018 09:02:33 +0000
Message-ID: <20181128090233.GQ4272@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-3-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123142411.8921-3-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, Max Krummenacher <max.krummenacher@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Alexandre Torgue <alexandre.torgue@st.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-input@vger.kernel.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
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
[...]

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

Formatting changes should be completed in a separate patch.

Here they only serve to obscure the real changes you have made.

Please split the formatting changes out and re-submit.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
