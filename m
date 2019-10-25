Return-Path: <SRS0=0DbS=YS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601BDCA9EA0
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B721872
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572039309;
	bh=eeY22LIphxnD45qtIsKa9DTNfiLbC5ai0dPyCl623FQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BI7nnj86kVrxookm3514EEv+4D5BrkZcxoq7MKddXfn4OR3p3pN1ie3kebWf1ogMy
	 SWrNhYPNz55uuDUBr+aCi5mn2KDsw4AtS58N1H3lgODeCCgLFfTrTSNzZyGY7HaV+0
	 xdwjsl3nR5dsNKhdckYfG98fBUH4rEA4evxEJoKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfJYVfI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfJYVfH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Oct 2019 17:35:07 -0400
Subject: Re: [git pull] Input updates for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039307;
        bh=eeY22LIphxnD45qtIsKa9DTNfiLbC5ai0dPyCl623FQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zc68m+TKFOdu+uqNr2Mx/yV3PEAD2KahfHHwrtlC8KlpsImUWGjgBb+f8oFZTZOa2
         0pTCJcR2zFcYu5KofLPeETF3JL6ckZBg6pQcxUF1RzNNMSsmapyrgcgtUAwvGyx3Q6
         qn6bj8mfgy+QrYkKtmNsPuEh/+Xegu3Q7olPc2Fk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191025204841.GA169639@dtor-ws>
References: <20191025204841.GA169639@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191025204841.GA169639@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: b1a402e75a5f5127ff1ffff0615249f98df8b7b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4b61b224d12ef12ff21cc598acce0ee818903ab
Message-Id: <157203930737.23557.17596054978713406374.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 21:35:07 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 13:48:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4b61b224d12ef12ff21cc598acce0ee818903ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
