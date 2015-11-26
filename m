From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
 rebased on 4.3
Date: Thu, 26 Nov 2015 11:41:44 +0100
Message-ID: <20151126104144.GC744@mail.corp.redhat.com>
References: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45355 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbbKZKlu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 05:41:50 -0500
Content-Disposition: inline
In-Reply-To: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Jiri Kosine <jikos@kernel.org>, Vincent Huang <vincent.huang@tw.synaptics.com>

Hi Andrew,

On Nov 25 2015 or thereabouts, Andrew Duggan wrote:
> This is a new patch series which squashes all of the development
> history of the RMI4 driver into patches based on functionality. The
> first patch adds the core RMI4 functionality needed by all RMI4 devices
> and then the additional patches add transport and function drivers for
> supporting various devices.

Thanks for this hard work. I did not do a full review of the series yet,
but caught some general design questions that I am writing here.

> 
> Touchpads which are currently using hid-rmi should have the same
> functionality, but now knowledge of RMI is handled in the core instead

I tried applying the series on top of a 4.4-rc2, and git am failed. I
think it's good to keep this one in the series, but we might want to
postpone its application when rmi4 hits Linus' tree so Jiri will be able
to take it without conflicting with Dmitry's tree. Well, Jiri and Dmitry
can sort this out :)

> of in hid-rmi. These patches also provide basic finger reporting for a
> wide range of RMI4 touchscreens connected to I2C and SPI busses.
> However, additional work may need to be done to implement product specific
> features.
> 
> I tried to include all of the feedback I received from the previous
> patches I posted. However, I did not come up with a satisfactory solution
> for allowing function drivers to be built as modules. I think it is fine
> to allow function drivers to be enabled or disabled in the core at build

I agree. I do not like the implementation however (I know, I contributed
a lot to it). How about we keep a static array of struct
rmi_function_handler? If we add a .registered file in struct
rmi_function_handler, we could simplify the registering/unregistering of
the functions more easily by looping through the array.

> time. However, if supporting function drivers as modules is a must have
> for upstreaming I can continue to try to find a solution. Also, I went
> ahead and removed support for polling.

Thanks for removing polling.

I have 2 other general concerns for rmi_bus:
- interrupts:
the current implementation has 2 type of interrupt handling depending on
the transport driver: either generic irqs or specific ones that are
triggered by the transport driver.

I think it would make sense to remove the generic irq handling in rmi4_bus
and let the transport driver handle it. This way, it will be easier for
the transport driver to decide whether or not forwarding the interrupts to
the bus.

This is what is done with the HID bus for the record. The transport
driver calls hid_input_report() when an irq has been processed.

- suspend/resume:
with the smbus implementation, we have quite some troubles with the
suspend/resume part. The reason is that both the rmi_bus and the serio
bus are registering to the pm subsystem and this leads to races between
them. Our current solution is to disable the pm registering in rmi_bus
and let the transport driver handle it at his level (which is in fine
triggered by the serio pm resume actually, not its own pm registration). 

I wonder if having the pm functions directly in the bus is a good idea
and if we should not let the transport driver handle those. We should
still keep the rmi specific functions in rmi_core/bus, I am just talking
about the registration of the bus to the subsystem.

[just thinking out loud: maybe we encounter problems of ordering due to
the fact that the bus is registered to the pm subsystem. Maybe if the
device itself in the transport driver registers, there will be guarantee
that the serio resume is called before the rmi_smbus one, which would
solve our problems].

Cheers,
Benjamin

> 
> Thanks,
> Andrew
> 
> Andrew Duggan (10):
>   Input: synaptics-rmi4: Add support for Synaptics RMI4 devices
>   Input: synaptics-rmi4: Add I2C transport driver
>   Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
>   Input: synaptics-rmi4: Add support for 2D sensors and F11
>   Input: synaptics-rmi4: Add device tree support for 2d sensors and F11
>   Input: synaptics-rmi4: Add support for F12
>   Input: synaptics-rmi4: Add support for F30
>   Input: synaptics-rmi4: Add SPI transport driver
>   Input: synaptics-rmi4: Add device tree support to the SPI transport
>     driver
>   HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
> 
>  .../bindings/input/rmi4/rmi_2d_sensor.txt          |   55 +
>  .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   40 +
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   53 +
>  .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   57 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/hid/hid-rmi.c                              |  922 ++-----------
>  drivers/input/Kconfig                              |    2 +
>  drivers/input/Makefile                             |    2 +
>  drivers/input/rmi4/Kconfig                         |   94 ++
>  drivers/input/rmi4/Makefile                        |   15 +
>  drivers/input/rmi4/rmi_2d_sensor.c                 |  323 +++++
>  drivers/input/rmi4/rmi_2d_sensor.h                 |   88 ++
>  drivers/input/rmi4/rmi_bus.c                       |  419 ++++++
>  drivers/input/rmi4/rmi_bus.h                       |  195 +++
>  drivers/input/rmi4/rmi_driver.c                    | 1112 ++++++++++++++++
>  drivers/input/rmi4/rmi_driver.h                    |  126 ++
>  drivers/input/rmi4/rmi_f01.c                       |  570 ++++++++
>  drivers/input/rmi4/rmi_f11.c                       | 1354 ++++++++++++++++++++
>  drivers/input/rmi4/rmi_f12.c                       |  487 +++++++
>  drivers/input/rmi4/rmi_f30.c                       |  419 ++++++
>  drivers/input/rmi4/rmi_i2c.c                       |  270 ++++
>  drivers/input/rmi4/rmi_spi.c                       |  464 +++++++
>  include/linux/rmi.h                                |  415 ++++++
>  include/uapi/linux/input.h                         |    1 +
>  24 files changed, 6638 insertions(+), 846 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
>  create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
>  create mode 100644 drivers/input/rmi4/Kconfig
>  create mode 100644 drivers/input/rmi4/Makefile
>  create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
>  create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h
>  create mode 100644 drivers/input/rmi4/rmi_bus.c
>  create mode 100644 drivers/input/rmi4/rmi_bus.h
>  create mode 100644 drivers/input/rmi4/rmi_driver.c
>  create mode 100644 drivers/input/rmi4/rmi_driver.h
>  create mode 100644 drivers/input/rmi4/rmi_f01.c
>  create mode 100644 drivers/input/rmi4/rmi_f11.c
>  create mode 100644 drivers/input/rmi4/rmi_f12.c
>  create mode 100644 drivers/input/rmi4/rmi_f30.c
>  create mode 100644 drivers/input/rmi4/rmi_i2c.c
>  create mode 100644 drivers/input/rmi4/rmi_spi.c
>  create mode 100644 include/linux/rmi.h
> 
> -- 
> 2.5.0
> 
