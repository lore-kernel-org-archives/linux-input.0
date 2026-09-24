Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F79359A70
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224423; cv=none; b=S8RlVNNFRAlX5FpB2jv9Q02NMEChN6EnbAfyKQJHBKAi45IlzjetPXcV+OGK5zhfhI2QwZqRxeAR7c4G3bUDIF5RpM4jglAAK2uLU+xOeRYBii+xgtHU4e8YqMg8Cwvc0FXcbsKA9j9h/jiTW1fA3wAAuxyAB9RB9feisPgZVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224423; c=relaxed/simple;
	bh=3QrqEW61DfZO06NnG7amST4oSEHfnKg19eZK/WvZLE0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IzsjARTGqKLGzydwnsoFsUxwoE49qZ5n032MYK9nk5zGCicYeDSpvDo2g9cwK2lDpPCYjDXSmDy1mMG9IgWSoa3vzkIEmujV6rDGFDDGxcP6SuPaIUlryDfCmuKBcGsNeuwkZec+BNjmt87CLKhDvfPeiNMLX2DtJCagCGn6zO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab4ca7ce3fso2153017b6e.0
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 21:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224420; x=1790829220;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nBcnLi08l1NYXdX9F9Sp3GEPBb3p9r+MlaeoU1T9lP8=;
        b=0ou3OMSVpbB7URxGIJfCh0l6YKEAC/iRNkWHgO11QKUZgpMwKUBEgPf/MsFnK9bDQr
         oWmqT3e1E/h7lFGWtYYAQddwBEamlhmAU/7zwafmf7pa4cDKMS33Foy4sQ/MJNt+68SJ
         wCFiQr2nSmnESx0JD39o0xKVHyJ+eOyPMZK1jiMWGW/RhMymqIKIrLHr71c1L42N9ga9
         tF1xr9cXBaiSNll+urZAMiEdcsEbOYIM9NpaAKb5LksEZehAW3RxyqmV+ErkDfPr6380
         yGo6fSrFbOelEgyVChqfEKtItFoWA+SMyx/33hQbyUiwBGXlN67WV2QAe0tcZXUVJNo1
         vSNA==
X-Gm-Message-State: AFuF++k64WfBUEk2nn2AqUYNjAgu0cXylVGPqU7J5ELI/Zv3Wo4GUt7r
	7WvseDguxbPJON0ziVYTNfQatmiRlIBuuBBL6vS01r5beSWJYxQZvROzieFBi1RRmrPkBnL53pZ
	swaXaqYyQictjd3qd38ouUFL5Zj2arDZEuTU4IH9a8yifIUgU7ZTg4BrZimg=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124a:b0:4c3:7695:1178 with SMTP id
 5614622812f47-4d72c04249bmr1240958b6e.8.1790224420584; Wed, 23 Sep 2026
 21:33:40 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:33:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab4a824.2e4f7bcc.334f63.0000.GAE@google.com>
Subject: [syzbot] Monthly input report (Sep 2026)
From: syzbot <syzbot+list8f8640fedc8d63924cf2@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 6 new issues were detected and 1 were fixed.
In total, 33 issues are still open and 66 have already been fixed.
There are also 4 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1367    Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event (2)
                   https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
<2>  199     Yes   KASAN: slab-use-after-free Read in report_descriptor_read
                   https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
<3>  87      No    KASAN: slab-use-after-free Read in str_to_user (2)
                   https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
<4>  51      Yes   WARNING: ODEBUG bug in hid_device_remove
                   https://syzkaller.appspot.com/bug?extid=f8fb5598924c7e645553
<5>  40      Yes   INFO: task hung in devres_release_group (2)
                   https://syzkaller.appspot.com/bug?extid=d789904ff97c2f3dac88
<6>  21      Yes   BUG: sleeping function called from invalid context in __hid_request
                   https://syzkaller.appspot.com/bug?extid=912222e4cb82423535fa
<7>  20      Yes   KASAN: slab-use-after-free Read in input_dev_uevent (2)
                   https://syzkaller.appspot.com/bug?extid=2a123f6269da57ffefaa
<8>  18      No    WARNING in roccat_open
                   https://syzkaller.appspot.com/bug?extid=e7b6bbf6cf88d7d932c3
<9>  12      Yes   KASAN: slab-out-of-bounds Read in aqc_raw_event
                   https://syzkaller.appspot.com/bug?extid=9ee5f5dc18673d6b2f37
<10> 7       Yes   KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
                   https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
