Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD15C3526C
	for <linux-input@archiver.kernel.org>; Wed, 16 Dec 2020 01:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB41923A03
	for <linux-input@archiver.kernel.org>; Wed, 16 Dec 2020 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgLPBBr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgLPBBZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:25 -0500
Subject: Re: [git pull] Input updates for v5.11-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080407;
        bh=vPy0wd2Ub/J5W/JoWBT/kLaGAB4GuHngRtoBWaD8fCo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PBevrwnusNmbAPb9/QmaYPetdcQlY+w8DM/3LraRExQ2MnzuJqH9ZISMC+EvN3tpH
         CH6lQ5lngTS4iXW2a9wwKe/lGqvefNPy48cq8HVqXybK0iJt+wntp1QRFsa43NA4/8
         KPji3z9ZVmGS7FUStqir1wZUSUFvKS1C+skvJOfIZRjWwT9L69VvwuS2vKpWfLNJRg
         cYfDyIU64W3N1wOTq6bB1Zs//d88G5b6BkVkqK9B94Q7aY0zz1UiDYNsEZJA5ZRFtn
         FhgGH1MPw/E6Ox6PTzkxjkvWARet/x4BVlX99P3nxlXI/3TMWhyzRysZxi9ZE2/dJ2
         eMQBxwU9tAhMw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9gXHwIQvxomBHFt@google.com>
References: <X9gXHwIQvxomBHFt@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9gXHwIQvxomBHFt@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 4b4193256c8d3bc3a5397b5cd9494c2ad386317d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee249d30fadec7677364063648f5547e243bf93f
Message-Id: <160808040732.29502.12165143792878246683.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:07 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 17:53:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee249d30fadec7677364063648f5547e243bf93f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
