Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F0C432BE
	for <linux-input@archiver.kernel.org>; Mon, 30 Aug 2021 13:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EAB604D7
	for <linux-input@archiver.kernel.org>; Mon, 30 Aug 2021 13:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhH3NbE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:31:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:9932 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NbD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Aug 2021 09:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1630330202;
    s=strato-dkim-0002; d=inhub.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ACu53JgT/GdaYDwLoNs8zQ8b7Y+iMfU6hUBEpWGnMpw=;
    b=fxQpfttvvwiGIx8PzlfmkZYhoUaVSnCrM5Cz4OiDDs2Z/Q9zFwDOpF1ADZUVyuihuH
    VTYPqqyMV7ScmP6g8PFmHmkK2s7xLEFbnyoA9u6ZP3MNZP6QWZZE6pRqaDFN6ct9nOMI
    xugKriVDf7EMf1wh1ym+3vsBdF9BDXdxi7BS8CoK7f4eN6iO0+3NxyMlf/yDbqFYhViX
    S9sH2GA7kN1+IoFvpAyV5K46O2numdfLENqkt4BASEVHgxtYWpo4Ii5Kcyw19VoXcYkq
    Nn8Q/EqhRzbgp1+srXDGJJD6wPr/K848axXk80e1Jjy5SL3oFYASIjcME70hjuLFYEuO
    zeNg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OGMGfEG7NfU1WQAxQKSndOy9b62IXRUXP1G+n0e9SfNgaKe3jg5kqErmuuTsxxnmJ1DWc546Eg=="
X-RZG-CLASS-ID: mo00
Received: from crypto.localnet
    by smtp.strato.de (RZmta 47.32.1 AUTH)
    with ESMTPSA id 2023a9x7UDU1HxL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Aug 2021 15:30:01 +0200 (CEST)
From:   Tobias Junghans <tobias.junghans@inhub.de>
To:     rishi gupta <gupt21@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] HID: mcp2221: configure GP pins for GPIO function
Date:   Mon, 30 Aug 2021 15:30:01 +0200
Message-ID: <1931977.PIDvDuAF1L@306e6e011c15>
Organization: in.hub GmbH
In-Reply-To: <CALUj-gvwPJW6qND7_8eBPLjdXe9OienMeSNu7zAgq6Q-YEitiQ@mail.gmail.com>
References: <20210818152743.163929-1-tobias.junghans@inhub.de> <3382390.V25eIC5XRa@306e6e011c15> <CALUj-gvwPJW6qND7_8eBPLjdXe9OienMeSNu7zAgq6Q-YEitiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Rishi,

Sure, this can always happen =E2=80=93 like with any other kinds of (e.g. S=
oC) GPIOs=20
where you have to take care and/or keep track of your system's permissions=
=20
(which should prevent non-root applications from doing bad things such as=20
playing with GPIO settings or wiping your storage). As written, the code=20
changes do no harm unless you enforce it.

Best regards

Tobias

> By mistake during development it may happen or a rogue application can
> knowingly play with our hardware (commercial product may be
> vulnerable). What are your thoughts?
>=20
> -Rishi
>=20



