From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 09/10] Input: synaptics-rmi4: Add device tree support to
 the SPI transport driver
Date: Mon, 30 Nov 2015 15:28:00 -0600
Message-ID: <20151130212800.GA6213@rob-hp-laptop>
References: <1448496625-25408-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32782 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbK3V2F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 16:28:05 -0500
Content-Disposition: inline
In-Reply-To: <1448496625-25408-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, devicetree@vger.kernel.org

On Wed, Nov 25, 2015 at 04:10:25PM -0800, Andrew Duggan wrote:
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
> index 0000000..f20366b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
> @@ -0,0 +1,57 @@
> +Synaptics RMI4 SPI Device Binding
> +
> +The Synaptics RMI4 core is able to support RMI4 devices using differnet
> +transports and differnet functions. This file describes the device tree
> +bindings for devices using the SPI tranport driver. Complete documentation
> +for other transports and functions cen be found ini
> +Documentation/devicetree/bindings/input/rmi4.
> +
> +Required Properties:
> +- compatible: syna,rmi-spi
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
> +- syna,spi-read-delay: millisecond delay between read byte transfers.
> +- syna,spi-write-delay: millisecond delay between write byte transfers.

These could possibly be common SPI properties, but they would need to be 
somewhat better defined as every access on SPI is a read and a write. 
What if you have a read then write or write then read? Just a time 
between transfers would probably make more sense.

Minimally, they should have -msec suffix.

Rob
