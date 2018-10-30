From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Date: Tue, 30 Oct 2018 14:34:36 -0500
Message-ID: <20181030193436.GA29710@bogus>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-4-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540830122-2577-4-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 29, 2018 at 04:22:05PM +0000, Pascal PAILLET-LME wrote:
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v5:
> * describe regulator-active-discharge is available for power switches
> * remove interrupt parents
> 
>  .../bindings/regulator/st,stpmic1-regulator.txt    | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> new file mode 100644
> index 0000000..5adc938
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> @@ -0,0 +1,67 @@
> +STMicroelectronics STPMIC1 Voltage regulators
> +
> +Regulator Nodes are optional depending on needs.
> +
> +Available Regulators in STPMIC1 device are:
> +  - buck1 for Buck BUCK1
> +  - buck2 for Buck BUCK2
> +  - buck3 for Buck BUCK3
> +  - buck4 for Buck BUCK4
> +  - ldo1 for LDO LDO1
> +  - ldo2 for LDO LDO2
> +  - ldo3 for LDO LDO3
> +  - ldo4 for LDO LDO4
> +  - ldo5 for LDO LDO5
> +  - ldo6 for LDO LDO6
> +  - vref_ddr for LDO Vref DDR
> +  - boost for Buck BOOST
> +  - pwr_sw1 for VBUS_OTG switch
> +  - pwr_sw2 for SW_OUT switch
> +
> +Switches are fixed voltage regulators with only enable/disable capability.
> +
> +Optional properties:
> +- st,mask-reset: mask reset for this regulator: the regulator configuration
> +  is maintained during pmic reset.
> +- regulator-pull-down: enable high pull down
> +  if not specified light pull down is used
> +- regulator-over-current-protection:
> +    if set, all regulators are switched off in case of over-current detection
> +    on this regulator,
> +    if not set, the driver only sends an over-current event.
> +- interrupt-parent: phandle to the parent interrupt controller

This is not needed as the parent is a parent node with 
'interrupt-controller' property.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +- interrupts: index of current limit detection interrupt
> +- <regulator>-supply: phandle to the parent supply/regulator node
> +	each regulator supply can be described except vref_ddr.
> +- regulator-active-discharge: can be used on pwr_sw1 and pwr_sw2.
> +
> +Example:
> +regulators {
> +	compatible = "st,stpmic1-regulators";
> +
> +	ldo6-supply = <&v3v3>;
> +
> +	vdd_core: buck1 {
> +		regulator-name = "vdd_core";
> +		interrupts = <IT_CURLIM_BUCK1 0>;
> +		st,mask-reset;
> +		regulator-pull-down;
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	v3v3: buck4 {
> +		regulator-name = "v3v3";
> +		interrupts = <IT_CURLIM_BUCK4 0>;
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	v1v8: ldo6 {
> +		regulator-name = "v1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-over-current-protection;
> +	};
> +};
> -- 
> 1.9.1
