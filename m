Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D139C651
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125705; cv=none; b=uULoyKdSx8/6kautUQi/LguhlKnMDZyMnQBi9ZNTtAvKOnQ8YmJs26m5DyZMvSgZJ/l/4sCps3gDqSpbpMK8QSBFbwms77lp4XkkZ1Hb+4SQp1BZrG/et1YXTwrhXNlKrpDfV9biB2GGFz6/cS2llLaWaCXO5PGT/763TbSIVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125705; c=relaxed/simple;
	bh=ZZ4pBXDIrZeUKSoJcjLSCU1hhEAVf1/7AA3xeYo0rGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r4KXtUZct7UF0ujX23J85VOj565IrOZIfTdVhJ9/7KRQLB8SYvVOhGOJ58MdhDT8IYcqcFojyquRYNgtvyZCLyT+kl44EbCK5sgfoEjlvYlvdbhchoAmZMDH8Z+9TPjVbG3q3ix6FZkwRessuQumPWn5+xbiCwZPpJK91DOXito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-66485ced3aaso14514371eaf.1
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 05:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770125703; x=1770730503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/ye+P3u/TQniUhIsnz6XxNe/73JJs4d9RPEqAhqUWk=;
        b=AV8jXVrDTnSVcUz6Wv8Mom4IH72fuooWF7q2Oe99budIiU38GdNq/CvDe75YxwNpAW
         GhEOVbFdyLZFhr8IOERBMdFoTkDWjD+9ssUBeaExYixAiT7LBPC6XITm2gw4gCspDjnr
         WMSWfUCQPUsJYj7jsqTRc3oArqil5T5Xgum/J0AZIa6bwUSVhjCwBBayLEvxL8DoAt44
         Dvh7HyBO4RKsy06EOaYeUyFSOMImctoM8W6ytySqrEBP/dr45k6ygX7s8bw3dRqvz77s
         8JXft+xwdeoM1dosCrD2Q5Kklh3CCickT6H0LHotcGJ0BiLDUK4w1rirk1UC/DxuLEVH
         0n8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgHn/r3UZxGbBNFXuFzUYwI94uRmPaYYgOlMs/gTIj9kGFqo6v2ZHyV01yzwlv6V/5Z8PMkbxTK8IKyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+A0GfbMfPXFQJa8yAD4QERPqcmYPMiv4ctrReyrsjRpS1fN9
	nD39gMspbbPpCXK7JpkICTXqBiWDbZ7wMkS1BKplP/zLr6cl3tXOodOl7/UQlhgxeqSwbvf3HLh
	sOJBAa6K4H5eX3zgz+s1KtTYl0VD/Sgx7f7fjF0aR8+KnIbSb7lDo0AD3cCo=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4106:b0:664:7c2b:c79f with SMTP id
 006d021491bc7-6647c2bcb13mr4298574eaf.73.1770125703078; Tue, 03 Feb 2026
 05:35:03 -0800 (PST)
Date: Tue, 03 Feb 2026 05:35:03 -0800
In-Reply-To: <aYHJUJzHlkBD_Nza@chandna.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6981f987.050a0220.3b3015.000b.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING in asus_remove
From: syzbot <syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com>
To: bentiss@kernel.org, chandna.sahil@gmail.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/hid/hid-asus.c
Hunk #1 FAILED at 147.
Hunk #4 succeeded at 1346 with fuzz 1.
1 out of 4 hunks FAILED



Tested on:

commit:         193579fe Add linux-next specific files for 20260202
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=750532df2c47a03
dashboard link: https://syzkaller.appspot.com/bug?extid=13f8286fa2de04a7cd48
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1129c53a580000

