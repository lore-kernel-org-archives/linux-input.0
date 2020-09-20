Return-Path: <SRS0=BIM7=C5=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10811C43463
	for <linux-input@archiver.kernel.org>; Sun, 20 Sep 2020 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA34820897
	for <linux-input@archiver.kernel.org>; Sun, 20 Sep 2020 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600624816;
	bh=hqLet5dBu1k/82ZcUt7LhNqgfBFdFv46I5+DydmkHV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VEA2yW22QCgeK5YrGSGOpqZa/0DETfwF3oaSuCwZP+OjYoZkyxXV3x6L0k6RrKSUV
	 5LY9oopEjsQzTGWUt6ykWv7XsYJsvbRQQ7cDDALFQfpS/MCZFsPCx+n7Oz5ZepJSML
	 n9ysTuVdi0gWgIkKIXuh2qZhC857rcaDc24ZCCDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgITSAQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 20 Sep 2020 14:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgITSAP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 20 Sep 2020 14:00:15 -0400
Subject: Re: [git pull] Input updates for v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600624815;
        bh=hqLet5dBu1k/82ZcUt7LhNqgfBFdFv46I5+DydmkHV0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iJqKqDiDjF7oBRLvBnZMVAKf5v+XLWOYQZEqzxCyl1fZz5KDQWiTrQW1/jbgR+CHE
         kSpFCIyj0jKy77Pji7kEiZ78402PMZNvS9MVCXRD4g588rFcnA/FdSHZcLo2H7AS/F
         B1VwabdrXGKHeShNDhaIgawIzlp1wNbnRGqB11xo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920040959.GA5175@dtor-ws>
References: <20200920040959.GA5175@dtor-ws>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920040959.GA5175@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 6c77545af100a72bf5e28142b510ba042a17648d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 376566ca87257b9116ac5205f0efaa3c0f29103b
Message-Id: <160062481559.2021.9110404576738163090.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 18:00:15 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Sat, 19 Sep 2020 21:09:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/376566ca87257b9116ac5205f0efaa3c0f29103b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
