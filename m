From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] Input: Add driver for Microchip's CAP1106
Date: Mon, 14 Jul 2014 10:52:47 +0100
Message-ID: <20140714095247.GB4980@leverpostej>
References: <1405073193-21448-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36068 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754258AbaGNJxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2014 05:53:06 -0400
Content-Disposition: inline
In-Reply-To: <1405073193-21448-1-git-send-email-zonque@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "dtor@mail.ru" <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "dh.herrmann@gmail.com" <dh.herrmann@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Jul 11, 2014 at 11:06:33AM +0100, Daniel Mack wrote:
> This patch adds a driver for Microchips CAP1106, an I2C driven, 6-channel
> capacitive touch sensor.
> 
> For now, only the capacitive buttons are supported, and no specific
> settings that can be tweaked for individual channels, except for the
> device-wide sensitivity gain. The defaults seem to work just fine out of
> the box, so I'll leave configurable parameters for someone who's in need
> of them and who can actually measure the impact. All registers are
> prepared, however. Many of them are just not used for now.
> 
> The implementation does not make any attempt to be compatible to platform
> data driven boards, but fully depends on CONFIG_OF.
> 
> Power management functions are also left for volounteers with the ability
> to actually test them.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> v2:
>  * Fix potential deadlocks pointed out by David.
> 
>  .../devicetree/bindings/input/cap1106.txt          |  63 ++++
>  drivers/input/keyboard/Kconfig                     |  10 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/cap1106.c                   | 378 +++++++++++++++++++++
>  4 files changed, 452 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cap1106.txt
>  create mode 100644 drivers/input/keyboard/cap1106.c
> 
> diff --git a/Documentation/devicetree/bindings/input/cap1106.txt b/Documentation/devicetree/bindings/input/cap1106.txt
> new file mode 100644
> index 0000000..57f5af3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cap1106.txt
> @@ -0,0 +1,63 @@
> +Device tree bindings for Microchip CAP1106, 6 channel capacitive touch sensor
> +
> +The node for this driver must be a child of a I2C controller node, as the
> +device communication via I2C only.
> +
> +Required properties:
> +
> +       compatible:             Must be "microchip,cap1106"
> +       reg:                    The I2C slave address of the device.
> +                               Only 0x28 is valid.
> +       interrupt:              Node describing the interrupt line the device's
> +                               ALERT#/CM_IRQ# pin is connected to.

s/interrupt/interrupts/

This is a _property_, not a node.

I take it the device only has a single interrupt line?

> +
> +Optional properties:
> +
> +       autorepeat:             Enables the Linux input system's autorepeat
> +                               feature on the input device.
> +       microchip,sensor-gain:  Defines the gain of the sensor circuitry. This
> +                               effectively controls the sensitivity, as a
> +                               smaller delta capacitance is required to
> +                               generate the same delta count values.
> +                               Valid values are 1, 2, 4, and 8.
> +                               By default, a gain of 1 is set.

Does the official documentation describe this in absolute terms?

> +
> +To define details of each individual button channel, six subnodes can be
> +specified. Inside each of those, the following property is valid:
> +
> +       linux,keycode:  Specify the numeric identifier of the keycode to be
> +                       generated when this channel is activated. If this
> +                       property is omitted, KEY_A, KEY_B, etc are used as
> +                       defaults.

What are those subnodes, and how are they told apart? Name, compatible?

I strongly recommend against relying on the order of the DT. It's very
easy for that to get messed up and makes things hard to read.

Is is not possible to use linux,keymap and treat the buttons as a
matrix keypad? Then you don't need subnodes at all, and you can have a
sparse keymap if you want.

[...]

> +struct cap1106_priv {
> +       struct regmap *regmap;
> +       struct input_dev *idev;
> +       struct work_struct work;
> +       spinlock_t lock;
> +       bool closed:1;

I don't think you're saving anything here by trying to have a bool
bitfield.

[...]

> +       i = 0;
> +       for_each_child_of_node(node, child) {
> +               if (i == CAP1106_NUM_CHN) {
> +                       dev_err(dev, "Too many button nodes.\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (!of_property_read_u32(child, "linux,keycode", &tmp32))
> +                       priv->keycodes[i] = tmp32;
> +
> +               i++;
> +       }

I don't think that it is a good idea to rely on the order of sub-nodes
in the DTB.

[...]

> +       if (of_get_property(node, "autorepeat", NULL))
> +               __set_bit(EV_REP, priv->idev->evbit);

Use of_property_read_bool.

/me mutters usual grumblings about the autorepeat property.

Thanks,
Mark.
