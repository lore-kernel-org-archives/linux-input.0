Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD655C2B9F4
	for <linux-input@archiver.kernel.org>; Mon, 14 Jun 2021 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5D661153
	for <linux-input@archiver.kernel.org>; Mon, 14 Jun 2021 13:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhFNNjv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhFNNju (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Jun 2021 09:39:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12B516109E;
        Mon, 14 Jun 2021 13:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623677867;
        bh=rJISanVig5hRvuzllv818rB6nZqMhjFt/Wl43skWtSk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZccxO1/w31NPCjcXwSb9tibabKETFCeqRnNrm6eAUqiY0lDR01vXALDzSwOWkQIYi
         WOGe6Bicq9ehmzuWDRHg5BGFkvGJKsmzKGi1BaKFgvYVKEAHmgEWWiM7WKIoS6/Bol
         eUQSeA0+vaPeT2mCwvF4h3sR88H+1qS/+duSaHbev4//2x8h9le8B34Mru+joAaeZ/
         c5BVseBZeWWpwkDBAMbhNsPehmIvoQb5TZfHhYjaSYzp+XEdyhr2DJEFZHGSIDrCn0
         ud0gPe0zj96YKMwSkLhvXx4p9Slm1aK9cW11s4GkgYqHas2xUDa6lLxB3INeF6/1C7
         d0UrGK1SLwzoQ==
Date:   Mon, 14 Jun 2021 15:37:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Zoltan Tamas Vajda <zoltan.tamas.vajda@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-input: add Surface Go battery quirk
In-Reply-To: <20210603185814.12659-1-zoltan.tamas.vajda@gmail.com>
Message-ID: <nycvar.YFH.7.76.2106141537380.28378@cbobk.fhfr.pm>
References: <20210603185814.12659-1-zoltan.tamas.vajda@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 3 Jun 2021, Zoltan Tamas Vajda wrote:

> The Elantech touchscreen/digitizer in the Surface Go mistakenly reports
> having a battery. This results in a low battery message every time you
> try to use the pen.
> 
> This patch adds a quirk to ignore the non-existent battery and
> gets rid of the false low battery messages.
> 
> Signed-off-by: Zoltan Tamas Vajda <zoltan.tamas.vajda@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

