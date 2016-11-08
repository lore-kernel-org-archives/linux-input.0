From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 8 Nov 2016 23:34:07 +0100 (CET)
Message-ID: <1401051818.290769.fabb549c-29f9-4e5c-a868-650c6df97a1d.open-xchange@email.1und1.de>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, lee.jones@linaro.org
Cc: linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, marex@denx.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 2. November 2016 um
> 08:38 geschrieben:
> 
> 
> Add core files for low resolution analog-to-digital converter (mxs-lradc)
> MFD driver.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

for Patch 1 + 2

> ---
> ...
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9834e66..057ca15 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -211,3 +211,4 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o

Btw this part won't apply anymore
