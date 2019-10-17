Return-Path: <SRS0=CCxI=YK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A771ECE58E
	for <linux-input@archiver.kernel.org>; Thu, 17 Oct 2019 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6EA20854
	for <linux-input@archiver.kernel.org>; Thu, 17 Oct 2019 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571336707;
	bh=+9nv5fNhyaYV/7H/IeiDQCIMr6krzuXjotdoqNI4yyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RTmlKsvKfvv9KVmxk8swJu4dSPP5DJs/ReV//cUusvNs7epFHjy1H8P5t31dUUQ7+
	 ri8T4Eds8E8gUI9ubkbuVVMO/HEDk8DYisI7bOIr4bSE6QsCI85zniP2Q8o9Wr8poM
	 HWxgxXk87VXn2rD9lY1n97DZPEl3B+ZgkaanReKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbfJQSZG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391700AbfJQSZG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Oct 2019 14:25:06 -0400
Subject: Re: [git pull] Input updates for v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571336706;
        bh=+9nv5fNhyaYV/7H/IeiDQCIMr6krzuXjotdoqNI4yyI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XYeCvAV+GbHo+9SL1oMxXNUTqdStBqB45Pap5umrU0TFbV516uaWkgUzUS3arKuYE
         u+iH/ZtaWDQO4MjKMrv1hm4fTg2HVM9ScX73UJMT7JlmWMLNWl67B3E9gggrLuwfdB
         xteYjA7GwtxvQbLRmdvMGiKqy66fCqxj7CKC7b4s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191017180000.GA201965@dtor-ws>
References: <20191017180000.GA201965@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191017180000.GA201965@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: c324345ce89c3cc50226372960619c7ee940f616
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84629d4370b8e6b7871d97440babece3eb1108a5
Message-Id: <157133670611.10427.10209891414426063814.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Oct 2019 18:25:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Thu, 17 Oct 2019 11:00:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84629d4370b8e6b7871d97440babece3eb1108a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
