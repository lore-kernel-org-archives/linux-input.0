Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638828;
	b=F76OhWUEvl/fxnep3ZFv4pW87zzfUfNfbB4qPCDBUqPo681jySLV2KYwSfsjFSHmUN4M
	 4jaORszjlN3J7qJXJoFlRAs7/ZPYr5SSHVgAHAPwSnS08+D2CvoqYfiusb2rRcqz+pb9+
	 DnD33gzRq90Nxrl5kypvAV5zBnzkLqx08DF7efPtHrIxaYr24V7D0J/+GP2jGb5SeI1Ds
	 Vyqpu3Za+3Fsdlm2TYl45oZw2TFiSp5vBYMEZ0wy9s0IetZnKhc3kBz7t42D8Ny6U8MLx
	 AxbKYrGgqr6ml8tNLssAR3TbvJYHVTd57LLM3SQtjtfgWUJJxqVuehq9PhafFkMg3hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638828;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=Oc3NJGpAs8FNeOb1kE44lSvp6vnsKf0LvOK+gGylU+E=;
	b=MMPGM/F5tsK8MuLoUTTlPdJwcxvf7B4BKI8kBbPI9PuaW7CvBvL6rXlPPHczr+/ZiHQ8
	 GrIZX0lylH6Om0gLGENDdhqzppiuhaMzZi30ls111S/9mfnMg9h7GJGfFNcm/S0t26dcT
	 2ZU9CJStBigm59ourDZy0ik4YUXak6CPkD7NOTERxlWdrWYkrzzaGCm5nSv4ukC8SSRJl
	 jq8uBrpJDLoTbYU/Juj1pDYRoDSqSjU8qVoOspiKHfvMj56kKGIWxKcpDnBhm4KHSCeDs
	 3TPRAYYuflH0YfIlqnGRqUQEC/sWveLdWXQHmPCFOAQAN1qMuaKMlopCmSUjk0FEEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783DD606A326
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 20:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783DD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b2d1eb484aso6604951b6e.2
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 12:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638827; x=1796243627;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oc3NJGpAs8FNeOb1kE44lSvp6vnsKf0LvOK+gGylU+E=;
        b=koZl5shBYwUQCYdtlR58ro7+kWAM0RxAoQFoH0//WyRUh166ZnDl3FknqcMWyAJc09
         dt62jNdQjdZUfPySyk1kFPAIB0D+zl2g2XcpbLNmKnnm5iuE+L3907MgfPCfgUXbzfg6
         Q7WDINk9D9dUB04ckzkQCJiUKtZpuNUuo5q8jTTJvxJz6SduzfaTosJUu054R7QH+tcl
         PAjs8o2qACZqmL5jIdxyCzPPVGoVVznRgWn9uOJ7Y//5wbAmVBZmLS7sWtI4RekFTw5+
         kXSjTVWqNdTtaHZPEjnKSwv/5rBDrZNlhwkQQalmKl4auSm+GuajgcYNWSeasUC7Mx/m
         0jIA==
X-Gm-Message-State: APuU4Z9FB13fD77cnNdCx0FmdBcR16rniiMfNS7rNj+eF1QEmpiWEXF+
	yfQ5sjbT7yL8mIm7OcgSNpZvGd56ULlIoXXhxq6xijGZHMYP6h6ciuC6PrbyCNYYu5DHanrLQoU
	ozKSokkYW0foKtfbsI2+WYGvjbDMLFG5C2j6wLa+8wrx0uspZyofph+mlgN8=
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:250d:b0:572:f24f:c443 with SMTP id
 5614622812f47-57a056c81d6mr19190171b6e.8.1795638827424; Wed, 25 Nov 2026
 12:33:47 -0800 (PST)
Date: Wed, 25 Nov 2026 12:33:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b07462b.bb6e6ada.e0302.000c.GAE@google.com>
Subject: [syzbot] Monthly input report (Nov 2026)
From: syzbot <syzbot+list38d6ff782e475adefcb5@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 0 were fixed.
In total, 23 issues are still open and 76 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1097    Yes   WARNING: ODEBUG bug in corsair_remove
                  https://syzkaller.appspot.com/bug?extid=0a031a76585d1c7e737d
<2> 503     Yes   possible deadlock in __kernfs_remove (3)
                  https://syzkaller.appspot.com/bug?extid=1075f6dc93f398c1857e
<3> 12      Yes   general protection fault in wacom_report_numbered_buttons
                  https://syzkaller.appspot.com/bug?extid=ae7f998154426e723cbf
<4> 4       Yes   memory leak in __usbhid_submit_report (2)
                  https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
