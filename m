Return-Path: <SRS0=TKna=AZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D6BC433E7
	for <linux-input@archiver.kernel.org>; Tue, 14 Jul 2020 19:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179DF22CB1
	for <linux-input@archiver.kernel.org>; Tue, 14 Jul 2020 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594755612;
	bh=pcuKZNaNufkGLHLNWD8QpG9rGBl7RWapF2nTKQpekvc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vw4ycoa6IUv56HhHK8SHMq2OYUKnHHSq57Z8/WnZbTKz0v+Bj/u5nGE3iQ+5pVuNl
	 ObnjVsK2Cl4wYNXPDtzXFxUg6AQxco0Kj5QkuYAjmQ7WYqENfi6nOSzLV1Zh+zrYcT
	 PWy82+EwybEl/Kf7rNwcHw9F9BsPA0Xg2gD6uC4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgGNTkF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbgGNTkF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Jul 2020 15:40:05 -0400
Subject: Re: [git pull] Input updates for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594755604;
        bh=pcuKZNaNufkGLHLNWD8QpG9rGBl7RWapF2nTKQpekvc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mzOWRcJMRTiDaHxP9rQQDoAD9PFEsJ1zPEh9/OU8USUNpZvCZUL9iSSSJfniKrLiJ
         wUxoMyRuR+w/MUdzaGDG7/f02ixet9JW52aXIHcQhuf6hzSBbJ+gmM8ia4pT3Q3V0P
         jKoF0gHDaDvhKBoT8my/Fs7uMEqiX/T159cOYPRU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200714002748.GA1477546@dtor-ws>
References: <20200714002748.GA1477546@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200714002748.GA1477546@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: a50ca29523b18baea548bdf5df9b4b923c2bb4f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9919e11e219eaa5e8041b7b1a196839143e9125
Message-Id: <159475560462.23655.616523737761639070.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Jul 2020 19:40:04 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Mon, 13 Jul 2020 17:53:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9919e11e219eaa5e8041b7b1a196839143e9125

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
