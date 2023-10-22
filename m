Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ACCDB474
	for <linux-input@archiver.kernel.org>; Sun, 22 Oct 2023 15:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJVPNJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 22 Oct 2023 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVPNI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Oct 2023 11:13:08 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40324E8;
        Sun, 22 Oct 2023 08:13:04 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 0DB5D20289;
        Sun, 22 Oct 2023 17:13:01 +0200 (CEST)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id A62B27FC11;
        Sun, 22 Oct 2023 17:13:00 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1qua8S-0000u1-1m;
        Sun, 22 Oct 2023 17:13:00 +0200
Date:   Sun, 22 Oct 2023 17:13:00 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
Subject: Re: [PATCH v2 0/2] Input: ilitek_ts_i2c - Fix spurious input events
Message-ID: <ZTU7_ICOgw9tka8I@livingston.pivistrello.it>
References: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello Dmitry,

On Wed, Sep 20, 2023 at 09:46:48AM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> A couple of fixes to prevent spurious events when the data buffer is not the expected one.
> 
> Emanuele Ghidoli (2):
>   Input: ilitek_ts_i2c - avoid wrong input subsystem sync
>   Input: ilitek_ts_i2c - add report id message validation
> 
>  drivers/input/touchscreen/ilitek_ts_i2c.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Just a gently ping on this series.

Thanks,
Francesco

