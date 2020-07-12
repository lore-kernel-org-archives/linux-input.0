Return-Path: <SRS0=jc0I=AX=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544ABC433E3
	for <linux-input@archiver.kernel.org>; Sun, 12 Jul 2020 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E7820674
	for <linux-input@archiver.kernel.org>; Sun, 12 Jul 2020 21:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgGLVC3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:02:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59228 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLVC3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Jul 2020 17:02:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 97C8D1C0BDE; Sun, 12 Jul 2020 23:02:23 +0200 (CEST)
Date:   Sun, 12 Jul 2020 23:02:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] ARM: dts: sun8i-a83t-tbs-a711: Add support for
 the vibrator motor
Message-ID: <20200712210222.GA983@bug>
References: <20200702112041.1942707-1-megous@megous.com>
 <20200702112041.1942707-4-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702112041.1942707-4-megous@megous.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi!

> The board has a vibrator mottor. Hook it to the input subsystem.

motor, I believe.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
