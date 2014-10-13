From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 1/3] cap11xx: make driver generic for variant support
Date: Mon, 13 Oct 2014 12:12:18 +0100
Message-ID: <20141013111218.GB15326@leverpostej>
References: <1413004014-23807-1-git-send-email-mranostay@gmail.com>
 <1413004014-23807-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55458 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204AbaJMLM2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2014 07:12:28 -0400
Content-Disposition: inline
In-Reply-To: <1413004014-23807-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "zonque@gmail.com" <zonque@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sat, Oct 11, 2014 at 06:06:52AM +0100, Matt Ranostay wrote:
> cap1106 driver can support much more one device make the driver
> generic for support of similar parts.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  .../devicetree/bindings/input/cap1106.txt          |  53 ----
>  .../devicetree/bindings/input/cap11xx.txt          |  54 ++++
>  drivers/input/keyboard/Kconfig                     |   8 +-
>  drivers/input/keyboard/Makefile                    |   2 +-
>  drivers/input/keyboard/cap1106.c                   | 341 ---------------------
>  drivers/input/keyboard/cap11xx.c                   | 340 ++++++++++++++++++++
>  6 files changed, 399 insertions(+), 399 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cap1106.txt
>  create mode 100644 Documentation/devicetree/bindings/input/cap11xx.txt
>  delete mode 100644 drivers/input/keyboard/cap1106.c
>  create mode 100644 drivers/input/keyboard/cap11xx.c

[...]

> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
> new file mode 100644
> index 0000000..738f5f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
> @@ -0,0 +1,54 @@
> +Device tree bindings for Microchip CAP1106 based capacitive touch sensor
> +
> +The node for this driver must be a child of a I2C controller node, as the

s/driver/device/

> +device communication via I2C only.
> +
> +Required properties:
> +
> +       compatible:             Must be on the following, depending on the model:

Please change this to say "Must contain one of:"

The rest is implied by the usual semantics of the compatible property.

> +                                       "microchip,cap1106"
> +
> +       reg:                    The I2C slave address of the device.
> +                               Only 0x28 is valid.
> +
> +       interrupts:             Property describing the interrupt line the
> +                               device's ALERT#/CM_IRQ# pin is connected to.
> +                               The device only has one interrupt source.
> +
> +Optional properties:
> +
> +       autorepeat:             Enables the Linux input system's autorepeat
> +                               feature on the input device.
> +
> +       microchip,sensor-gain:  Defines the gain of the sensor circuitry. This
> +                               effectively controls the sensitivity, as a
> +                               smaller delta capacitance is required to
> +                               generate the same delta count values.
> +                               Valid values are 1, 2, 4, and 8.
> +                               By default, a gain of 1 is set.
> +
> +       linux,keycodes:         Specifies an array of numeric keycode values to
> +                               be used for the channels. If this property is
> +                               omitted, KEY_A, KEY_B, etc are used as
> +                               defaults. The array must have exactly six
> +                               entries.
> +
> +Example:
> +
> +i2c_controller {
> +       cap1106@28 {
> +               compatible = "microchip,cap1106";
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <0 0>;
> +               reg = <0x28>;
> +               autorepeat;
> +               microchip,sensor-gain = <2>;
> +
> +               linux,keycodes = <103           /* KEY_UP */
> +                                 106           /* KEY_RIGHT */
> +                                 108           /* KEY_DOWN */
> +                                 105           /* KEY_LEFT */
> +                                 109           /* KEY_PAGEDOWN */
> +                                 104>;         /* KEY_PAGEUP */

As we're moving this around anyway, please bracket this list entries
individually.

Thanks,
Mark.
