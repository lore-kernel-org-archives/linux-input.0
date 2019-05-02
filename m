From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/4] dt-bindings: input: Add support for the MPR121
 without interrupt line
Date: Wed, 1 May 2019 19:48:49 -0500
Message-ID: <20190502004849.GA8232@bogus>
References: <1556267420-93219-1-git-send-email-michal.vokac@ysoft.com>
 <1556267420-93219-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556267420-93219-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 26, 2019 at 10:30:17AM +0200, Michal Vokáč wrote:
> Normally, the MPR121 controller uses separate interrupt line to notify
> the I2C host that a key was touched/released. To support platforms that
> can not use the interrupt line, polling of the MPR121 registers can be
> used.

Other than making the 'interrupts' property optional, that's a driver 
change, not a DT change. IOW, we shouldn't need a whole new binding.

> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  .../bindings/input/mpr121-touchkey-polled.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt b/Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt
> new file mode 100644
> index 000000000000..6bb1d312614c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt
> @@ -0,0 +1,26 @@
> +* Freescale MPR121 Controller without interrupt line
> +
> +Required Properties:
> +- compatible:		Should be "fsl,mpr121-touchkey-polled"
> +- reg:			The I2C slave address of the device.
> +- vdd-supply:		Phandle to the Vdd power supply.
> +- linux,keycodes:	Specifies an array of numeric keycode values to
> +			be used for reporting button presses. The array can
> +			contain up to 12 entries.
> +
> +Optional Properties:
> +- autorepeat:		Enable autorepeat feature.
> +
> +Example:
> +
> +#include "dt-bindings/input/input.h"
> +
> +	touchkeys: keys@5a {
> +		compatible = "fsl,mpr121-touchkey-polled";
> +		reg = <0x5a>;
> +		autorepeat;
> +		vdd-supply = <&ldo4_reg>;
> +		linux,keycodes = <KEY_0>, <KEY_1>, <KEY_2>, <KEY_3>,
> +				<KEY_4> <KEY_5>, <KEY_6>, <KEY_7>,
> +				<KEY_8>, <KEY_9>, <KEY_A>, <KEY_B>;
> +	};
> -- 
> 2.1.4
> 
