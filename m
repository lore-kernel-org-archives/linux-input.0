Return-Path: <SRS0=guqd=BU=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A402C433E0
	for <linux-input@archiver.kernel.org>; Mon, 10 Aug 2020 23:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C6D20734
	for <linux-input@archiver.kernel.org>; Mon, 10 Aug 2020 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597102796;
	bh=Lqj2FkHw8bO0w3Dr4l9ij4v95Nm7vhZMhIf5vyNJERc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sa/n6J3W6XCGHd+cjnb0BHV2sml27mooYhOyUsYPlkC2f5zK3OAYxCt5F45vzJV/D
	 nvguONM7mHFKus4dke1DkeM3QOTCK7Q0xtoiM8a2wNwMXlrcLADhXWLZ35eyv1gG5I
	 kXtbuqvpqK/E3zjZ5XY5XLrWa2LtFjyfspueGFxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHJXjz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgHJXjy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Aug 2020 19:39:54 -0400
Subject: Re: [git pull] Input updates for v5.9-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597102794;
        bh=Lqj2FkHw8bO0w3Dr4l9ij4v95Nm7vhZMhIf5vyNJERc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0D6t5IvIjeeEXpwrJDJMMSew1fTgu67hhsyWSJtf9Xu8r7fmd2/fb3oew9fPyroXk
         b7sYZhoP/FPBvQbHVNjgwCWgK/Wz9kkhnJ+1fV1FzVZe8TqxMn7kvsx+7lmKtPD9u1
         qMEcl1UxklD+PboMofgzfxbk2BOnokDE0GxwdOgY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200810181235.GA929203@dtor-ws>
References: <20200810181235.GA929203@dtor-ws>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200810181235.GA929203@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 9e8238020c5beba64e7ffafbb7ea0fb02fe68270
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bcf69e57063c9b1b15df1a293c969e80a1c97e6
Message-Id: <159710279452.26236.17600376947073007403.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Aug 2020 23:39:54 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 11:12:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bcf69e57063c9b1b15df1a293c969e80a1c97e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
