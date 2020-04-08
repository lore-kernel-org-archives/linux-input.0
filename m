Return-Path: <SRS0=LeEh=5Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCCBC2D0F4
	for <linux-input@archiver.kernel.org>; Wed,  8 Apr 2020 03:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0265520661
	for <linux-input@archiver.kernel.org>; Wed,  8 Apr 2020 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586317230;
	bh=/GtrIBuTrMTfhgIAOvA2gzDMBnGzw0O0nDV3btpCY/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Gpu9Wvp/s8/0vok+1Z7MymDnZ7i3eVo8GXJDfTOzl7WnALdj3npInKUyqVVPyC2EU
	 /CXdWrHOwBflOhDWia3tSf691pHm9bh4tipXVpd/Xa+CD2T+2NL6Q1z0qCaLKfubfd
	 7DGEKeu8bqK0HWWeRkQMm4BvuRY/8CDMA7yKmrNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDHDk0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHDk0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Apr 2020 23:40:26 -0400
Subject: Re: [git pull] Input updates for v5.7-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586317225;
        bh=/GtrIBuTrMTfhgIAOvA2gzDMBnGzw0O0nDV3btpCY/o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vq3VovjWfU6iRLwMHDu8MoYUbhhhCYUu6hG1MoH8XGQUJnuWpy+ud1P9noY9f9MjI
         4u952aSVyb61Qclb7Q2nWJ2N5Jx9ZXlTfdGPiBbtFVdnPtPYlt127H8yw4LeIDx9ta
         v+bk3zxMFZk6E3w0uD2xM0qXFpVieIUKLVce3LJg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407182624.GA222411@dtor-ws>
References: <20200407182624.GA222411@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407182624.GA222411@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: cd510679f4b588b7726fc8b25e5a0afd6f889b14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ebe5422ad6c0309d3a2d4cd099b8410d2b6c6b0
Message-Id: <158631722543.10073.8619977924114229845.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:40:25 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 11:26:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ebe5422ad6c0309d3a2d4cd099b8410d2b6c6b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
