From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v7 0/3] add support for Allwinner SoCs ADC
Date: Thu,  3 Nov 2016 11:15:58 +0100
Message-ID: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. The first four channels can be used either
for the ADC or the touchscreen and the fifth channel is used for the
thermal sensor. We currently have a driver for the two latter functions in
drivers/input/touchscreen/sun4i-ts.c but we don't have access to the ADC
feature at all. It is meant to replace the current driver by using MFD and
subdrivers.

This adds initial support for Allwinner SoCs ADC with all features. Yet,
the touchscreen is not implemented but will be added later. To switch
between touchscreen and ADC modes, you need to poke a few bits in registers
and (de)activate an interrupt (pen-up).

When changing modes or channels, the IP is in inconsistent mode and has no
register or interrupt to notify the kernel when it's stable and ready to return
correct values. Therefore, we add a delay of 100ms when changing modes and 10ms
when changing channels. These values have been found empirically.

An MFD is provided to let the input driver activate the pen-up interrupt
through a virtual interrupt, poke a few bits via regmap and read data from
the ADC driver while both (and iio_hwmon) are probed by the MFD.

The thermal sensor requires the IP to be in touchscreen mode to return correct
values. Therefore, if the user is continuously reading the ADC channel(s), the
thermal framework in which the thermal sensor is registered will switch the IP
in touchscreen mode to get a temperature value and requires a delay of 100ms
(because of the mode switching), then the ADC will switch back to ADC mode and
requires also a delay of 100ms. If the ADC readings are critical to user and the
SoC temperature is not, this driver is capable of not registering the thermal
sensor in the thermal framework and thus, "quicken" the ADC readings. In most
use cases, the SoC temperature is more critical (for cpu throttling for example
or activating cooling devices) than ADC readings, thus it is enabled by default
in multi_v7_defconfig and in sunxi_defconfig (default being added in this patch
series).

There are slight variations between the different SoCs ADC like the address
of some registers and the scale and offset to apply to raw thermal sensor
values. These variations are handled by using different platform_device_id,
passed to the sub-drivers when they are probed by the MFD.



Removal of proposed patch for iio_hwmon's iio channel's label in v3. The
patch induces irreversible ABI changes and will be handled as a separate
patch since I think it is not absolutely necessary to have labels yet in
iio_hwmon.

Removal of proposed patch for reattaching of_node of the MFD to the MFD
cell device structure in v3. As Lee Jones said, this patch might cause
"unintended side-effects for existing drivers.". Moreover, this patch
introduced a bug of multiple probe of this MFD driver I haven't identified
yet. This patch aimed at allowing the ADC driver (which is a child of the
MFD and not present in the DT) to register in the thermal framework. The
thermal driver has a phandle to the MFD node which is used to match against
the MFD of_node but since the ADC driver has no node in the DT, could not
register in the thermal framework. The other solution is to "impersonate"
the MFD when registering in the thermal framework since the device is only
used to match the phandle and the of_node, an other structure passed by
parameter being used to compute temperatures.

(in the ADC driver, probed by the MFD driver) instead of:
tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
					   &sun4i_ts_tz_ops);
we now have:
tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
					   &sun4i_ts_tz_ops);

Removal of proposed patch to use late_initcall for iio_hwmon probe deferring.

Removal of patch for iio_hwmon probe deferring due to being applied to -next by
Guenter Roeck.

This patch series requires this[1] patch which has already been merged by Lee
Jones.

[1] https://patchwork.kernel.org/patch/9333547/

Quentin Schulz (3):
  input: touchscreen: TOUCHSCREEN_SUN4I depends on !SUN4I_GPADC
  ARM: sunxi_defconfig: Add CONFIG_THERMAL_OF
  iio: adc: add support for Allwinner SoCs ADC

 arch/arm/configs/sunxi_defconfig  |   1 +
 drivers/iio/adc/Kconfig           |  17 ++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/sun4i-gpadc-iio.c | 605 ++++++++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/Kconfig |   1 +
 include/linux/mfd/sun4i-gpadc.h   |   2 +
 6 files changed, 627 insertions(+)
 create mode 100644 drivers/iio/adc/sun4i-gpadc-iio.c

-- 
2.9.3
