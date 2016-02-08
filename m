From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 09/10] Input: synaptics-rmi4: Add device tree support
 to the SPI transport driver
Date: Mon, 8 Feb 2016 11:24:02 -0600
Message-ID: <20160208172402.GA25420@rob-hp-laptop>
References: <1454463965-4370-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49474 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbcBHRYJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Feb 2016 12:24:09 -0500
Content-Disposition: inline
In-Reply-To: <1454463965-4370-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org

On Tue, Feb 02, 2016 at 05:46:05PM -0800, Andrew Duggan wrote:
> Add devicetree binding for SPI devices.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_spi.txt     | 57 ++++++++++++++++++++++
>  drivers/input/rmi4/rmi_spi.c                       | 44 ++++++++++++++++-
>  2 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
> new file mode 100644
> index 0000000..367b310
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
> @@ -0,0 +1,57 @@
> +Synaptics RMI4 SPI Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using different
> +transports and different functions. This file describes the device tree
> +bindings for devices using the SPI transport driver. Complete documentation
> +for other transports and functions can be found in
> +Documentation/devicetree/bindings/input/rmi4.
> +
> +Required Properties:
> +- compatible: syna,rmi4-spi
> +- reg: Chip select address for the device
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
> +- syna,spi-rx-delay-usec: microsecond delay after a read transfer.
> +- syna,spi-tx-delay-usec: microsecond delay after a write transfer.

s/usec/us/

These could perhaps be common SPI properties instead. Davinci at least 
has a similar property.

Rob
