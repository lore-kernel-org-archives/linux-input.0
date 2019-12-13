Return-Path: <SRS0=2/97=2D=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E607FC2D0C9
	for <linux-input@archiver.kernel.org>; Fri, 13 Dec 2019 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4CD246A2
	for <linux-input@archiver.kernel.org>; Fri, 13 Dec 2019 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269753;
	bh=WiTg4Ge7Np1vjag2L2wUpM/mYzzHU246mF4XPHbXBC4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=FlZmGez46RgFM7UPJ1t8CTi59dXPKJSKqWUXp981pFDXVtHtiBKpuQS36pPFKB27Y
	 Ocun6UGtkvEtnRyO2zsvdn5ma/73ceFRb9H2pqF2lF15C2gNk3imWPq2M6GyoQjcoV
	 ZyQ4wXZ21qK5oEhiTycPvdq221jfNNalYN2/ZDu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMUmd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLMUmd (ORCPT <rfc822;Linux-input@vger.kernel.org>);
        Fri, 13 Dec 2019 15:42:33 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C02246A2;
        Fri, 13 Dec 2019 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576269751;
        bh=WiTg4Ge7Np1vjag2L2wUpM/mYzzHU246mF4XPHbXBC4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FKVFfBLXIigrvqgHVfUtxDCs2yDo1uZeIAs/i8gX+vbV/1ena/m7Q2iNrdMzLMKu1
         L/S8WdAG3RZWGWBkoa1XZitxCq1v7C73btAduRVlrHAs5JRGG59rQp319xIx98JltW
         4nOKiEOQtZ3QpvLYVT8zDZp5NT70cSKS5WuUACAQ=
Date:   Fri, 13 Dec 2019 21:42:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Balan <admin@kryma.net>
cc:     Linux-input@vger.kernel.org,
        Dmitry Torokhov <Dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add an I2C HID quirk for incorrect input length.
In-Reply-To: <20191127032329.8406-1-admin@kryma.net>
Message-ID: <nycvar.YFH.7.76.1912131305020.4603@cbobk.fhfr.pm>
References: <20191127032329.8406-1-admin@kryma.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 27 Nov 2019, admin@kryma.net wrote:

> From: Pavel Balan <admin@kryma.net>
> 
> Apply it to the Lenovo Y720 gaming laptop I2C peripheral then.
> 
> This fixes dmesg being flooded with errors visible on un-suspend
> in Linux Mint 19 Cinnamon.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

