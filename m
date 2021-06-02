Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E714AC47083
	for <linux-input@archiver.kernel.org>; Wed,  2 Jun 2021 03:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2B061396
	for <linux-input@archiver.kernel.org>; Wed,  2 Jun 2021 03:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhFBD0u (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Jun 2021 23:26:50 -0400
Received: from mail-40138.protonmail.ch ([185.70.40.138]:48547 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhFBD0u (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Jun 2021 23:26:50 -0400
Date:   Wed, 02 Jun 2021 03:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1622604306;
        bh=VEHPJSJC/3rTRLt0HpZHiBB2+tWfV7rQpwuFURen29M=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=r32hjhmEyT4YUalY4tIXbTrFiLuHZIRvuaCFj8iHaGpg0ENikzKL0pODJuuI9PU9Y
         FM2ZfiaiaW2APETD4G49M+7RSo7p5Ucsn2FIoVtez2kYxT9nm/BUsZTo800y6t6K5k
         kkrRfKHIgjmmHEJ/PODW1MPUhzJW2lUaSQUyegEU=
To:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 1/2] Input: cypress-sf - Add Cypress StreetFighter touchkey driver
Message-ID: <vXRJOabHa4SHho3woxsMCZWVVduIWcO_qRQ4yW0cdtpY_fWrFp9epbWdiEPuwnvWbpfrbJ9TV4j9ReiHl5QdprgRVcr2tdxs6mIOMBe0oT4=@protonmail.com>
In-Reply-To: <bj_bmlxlyRbM5zdpsUEqvPyby_NWhFH95Y9wn9b7EIpvi2N48e6x6dBFY9EpyS4mxJhuRRJeC4ReVM3YMawD44RBZDHdSKftdbV6E8AMuoo=@protonmail.com>
References: <ocb1SNCqWH2dOajA4VYTx5jo9jZ67pS6FTejJN82OnPIUdmqBXL62kjGDQ-ZIMPnmhm3C16FCJz94cs82kGFmFBq7mERwqtHhwr7BgZC_w0=@protonmail.com> <bj_bmlxlyRbM5zdpsUEqvPyby_NWhFH95Y9wn9b7EIpvi2N48e6x6dBFY9EpyS4mxJhuRRJeC4ReVM3YMawD44RBZDHdSKftdbV6E8AMuoo=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Sorry, I have just realized that I replied to v1 of this patch.

Please check v2 instead:
https://lore.kernel.org/linux-input/7PLVBAKRbtNysjS13InqsN59dLZarOcTPCpRg8H=
H4@cp3-web-029.plabs.ch/T/#u

Yassine

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, June 1, 2021 1:16 PM, Yassine Oudjana <y.oudjana@protonmail.com=
> wrote:

> Any comments on this patch?
>
> Yassine


