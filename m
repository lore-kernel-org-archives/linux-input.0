Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17AC4332F
	for <linux-input@archiver.kernel.org>; Wed,  4 Jan 2023 10:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjADKdR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Jan 2023 05:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjADKdQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2023 05:33:16 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780941E3D4
        for <linux-input@vger.kernel.org>; Wed,  4 Jan 2023 02:33:13 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pD153-0005Yn-Qh; Wed, 04 Jan 2023 11:33:09 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 34/69] Input: auo-pixcir-ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Wed, 04 Jan 2023 11:33:09 +0100
Message-ID: <4458575.LvFx2qVVIh@diego>
In-Reply-To: <20230102181842.718010-35-jic23@kernel.org>
References: <20230102181842.718010-1-jic23@kernel.org> <20230102181842.718010-35-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Am Montag, 2. Januar 2023, 19:18:07 CET schrieb Jonathan Cameron:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> SIMPLE_DEV_PM_OPS() is deprecated as it requires explicit protection
> against unused function warnings.  The new combination of pm_sleep_ptr()
> and DEFINE_SIMPLE_DEV_PM_OPS() allows the compiler to see the functions,
> thus suppressing the warning, but still allowing the unused code to be
> removed. Thus also drop the __maybe_unused markings.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


