From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 05/10] Input: synaptics-rmi4: Add device tree support
 for 2d sensors and F11
Date: Mon, 8 Feb 2016 11:16:56 -0600
Message-ID: <20160208171656.GA22261@rob-hp-laptop>
References: <1454463906-4175-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454463906-4175-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 02, 2016 at 05:45:05PM -0800, Andrew Duggan wrote:
> 2D sensors have several parameter which can be set in the platform data.
> This patch adds support for getting those values from devicetree.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../bindings/input/rmi4/rmi_2d_sensor.txt          |  56 +++++++++++
>  .../bindings/input/touchscreen/touchscreen.txt     |   2 +
>  drivers/input/rmi4/rmi_2d_sensor.c                 | 108 +++++++++++++++++++++
>  drivers/input/rmi4/rmi_2d_sensor.h                 |   3 +
>  drivers/input/rmi4/rmi_f11.c                       |   7 +-
>  5 files changed, 175 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> new file mode 100644
> index 0000000..470d326
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> @@ -0,0 +1,56 @@
> +Synaptics RMI4 2D Sensor Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using different
> +transports and different functions. This file describes the device tree
> +bindings for devices which contain 2D sensors using Function 11 or
> +Function 12. Complete documentation for transports and other functions
> +can be found in:
> +Documentation/devicetree/bindings/input/rmi4.
> +
> +RMI4 Function 11 and Function 12 are for 2D touch position sensing.
> +Additional documentation for F11 can be found at:
> +http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
> +
> +Optional Touch Properties:
> +Description in Documentation/devicetree/bindings/input/touch
> +- touchscreen-inverted-x
> +- touchscreen-inverted-y
> +- touchscreen-swapped-x-y
> +- touchscreen-mm-x
> +- touchscreen-mm-y
> +
> +Optional Properties:
> +- syna,clip-x-low: Sets a minimum value for X.
> +- syna,clip-y-low: Sets a minimum value for Y.
> +- syna,clip-x-high: Sets a maximum value for X.
> +- syna,clip-y-high: Sets a maximum value for Y.
> +- syna,offset-x: Add an offset to X.
> +- syna,offset-y: Add an offset to Y.
> +- syna,delta-x-threshold: Set the minimum distance on the X axis required
> +				to generate an interrupt in reduced reporting
> +				mode.
> +- syna,delta-y-threshold: Set the minimum distance on the Y axis required
> +				to generate an interrupt in reduced reporting
> +				mode.
> +- syna,sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
> +- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
> +				disable reporing absolute position data.
> +- syna,rezero-wait-msec: Time in miliseconds to wait after issuing a rezero
> +				command.

s/msec/ms/

Sorry.

> +
> +
> +Example of a RMI4 I2C device with F11:
> +Example:
> +	&i2c1 {
> +		rmi4-i2c-dev@2c {
> +			compatible = "syna,rmi4-i2c";
> +
> +			...
> +
> +			rmi4-f11@11 {
> +				reg = <0x11>;
> +				touchscreen-inverted-y;
> +				syna,sensor-type = <2>;
> +			};
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> index ac23caf..d6674de 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> @@ -18,6 +18,8 @@ Optional properties for Touchscreens:
>   - touchscreen-inverted-y	: Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
>  				  Swapping is done after inverting the axis
> + - touchscreen-mm-x		: horizontal length in mm of the touchscreen
> + - touchscreen-mm-y		: vertical length in mm of the touchscreen

In keeping with units on the end, make it touchscreen-x-mm

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
