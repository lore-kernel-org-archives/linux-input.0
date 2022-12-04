Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F57C4332F
	for <linux-input@archiver.kernel.org>; Sun,  4 Dec 2022 21:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiLDVZo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 4 Dec 2022 16:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiLDVZk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Dec 2022 16:25:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634413D1D;
        Sun,  4 Dec 2022 13:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6FE601D7;
        Sun,  4 Dec 2022 21:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81E4BC433D6;
        Sun,  4 Dec 2022 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670189136;
        bh=X8+ld/353+AbHmmH8N3deZVQR2MDIjN8csNVyOOonu0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N5bfx9TlijI/NAwl//VLKmtgyAGKXvWklllp8CKjV3Pu1JFPfL/d/xsi036ttv5q3
         tWXXDUrYTriyWbW70+oP0s9CoRhFPNVJcXiWlVIJzlOs2xen1pbB6GDcp+tK71b8Kf
         Ep5ITT1JF7EhHXfo3JEbEpfZDeWw2z7/AqDHuSNc5DBASMQAsGMFo9Lyzm18BQ0yj7
         wYUem3xuhG182O0OXJ+2P3YPadkCev4CzVOxCJvu8IHR8yok64ltPNySJ80TcP8jJO
         c591EaIixaH8/xK3iKwAwZege3YVjhiwPPgQSTMEy9HS9GWZeNL2ZHz3fJ1wHQuh1a
         r3tj0pMUhS68Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F294C395EE;
        Sun,  4 Dec 2022 21:25:36 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4wkOCD1YCcchwv+@google.com>
References: <Y4wkOCD1YCcchwv+@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4wkOCD1YCcchwv+@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc7
X-PR-Tracked-Commit-Id: 8c9a59939deb4bfafdc451100c03d1e848b4169b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50f36c5aa12c8d0f2adca662e0c106212ea897a8
Message-Id: <167018913644.1549.14784126415807357199.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Dec 2022 21:25:36 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Sat, 3 Dec 2022 20:38:16 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50f36c5aa12c8d0f2adca662e0c106212ea897a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
