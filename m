From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/5] Add support for the Qualcomm PM8018 PMIC
Date: Fri, 17 Jun 2016 12:22:04 +0200
Message-ID: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDAYD2P3QYGRBVU6R65QKGQEAJWDCUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, add the PM8018 PMIC support into MFD, Regulator, RTC and input.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

Neil Armstrong (5):
  mfd: pm8921: Add support for pm8018
  input: pmic8xxx-pwrkey: Add support for pm8018 pwrkey
  rtc: rtc-pm8xxx: Add support for pm8018 rtc
  mfd: qcom-rpm: Add support for pm8018 RPM Regulator
  regulator: qcom_rpm-regulator: Add support for pm8018 rpm regulator

 .../bindings/input/qcom,pm8xxx-pwrkey.txt          |   1 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  15 +++
 drivers/input/misc/pmic8xxx-pwrkey.c               |   1 +
 drivers/mfd/pm8921-core.c                          |   1 +
 drivers/mfd/qcom_rpm.c                             |  45 +++++++
 drivers/regulator/qcom_rpm-regulator.c             | 134 +++++++++++++++++++++
 drivers/rtc/rtc-pm8xxx.c                           |  11 ++
 include/dt-bindings/mfd/qcom-rpm.h                 |  23 ++++
 9 files changed, 232 insertions(+)

-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
