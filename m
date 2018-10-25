From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v3 0/3] ARM: qcom: add vibrator support for various MSM SOCs
Date: Wed, 24 Oct 2018 21:29:34 -0400
Message-ID: <20181025012937.2154-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, andy.gross@linaro.org, david.brown@linaro.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, masneyb@onstation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, jonathan@marek.ca
List-Id: linux-input@vger.kernel.org

This patch set adds support for the vibrator found on various Qualcomm
MSM SOCs. This is based on work from:

Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd060f8b52087a68ab93583292b5

Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
Android 3.4.0 sources:
https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-lollipop-wear-release/drivers/misc/msm_pwm_vibrator.c

Driver was tested on a LG Nexus 5 (hammerhead) phone using rumble-test:
https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

Changes since v2
- Moved from pwm to input subsystem based on feedback from
  https://lore.kernel.org/lkml/20181012114749.GC31561@ulmo/. I
  previously wired this into the input system via pwm-vibra.

Changes since v1
- Update device tree binding document based on feedback from Rob
  Herring.
- Changed the driver description to: Qualcomm PWM driver for the MSM
  vibrator.

Brian Masney (3):
  dt-bindings: Input: new bindings for MSM vibrator
  Input: add new vibrator driver for various MSM SOCs
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    vibrator

 .../bindings/input/msm-vibrator.txt           |  36 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  31 ++
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/msm-vibrator.c             | 276 ++++++++++++++++++
 5 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt
 create mode 100644 drivers/input/misc/msm-vibrator.c

-- 
2.17.2
