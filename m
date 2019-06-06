From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v5 0/3] Basic DT support for Lenovo Miix 630
Date: Thu,  6 Jun 2019 09:10:55 -0700
Message-ID: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bjorn.andersson@linaro.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jikos@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
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

v5:
-Split out elan_i2c changes into their own patch
-Use a static list of strings to match
-Fixed typo of "whitelist"
-Dropped incorrect thermal zones
-Dropped tags from Bjorn and Lee since the functional should be
identical, but the code is structured different

v4:
-Changed the hid-quirks ELAN handling around per Benjamin Tissoires
-Dropped new DT binding

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
  Input: elan_i2c: Add comment about link between elan_i2c and
    hid-quirks
  HID: quirks: Refactor ELAN 400 and 401 handling
  arm64: dts: qcom: Add Lenovo Miix 630

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 240 ++++++++++++++++++
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  30 +++
 drivers/hid/hid-quirks.c                      |  78 +++++-
 drivers/input/mouse/elan_i2c_core.c           |   4 +
 5 files changed, 342 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts

-- 
2.17.1
