From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v8 0/5] Basic DT support for Lenovo Miix 630
Date: Fri, 21 Jun 2019 07:48:54 -0700
Message-ID: <20190621144854.38568-1-jeffrey.l.hugo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jikos@kernel.org, hdegoede@redhat.com, bjorn.andersson@linaro.org, agross@kernel.org, lee.jones@linaro.org, xnox@ubuntu.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
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
overall duplication.  Adding support for the other two devices is tacked
onto the end of the series.

The bleeding edge work for these laptops and work in progress can be
found at https://github.com/aarch64-laptops/prebuilt

v8:
-Used original Elan copyright for new header file
-Kept the DT ids in the Elan core driver instead of miving them to the
header
-Fixed "device" misspelling in new header

v7:
-Removed HID matching on compatible strings as it was determined to be
not needed

v6:
-Export the elan_i2c DT and ACPI ids so that hid-quirks can use them
-Use the elan_i2c ids within hid-quirks to reduce duplication
-Add DTs for the Asus and HP devices since the DT seems finalized, and
folks have been asking

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

Jeffrey Hugo (5):
  Input: elan_i2c: Export the device id whitelist
  HID: quirks: Refactor ELAN 400 and 401 handling
  arm64: dts: qcom: Add Lenovo Miix 630
  arm64: dts: qcom: Add HP Envy x2
  arm64: dts: qcom: Add Asus NovaGo TP370QL

 arch/arm64/boot/dts/qcom/Makefile             |   3 +
 .../dts/qcom/msm8998-asus-novago-tp370ql.dts  |  47 ++++
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 240 ++++++++++++++++++
 .../boot/dts/qcom/msm8998-hp-envy-x2.dts      |  30 +++
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  30 +++
 drivers/hid/hid-quirks.c                      |  22 +-
 drivers/input/mouse/elan_i2c_core.c           |  50 +---
 include/linux/input/elan-i2c-ids.h            |  76 ++++++
 8 files changed, 438 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
 create mode 100644 include/linux/input/elan-i2c-ids.h

-- 
2.17.1
