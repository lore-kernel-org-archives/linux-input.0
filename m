Return-Path: <SRS0=VovD=Z6=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4664C43603
	for <linux-input@archiver.kernel.org>; Sun,  8 Dec 2019 02:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BE320663
	for <linux-input@archiver.kernel.org>; Sun,  8 Dec 2019 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575772828;
	bh=l8nH7a5AoPHySFKMFc58M653Rh4pysgA8IIxVoA/71o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UYUc6E56LiRDQYpXLeIrCemlgDD3luaL96kFYioqvMX9FFu1EjwKXKU89OJx7MqFR
	 WuKy5M/XdRkf5gyOVqGdyOYLvLL6tk2cMoykkiYUfgOVsafYji0PrKZ9wNtMfl1llq
	 SPIooGX65ROmbgpmmztO7X4gLy1aOxSYyQkbTJvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLHCk2 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 7 Dec 2019 21:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfLHCk2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 7 Dec 2019 21:40:28 -0500
Subject: Re: [git pull] Input updates for v5.5-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575772827;
        bh=l8nH7a5AoPHySFKMFc58M653Rh4pysgA8IIxVoA/71o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Tn4/2KWUDbwQ0W4otpW3twwXob2dCyAfuhKWfEjrS++b/bCaXPxi0/USovkeaFgD6
         FNv1F8V2nELXKqBjmCEPKswBlb/mYx9Mhnkxt55T5GYs6jgNX+fJAE0cuszaXQRy5k
         /CmSqWPU+loDMuk31ILXxnSLnu3omEA+hMO9kieU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191207202733.GA153817@dtor-ws>
References: <20191207202733.GA153817@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191207202733.GA153817@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: afbd65f5e71a37fc9f46cb3e867e141a65d6ec25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 737214515d7965485c52bc5f869e57a6976cf216
Message-Id: <157577282739.16893.3644948632975034184.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 02:40:27 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Sat, 7 Dec 2019 12:27:33 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/737214515d7965485c52bc5f869e57a6976cf216

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
