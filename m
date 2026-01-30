Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65D2F7444
	for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756647; cv=none; b=WhmIsaUYMFlyoIAw6uxJjT90XNu4rFiOtS97/fmYWRmXfAuoelicQoZDy1fAFqQKuJjTzBt5qAU5Nxo1ruXK6MGaBaExWqIPCzDi/LFNCWXbL5eXSTeBWkbMhdIE+3s/11fvpYAXulhgAxytzfU6yH2fn3IV482sYYzffkcuHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756647; c=relaxed/simple;
	bh=BdRblF0eUIZYT8LxhwoalBg55iUruXhe9k2VLW0Z9c4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ey2FTgd+0ZAocCYndMfbkcYKBWpSEQbOpYJqYr42eididbhQi4aYdLlXY1RK09IJxo3OSlMUpfMfOdzcpmj/Oyb7dP7HMLZzxkHknrFA2NyTdYxRrEqBQP4rOcgjZsoeMse/acEedxCViZSA4jdGqirNrJf1O+urR28lSBXYk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6630a7f447bso4099650eaf.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 23:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769756645; x=1770361445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04yApS+YXO8wnw6pH0ng6f5u1qXXv/RDzIOLVNyCM8g=;
        b=sY9kHhdvYek3Gh6tiR5qxu7lXiuzzF+OimE9hKZJgP4TqC65nRG/Ou2IwBdyvhpFKc
         iu5MsgG/yRYW46j++ZFBXM6sv9/XfRk6tq7iBHn6yCvEEW9Zstr2HnVinwDEzi/fXCVI
         Ecgyk3nEPKP83PNaj4p1v2hAPDztGXX9rU/mKw9f55lc2OPpkWt8UxjA1BEuwhZAVXFK
         a+63MXYWo5DzufVuxjGIwMb+bEJ/SSr5/xryppMm46up4X9jsFda1/XX/BC9WUdWoQKa
         S5vrbXU+t8yXXeiSLWRXnIEsTY7W8yi2AuxgERg4xUSejSDJZOt51NaM3uKBTN78yL2Y
         M2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWUXDyIG5Jfzlyts9QVx25uM1vWJto5o1C0owrJyvyZJEbMQF6YBa8nfrOqTX5/53bqYEaDp0TjvVYF5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzocb1tk4LhiuzZOBNk90ntQbyxulYWi3ybzJ0R84wXQl9UXn7w
	bk8TCslbkBioZAwoiz59NokamJJQVty0VN+kEYdLVHpxhI3avdCVHYlzoXgd5WJwwiTb2uFxyz0
	Dno6Hk4W4P4eMemp18jTi/+W1JEoFxemc1qekBJKI7NmtITlJ+pzPqHynsvs=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150a:b0:662:f39e:efb2 with SMTP id
 006d021491bc7-6630f3aa2e5mr692232eaf.74.1769756645181; Thu, 29 Jan 2026
 23:04:05 -0800 (PST)
Date: Thu, 29 Jan 2026 23:04:05 -0800
In-Reply-To: <aXxOhV79TnuYaw0-@chandna.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697c57e5.a00a0220.35f26.0011.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING in asus_remove
From: syzbot <syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com>
To: bentiss@kernel.org, chandna.sahil@gmail.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
Tested-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com

Tested on:

commit:         33a647c6 Add linux-next specific files for 20260129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=140cf6ef980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef5831c38e37e48
dashboard link: https://syzkaller.appspot.com/bug?extid=13f8286fa2de04a7cd48
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ec1644580000

Note: testing is done by a robot and is best-effort only.
