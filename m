From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v5 0/4] mxs-lradc: Split driver into MFD
Date: Tue, 23 Aug 2016 22:18:55 +0200 (CEST)
Message-ID: <770097944.403326.225ddbfe-fd96-4f9b-a2b9-e0173af882ba.open-xchange@email.1und1.de>
References: <cover.1471524593.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:60083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbcHWUTV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Aug 2016 16:19:21 -0400
In-Reply-To: <cover.1471524593.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org, linux-iio@vger.kernel.org, marex@denx.de, Fabio Estevam <fabio.estevam@nxp.com>

Hi,

[add Fabio's NXP address]

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 18. August 2016 um
> 15:44 geschrieben:
> 
> 
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28.

i tested the patch 1 and 2 successful on a i.MX23 board.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

> 
> 
> Ksenija Stanojevic (4):
>   mfd: mxs-lradc: Add support for mxs-lradc MFD
>   iio: adc: mxs-lradc: Add support for adc driver
>   input: touchscreen: mxs-lradc: Add support for touchscreen
>   iio: adc: mxs-lradc: Remove driver
> 
>  drivers/iio/adc/Kconfig                  |   27 +-
>  drivers/iio/adc/Makefile                 |    2 +-
>  drivers/iio/adc/mxs-lradc-adc.c          |  844 ++++++++++++++
>  drivers/iio/adc/mxs-lradc.c              | 1775
> ------------------------------
>  drivers/input/touchscreen/Kconfig        |   10 +
>  drivers/input/touchscreen/Makefile       |    1 +
>  drivers/input/touchscreen/mxs-lradc-ts.c |  742 +++++++++++++
>  drivers/mfd/Kconfig                      |   17 +
>  drivers/mfd/Makefile                     |    1 +
>  drivers/mfd/mxs-lradc.c                  |  255 +++++
>  include/linux/mfd/mxs-lradc.h            |  194 ++++
>  11 files changed, 2078 insertions(+), 1790 deletions(-)
>  create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
> 
> -- 
> 1.9.1
>
