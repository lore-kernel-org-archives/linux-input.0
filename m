From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/8] mfd: stpmu1: add stpmu1 pmic driver
Date: Mon, 16 Jul 2018 16:15:58 -0600
Message-ID: <20180716221558.GA3786@rob-hp-laptop>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-3-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530803657-17684-3-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 05, 2018 at 03:14:22PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmu1 is a pmic from STMicroelectronics. The stpmu1 integrates 10
> regulators and 3 switches with various capabilities.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  drivers/mfd/Kconfig                 |  14 ++
>  drivers/mfd/Makefile                |   1 +
>  drivers/mfd/stpmu1.c                | 490 ++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmu1.h |  46 ++++

This belongs with patch 1.

>  include/linux/mfd/stpmu1.h          | 220 ++++++++++++++++
>  5 files changed, 771 insertions(+)
>  create mode 100644 drivers/mfd/stpmu1.c
>  create mode 100644 include/dt-bindings/mfd/st,stpmu1.h
>  create mode 100644 include/linux/mfd/stpmu1.h
