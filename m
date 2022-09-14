Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C823DECAAD3
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiINOk3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINOk2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 10:40:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE650725;
        Wed, 14 Sep 2022 07:40:25 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYTYt-0006db-9r; Wed, 14 Sep 2022 16:40:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: auo-pixcir-ts - drop support for platform data
Date:   Wed, 14 Sep 2022 16:40:22 +0200
Message-ID: <5602073.DvuYhMxLoT@phil>
In-Reply-To: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Am Mittwoch, 14. September 2022, 16:14:24 CEST schrieb Dmitry Torokhov:
> Currently there are no users of auo_pixcir_ts_platdata in the mainline, and
> having it (with legacy gpio numbers) prevents us from converting the driver
> to gpiod API, so let's drop it.
> 
> If, in the future, someone wants to use this driver on non-device tree,
> non-ACPI system, they should use static device properties instead of
> platform data.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


