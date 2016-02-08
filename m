From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 03/10] Input: synaptics-rmi4: Add device tree support
 for RMI4 I2C devices
Date: Mon, 8 Feb 2016 11:11:06 -0600
Message-ID: <20160208171106.GA20902@rob-hp-laptop>
References: <1454463857-4035-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47158 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561AbcBHRLL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Feb 2016 12:11:11 -0500
Content-Disposition: inline
In-Reply-To: <1454463857-4035-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org

On Tue, Feb 02, 2016 at 05:44:17PM -0800, Andrew Duggan wrote:
> Add devicetree binding for I2C devices and add bindings for optional
> parameters in the function drivers. Parameters for function drivers are
> defined in child nodes for each of the functions.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_f01.txt     | 39 ++++++++++++++++
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     | 53 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/rmi4/rmi_bus.c                       | 35 ++++++++++++++
>  drivers/input/rmi4/rmi_bus.h                       |  4 --
>  drivers/input/rmi4/rmi_driver.c                    | 28 ++++++++++++
>  drivers/input/rmi4/rmi_f01.c                       | 50 ++++++++++++++++++++
>  drivers/input/rmi4/rmi_i2c.c                       | 12 ++++-
>  8 files changed, 217 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
> new file mode 100644
> index 0000000..096855c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
> @@ -0,0 +1,39 @@
> +Synaptics RMI4 F01 Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using different
> +transports and different functions. This file describes the device tree
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
> +- syna,doze-holdoff-msec: The delay to wait after the last finger lift and the
> +				first doze cycle.
> +- syna,doze-interval-msec: The time period that the device sleeps between finger
> +				activity.

Sorry, but I told you the wrong suffix. It should be just '-ms'.

I've finally done my TODO list item of documenting what suffixes to use.

Otherwise, for the bindings:

Acked-by: Rob Herring <robh@kernel.org>
