From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH v2 0/2] Qualcomm PM8941 power key driver
Date: Fri, 23 Jan 2015 16:19:05 -0800
Message-ID: <1422058747-13486-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These patches add dt bindings and a device driver for the power key block in
the Qualcomm PM8941 pmic.

Changes since v1:
 * Use a reboot_notifier to set power off/reboot mode
 * Use irq flags from devicetree
 * Some style fixes

Courtney Cavin (2):
  input: Add Qualcomm PM8941 power key driver
  input: pm8941-pwrkey: Add DT binding documentation

 .../bindings/input/qcom,pm8941-pwrkey.txt          |  43 ++++
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pm8941-pwrkey.c                 | 281 +++++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
 create mode 100644 drivers/input/misc/pm8941-pwrkey.c

-- 
1.9.1
