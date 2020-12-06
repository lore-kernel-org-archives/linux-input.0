Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF92C433FE
	for <linux-input@archiver.kernel.org>; Sun,  6 Dec 2020 00:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D7A2313A
	for <linux-input@archiver.kernel.org>; Sun,  6 Dec 2020 00:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLFAVU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgLFAVU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 5 Dec 2020 19:21:20 -0500
Subject: Re: [git pull] Input updates for v5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607214040;
        bh=IYHOj4vaPvp6771HWufe8aoWa0ykGu8LWN7qLFEVWxI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XLlGyaXi/B13beFRR6eEuZGrEqYyT0vrpAL+8HgbZuuoHvu0Hw1NHj4iKgU+abd8X
         R/oqz5BfbnZoETBZMdpl3/0B5eff9vdl3NM8N5m+ZcnhFFA0yRzKSER17hAt/hPtnk
         Hgk2H34XSgeR5VNmNxJmSN4emVcRre6DJ55tg0+DQ02rx21qR2kx6HUhDuUrJv8+9r
         kiy8+UJJtzBK110Pfn8pdt/eipWaSipRPxmapqQTYG6ddmo7rqZnFhVrRv3qd41rWV
         2HSkSlrYQsJBgSqHvyrHj2L0YkVdY7YnoBVgb9p/YYOCEuUvl/iifjFEoxA3sjOWWT
         740G8Yn3W2BBg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X8we6Ff3ikti/2bR@google.com>
References: <X8we6Ff3ikti/2bR@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X8we6Ff3ikti/2bR@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 8c3b55a299c325830a987de21dab6a89ecb71164
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7059c2c00a2196865c2139083cbef47cd18109b6
Message-Id: <160721404011.14459.459879198480889297.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 00:20:40 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Sat, 5 Dec 2020 15:59:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7059c2c00a2196865c2139083cbef47cd18109b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
