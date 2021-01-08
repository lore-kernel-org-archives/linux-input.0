Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9EC433DB
	for <linux-input@archiver.kernel.org>; Fri,  8 Jan 2021 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E9823788
	for <linux-input@archiver.kernel.org>; Fri,  8 Jan 2021 13:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAHNI4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 8 Jan 2021 08:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbhAHNIz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Jan 2021 08:08:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D5D2235FC;
        Fri,  8 Jan 2021 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610111295;
        bh=6Yah1f+8BLz2MwUhsQSUqEzgqrjzlaNR/fcAcpV3c6U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=r/rAhkX2uMWNlFmli2aGwlKnwiqwvcMw3GNDN94cRR5rYnYRXL2SY7vr8OtI0VNN2
         z6UDPVJSsPfyOK2OhpqvPw05JH/ju7BVpRhcDhbkPmBgYnXKu2ZX3ovdYyBuC5TjDK
         oSjxj3QIXhDGC0JT41cNsyejOpAaI1azs2QqL8ELCW+34rGyKCs46yOfbzLO6yn6ZO
         roAYiQWv75t46+TznHkoU5k17l8D1bHRL24Dp0EJGhMa5hB25FmupVjsmc31+grsfv
         8bsF6eBv3mi+ORjo7poDJRjCvJAqeShFkyYNeQSAmS5IZ04uYHoihRj0NvH5xh+yoh
         dVJBJY4yK1aVA==
Date:   Fri, 8 Jan 2021 14:08:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Cristian Klein <cristian.klein@elastisys.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Improve support for Trust Panora
In-Reply-To: <20201227130815.437433-1-cristian.klein@elastisys.com>
Message-ID: <nycvar.YFH.7.76.2101081408020.13752@cbobk.fhfr.pm>
References: <20201227130815.437433-1-cristian.klein@elastisys.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 27 Dec 2020, Cristian Klein wrote:

> After more discussions with the [libinput project][1], it has been
> determined that the uclogic driver provides better support for this
> tablet. Fortunately, the Trust Panora is physically and logically
> identical with the UGEE G5, despite having a different USB vendor and
> product ID.
> 
> [1]: https://gitlab.freedesktop.org/libinput/libinput/-/issues/482
> 
> Signed-off-by: Cristian Klein <cristian.klein@elastisys.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

