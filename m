Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DBC433FE
	for <linux-input@archiver.kernel.org>; Fri,  3 Sep 2021 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02B0610CF
	for <linux-input@archiver.kernel.org>; Fri,  3 Sep 2021 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhICQSC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Fri, 3 Sep 2021 12:18:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53262 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhICQSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2021 12:18:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 719691C0B87; Fri,  3 Sep 2021 18:17:00 +0200 (CEST)
Date:   Fri, 3 Sep 2021 18:16:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Roderick Colenbrander <roderick@gaikai.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        "Daniel J . Ogorchock" <djogorchock@gmail.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
Subject: Re: [PATCH v2 1/3] HID: playstation: expose DualSense lightbar
 through a multi-color LED.
Message-ID: <20210903161659.GA2209@bug>
References: <20210901223037.2964665-1-roderick.colenbrander@sony.com>
 <20210901223037.2964665-2-roderick.colenbrander@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210901223037.2964665-2-roderick.colenbrander@sony.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed 2021-09-01 15:30:35, Roderick Colenbrander wrote:
> The DualSense lightbar has so far been supported, but it was not yet
> adjustable from user space. This patch exposes it through a multi-color
> LED.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Ack.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
