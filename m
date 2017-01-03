From: Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/4] Add touch key driver support for TM2
Date: Tue, 03 Jan 2017 16:57:13 +0900
Message-ID: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
References: <CGME20170103075733epcas5p48985c789a816f1f2eae84c52e070cc14@epcas5p4.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galaxyra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

This patchset adds support for the tm2 touchkey device.

The driver has been ported from Tizen Kernel, originally written
by Beomho. I ported it to the latest mainline Kernel.

dts has been separated between tm2 and tm2e because touchkey is present in tm2
but not tm2e.

Best Regards,
Jaechul

Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/samsung,tm2-touchkey.txt        |   27 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1037 +------------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tm2-touchkey.c              |  326 ++++++
 7 files changed, 1422 insertions(+), 1028 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
