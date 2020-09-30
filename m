Return-Path: <SRS0=VgpC=DH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C41C4727E
	for <linux-input@archiver.kernel.org>; Wed, 30 Sep 2020 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22D920706
	for <linux-input@archiver.kernel.org>; Wed, 30 Sep 2020 17:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="hybbOS8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3R2q (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 30 Sep 2020 13:28:46 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:46148 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI3R2p (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Sep 2020 13:28:45 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4C1jsQ2X2qz6R;
        Wed, 30 Sep 2020 19:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601486924; bh=8Ui9TfAAjPNnKxDVRtx0NMAj8Bki4TbbzB+F4+j1aaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hybbOS8qzLFgVTMiFOVYtxK6Ec/qLywpBc4Flvwgrle47IYVASVFDIW2LNgFeSl8y
         2+1nkbWV/Iq3Ww4Ju+kQ+j3cZj+erwSNet0yErb2PW1iaUMfHeHZapwo91v0DEouPv
         ryGoiLd096qQQ06J5mcK4lBkmEOoVjyyIGhp1o3yhNFMit1HduRJnHvW7mAMJEXrsD
         DtQFAnrvHRPBf22Em1M4UNFNo5VMRq2hXhp03F/vwEShCwmVHe4Fy7pTCqlcbAgjA/
         zNvH/TQVLr7X9kiThkzRUzYjqO9UBO5yBzr4Zq4TNFV2dzpK4eQnv5q55jb0WWIOF6
         jEknUfhuZMKcw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 30 Sep 2020 19:28:41 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Chen <james.chen@emc.com.tw>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Scott Liu <scott.liu@emc.com.tw>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] input: elants: Support Asus TF300T and Nexus 7
 touchscreen
Message-ID: <20200930172841.GB12964@qmqm.qmqm.pl>
References: <cover.1600551334.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1600551334.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, Sep 19, 2020 at 11:41:19PM +0200, Micha³ Miros³aw wrote:
> This series cleans up the driver a bit and implements changes needed to
> support EKTF3624-based touchscreen used in Asus TF300T, Google Nexus 7
> and similar Tegra3-based tablets.
[...]

Ping? Should I resend? This got only cosmetic fixups and rebases through
last couple of iterations.

Best Regards
Micha³ Miros³aw
