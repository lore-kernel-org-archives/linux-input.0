Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E830B53F
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849464; cv=none; b=WNlMN1Wv/5lmn0xBCZPsWAmDp/sQfhCxUdyGNAl5cGn+JVYlbYahlQxGL19Z4M23rZzI29Tzh4o5gIncv3j2Ltf/tD2DSQEU7oOj7QzfnMsPHFYGQBByXtG1fuWTK0/K2c7TlmyJxwDNsL8bTcw8Odo+mRp+WMi/Zw+k/URLHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849464; c=relaxed/simple;
	bh=tFLQ3JuBry+GrFMTvnvNPPyuCdQR6pSnPsQLTnAgbCc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l4nng0BmZ3zqN20xV/YlwZJFfd8wAlSzn+yViGDEV5auf1kZ/OXid71se1XRKQ1YBDXR2SEd0as/JxqZD+O3Lz4R9bFgsfxCFCTizyV0GCYESXayP3i5F1OmqvpJ7rA3eVoFitgMcVEE3gr5LkL8j26Rrx7+TIrX763NsUzSifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b37733badcso326611b6e.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 09:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849462; x=1788454262;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zFqjgAYe8iCKJQKyaWMIcLe0u+fWcArjSHpg11702jA=;
        b=OQeTlWlnLcSR/10Dq+4DYyvPvb737p313TjScWOSoNzymiY846GSWnc0PU6h+gTiYl
         jhN8c3rKgLFI9nBRs2BpslcLV12JkmkiHylkicu+5G0v3Ogl1stB2jxncn+8/Da+q/g/
         UeWUwtBmcoF7B601/3nPLM2aPg+SxKYBeFnPMGuNWzKvjLzymk5IHWjTs8B+1WfbF84e
         kzMkD76AHhEWb7BTtfPBC9L8zNxy6O4m0pX1C0XEC+JvHyI061tUGHMFCM4g8vFf0GeG
         zxHt62bDSOlvAvCuiOKmojqlcWS0FuoThBYNX+0/k7ExT3XiXpLd/AEi3D+Ql5/iDFtr
         79hw==
X-Forwarded-Encrypted: i=1; AHgh+Rpeiy3zebFLsbt6YDFhNyrgeaCLCGS0lmom5LgfDXfU9itXs2zxT8vbcXRSheK0Eem0vdBjMXeldqVyTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nSZ9tEIY97Q1w5hxH5tCCYVdN5rN0KtFJ6h7oCVKfanKo0cU/6
	dweAvqXFcP3r++N+E98cwP93oUiw1X6S3TZa1GnnXRl3QQrsST/LWR0YQbTWy35yJQ7u4Gso/qe
	fpkKek8oWg39Hpb8U9zv5O6kE5xsiNgw//ZkTEfqX++LMXUa3QdlNJ6igyn0=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1627:b0:6b1:a22c:1f12 with SMTP id
 006d021491bc7-6b1a22c22f3mr13088461eaf.9.1787849462373; Thu, 27 Aug 2026
 09:51:02 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:51:02 -0700
In-Reply-To: <20260827092301.19883-1-jeffinphilip14@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a906af6.4d659fcc.734b4.0011.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in roccat_open
From: syzbot <syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com>
To: jeffinphilip14@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 12



Tested on:

commit:         903c1cf6 Add linux-next specific files for 20260821
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbaf6d30cb97db
dashboard link: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1513b415580000

