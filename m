Return-Path: <SRS0=AvWt=ZI=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81EDC432C3
	for <linux-input@archiver.kernel.org>; Sat, 16 Nov 2019 02:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13202073A
	for <linux-input@archiver.kernel.org>; Sat, 16 Nov 2019 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573872606;
	bh=asNmQ1Ms7zBvRsto/aYcA0eH3A0J0l3h0I9Qg76hfKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dg6fy8MK63qPdAnsrtK5sxcBD5RAPdOpi5HSoTUjoIigP1YJkIHcvfUK+F9DHLpvY
	 rhwFpt9n84O9fJeUBpMybjJMFXmQWT7FTDRult+V6V9VPotY1fvD+BRgo7W5u3jAPZ
	 6VqXEszjijhRXbnX8oKNFDrDCLkTep1nhGXf/QnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfKPCuG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 Nov 2019 21:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfKPCuF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Nov 2019 21:50:05 -0500
Subject: Re: [git pull] Input updates for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573872605;
        bh=asNmQ1Ms7zBvRsto/aYcA0eH3A0J0l3h0I9Qg76hfKQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fh8QP2Xvw3FVVhc+jStAEM/xvi5JaYUWFV87Pr+9ZdzH31c+rSUWahz+VF3tWebz1
         3b9aM8Ibj9s0QfwDxhWN6nUoo5hrmHceZhZy4F4XSHk+Xitvd35xSGhjjts/T1d22H
         2CZB9fmUfVUP5157EWvvQz4ERr9qUF0OAsZ1MWe4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191115235114.GA173184@dtor-ws>
References: <20191115235114.GA173184@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191115235114.GA173184@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 768ea88bcb235ac3a92754bf82afcd3f12200bcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c9594bdd47412ebf74616593b9dcad67c4e9e00
Message-Id: <157387260540.30691.10530031136253318456.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Nov 2019 02:50:05 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 15:51:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c9594bdd47412ebf74616593b9dcad67c4e9e00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
