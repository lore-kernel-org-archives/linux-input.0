From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, Input and Watchdog due for
 the v5.1 merge window
Date: Wed, 16 Jan 2019 14:04:26 +0000
Message-ID: <20190116140426.GF23399@dell>
References: <1547460290-21049-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547460290-21049-1-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

Enjoy!

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-watchdog-v5.1

for you to fetch changes up to 28804c2c8fb3401aa4b7f16a883d49dd82f5e377:

  watchdog: stpmic1: Add STPMIC1 watchdog driver (2019-01-16 14:01:19 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Input and Watchdog due for the v5.1 merge window

----------------------------------------------------------------
Pascal PAILLET-LME (6):
      dt-bindings: mfd: Document STPMIC1
      mfd: stpmic1: Add STPMIC1 driver
      dt-bindings: input: Document STPMIC1 PMIC onkey
      input: stpmic1: Add STPMIC1 onkey driver
      dt-bindings: watchdog: document STPMIC1 PMIC watchdog
      watchdog: stpmic1: Add STPMIC1 watchdog driver

 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  16 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmic1_wdt.c                     | 139 ++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               |  50 +++++
 include/linux/mfd/stpmic1.h                        | 212 ++++++++++++++++++++
 14 files changed, 955 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 drivers/input/misc/stpmic1_onkey.c
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 drivers/watchdog/stpmic1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 create mode 100644 include/linux/mfd/stpmic1.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
