Return-Path: <SRS0=64J9=ED=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C9C55179
	for <linux-input@archiver.kernel.org>; Wed, 28 Oct 2020 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7978320719
	for <linux-input@archiver.kernel.org>; Wed, 28 Oct 2020 22:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603924088;
	bh=59DdxNpYXMGEmMZRUHL4zEVruKRkXdPo4sVP3tOqfIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=iLDj8KLqsIkURmVxJLAdt/9BdOhgw8Zugp077aL2LL+uaNHODxP9eT3ZEiAaERUak
	 qM0VXQ20fGaC3C1d/7bTRtHeySPlvlDKKtgCtpiyGpksB2HJNntJ4hAHUZAD0OzFs6
	 FtT4lSsVGK3OUZc5zCaB0+KirftRNjNcKOmunNUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgJ1W2H (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733252AbgJ1W1X (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:23 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF96A247B6;
        Wed, 28 Oct 2020 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603902567;
        bh=59DdxNpYXMGEmMZRUHL4zEVruKRkXdPo4sVP3tOqfIM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=wwFaATmVUjDK1p4lvhER4GMtsvWr77DepxQ9klvBLWpJ1mmEJM69U72U6rVC/CfML
         n5ZdH1p4xCrYofZBT4GDNyJG7v6qulfHv9eIWiURtNvazzx+l+q4G1/qtcFBOltybZ
         8JgHPz5OaJ/Vf/q/aFw9ziZab58fYwLkZ93+vWDI=
Date:   Wed, 28 Oct 2020 17:29:23 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     dmitry.torokhov@gmail.com, vojtech@suse.cz,
        linux-input@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Proper support for Saitek X36F joystick
In-Reply-To: <20201028162621.GA18184@amd>
Message-ID: <nycvar.YFH.7.76.2010281728260.18859@cbobk.fhfr.pm>
References: <20201027124235.GA27148@duo.ucw.cz> <nycvar.YFH.7.76.2010272006490.18859@cbobk.fhfr.pm> <20201027210732.GA4479@amd> <20201028162621.GA18184@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 28 Oct 2020, Pavel Machek wrote:

> So no, I can't even replace it with equivalent one. Perhaps hrdc got
> decompilation wrong, or I'm doing something else wrong.

You don't need to do any decompilation -- the descriptor can be obtained 
from /sys/kernel/debug/hid/<device>/rdesc (also lsusb in verbose enough 
mode should present it in case no driver is bound to the device).

-- 
Jiri Kosina
SUSE Labs

