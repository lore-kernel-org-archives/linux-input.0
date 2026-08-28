Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6431F9A4
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926804; cv=none; b=rRP9hTggEdB2Xu4IO9D4VxB4Dh3Fof7AMtWxgVPSR0y1gTBj5264fze+A6AhR8PCuTg1u2XH9ydptwPCgw/M7lbHQR5AWYdPK09qpwMjqZFSN7rDmxoXwUKWX38f7Y6UOlSUYhc1kn0C6mD28svbdn9seOREfTUypi0tUFXQrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926804; c=relaxed/simple;
	bh=Dtei0Q0DVYXKDgscH2xqgQXXr75JyW1PMC8df+Y+XP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Es8HMkmW35tneE5iHi3+Qz803/g8YQhTExjtQftm1ObZDsmmwDafVeE0AH9R+tewxPLXKoJPgWMXjtwu68RRZdUjjGSzBXM1KCV0/c8/zbC00VbzHiUBNpXXIcGur+7X0L/83PKfqkklJ+lAoa2JlHBNXf4+FP3jJY6Oj2ukSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-463ddb3b4f7so1344401fac.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 07:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926802; x=1788531602;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QkNQuF+HTncNTf9v0fNYbdxqYXnPhQHseV/NE/n7x7Q=;
        b=LHBTGH+4IdkII6+D1AQ7u7gvFDXXyKN8YMJKpnt3BWaQugVqkFbqMGkegR7mWctxoZ
         F8j1xFkhRFJ6q5cejtTSvPfTxYTk/M6BOMzqPo9x0oxGWLV+LRRi522N3ZKnUh7bILOA
         80Q+4oYbVjbWF7JzxZoM3e1iU9yyjZMcmktmh+YOCSjOejtqq2ME2EiYG7oi5wtLbzHk
         RVHc7RUquuOuA+KIqy0ovbnjfhCZsU+IrfFwgVDi5DY7rt4Hr+OlbNdaPQp2b7YruEP/
         qcwPo0pvk06IOh2LyGGC2R8tJGRShzrzzW1B2B58H9dyrC5y67OEJZbwWlpPGJg6rA/7
         mUwA==
X-Forwarded-Encrypted: i=1; AHgh+RqRgPYTWnjhyKZ0YqVbkyaSSZ1280xnPTaQSNpm+iGFcc5oDsu2t60StUp+ql2AYmPBNTb/QiajsHOxVg==@vger.kernel.org
X-Gm-Message-State: AFuF++nd98yGo6iCgOojOmG8XsIbhQLogwYM1Kvknvai4KFpG3T8OqRn
	BUdb4Driw/hcyr0fwWuxGyzmJl0jLk8L3U5TJRwr/1Xtpi7xrP2ddJxklQpLHhOV8/G6BdKh/SY
	3NWE6vGerP0FziRpZyP42tk7+pLlSeFd7kLGmMszUlbN2k1Qu7UE8CitXEsw=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:189b:b0:6aa:e13e:ba26 with SMTP id
 006d021491bc7-6b1c67d98f8mr6532674eaf.33.1787926802059; Fri, 28 Aug 2026
 07:20:02 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:20:02 -0700
In-Reply-To: <20260828140330.134760-1-jeffinphilip14@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a919912.1d9ded08.62e62.00ee.GAE@google.com>
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
From: syzbot <syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com>
To: jeffinphilip14@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Tested-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com

Tested on:

commit:         818bebeb drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=126a6d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ecf625580000

Note: testing is done by a robot and is best-effort only.
