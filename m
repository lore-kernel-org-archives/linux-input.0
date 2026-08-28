Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E391471D02
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925969; cv=none; b=aEdRPBlaTnE1vTB0soxEOwyPzbgv9SqgwvhWXQyxyuxlBS81Pl3xXxH6H4BEibPmuyzyeVaZaiBatTaYWBJmzFItzvtw10lByThsn6hhxm1qle4wH5YgVhjBdmfeU8DSPOclYNmzvlUsWGcr41zm95uGMHkyEk0+Clc8U+/HHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925969; c=relaxed/simple;
	bh=qmaSYORGNwISjTbbE1XIHT1PbYz3AlFrsu7T6UOygD8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kDu1AeTKhHsVTOZxZDub369D+PqLg3yRdNi7BLbW7PSWgzpw6TI3xsKWVl9en5c5CalEbKRj63oNmsJsklCzct90heVxSpkCXJS+MhKrCDAFUa/T6vRKUgTsVxb2U4aTmpW+RATVqrMh0C5isJhKnhJEQAgIvjGrcbP3G25YRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48e5de5a23cso1642548b6e.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 07:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925964; x=1788530764;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GS8yPGaPTIKohnoXkAjEQF4WQ47FwbB3S1bwuX4jWyg=;
        b=agaiylGle3kAZWDdzketprZqHoi1+QdEWB7viB92HM2bIII8w3sN6mkfMMNunbrAKH
         svGeZM1I8SZ/G8IADW0BTGLHvo3z1YqmmrssTxUlRGqlQ+mc16AlgFfbULRoyaKz9pAR
         GY3h96ooGweysFqMnRwmZ55k5/sPaYHDdvJRVdBPDFvgwCmi8xXeykCgqCSv08SUQ7kY
         gLT0lUHve7ydfVUejDsNlTfCjeGlMqy7oCcs91QPaHOqW5iO7U+ofAoxRSVh6R8+YIzu
         Nf0y/HiWzpRVmjqStM79yjYsJg+yhuFbj8UUCTbAyjztvhvij49jfOFxyARWwKAlU50G
         0PCg==
X-Forwarded-Encrypted: i=1; AHgh+RoxRO5wR5o6OiBhlLiExLX5zHEnuCUrVwiQHmEQRy+Qow2/gWPfH8JvEpPWVyCxLjJfimJwPBgFlSHoWA==@vger.kernel.org
X-Gm-Message-State: AFuF++m1Hhp55hXWhX4BsM8EPjngLWOdRW71fp5tYzKi1HqwSt1/PjzD
	rDUMw5H5MhIn/1bg5PZw9BSSyn/ryZNcxv2vknAys9+QginowZGpEswm2koO1mWB0hxgvB5658J
	c6lcX1w0CWI2Tz4lNrVUX9i0YmL+vpn0Yh9MQU1d6FNZpr6EWYV54iy0S3L0=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a16:b0:4a3:ff0a:e407 with SMTP id
 5614622812f47-4b39826ab7dmr6642851b6e.15.1787925964221; Fri, 28 Aug 2026
 07:06:04 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:06:04 -0700
In-Reply-To: <20260828134149.128160-1-jeffinphilip14@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9195cc.4d659fcc.734b4.001f.GAE@google.com>
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
From: syzbot <syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, jeffinphilip14@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Tested-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com

Tested on:

commit:         818bebeb drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=109cf625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138fdd49580000

Note: testing is done by a robot and is best-effort only.
