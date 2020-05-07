Return-Path: <SRS0=FvaY=6V=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A79C38A24
	for <linux-input@archiver.kernel.org>; Thu,  7 May 2020 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31652173E
	for <linux-input@archiver.kernel.org>; Thu,  7 May 2020 17:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEGRqr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 7 May 2020 13:46:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40860 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEGRqq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2020 13:46:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5CA381C025D; Thu,  7 May 2020 19:46:45 +0200 (CEST)
Date:   Thu, 7 May 2020 19:46:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add driver for power button on Dell Wyse 3020
Message-ID: <20200507174644.GF1216@bug>
References: <20200503201237.413864-1-lkundrak@v3.sk>
 <20200503201237.413864-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503201237.413864-3-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi!

> +struct ec_input_response {
> +	u8 reserved;
> +	u8 msg_counter:2;
> +	u8 count:2;
> +	u8 type:4;
> +	u8 data[3];
> +} __packed;

Bitfields, and relying on them being in the right place for communication with hardware.

We don't usually do that, and there may be reasons why we don't. I'm pretty sure it 
breaks on big endian... and Im not sure if there's something else.

										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
