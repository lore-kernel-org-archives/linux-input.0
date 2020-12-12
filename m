Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2249C4361B
	for <linux-input@archiver.kernel.org>; Sat, 12 Dec 2020 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8315E221F8
	for <linux-input@archiver.kernel.org>; Sat, 12 Dec 2020 19:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407790AbgLLTBu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 12 Dec 2020 14:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407786AbgLLTBu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Dec 2020 14:01:50 -0500
Subject: Re: [git pull] Input updates for v5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607799670;
        bh=V1GbyEKqxA3DyjqJ+NQWByffW7wblzv/XSMZOJPMZt8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LlpyZxERh/vyH2CO9aw/ekJQx94uW3UncbQGYolv6vkiUsH8ROzkOSRETa6c/K+mB
         dzSvTt7GThRmzDEd+Yh95ZjFq6Qd2TAN4cmbaTcczFfhENyJxG0fNBhnCe+Lprx8tx
         O0IeuwDA5OlmGTA/5Sw2JUFNhzk+Snyj/gpNG/H37emTjI1AcZe1yKTvd/SKByL2/K
         b4Cdzdi2um3m1TEmBoA7AhdPR5pYHHaHImRKl/6NhPCqhQQmuZmzwFQvXFdotpcUZo
         gKMDQtz70qTKotjTDMwg2sdJOvrKHUhVA2T2tBkvbodQopQ/uYeT4Bq3PdC3sdHiYo
         eNCpU3s7+I/Dg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9Q1UXLZ812+YO2p@google.com>
References: <X9Q1UXLZ812+YO2p@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9Q1UXLZ812+YO2p@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: cffdd6d90482316e18d686060a4397902ea04bd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 643e69aff89a2d0abc53979acc441b68ce86139b
Message-Id: <160779967030.16081.10225298404477549381.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Dec 2020 19:01:10 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 19:13:21 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/643e69aff89a2d0abc53979acc441b68ce86139b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
