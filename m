Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792931607;
	b=udJO0ZJ+ycYbrZwdftN1f8aVhFbwGPYGGYjmfAxYzuwl+6Gbl8b4ulUmNhZ/ZjrV/QU2
	 rg107wBlIptirV8VSwTpRWWI3SJ9kM1Mz6+IFxC1qzjU1tUody3hvXV0UvCMO52lK88FP
	 x47KOMG61mHs33z5Mjf7SSZ1JzTlxt6UaGvOVKx6SS5tTu8kyq3UIkLuPzXdtucLfmx2P
	 /eT9t+VNhV2VSGC3XptWI+NJeN0BXqPXFPVsOIPusfoakV9cnSp2gufw8RuCt2RvKzERo
	 4wPUDP2PcPMHneBhjLQvNCL+VZj7IVq5Pq7iNuH4KPLRQ7k6sYF+bHXxm6QtjsVU6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931607;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=kVBzGFtNCTUSDocuvH1j5E27S8HzPs9e8Kt49P7lnhQ=;
	b=IL0B8Hsq3lL4+6rjWa6TzLen+iTciDdmAbi7cDBkk7ALRmAmGxMIw2zP1PY/wjekYQQj
	 MVX3yDq8gEu+56Q4NBogGXM8iYllPzphkBXkr9AIn+8V2vc8lbLj3Ariq8PiDDdqEQEPN
	 mzeAE6HSLZZ443wZMFq1i5BfT/U1pMEsxAB/bkPd1OEyR4rwD7Om1Z5eR/thf1UX4ihBU
	 GqhtN28ZYHrw4qMbfbNr/P7HFonN4sw5NgRVDYDjwxrbPhDawPwpfL5CqDmQ8MED/QPAg
	 s0JDAhWBdDzVGaFFZQ1QoO/Pz6n64ySWKRHWRXTCVig7Vt0HkWAegovsJe5oY/Aci9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E90606A31B
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 12:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E90606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8255327a28fso2998751a34.0
        for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 05:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792931606; x=1793536406;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVBzGFtNCTUSDocuvH1j5E27S8HzPs9e8Kt49P7lnhQ=;
        b=Io2ZoqpnVCylUSAevputGXlhCr6+p9UaHYIDbTUMGavoCB97OoV8Eqa1nl+5pk1t/p
         u9BqJ78v1vRxvU+vfc8QQ/c/8zh1vVPq9T0gaH3FkDxr+taBEdjpHzYzPIZN8DKvPKI0
         aFW1/UEEkPWI5VRGElP7E68Agj23dVlz6rdsrXojv2azQZcBlBWEYVNAP8qMlu4eKpU8
         NFylgRyO5IXwnEFQSk66b1wEg5ajhkUtEcbsHZPUY/zuArGA2Ju520rIx5bQHJxusaF1
         9+/oPnQhWIKq+NKi75cl/aQpuoz941dQKGrr1o0ZXkEquvGIW5yW7YL8G9KyUIzgvlm2
         XWWw==
X-Gm-Message-State: AFq9FYJU3eE/jJhy4GJIh3xRhkQSmPFIA3eEg/JAzWjget7k6yDVpMka
	bn3lWGl0SFJMMadY0MojuZJVTCuSjLBf5nZVXdVXVu9z2pxejW65Ifattd5akN1VzWlqGLQQfL8
	dbFUnyxr2izFRQr3Pr8lmJqvdKoCbcpeREntRVBJev7GLS4z6LZMHKjd0Nz0=
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f06:b0:549:572c:fd42 with SMTP id
 5614622812f47-55c0031b091mr2010500b6e.47.1792931605841; Sun, 25 Oct 2026
 05:33:25 -0700 (PDT)
Date: Sun, 25 Oct 2026 05:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6addf715.67317f00.38c4bc.0080.GAE@google.com>
Subject: [syzbot] Monthly input report (Oct 2026)
From: syzbot <syzbot+list4c580c10329f11ac634c@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 3 new issues were detected and 3 were fixed.
In total, 32 issues are still open and 70 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1516    Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event (2)
                  https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
<2> 873     Yes   WARNING: ODEBUG bug in corsair_remove
                  https://syzkaller.appspot.com/bug?extid=0a031a76585d1c7e737d
<3> 368     Yes   possible deadlock in __kernfs_remove (3)
                  https://syzkaller.appspot.com/bug?extid=1075f6dc93f398c1857e
<4> 42      Yes   INFO: task hung in devres_release_group (2)
                  https://syzkaller.appspot.com/bug?extid=d789904ff97c2f3dac88
<5> 28      Yes   INFO: task hung in __input_unregister_device (5)
                  https://syzkaller.appspot.com/bug?extid=78e2288f58b881ed3c45
<6> 12      No    KASAN: slab-use-after-free Read in k90_backlight_work
                  https://syzkaller.appspot.com/bug?extid=abcedffc9201f2bb66c2
<7> 2       Yes   memory leak in __usbhid_submit_report (2)
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
