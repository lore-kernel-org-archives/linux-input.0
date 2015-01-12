From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v3 0/9] ARM: sunxi: Support cpufreq on sun[457]i
Date: Mon, 12 Jan 2015 12:34:00 +0800
Message-ID: <1421037249-28461-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:44976 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbbALEeU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2015 23:34:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi,

This is v3 of the cpufreq support series for sunxi. The series has been
rebased onto the latest sunxi-next. I've dropped all the patches Maxime
merged. This includes "ARM: sunxi: Register cpufreq-dt for sun[45678]i"
which was merged but not published yet.

Individual changes since v2 are listed within each patch.


Original cover letter follows:

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


Chen-Yu Tsai (9):
  Input: sun4i-ts: Add thermal zone sensor support
  ARM: dts: sunxi: Add dtsi for AXP209 PMIC
  ARM: dts: sun7i: Add cpu thermal zones to dtsi
  ARM: dts: sun7i: cubieboard2: add axp209 regulator nodes
  ARM: dts: sun7i: cubietruck: add axp209 regulator nodes
  ARM: dts: sun5i: Add cpu thermal zones to dtsi
  ARM: dts: sun5i: hsg-h702: add axp209 regulator nodes
  ARM: dts: sun4i: Add cpu thermal zones to dtsi
  ARM: dts: sun4i: cubieboard: add axp209 regulator nodes

 .../bindings/input/touchscreen/sun4i.txt           |  2 +
 arch/arm/boot/dts/axp209.dtsi                      | 97 ++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         | 35 +++++++-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 34 ++++++++
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           | 46 ++++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 34 ++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        | 35 +++++++-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         | 35 +++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 33 ++++++++
 drivers/input/touchscreen/sun4i-ts.c               | 54 +++++++++++-
 10 files changed, 381 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp209.dtsi

-- 
2.1.4

