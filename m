From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] Input: Add driver for Microchip's CAP1106
Date: Tue, 15 Jul 2014 09:51:38 +0100
Message-ID: <20140715085138.GR26465@leverpostej>
References: <1405073193-21448-1-git-send-email-zonque@gmail.com>
 <20140714095247.GB4980@leverpostej>
 <53C3AEE1.4030805@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49920 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758047AbaGOIv6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jul 2014 04:51:58 -0400
Content-Disposition: inline
In-Reply-To: <53C3AEE1.4030805@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: "dtor@mail.ru" <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "dh.herrmann@gmail.com" <dh.herrmann@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jul 14, 2014 at 11:20:17AM +0100, Daniel Mack wrote:
> Hi Mark,
> 
> thanks a lot for your feedback! Much appreciated.
> 
> On 07/14/2014 11:52 AM, Mark Rutland wrote:
> > On Fri, Jul 11, 2014 at 11:06:33AM +0100, Daniel Mack wrote:
> 
> >> +++ b/Documentation/devicetree/bindings/input/cap1106.txt
> >> @@ -0,0 +1,63 @@
> >> +Device tree bindings for Microchip CAP1106, 6 channel capacitive touch sensor
> >> +
> >> +The node for this driver must be a child of a I2C controller node, as the
> >> +device communication via I2C only.
> >> +
> >> +Required properties:
> >> +
> >> +       compatible:             Must be "microchip,cap1106"
> >> +       reg:                    The I2C slave address of the device.
> >> +                               Only 0x28 is valid.
> >> +       interrupt:              Node describing the interrupt line the device's
> >> +                               ALERT#/CM_IRQ# pin is connected to.
> > 
> > s/interrupt/interrupts/
> > 
> > This is a _property_, not a node.
> 
> Yes, I reworded that description a couple of times. Together with
> interrupt-parent, it's actually a property referencing a node ;) Will fix.
> 
> > I take it the device only has a single interrupt line?
> 
> Yes.

Ok, that sounds fine then.

> >> +
> >> +Optional properties:
> >> +
> >> +       autorepeat:             Enables the Linux input system's autorepeat
> >> +                               feature on the input device.
> >> +       microchip,sensor-gain:  Defines the gain of the sensor circuitry. This
> >> +                               effectively controls the sensitivity, as a
> >> +                               smaller delta capacitance is required to
> >> +                               generate the same delta count values.
> >> +                               Valid values are 1, 2, 4, and 8.
> >> +                               By default, a gain of 1 is set.
> > 
> > Does the official documentation describe this in absolute terms?
> 
> The documentation describes the gain feature as "1, 2, 4, or 8", so I
> kept it like this in the bindings. Internally, the register stores that
> value in 2 bits. The driver takes care for the translation.

That sounds fine.

> >> +To define details of each individual button channel, six subnodes can be
> >> +specified. Inside each of those, the following property is valid:
> >> +
> >> +       linux,keycode:  Specify the numeric identifier of the keycode to be
> >> +                       generated when this channel is activated. If this
> >> +                       property is omitted, KEY_A, KEY_B, etc are used as
> >> +                       defaults.
> > 
> > What are those subnodes, and how are they told apart? Name, compatible?
> > 
> > I strongly recommend against relying on the order of the DT. It's very
> > easy for that to get messed up and makes things hard to read.
> > 
> > Is is not possible to use linux,keymap and treat the buttons as a
> > matrix keypad? Then you don't need subnodes at all, and you can have a
> > sparse keymap if you want.
> 
> Hmm, I thought about that, but there are - in theory - more details that
> could be specified per channel. I left those functions out for the first
> version, as I have no good way to test them.

Ok. Could you elaborate on what those details might be? It might make
sense to have these as nodes if there are arbitrary properties to
describe for each button, but I'm not familiar enough with the hardware
to make a call either way.

> Hence, my idea was to have everything related to one channel nicely
> grouped in a subnode. I've also seen bindings that rely on the order of
> subnodes before, for example in regulator drivers.

Sure. There's plenty of bad practice in DT bindings and code. There's
just too much of it going on to get everything sane, and it's not always
possible to fix the insane stuff if people are already using it.

> But I agree with you that it makes board definitions error-prone.
> 
> linux,keycode feels a bit overkill here though, so I'd rather go for a
> fixed-size linux,keycodes property. The number of entries is fixed,
> anyway. Would you be fine with that?

Assuming no-one's likely to want a sparse keymap (i.e. one where some
keys do nothing) then that's probably ok.

> >> +struct cap1106_priv {
> >> +       struct regmap *regmap;
> >> +       struct input_dev *idev;
> >> +       struct work_struct work;
> >> +       spinlock_t lock;
> >> +       bool closed:1;
> > 
> > I don't think you're saving anything here by trying to have a bool
> > bitfield.
> 
> That variable has been dropped in v3 already :)
> 
> >> +       i = 0;
> >> +       for_each_child_of_node(node, child) {
> >> +               if (i == CAP1106_NUM_CHN) {
> >> +                       dev_err(dev, "Too many button nodes.\n");
> >> +                       return -EINVAL;
> >> +               }
> >> +
> >> +               if (!of_property_read_u32(child, "linux,keycode", &tmp32))
> >> +                       priv->keycodes[i] = tmp32;
> >> +
> >> +               i++;
> >> +       }
> > 
> > I don't think that it is a good idea to rely on the order of sub-nodes
> > in the DTB.
> 
> Jup, I agree. As mentioned above, I'd like to solve that with
> linux,keycode for now.
> 
> > [...]
> > 
> >> +       if (of_get_property(node, "autorepeat", NULL))
> >> +               __set_bit(EV_REP, priv->idev->evbit);
> > 
> > Use of_property_read_bool.
> 
> Will do, thanks.
> 
> > /me mutters usual grumblings about the autorepeat property.
> 
> I took that from the gpio-keys driver. Is there a better way to denote
> such a feature?

Unfortunately not, given current practice. My gripe is that it's a Linux
detail that were describing rather than a property of the device. We can
forget about that for now.

Thanks,
Mark.
