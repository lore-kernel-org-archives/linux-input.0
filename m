Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB13D1AA2
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923565; cv=none; b=hrMLVkHR+AUljXQjHCFF2EOcCxm7yPHy8nfsEIZDvuBtowBR3RJzzjHSyfb1f1g2fAa2ELmz6CcWd+jPcsbukVb06WNw5OZ+2prQlv4SZRqVopgzwImO8hewK7+iu3W6dVH0/OtTmoIQ75oxkrLcFreb4cZL8Qar0axlAWsyBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923565; c=relaxed/simple;
	bh=NIuv6od53DRf2oVKSqrVBaibQdZOjEOaUZk9OXQcI+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jrv/Uh3NNFhCdO6yLs9xOKIqhqbownrjqODwIYIjidzVj70OvbU/fobpGLs4mjUeRxyDmaATuv/lKRtA6oFIbsv0SnJGMqb808Wmd4kFayeieP11A2x4tvBv5sJICUtMZ3WaCfFIdYikAa+UuZ4ts5rsbeTzWGYHBLyb9858B3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-467c2c754f8so569068fac.3
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 06:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787923562; x=1788528362;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZjgTeM0Onmo3J23ctw8YBEh9xQmtBdt9GZyqCaE/QF0=;
        b=ZH2H3URJbFbIU8snxq9O+RYTv0jMTvMWa/4MaiTA1JP/xSe88dcsojKuzwtk7PvB4n
         y3B19c2zvm96ebA9YJseL2Zhl3RLXucqVWBHoQuJeypeteIqkQLek7iZRF2Nc7A98jzn
         VkQZk0nqXTQjHZoHY/At39Zvrozir075MkG6rwQSKYrFWpuv7fxV9dHCDAVNwaRQXN1P
         va5cnhiLnrkvPbToykBWYFY+mCWZWyEuo0GD0DSPCLP5cPPvr8K9FVXJsWwqhJJs7VE0
         H96DbvIlWSyNTcRqGz87dN3fhgfZvzywA7YqncfZ8ahAlQlmuEcTBc31OC9d22021tUr
         CI9A==
X-Forwarded-Encrypted: i=1; AHgh+RpT86ZxxzpThjNIDTuHVGk9/xDGx70EtSA7881eHjxJPAn5DRXu+USjOh62+LmJa8Ou49hia/nUEf99Iw==@vger.kernel.org
X-Gm-Message-State: AFuF++mWMjcAs0PH7/b5QsBgMwhcFFyGcVg+SaUCK5GfqKOJfxTynd+A
	ZaEpGwik+lGTBbfdZ75OW9sFbOKhIV24AxtrNQBtap3c2Hh1j9wuec4QOdL/Z/6aKgjNJ8BKsTV
	jWrnHacl6AdupdQyOTYSP8vDlh4IqRSpCAVhE+EsY+s7gR8IjfgDYn8HOPi4=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:318c:b0:4b1:bc2e:3f60 with SMTP id
 5614622812f47-4b398299c26mr6853171b6e.16.1787923562532; Fri, 28 Aug 2026
 06:26:02 -0700 (PDT)
Date: Fri, 28 Aug 2026 06:26:02 -0700
In-Reply-To: <6a802643.9ebadd4d.20b15e.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a918c6a.27659fcc.2ceef7.001a.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING: ODEBUG bug in corsair_remove
From: syzbot <syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com>
To: bentiss@kernel.org, ccc194101@163.com, chenchangcheng@kylinos.cn, 
	jeffinphilip14@gmail.com, jikos@kernel.org, jkosina@suse.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit eb51c9f8cb4f064981d9c6cae13de8eda280785d
Author: Chen Changcheng <chenchangcheng@kylinos.cn>
Date:   Mon Jul 27 01:35:00 2026 +0000

    HID: corsair: cancel worker before unregistering LED to fix use-after-free

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12580379580000
start commit:   73e3f0710014 Merge tag 'nfs-for-7.3-1' of git://git.linux-..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11580379580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16580379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9efed59cf70d6280
dashboard link: https://syzkaller.appspot.com/bug?extid=0a031a76585d1c7e737d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6e579580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e4ed49580000

Reported-by: syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com
Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
