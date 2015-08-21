From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v4 0/3] Add support for touchscreen on Colibri VF50
Date: Fri, 21 Aug 2015 18:56:29 +0530
Message-ID: <cover.1440162473.git.maitysanchayan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: shawnguo@kernel.org, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>
List-Id: linux-input@vger.kernel.org

Hello,

The patchset adds support for 4 wire touchscreen on Toradex Colibri
VF50 modules.

Thanks Dmitry for your feedback.

Changes since v3:
1. Add a #define for the average readings measurement.
2. Instead of configuring gpios every open, configure them on request.
3. Use a memory barrier and synchronize irq call to make sure IRQ is
not running past close.
4. Drop inline for vf50_ts_get_gpiod
5. Convert "ret" to "error"
6. Use devm_add_action to add a function for releasing iio channels and
drop remove completely.
7. Kill __set_bits()
8. Instead of requesting for pen irq as gpio and then irq, use the
interrupts property for DT and let it be handled automatically. Anyways
we never read it's state.
9. Just use IRQF_ONESHOT here, rely on the platform/OF to read and set up
the trigger properly (via "interrupts" property).

Changes since v2:
1. Fix pin multiplexing for pins in idle state. Configuration of the
pen detect pull up viz. PTA19__GPIO_9 resulted in generation of pen
irq's on a continuous basis.
2. Fix pinmux of the ADC pins as per the recommended pinmux in TRM.
3. Use a threaded irq handler instead of a irq handler plus workqueue
approach.
4. Use a low level trigger with oneshot flag specifier instead of the
previous falling edge triggered irq's. This coupled with the fix in
point 1 fixes the previous continuous spurious irq generation bug.
5. Change/fix the TS measurement logic to account for the fact that
iio_channel_read_raw might actually return an error. To be more
specific use break instead of continue and take care to close the
FET's in case of channel read error.
6. Drop the first patch "Add io-channel-cells property for ADC node"
as it has already been applied.
7. Move the iio channel get call again at the start. Having it in
the end resulted in crashes sometimes when iio was not probed and
the ts device got probed and opened earlier.

Changes since v1:
1. Fix/drop comments
2. Use an inline function for multiple gpiod_get calls in probe
3. Remove the pull up in the pinmux specified in DT for touchctrl_gpios
4. Add the io-channel-cells property before status property.
5. Add GPIOLIB as dependency in the Kconfig file

Version 3 of the patchset can be found here
https://lkml.org/lkml/2015/8/5/173

Version 2 of the patchset can be found here
https://www.mail-archive.com/linux-input@vger.kernel.org/msg18090.html

Version 1 of the patchset can be found here
https://lkml.org/lkml/2015/6/30/103

Thank you very much for the feedback till now.

Regards,
Sanchayan.

Sanchayan Maity (3):
  ARM: dts: vf500-colibri: Add device tree node for touchscreen support
  input: Add DT binding documentation for Colibri VF50 touchscreen
  touchscreen: colibri-vf50-ts: Add touchscreen support for Colibri VF50

 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  36 ++
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   4 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |  47 +++
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c        | 370 +++++++++++++++++++++
 6 files changed, 470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
 create mode 100644 drivers/input/touchscreen/colibri-vf50-ts.c

-- 
2.5.0
