From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 00/17] ARM: sunxi: Support cpufreq on sun[457]i
Date: Tue,  6 Jan 2015 10:35:10 +0800
Message-ID: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40940 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbAFCfm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi everyone,

This series adds support cpufreq support for sun[457]i using cpufreq-dt.
This also supports passive cpu cooling (thermal throttling) using thermal
zones with the temperature sensor in the SoC.

The operating points for the supported platforms were taken from the
linux-sunxi FEX files repository. The majority of boards use the same
settings. Only with sun7i do we see slight variations, either disabling
some frequencies, or bumping up the voltage a bit. In either case this
can be done by limiting the constraints for the supply regulator, or 
overriding the OPP table in the board dts file.

On sun7i, there is an additional operating point not found in the FEX
files, 960 MHz @ 1.4V, which is the full speed setting in both u-boot-sunxi
and mainline u-boot.

The series has been tested on the 4 boards I have. With cpufreq active,
the effects are visible as a decrease in SoC internal temperature.
Stability for the operating points has been tested using:

  http://linux-sunxi.org/Hardware_Reliability_Tests#Reliability_of_cpufreq_voltage.2Ffrequency_settings

More real world usage feedback is appreciated. Thermal throttling hasn't
been tested much, due to not being able to generate enough load without
the GPU for the SoC to heat up. Also on sun4i, the temperature sensor
still hasn't been calibrated, so the readings are highly inaccurate.


Patch 1 registers the cpufreq-dt platform device for all known single
cluster (all cores sharing the same supply and clock line) sunxi
platforms with a late init call.

Patch 2 makes the sunxi mux clocks propagate clk_set_rate calls to
parents. This is needed as the cpu clocks are simple mux clocks. The
actual changing part is the parent PLL.

Patch 3 adds thermal zone sensor support to sun4i-ts, which already
has hwmon support. This is used for thermal throttling.

Patch 4 adds a dtsi file for the AXP209 PMIC, which holds a list of
regulators and some common properties.

Patch 5 adds #thermal-sensor-cells to sun[457]i dtsi files for the
thermal framework.

Patch 6 adds the cpu clock and OPP to sun7i dtsi. At this point cpufreq
is usable. However the OPP does have points with over-voltage (> 1.4V).
Without the regulator reference, bumping the frequency up may be
unstable.

Patch 7 adds thermal zones for passive cooling to sun7i dtsi. This
includes a constant which should be a macro. Maxime is working on
cleaning up the sunxi dts files, so I'll leave this bit for later
to avoid repeated work and conflicts.

Patch 8 and 9 adds the axp209 regulator constraints and references
for cubieboard2 and cubietruck.

Patches 10~15 do the same as 7~9, except for sun4i and sun5i.

Patch 16 enables support for cpufreq and thermal throttling in
sunxi_defconfig.

Patch 17 does the same for multi_v7_defconfig.


The thermal sensor bits are pretty standard. Nevertheless I've included
the thermal subsystem supporters.

Dmitry, could you pick up patch 3?

Maxime, could you take a look at the rest?


Thanks
ChenYu


Chen-Yu Tsai (17):
  ARM: sunxi: Register cpufreq-dt for sun[45678]i
  clk: sunxi: Propagate rate changes to parent for mux clocks
  Input: sun4i-ts: Add thermal zone sensor support
  ARM: dts: sunxi: Add dtsi for AXP209 PMIC
  ARM: dts: sunxi: Enable thermal sensor support for RTP on sun[457]i
  ARM: dts: sun7i: Add cpu clock reference and operating points to dtsi
  ARM: dts: sun7i: Add cpu thermal zones to dtsi
  ARM: dts: sun7i: cubieboard2: add axp209 regulator nodes
  ARM: dts: sun7i: cubietruck: add axp209 regulator nodes
  ARM: dts: sun5i: Add cpu clock reference and operating points to dtsi
  ARM: dts: sun5i: Add cpu thermal zones to dtsi
  ARM: dts: sun5i: hsg-h702: add axp209 regulator nodes
  ARM: dts: sun4i: Add cpu clock reference and operating points to dtsi
  ARM: dts: sun4i: Add cpu thermal zones to dtsi
  ARM: dts: sun4i: cubieboard: add axp209 regulator nodes
  ARM: sunxi_defconfig: Enable TOUCHSCREEN_SUN4I, CPUFREQ_DT,
    CPU_THERMAL
  ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I, CPU_THERMAL

 .../bindings/input/touchscreen/sun4i.txt           |  1 +
 arch/arm/boot/dts/axp209.dtsi                      | 91 ++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         | 35 ++++++++-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 48 +++++++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  1 +
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           | 46 +++++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 51 +++++++++++-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        | 35 ++++++++-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         | 35 ++++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 51 +++++++++++-
 arch/arm/configs/multi_v7_defconfig                |  2 +
 arch/arm/configs/sunxi_defconfig                   |  7 +-
 arch/arm/mach-sunxi/sunxi.c                        | 10 +++
 drivers/clk/sunxi/clk-sunxi.c                      |  2 +-
 drivers/input/touchscreen/sun4i-ts.c               | 27 +++++++
 15 files changed, 417 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp209.dtsi

-- 
2.1.4

