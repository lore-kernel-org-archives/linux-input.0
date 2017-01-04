From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 5/5] mfd: Move binding document
Date: Wed, 4 Jan 2017 10:57:30 +0000
Message-ID: <20170104105730.GW27589@dell>
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
 <bdf92a9bfc74fc9f9741caf508b1d6e2f45826b0.1481234322.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:36750 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdADKxs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2017 05:53:48 -0500
Received: by mail-wj0-f172.google.com with SMTP id c11so261128615wjx.3
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 02:53:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bdf92a9bfc74fc9f9741caf508b1d6e2f45826b0.1481234322.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com

On Thu, 08 Dec 2016, Ksenija Stanojevic wrote:

> The bindings, which are now used in MFD, need also to be
> documented in the MFD binding document.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> ---
> Changes in v11:
>  - none
> 
> Changes in v10:
>  - none
> 
> Changes in v9:
>  - format patch using -M option
> 
> Changes in v8:
>  - rebase onto 4.9-rc1
> 
> Changes in v7:
>  - add to the patchset
> 
>  Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> rename to Documentation/devicetree/bindings/mfd/mxs-lradc.txt

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
