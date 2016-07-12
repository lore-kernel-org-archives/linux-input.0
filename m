From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3 1/2] input: adc-keys: add DT binding documentation
Date: Tue, 12 Jul 2016 21:33:16 +0200
Message-ID: <20160712193316.GX22202@piout.net>
References: <1468351790-13043-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52279 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750897AbcGLTdY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 15:33:24 -0400
Content-Disposition: inline
In-Reply-To: <1468351790-13043-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On 12/07/2016 at 21:29:49 +0200, Alexandre Belloni wrote :
> Add documentation for ADC keys
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> 

Woops, disregard that series, I'll send v4 shortly.

>  .../devicetree/bindings/input/adc-keys.txt         | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> new file mode 100644
> index 000000000000..0b92ebb4ac21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> @@ -0,0 +1,49 @@
> +ADC attached resistor ladder buttons
> +------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names = "buttons";
> + - keyup-threshold-mvolt: Voltage at which all the keys are considered up.
> +
> +Optional properties:
> +	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> +	  subsystem.
> +
> +Each button (key) is represented as a sub-node of "adc-keys":
> +
> +Required subnode-properties:
> +	- label: Descriptive name of the key.
> +	- linux,code: Keycode to emit.
> +	- press-threshold-mvolt: Voltage adc input when this key is pressed.
> +
> +Example:
> +
> +#include <dt-bindings/input/input.h>
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&lradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-mvolt = <2000>;
> +
> +		button@1500 {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-mvolt = <1500>;
> +		};
> +
> +		button@1000 {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-mvolt = <1000>;
> +		};
> +
> +		button@500 {
> +			label = "Enter";
> +			linux,code = <KEY_ENTER>;
> +			press-threshold-mvolt = <500>;
> +		};
> +	};
> +
> -- 
> 2.8.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
