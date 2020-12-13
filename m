Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23AC0018C
	for <linux-input@archiver.kernel.org>; Sun, 13 Dec 2020 05:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21D823128
	for <linux-input@archiver.kernel.org>; Sun, 13 Dec 2020 05:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgLMFNC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgLMFNB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Dec 2020 00:13:01 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607836341;
        bh=TqzYETjbAAR1v2pDu9TQPnyXw2xJaDm3B4LiTu3mQMM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QbAqkXZjlL1HfckhuofwW20rTV3ZOXA/K1zeyUSZL7cjLcSMAKH2WAzCZRpQB19aT
         XzFukeUduJLDbh5Uhl6ORk9IE81+uQCuhIw7zCc+yTuYMVwsbd0z2ntZlysAEpxMwV
         77jRtq9rPTy1YOY5hBvo+csOOyocfHrt42Zfjv/zLyNeD3FXzEyNGWZ29mZHMO/TFJ
         Pi17yB8s0Alj02B/bCifDguVgSUvYWBgpdTUzh7tIe1NytFyfFHIgWxX1xUCpkQfGh
         +LA3AzFzRJE3uA5/o+dVrDxzMYtLqUaZ99uUZEHNkO1u6k3zgluOOZRohgMlDSXWPI
         0+d0hS/06Z5hA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201211164801.7838-4-nsaenzjulienne@suse.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de> <20201211164801.7838-4-nsaenzjulienne@suse.de>
Subject: Re: [PATCH v6 03/11] clk: bcm: rpi: Release firmware handle on unbind
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Michael Turquette <mturquette@baylibre.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Date:   Sat, 12 Dec 2020 21:12:19 -0800
Message-ID: <160783633985.1580929.12212485236101493377@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Quoting Nicolas Saenz Julienne (2020-12-11 08:47:52)
> Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
> interface when unbinding the device.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
