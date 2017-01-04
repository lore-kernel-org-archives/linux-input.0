From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 4 Jan 2017 10:33:08 +0000
Message-ID: <20170104103308.GV27589@dell>
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
 <7122f136e4735fe18c8b431006e6d6314b3c7e41.1481234322.git.ksenija.stanojevic@gmail.com>
 <8b5ad884-ed94-c776-043d-1dbdd64182d2@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f174.google.com ([209.85.210.174]:33912 "EHLO
        mail-wj0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdADK30 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2017 05:29:26 -0500
Received: by mail-wj0-f174.google.com with SMTP id tn15so6954680wjb.1
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 02:29:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8b5ad884-ed94-c776-043d-1dbdd64182d2@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com

On Thu, 08 Dec 2016, Marek Vasut wrote:

> On 12/08/2016 11:27 PM, Ksenija Stanojevic wrote:
> > Add core files for low resolution analog-to-digital converter (mxs-lradc)
> > MFD driver.
> > 
> > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> 
> Just a nit below.
> 
> > +++ b/include/linux/mfd/mxs-lradc.h
> > @@ -0,0 +1,187 @@
> > +/*
> 
> [...]
> 
> > +#define LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
> > +#define LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
> > +#define LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
> > +#define LRADC_CTRL1_TOUCH_DETECT_IRQ		BIT(8)
> > +#define LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
> 
> This would turn into BIT(n) , no ?

Once you have fixed this, you can apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> > +#define LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
> > +#define LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
> > +#define LRADC_CTRL1_LRADC_IRQ_OFFSET		0
> 
> [...]
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
