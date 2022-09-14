Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8F9C6FA8A
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 15:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiINPGY (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINPGW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF048C96;
        Wed, 14 Sep 2022 08:06:21 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYTxz-0006ma-Gd; Wed, 14 Sep 2022 17:06:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Input: auo-pixcir-ts - switch to using generic device properties
Date:   Wed, 14 Sep 2022 17:06:18 +0200
Message-ID: <3194447.44csPzL39Z@phil>
In-Reply-To: <20220914141428.2201784-4-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com> <20220914141428.2201784-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Am Mittwoch, 14. September 2022, 16:14:27 CEST schrieb Dmitry Torokhov:
> Let's use generic device properties API instead of OF-specific one.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


