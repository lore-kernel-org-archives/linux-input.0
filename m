Return-Path: <SRS0=gHlt=27=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD01C282DD
	for <linux-input@archiver.kernel.org>; Fri, 10 Jan 2020 00:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5CE20661
	for <linux-input@archiver.kernel.org>; Fri, 10 Jan 2020 00:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578615307;
	bh=itW1XMPzr3va38/lP9rBGthLsFpyAnNnTobJGcTM2zQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ayVjirEInDNE2uhxJUqS9/MXgtvVYFPNXo8/xrKdhl9m3GVoYi+8lqrHBQ49sWWiZ
	 /ieEHoURdlVKKzQyRdiPdXp08taeWVafRCXv1UK7vSReJvUuM2OORNEXY8ROgrFdn2
	 m3Q4HRfiX0C87q1t2Qx6YIZ7nIgmO95Cj4lqU6zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgAJAPH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgAJAPG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Jan 2020 19:15:06 -0500
Subject: Re: [git pull] Input updates for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578615306;
        bh=itW1XMPzr3va38/lP9rBGthLsFpyAnNnTobJGcTM2zQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MBBiCPPabcUD6GNtQkidDNAzYrK5OA6csSsB1dwz4mwKMIUREyxlz5zX93cwSQ7lt
         7HOB8aB/CPcpJ7Y5b3cziSgwPFdAw9TV8q7WHBedC0+SophAnMWNtZEDHErYfKxwAY
         ZEVwtf0pOWgeu3F5GSgOqNsH9XrKhc/MizYgfhOc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200109192207.GA210536@dtor-ws>
References: <20200109192207.GA210536@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200109192207.GA210536@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 1021dcf19db1387bc0db26d14bbcba719923a466
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5b3159cff66b5b6830701d318b470d4b3e9a57f
Message-Id: <157861530632.24562.14884612015644802227.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jan 2020 00:15:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The pull request you sent on Thu, 9 Jan 2020 11:22:07 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5b3159cff66b5b6830701d318b470d4b3e9a57f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
