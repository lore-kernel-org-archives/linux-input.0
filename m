From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] input: adc-keys: add DT binding documentation
Date: Sat, 16 Jul 2016 17:11:39 -0500
Message-ID: <20160716221139.GA3751@rob-hp-laptop>
References: <1468352186-14190-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35974 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcGPWLm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jul 2016 18:11:42 -0400
Content-Disposition: inline
In-Reply-To: <1468352186-14190-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Jul 12, 2016 at 09:36:25PM +0200, Alexandre Belloni wrote:
> Add documentation for ADC keys
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> 
> Changes v2..v4:
>  - Documented autorepeat and poll-interval
> 
> 
>  .../devicetree/bindings/input/adc-keys.txt         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> new file mode 100644
> index 000000000000..6f26ad75ed2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> @@ -0,0 +1,50 @@
> +ADC attached resistor ladder buttons
> +------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names = "buttons";
> + - keyup-threshold-mvolt: Voltage at which all the keys are considered up.

'-microvolt' is the standard suffix.

> +
> +Optional properties:
> +	- poll-interval: Poll interval time in milliseconds
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
