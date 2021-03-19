Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383FC433E6
	for <linux-input@archiver.kernel.org>; Fri, 19 Mar 2021 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8464EFC
	for <linux-input@archiver.kernel.org>; Fri, 19 Mar 2021 13:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSNLT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhCSNLP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Mar 2021 09:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E03C64ED7;
        Fri, 19 Mar 2021 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616159475;
        bh=fg3NpZXs8IsAw5jPOhQGLsgID4HRrBWTbPX5XMCU8Yo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=psKguyedq2LbiKfDPb3aEuupGUbam786Ze8Wgwu9+MJXzfKM27ygvf7/cDsaQLoul
         c+8i85pyYZ5zNgtAtLEV2ICEwRhYewxYICWYKYS3tdKq7ZI8GV2Cm4U51NJxcpKeBY
         yKokG0k1z3n4/3CfCrnYCxEYf85grjK+fgQFPzy9mBaqvMTmYD5EWDTIZuwAVfxP0F
         5kJDFtfjP0xjp1sO4E9wcMjEGkW6PoforoG23iuuIg2HrAQyNv7S9WywW1M2DLng96
         xjQiNd33RcAS5cny7RvxfUSQt9FIxGEzTowO6ko/EcQX1yUs80EEtMqSCE6mDBLznA
         kVMyqIY7toEjg==
Date:   Fri, 19 Mar 2021 14:11:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dario Pagani <dario.pagani.146@gmail.com>
cc:     linux-input@vger.kernel.org, kimi.h.kuparinen@gmail.com
Subject: Re: [PATCH] HID: support for initialization of some Thrustmaster
 wheels
In-Reply-To: <665a7a24-bc18-46e2-dee6-cb08f4a7b973@gmail.com>
Message-ID: <nycvar.YFH.7.76.2103191410390.12405@cbobk.fhfr.pm>
References: <20210131090045.10636-1-dario.pagani.146@gmail.com> <nycvar.YFH.7.76.2103081458550.12405@cbobk.fhfr.pm> <665a7a24-bc18-46e2-dee6-cb08f4a7b973@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 14 Mar 2021, Dario Pagani wrote:

> > - I don't think we need to have this in a separate driver, is there a
> >    substantial reason why it can't be folded into hid-thrustmaster proper?
> 
> I didn't add the init code to the hid-tmff as the ff stands for force feedback
> and hid-tminit does a completely different job.
> 
> However there are no significant reasons to avoid folding the two logics in a
> common module hid-tmff or hid-thrustmaster.

I will rename the driver to hid-thurstmaster and apply.

Thanks,

-- 
Jiri Kosina
SUSE Labs

