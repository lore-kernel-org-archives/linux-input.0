Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC38FECAAD3
	for <linux-input@archiver.kernel.org>; Thu, 15 Sep 2022 13:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIONId (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 15 Sep 2022 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIONIc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2022 09:08:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6954C8C;
        Thu, 15 Sep 2022 06:08:27 -0700 (PDT)
Received: from [89.101.193.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYobR-0004k4-Dn; Thu, 15 Sep 2022 15:08:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: auo-pixcir-ts - switch to using gpiod API
Date:   Thu, 15 Sep 2022 15:08:24 +0200
Message-ID: <1736542.VLH7GnMWUR@phil>
In-Reply-To: <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com> <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Am Mittwoch, 14. September 2022, 16:14:25 CEST schrieb Dmitry Torokhov:
> This switches the driver to gpiod API and drops uses of of_get_gpio() API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


