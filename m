From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 05/10] Input: synaptics-rmi4: Add device tree support for
 2d sensors and F11
Date: Fri, 27 Nov 2015 15:10:51 -0600
Message-ID: <20151127211051.GA23000@rob-hp-laptop>
References: <1448496553-25208-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448496553-25208-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 25, 2015 at 04:09:13PM -0800, Andrew Duggan wrote:
> 2D sensors have several parameter which can be set in the platform data.
> This patch adds support for getting those values from devicetree.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../bindings/input/rmi4/rmi_2d_sensor.txt          |  54 +++++++++++
>  drivers/input/rmi4/rmi_2d_sensor.c                 | 103 +++++++++++++++++++++
>  drivers/input/rmi4/rmi_2d_sensor.h                 |   3 +
>  drivers/input/rmi4/rmi_f11.c                       |   7 +-
>  4 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> new file mode 100644
> index 0000000..bbff31b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> @@ -0,0 +1,54 @@
> +Synaptics RMI4 2D Sensor Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using differnet

s/differnet/different/

> +transports and differnet functions. This file describes the device tree

ditto.

> +bindings for devices which contain 2D sensors using Function 11 or
> +Function 12. Complete documentation for transports and other functions
> +can be found in:
> +Documentation/devicetree/bindings/input/rmi4.
> +
> +RMI4 Function 11 and Function 12 are for 2D touch position sensing.
> +Additional documentation for F11 can be found at:
> +http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
> +
> +Optional Properties:
> +- syna,swap-axes: Swap X and Y positions when reporting (boolean).
> +- syna,flip-x: Reverse the direction of X (boolean).
> +- syna,flip-y: Reverse the direction of Y (boolean).

We already have similar, generic properties for these.

> +- syna,clip-x-low: Sets a minimum value for X.
> +- syna,clip-y-low: Sets a minimum value for Y.
> +- syna,clip-x-high: Sets a maximum value for X.
> +- syna,clip-y-high: Sets a maximum value for Y.
> +- syna,offset-x: Add an offset to X.
> +- syna,offset_y: Add an offset to Y.

Don't use "_".

> +- syna,delta-x-threshold: Set the minimum distance on the X axis required
> +				to generate an interrupt in reduced reporting
> +				mode.
> +- syna,delta-y-threshold: Set the minimum distance on the Y axis required
> +				to generate an interrupt in reduced reporting
> +				mode.
> +- syna,type-a: Report type A multitouch events.
> +- syna,sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
> +- syna,x-mm: The length in millimeters of the X axis.
> +- syna,y-mm: The length in millimeters of the Y axis.

I think some of these have common properties defined too. If not, we 
should add them.

> +- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
> +				disable reporing absolute position data.
> +- syna,rezero-wait: Time in miliseconds to wait after issuing a rezero
> +				command.

Add -msec suffix.
