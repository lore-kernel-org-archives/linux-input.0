From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 20:31:10 +0200
Message-ID: <20170424183110.uhzegc6iauaa6noh@kozik-lap>
References: <20170424094231.435f82de@endymion>
 <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
 <20170424114841.130cad35@endymion>
 <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
 <20170424133414.1395ba3d@endymion>
 <CAJKOXPdSTyygm3MAP0EjVm8QWM3aC_M_DGnTVcBMWNUtwhSjqw@mail.gmail.com>
 <20170424170953.GB12374@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33185 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S975411AbdDXSbO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 14:31:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so8446252wmh.0
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 11:31:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170424170953.GB12374@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>

On Mon, Apr 24, 2017 at 10:09:53AM -0700, Dmitry Torokhov wrote:
> On Mon, Apr 24, 2017 at 01:56:06PM +0200, Krzysztof Kozlowski wrote:
> > Workaround might be using default = N, unless ARCH_EXYNOS. Something like:
> > default y if ARCH_EXYNOS
> 
> This would strongly imply that the device is available on all Exynos
> boards. I am fairly certain that our Chromebooks, for example, do not
> have it.

A new Kconfig keyword like "usable on" would imply that as well... I do
not know how you want to limit this to only few specific boards.

> 
> Besides, I do not see what is wrong with driver being offered on a
> platform that does not have it. This happens all the time. Consider I2C
> stuff:
> 
> config I2C_I801
> 	tristate "Intel 82801 (ICH/PCH)"
> 	depends on PCI
> 	select CHECK_SIGNATURE if X86 && DMI
> 	select I2C_SMBUS
> 
> This is an X86 device, but is offered everywhere where we have PCI.

But that I2C_I801 driver has a real dependency on PCI. It just needs the
PCI. This is why you have depends for.

Other drivers who exist only on Exynos boards do not have such
dependencies. They have only real hardware or software "depends", e.g.:
config MFD_MAX77686                                                                                                                                                                      
         tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
         depends on I2C
         depends on OF || COMPILE_TEST
         select MFD_CORE
         select REGMAP_I2C
         select REGMAP_IRQ
         select IRQ_DOMAIN

This driver needs I2C and OF. It does not need Exynos for anything,
although it is used only for Exynos specific boards so far.

Modeling drivers that "exist only on two Exynos based boards" through
depending on ARCH_EXYNOS is different. Not mentioning that the TM2 touch
key is in fact Cypress touchkey and could be used on other boards.

Best regards,
Krzysztof

