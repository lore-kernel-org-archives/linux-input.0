From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] input: adc-keys: add DT binding documentation
Date: Sun, 3 Jul 2016 14:43:56 +0100
Message-ID: <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
References: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/07/16 22:30, Alexandre Belloni wrote:
> Add documentation for ADC keys
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Clean looking binding to me - one comment inline.

Jonathan
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> 
>  .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> new file mode 100644
> index 000000000000..873476bb4eab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> @@ -0,0 +1,45 @@
> +Allwinner sun4i low res adc attached tablet keys
What is allwinner specific in here?  Looks pretty general purpose to me!
> +------------------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names = "buttons";
> + - voltage-keyup-mvolt: Voltage at which all the keys are considered up.
> +
> +Each key is represented as a sub-node of "adc-keys":
> +
> +Required subnode-properties:
> +	- label: Descriptive name of the key.
> +	- linux,code: Keycode to emit.
> +	- voltage-mvolt: Voltage adc input when this key is pressed.
> +
> +Example:
> +
> +#include <dt-bindings/input/input.h>
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&lradc 0>;
> +		io-channel-names = "buttons";
> +		voltage-keyup-mvolt = <2000>;
> +
> +		button@1500 {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			voltage-mvolt = <1500>;
> +		};
> +
> +		button@1000 {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			voltage-mvolt = <1000>;
> +		};
> +
> +		button@500 {
> +			label = "Enter";
> +			linux,code = <KEY_ENTER>;
> +			voltage-mvolt = <500>;
> +		};
> +	};
> +
> 
