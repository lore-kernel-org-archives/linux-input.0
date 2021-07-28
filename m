Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FAC4338F
	for <linux-input@archiver.kernel.org>; Wed, 28 Jul 2021 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF7560F59
	for <linux-input@archiver.kernel.org>; Wed, 28 Jul 2021 10:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhG1KGP (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhG1KEV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jul 2021 06:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01A7160F23;
        Wed, 28 Jul 2021 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627466659;
        bh=yooTXTZnTDsYMB+aJApq848hzJTObpgXG66PkViLdZ0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kyroEidLXlujgMXg4ylalSLctNVpMbSR7g22Ws2BUj/82slrLdW/69SkUIawJ0HnE
         d1S0mx/3iNypR+5Hk6Nj1QdvIM+3mOGaNn7adWGLHaxAy3H1X4exi3nu5Xzcc0jh9N
         58sxyEO98IdZzXSkV2UKwTpjkJOjYs8wtJUUYfS1lYKFA5z1FrAnMpNBTrj0AQjsW5
         /TDjBtKJkIrjMywRlIxyLNGouOK7Zc1NqTNep/CIpzE7r0V5K7RT6eeSL6S1IIKhDR
         qfuRjAMpVqHUCtqVg5HdVueDCRVj1PhMVz0SpdyEeSWrGGGQLF7kFzJJshaE+dqYyq
         z7WwcrHlh8Grg==
Date:   Wed, 28 Jul 2021 12:04:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] HID: magicmouse: register power supply
In-Reply-To: <20210728095803.GA31924@elementary-os.localdomain>
Message-ID: <nycvar.YFH.7.76.2107281204050.8253@cbobk.fhfr.pm>
References: <20210522180611.314300-1-jose.exposito89@gmail.com> <nycvar.YFH.7.76.2106241532511.18969@cbobk.fhfr.pm> <20210625170834.GA9573@elementary-os.localdomain> <nycvar.YFH.7.76.2107281134430.8253@cbobk.fhfr.pm>
 <20210728095803.GA31924@elementary-os.localdomain>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 28 Jul 2021, José Expósito wrote:

> So, if you don't mind, I'd prefer not to apply this patchset yet until I 
> figure out a better solution on v3.

Thanks for the heads up. I am dropping it for now.

-- 
Jiri Kosina
SUSE Labs

