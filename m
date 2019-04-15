From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 0/3] Basic DT support for Lenovo Miix 630
Date: Mon, 15 Apr 2019 09:09:15 -0700
Message-ID: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: lee.jones@linaro.org, bjorn.andersson@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
List-Id: linux-input@vger.kernel.org

The Lenovo Miix 630 is one of three ARM based (specifically Qualcomm
MSM8998) laptops that comes with Windows, and seems to have a dedicated
following of folks intrested to get Linux up and running on it.

This series adds support for the basic functionality this is validated
towork using devicetree.  Although the laptops do feed ACPI to Windows,
the existing MSM8998 support in mainline is DT based, so DT provides a
quick path to functionality while ACPI support is investigated.

The three devices are very similar, but do have differences in the set
of peripherals supported, so the idea is that the vast majority of the
support for all three can live in a common include, which should reduce
overall duplication.  Adding support for the other two devices as a
follow on should involve minimal work.

The bleeding edge work for these laptops and work in progress can be
found at https://github.com/aarch64-laptops/prebuilt

v3:
-Changed "clam" to "clamshell"
-Defined a dt binding for the combo Elan keyboard + touchpad device
-Adjusted the HID quirk to be correct for dt boot
-Removed extranious comment in board dts
-Fixed board level compatible

v2:
-Changed "cls" to "clam" since feedback indicated "cls" is too opaque,
but
"clamshell" is a mouthfull.  "clam" seems to be a happy medium.

Jeffrey Hugo (3):
  dt-bindings: input: add Elan 400 combo keyboard/touchpad over i2c
  HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630 for DT
  arm64: dts: qcom: Add Lenovo Miix 630

 .../bindings/input/elan,combo400-i2c.txt      |  11 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 278 ++++++++++++++++++
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  30 ++
 drivers/hid/hid-quirks.c                      |   3 +-
 5 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts

-- 
2.17.1
