From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] Immutable branch between MFD, Regulator and RTC
Date: Wed, 31 Aug 2016 09:38:49 +0100
Message-ID: <20160831083849.GQ10121@dell>
References: <1470921406-18468-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <rtc-linux+bncBDA7X7F2WUEBBLVOTK7AKGQEDEMJJBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1470921406-18468-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Enjoy!

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d=
:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-reg=
ulator-rtc-v4.9

for you to fetch changes up to ddc085d44dd001e65eecd0a8bf05064bff063668:

  regulator: qcom_rpm-regulator: Add support for pm8018 rpm regulator (2016=
-08-31 09:33:54 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Regulator and RTC due for the v4.9 merge wind=
ow.

----------------------------------------------------------------
Neil Armstrong (4):
      mfd: pm8921: Add support for pm8018
      rtc: rtc-pm8xxx: Add support for pm8018 rtc
      mfd: qcom-rpm: Add support for pm8018 RPM Regulator
      regulator: qcom_rpm-regulator: Add support for pm8018 rpm regulator

 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |  1 +
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 15 +++++
 drivers/mfd/pm8921-core.c                          |  1 +
 drivers/mfd/qcom_rpm.c                             | 51 +++++++++++++++++
 drivers/regulator/qcom_rpm-regulator.c             | 66 ++++++++++++++++++=
++++
 drivers/rtc/rtc-pm8xxx.c                           |  1 +
 include/dt-bindings/mfd/qcom-rpm.h                 | 22 ++++++++
 7 files changed, 157 insertions(+)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
