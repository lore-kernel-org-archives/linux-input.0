From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 03/10] Input: synaptics-rmi4: Add device tree support for
 RMI4 I2C devices
Date: Fri, 27 Nov 2015 15:27:36 -0600
Message-ID: <20151127212704.GA28469@rob-hp-laptop>
References: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
 <1448496448-25123-4-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57049 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbbK0V1y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 16:27:54 -0500
Content-Disposition: inline
In-Reply-To: <1448496448-25123-4-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, devicetree@vger.kernel.org

On Wed, Nov 25, 2015 at 04:07:21PM -0800, Andrew Duggan wrote:
> Add devicetree binding for I2C devices and add bindings for optional
> parameters in the function drivers. Parameters for function drivers are
> defined in child nodes for each of the functions.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_f01.txt     | 39 ++++++++++++
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     | 53 ++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/rmi4/rmi_bus.c                       | 71 ++++++++++++++++++++++
>  drivers/input/rmi4/rmi_driver.c                    | 28 +++++++++
>  drivers/input/rmi4/rmi_i2c.c                       | 12 +++-
>  6 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
> new file mode 100644
> index 0000000..df34dd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
> @@ -0,0 +1,39 @@
> +Synaptics RMI4 F01 Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using differnet
> +transports and differnet functions. This file describes the device tree

s/differnet/different/

> +bindings for devices which contain Function 1. Complete documentation
> +for transports and other functions can be found in:
> +Documentation/devicetree/bindings/input/rmi4.
> +
> +Additional documentation for F01 can be found at:
> +http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
> +
> +Optional Properties:
> +- syna,nosleep-mode: If set the device will run at full power without sleeping.
> +			nosleep has 3 modes, 0 will not change the default
> +			setting, 1 will disable nosleep (allow sleeping),
> +			and 2 will enable nosleep (disabling sleep).
> +- syna,wakeup-threshold: Defines the amplitude of the disturbance to the
> +				background capacitance that will cause the
> +				device to wake from dozing.

> +- syna,doze-holdoff: The delay to wait after the last finger lift and the
> +				first doze cycle (in 0.1 second units).
> +- syna,doze-interval: The time period that the device sleeps between finger
> +				activity (in 10 ms units).

Use millisec units and -msec suffix.


> +
> +
> +Example of a RMI4 I2C device with F01:
> +	Example:
> +	&i2c1 {
> +		rmi-i2c-dev@2c {
> +			compatible = "syna,rmi-i2c";
> +
> +			...
> +
> +			rmi-f01@1 {
> +				reg = <0x1>;
> +				syna,nosleep-mode = <1>;
> +			};
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> new file mode 100644
> index 0000000..0f4a8e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> @@ -0,0 +1,53 @@
> +Synaptics RMI4 I2C Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using differnet
> +transports and differnet functions. This file describes the device tree

s/differnet/different/

> +bindings for devices using the I2C tranport driver. Complete documentation
> +for other transports and functions cen be found ini
> +Documentation/devicetree/bindings/input/rmi4.
> +
> +Required Properties:
> +- compatible: syna,rmi-i2c

This is not very specific. Perhaps at least "rmi4" instead of just rmi.

> +- reg: I2C address
> +- #address-cells: Set to 1 to indicate that the function child nodes
> +		    consist of only on uint32 value.
> +- #size-cells: Set to 0 to indicate that the function child nodes do not
> +		have a size property.
> +
> +Optional Properties:
> +- interrupts: interrupt which the rmi device is connected to.
> +- interrupt-parent: The interrupt controller.
> +See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +- syna,reset-delay-ms: The number of milliseconds to wait after resetting the

"-msec" is the more commonly used abreviation in bindings.

> +			device.
> +
> +Function Parameters:
> +Parameters specific to RMI functions are contained in child nodes of the rmi device
> + node. Documentation for the parameters of each function can be found in:
> +Documentation/devicetree/bindings/input/rmi4/rmi_f*.txt.
> +
> +
> +
> +Example:
> +	&i2c1 {
> +		rmi-i2c-dev@2c {
> +			compatible = "syna,rmi-i2c";
> +			reg = <0x2c>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <4 2>;
> +
> +			rmi-f01@1 {
> +				reg = <0x1>;
> +				syna,nosleep-mode = <1>;
> +			};
> +
> +			rmi-f11@11 {
> +				reg = <0x11>;
> +				syna,flip-y;
> +				syna,sensor-type = <2>;
> +			};
> +		};
> +	};
