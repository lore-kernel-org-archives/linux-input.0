From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for vibrator
Date: Wed, 6 Feb 2019 10:18:22 -0800
Message-ID: <20190206181822.GB174258@dtor-ws>
References: <20190206013329.18195-1-masneyb@onstation.org>
 <20190206013329.18195-4-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206013329.18195-4-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, jonathan@marek.ca
List-Id: linux-input@vger.kernel.org

On Tue, Feb 05, 2019 at 08:33:29PM -0500, Brian Masney wrote:
> This patch adds device device tree bindings for the vibrator found on
> the LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

This should go through Qualcomm tree with the other bindings?

> ---
> Changes since v3:
> - None
> 
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index b3b04736a159..1fd9f429f34a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
>  
>  / {
>  	model = "LGE MSM 8974 HAMMERHEAD";
> @@ -306,6 +307,36 @@
>  				input-enable;
>  			};
>  		};
> +
> +		vibrator_pin: vibrator {
> +			pwm {
> +				pins = "gpio27";
> +				function = "gp1_clk";
> +
> +				drive-strength = <6>;
> +				bias-disable;
> +			};
> +
> +			enable {
> +				pins = "gpio60";
> +				function = "gpio";
> +			};
> +		};
> +	};
> +
> +	vibrator@fd8c3450 {
> +		compatible = "qcom,msm8974-vibrator";
> +		reg = <0xfd8c3450 0x400>;
> +
> +		vcc-supply = <&pm8941_l19>;
> +
> +		clocks = <&mmcc CAMSS_GP1_CLK>;
> +		clock-names = "pwm";
> +
> +		enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vibrator_pin>;
>  	};
>  
>  	sdhci@f9824900 {
> -- 
> 2.17.2
> 

-- 
Dmitry
