Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC7C433DF
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 11:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B2320842
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPLDh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:03:37 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55104 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPLDe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 07:03:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0D7FF1C0C0A; Tue, 16 Jun 2020 13:03:33 +0200 (CEST)
Date:   Tue, 16 Jun 2020 13:03:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 2/3] drivers: input: misc: Add mtk vibrator driver
Message-ID: <20200616110325.GL1718@bug>
References: <20200615114203.116656-1-fengping.yu@mediatek.com>
 <20200615114203.116656-3-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615114203.116656-3-fengping.yu@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon 2020-06-15 19:42:04, Fengping Yu wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This adds regulator vibrator driver for Mediatek SoCs.
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> ---
>  drivers/input/misc/Kconfig              |  10 +
>  drivers/input/misc/Makefile             |   1 +
>  drivers/input/misc/regulator-vibrator.c | 422 ++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
>  create mode 100644 drivers/input/misc/regulator-vibrator.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 7e2e658d551c..71a0dd7a5271 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -459,6 +459,16 @@ config INPUT_REGULATOR_HAPTIC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called regulator-haptic.
>  
> +config INPUT_REGULATOR_VIBRATOR

Can you look at input_regulator_haptic, and explain why you need separate driver?

										Pavel
