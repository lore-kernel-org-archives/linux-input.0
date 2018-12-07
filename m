From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Date: Fri, 7 Dec 2018 07:31:32 +0000
Message-ID: <20181207073132.GH26661@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181203071145.GA26661@dell>
 <5C069C47.6080305@st.com>
 <20181205093604.GZ26661@dell>
 <5C07F08B.2010701@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C07F08B.2010701@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

On Wed, 05 Dec 2018, Pascal PAILLET-LME wrote:

> 
> pascal paillet (p.paillet@st.com) Le Mans / France
> Microcontrollers and Digital ICs Group | Application Development
> TEL: +33.(0)2.44.02.74.69 | TINA: 166 7469
> 
> Le 12/05/2018 10:36 AM, Lee Jones a écrit :
> > On Tue, 04 Dec 2018, Pascal PAILLET-LME wrote:
> >> Le 12/03/2018 08:11 AM, Lee Jones a écrit :
> >>> On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:
> >>>
> >>>> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from
> >>>> STMicroelectronics.
> >>>> The STPMIC1 regulators supply power to an application processor as well as
> >>>> to external system peripherals such as DDR, Flash memories and system
> >>>> devices. It also features onkey button input and an hardware watchdog.
> >>>> The STPMIC1 is controlled via I2C.
> >>>>
> >>>> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> >>>> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> >>>> as parent.
> >>>>
> >>>> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> >>>>
> >>>> Pascal Paillet (7):
> >>>> changes in v7:
> >>>> * rebase on regul/for-next
> >>>>
> >>>>     dt-bindings: mfd: document stpmic1
> >>>>     mfd: stpmic1: add stpmic1 driver
> >>>>     dt-bindings: input: document stpmic1 pmic onkey
> >>>>     input: stpmic1: add stpmic1 onkey driver
> >>>>     dt-bindings: watchdog: document stpmic1 pmic watchdog
> >>>>     watchdog: stpmic1: add stpmic1 watchdog driver
> >>>>     regulator: stpmic1: fix regulator_lock usage
> >>>>
> >>>>    .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
> >>>>    .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
> >>>>    .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
> >>>>    drivers/input/misc/Kconfig                         |  11 ++
> >>>>    drivers/input/misc/Makefile                        |   2 +
> >>>>    drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
> >>>>    drivers/mfd/Kconfig                                |  16 ++
> >>>>    drivers/mfd/Makefile                               |   1 +
> >>>>    drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
> >>>>    drivers/regulator/stpmic1_regulator.c              |   2 +-
> >>> Is it just Mark you're waiting on now?
> >> It is ok now, Mark has applied the patch.
> >> Evrey thing has been acked now. What is the nex step ?
> > Mark has applied patch 7?
> >
> > Why don't I see that?  Should you have removed it from this set?
> Hi Lee, I have received an email from Mark telliing that the regulator 
> patch is applied on
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git  
> 
> I can see it on the branch regul/for-next.

Mark,

Does your patch tracker only reply to the author?

Any reason why I don't see it?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
