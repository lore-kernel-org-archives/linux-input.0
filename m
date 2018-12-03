From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Date: Mon, 3 Dec 2018 07:11:45 +0000
Message-ID: <20181203071145.GA26661@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543571742-17995-1-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:

> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
> STMicroelectronics. 
> The STPMIC1 regulators supply power to an application processor as well as 
> to external system peripherals such as DDR, Flash memories and system
> devices. It also features onkey button input and an hardware watchdog.
> The STPMIC1 is controlled via I2C. 
> 
> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> as parent.
> 
> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> 
> Pascal Paillet (7):
> changes in v7:
> * rebase on regul/for-next
> 
>   dt-bindings: mfd: document stpmic1
>   mfd: stpmic1: add stpmic1 driver
>   dt-bindings: input: document stpmic1 pmic onkey
>   input: stpmic1: add stpmic1 onkey driver
>   dt-bindings: watchdog: document stpmic1 pmic watchdog
>   watchdog: stpmic1: add stpmic1 watchdog driver
>   regulator: stpmic1: fix regulator_lock usage
> 
>  .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
>  .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
>  .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
>  drivers/input/misc/Kconfig                         |  11 ++
>  drivers/input/misc/Makefile                        |   2 +
>  drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
>  drivers/mfd/Kconfig                                |  16 ++
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++

>  drivers/regulator/stpmic1_regulator.c              |   2 +-

Is it just Mark you're waiting on now?

>  drivers/watchdog/Kconfig                           |  12 ++
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/stpmic1_wdt.c                     | 139 ++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  50 +++++
>  include/linux/mfd/stpmic1.h                        | 212 ++++++++++++++++++++
>  15 files changed, 956 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
>  create mode 100644 drivers/input/misc/stpmic1_onkey.c
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 drivers/watchdog/stpmic1_wdt.c
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
>  create mode 100644 include/linux/mfd/stpmic1.h
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
