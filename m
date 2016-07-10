From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] input: adc-keys: add DT binding documentation
Date: Sun, 10 Jul 2016 15:44:28 +0100
Message-ID: <69bdd8e9-157b-cdc1-7236-7145b3f46f7a@kernel.org>
References: <1468027442-5033-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39161 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbcGJOoa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2016 10:44:30 -0400
In-Reply-To: <1468027442-5033-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/07/16 02:24, Alexandre Belloni wrote:
> Add documentation for ADC keys
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
I'm seeing a few more properties in the driver.  They may be generic
input ones, but should still be listed here...

autorepeat for example.

> ---
> Changes in v2:
>  - fix title
>  - use keyup-threshold-mvolt and press-threshold-mvolt instead of
>    voltage-keyup-mvolt and voltage-mvolt.
> 
>  .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> new file mode 100644
> index 000000000000..e43b8979b85a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> @@ -0,0 +1,45 @@
> +ADC attached resistor ladder buttons
> +------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names = "buttons";
> + - keyup-threshold-mvolt: Voltage at which all the keys are considered up.
> +
> +Each key is represented as a sub-node of "adc-keys":
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
> 

