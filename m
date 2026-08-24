Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB57238150
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787545958; cv=none; b=s3x3jAGW4ChqF2xvAaZNG9leRSl9BwhwXyvVbj+kgotACh1NQkeymJk2Y7KQRTxGqC073RFEYV2iCx3j0ovqYMtFjMhh1d8/hf8hycEG+nlF5jeJLMgoLYnJuOTP2HDS6iNq5Y77zv66l05ZMdjRDzLekr/HWKgPMuvqazgds6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787545958; c=relaxed/simple;
	bh=LULVv9+cxMQibNAw4GqRtO4wk8ZrnsL001SW2ofsgLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ul6xsahXfZKavYtTYfg0scNyvaR3sYo//I/79kHnSEKBII6SD7FcToG9+eUSmD9vr+/VlniMW+85i3rvD9LUtSjvFLyQcvIXPbB4PDGSpHZMExMe/bhcnR3gGOBv7PaGoJwu3Dr9WofqtLWMMUa5XYybMZFLiYoXLAzJxsIh29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48e5de5a23cso5715536b6e.0
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 21:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787545956; x=1788150756;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYDXorjwEajIXLH6ofQ7xSZ3GAPtikaP65ZXmuxfVGg=;
        b=tLkqBY3L0EyBS5ETKxWZ/Ddq/nBECOw76aw0ZGYonMtWMeJYnHmlWkrZfpjfabe4b0
         ccP/HgEoRUFJ0K2Dfb5nH1zNSsXDZuEMV5jSIEi+maVqTSEfGh9JVKr5VreTUZVmVnNw
         DNqcMYdWu9Dxy8Z1qktgw4QsRoHlEu10GfsgtvHMnU+CbR6IltpJnKB5pJgfsjMStfp6
         7fcKqRuKT6tlvaP7Gd9Fr6+gBLMgERIFjG+QbsdeRsrLzs77HqK8xkvL43K22U7WblJr
         cIa9o6e3kh5DUf38rwDmKHDdvg9cYVjAjTf95Ik2qWA82vb1bQoN+ws5+GMoyvSkDDiA
         vmJA==
X-Gm-Message-State: AFuF++n8/c01Xa2LMNt0T2NW1F5sUQAUGbw7K35eHc8i0yvdhv/7eP9z
	j631iask/p65wdUFd1/Q+q0CpKafcvjudvPV2J3J2OsFZ/jrznMYVKPGRQy30NVRA5B/YwbKnzv
	rdf7cn9HZ7Cz8ct5GHal870pEEunYYucfSppOsvzYicVAK2jYwe06BjKfpJo=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198f:b0:495:f79d:b08e with SMTP id
 5614622812f47-4b2ef584b2cmr25746409b6e.21.1787545956082; Sun, 23 Aug 2026
 21:32:36 -0700 (PDT)
Date: Sun, 23 Aug 2026 21:32:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8bc964.dbb3a75c.13dd47.005f.GAE@google.com>
Subject: [syzbot] Monthly input report (Aug 2026)
From: syzbot <syzbot+list4c2d90c86389244a175a@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 9 new issues were detected and 1 were fixed.
In total, 26 issues are still open and 65 have already been fixed.
There are also 4 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1192    Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event (2)
                  https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
<2> 270     Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                  https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<3> 177     Yes   KASAN: slab-use-after-free Read in report_descriptor_read
                  https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
<4> 93      Yes   possible deadlock in __kernfs_remove (3)
                  https://syzkaller.appspot.com/bug?extid=1075f6dc93f398c1857e
<5> 51      Yes   INFO: task hung in console_callback (6)
                  https://syzkaller.appspot.com/bug?extid=6027421afa74a2ba440d
<6> 26      Yes   INFO: task hung in __input_unregister_device (5)
                  https://syzkaller.appspot.com/bug?extid=78e2288f58b881ed3c45
<7> 24      Yes   INFO: rcu detected stall in do_syscall_64
                  https://syzkaller.appspot.com/bug?extid=a3bc6ce74afdd295fe4b
<8> 13      Yes   KASAN: slab-use-after-free Read in input_dev_uevent (2)
                  https://syzkaller.appspot.com/bug?extid=2a123f6269da57ffefaa
<9> 8       Yes   possible deadlock in tasklet_action_common (2)
                  https://syzkaller.appspot.com/bug?extid=b5d7ab56d43de3fd5aac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
