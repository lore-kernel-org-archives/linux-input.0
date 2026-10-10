Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AD370AFC
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791641885; cv=none; b=Qd0aqnNDVNlyCFh1rzTKIAHh+wB0LEA9jNw/Hf8U+DT8yhC5E4KX8LQ5ht5gmZE3KKNX3VRt5o9xGglB8c6ja2Y8/8wI7ORUCsGre2+GiGaZ7SfsIZMr5NxtoDr6SfZrT8s/ngD6ZBeGaMebp3WLuGpPF9E2pMdVhciL05G73bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791641885; c=relaxed/simple;
	bh=InT5YSzvTjWFNMB6OYCP5uV+r6SNFWBt1LxaECgGALo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t46bwSFmfiKUItKA927FelLfBaxd9npWzk9heo7yai0LNARECNJDt0bzgIQr4NPTZwVrgOYqn/aluKDE8pOBL1Z9aiMHsVlhrhdbL03uDtfg723164F2ZTwyzA1XCRF9WxxH5NKZfwGZl+eMX02LuB5Uhd8n3e5zuSKm4drZnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4dc57e2a3f2so1243503b6e.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791641883; x=1792246683;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EcxkuS2RBMYMTop2TmJ2lUQ2A0raMtRIJ95H86/AkrU=;
        b=0c1Ju3rEfG2d7f0WeXWheHny08NfqkvJQj1P16kiufJGmOLSRxtfagFbNVzsgwLDIf
         I9MWN9/e4LNtOx2mLvbbfMdRSqBK/IhXnf9g5N9UIIpSWCjqRDwYYJ7w3hknV91sL+Ro
         VJLSWyca8qh/5zDGOjRLCVbQuScOlvfAfDodabq7ft//WTAwPz57ijt6IrnzJiaZ3pVt
         UJC6dSmGM9FTX5mobgZT3WIBLR6imizKrEbl+jY2KUasNBrb5uBikz00NhkGHgu3lUDq
         Zzssp1E8e7Jx10k7k1f6TmQQ3hIcbGuc8xY68fYDvAcWdcCjIqcoatRbJT8gg1h/yOeK
         ceIg==
X-Gm-Message-State: AFq9FYITq2fvIcuEZFGUc4XVWHqgWjiWGp0bQtHpV0UibgHrBTHkwTL0
	6VqHDPuk/mgN+WXGxEaY0xWTX+3SaU7aofJehZmCWcjRRxBA/7JVfW0B7n4u1SkzC8rLp8LWUZL
	vwYrP5iz1F89lD8kGknhXd9p1I6YJJ58gSg37e9IMoUlyJgh7ylby6aGAzXo=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c6:b0:4f4:2b4c:d66e with SMTP id
 5614622812f47-50c5870f5e0mr4300516b6e.50.1791641882780; Sat, 10 Oct 2026
 07:18:02 -0700 (PDT)
Date: Sat, 10 Oct 2026 07:18:02 -0700
In-Reply-To: <f10557f6-fe56-4f3e-b138-c1624465a15e@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aca491a.a150a118.27e199.002a.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (3)
From: syzbot <syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com
Tested-by: syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com

Tested on:

commit:         5926a7da Merge 7.3-rc6 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1622867f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f0127eb11110629
dashboard link: https://syzkaller.appspot.com/bug?extid=25a1d2907885b2182275
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bd123e580000

Note: testing is done by a robot and is best-effort only.
