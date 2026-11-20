Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137112;
	b=bYfhQWA+u5LeXi7VjBc/WiK/+e7yleNGq2X0/LHU5INVHRLmBbHwMgZZVjQspr1TdHtI
	 kdaI83tCwxNsC7PZJ2LFpP94uJsDfP0ZiSrRRTzq1CbGretlEVP34x+3j0Ui7wkWsxR+Q
	 mkX9Rij3dxp8UKPwOOE/z2KPv1xgBjsWEbWyH/DCB//6pZtk+8P1QTUdOt8aOWUM4bF+k
	 IAZSeJ8GqNIyhWbAoHHsFhZsNQpOKc3fgpKsMJd6QoRt0v+iQr0LBLOaJ1+DcA6Rs8Lbl
	 NEnjS2Lpaq9WHRyOt2X+PZn8PJp2MIdDCcRDn9xjIM3DmhQ9PfXWF8rmqbs1UTQI1dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
	b=k3B3hYo7aO04voLYUL5s7IbnrKzqNRrT3wQfL0b3hDEKQ/t30Iq1f7mr4UAyfPESO1XV
	 9W/mlvVgrG9fnXjk++hLnhFGHoil3h/FbeW3YAddfAHZvwv4An56+1jzuHhC6HP1c3z8E
	 H/uxqKyDQXM0361a5r/3wbHTTIdULBOdKd7lzcNxETFVpqL3Vn+aGg3jOW9iVDz8JSjfH
	 Tbyv7bXHeFnkzxQ8mw4XVBzcS+RDG7xigIq1yjNE6oQubTZpbNtJGDfzueVXJtq0jAU5X
	 gDrGYcqGihqBml/qJcicnvRp2mrnVB/WxZkmh/yDTzyV0vZawyt7O3UaKX4gyJXUoag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsJxZNms;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068E606A325
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 01:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7068E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsJxZNms
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b40283c001so86562a91.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137111; x=1795741911; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
        b=AsJxZNmszeOmf1P6FoD0ZvPkULx6VuhNHhNoP35uartk7q3/nSMkJlYOf6yueuMrlI
         5rUFjDiLJpw3jewnIekcwE8Fb/ABsrk3cWYcbWo/qMDSk/kCrTnzfmyJ4ZaeMr5v9fY8
         zpt8AVlZVCuJhBXKzglnK6saQp3dvp9lXhoAoPmapLCth8xICO+5rUPc+BER5EqBJapn
         CiHl7pFqBHYMnE7x+uDF+IOOddA3ragPxAk1EgAtVDKg6dpGW7BGex6yUqBFRRVVIXzE
         oAfIhFc0kAsegIkD1PfBMLJa9+3/W4AoUIH4ChL5qWACy8FxfpS+Nf1Zk+RPTNgMnvQs
         6vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137111; x=1795741911;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
        b=ENGNq2nIzuzevU4MfxrobW9c7S3JJlMVVwQHyVJ0gqg5TIY/kLVociKkxKewn8lPfF
         4AtdizuoF+D8qg4Dx4PPw6PPs0Tbat/CtlTZfIpmdk2//u3Y1juSSZoRkneQ1mr+0MJ+
         hAv2rLjLMURyXb70X28FTSj0YQ7zn2ZWFmTQFtx0J6pezycrldOeLBPDVc8Pd2O+85Bs
         16BuPlhYhm5+PRfnEQZD6qAKUxaXqgJGtgJ6eg+i+0MBhEuu/36x6pR+H1auDvks5Q+h
         +gJUfrZzc56BVIIRD7KE/diaVR2iMgGIKQBdDMw4ZGHUnFYhHF/T51axqM/J7sO57E/g
         RU+A==
X-Forwarded-Encrypted: i=1; AL+hErGMKq8hvluQyRFwCs9iAQgiPhlzHI1fDumEjsleq0ks9wcvbtxZWB0uRrJvLxBEzAspZhEySUOAXaZHig==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ts+VxRS8MJfn2DA5FgZB8pkqCFpoaEqaRaakQDihrDuzrMYnb
	ndW1kWOqfi9SuTorEYZTRRnkoWtBGOowsgvWw8y4klfAltuwV8/khUE3
X-Gm-Gg: AZFdTZccJ6wjprjygBWuLcDdFs1ZQJRScWUG2hbSa3ra9gP5E5djpnV7pbmBWDmo4EY
	ZyG8OSeL2GndTKCqAy8Oq+2V8VTXKyoTROSRBDc7CWwJF/b1Kyno3N8+PJ3i3WTbCp3b9P4oEKZ
	0yZN94WDt/d621E5+2uJK67UnEmKPaWF0l5ah3t0kTjFX2uMWWSu6PT120JI255VoWFDqHbm54N
	O/Ds81mFShEftVoYBkFViftk/MnPabBSKUrIkxpOCbYcvhLbwup+XxrghVniHwOGzpXnR9rEouW
	cBo++uVp0tVwUrKD6F0HbwXW++7bJ6Y6ogpyYBK5G1fLUgQDMaJOebw0y2wWBMFATGEvpnA5oZG
	nhCpfJbTbytKf7Ny1rYDbS4G94sM2aBj8XLiCrsG1QFP3YtwfwyKfAJbUYPtHLDoXprYqDu6p9H
	9j4X0ZGKc6dHL+WMJZpevxomj0KjxE6cuySXtngLQuy09V3wn345kF85pFj8cOEEPZtl1uSqgGD
	u2XwDmIiffbjY0NHFxeBsg2Hs28m/q6Q7YjD1q3ZJWGpcWRauLJIdsdli1wvQ2EIwJtTu4RWS6N
	wLZFSQaiODO2SailPRoN/k3kBpM/+h6Ukk9oOYk69lhTb1TndTxrEZHyJMyJQLXlt/Rh3ap4JIh
	xpYxWgKf6XBI8
X-Received: by 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7 with SMTP id 98e67ed59e1d1-3b41c8d460emr1098385a91.23.1795137110648;
        Thu, 19 Nov 2026 17:11:50 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:11:50 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH RESEND v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
Date: Fri, 20 Nov 2026 12:05:46 +1100
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNTQvCMBBE/0rZs4tJxCCe7dWDHsVDPla7UtOSa
 BFK/7tJRS8eZ+Yxb4REkSnBthoh0sCJu5CDWlTgGhOuhOxzBiWUllIJvBtusWfXtc7joDBSouD
 xtzvya7PReuWlgPzSR7rwazac4FAf6/0Ozp8+Pe2N3KPcF9KaRGijCa4pVREt/0Uz9bXBNL0Bd
 +SW7MIAAAA=
X-Change-ID: 20261120-mail-picolcd-v2-resend-20261120-ced5a8663d10
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0

Hi Jiri,

Thanks for catching that. Both patch emails were line-wrapped in
transit, so I'm resending the full v2 series. The commit messages and
diffs are unchanged. I checked that a copy of patch 1/2 sent to myself
applies cleanly with git am.

This series fixes two PicoLCD locking problems. The first moves output
requests into sleepable context and serializes LED state updates. The
second breaks the last-close/deferred-worker lock dependency using a
private framebuffer update mutex.

The first patch was tested separately with the original syzkaller C
reproducer and bounded concurrent sysfs/UHID-destroy workloads on
PREEMPT_RT. The complete series additionally passed repeated framebuffer
open/write/close and persistent-open framebuffer tests. Pre-fix modules
reproduced the respective failures. Physical hardware, prolonged stress
and suspend/resume have not been tested.

Patch 2's Fixes tag identifies the fbdev change that began draining
deferred work from fb_release() while holding info->lock. Patch 1's Fixes
tag was checked against the upstream transport-conversion diff.

Changes in v2:
- Address Sebastian Andrzej Siewior's feedback: clarify that the issue
  is not specific to PREEMPT_RT and identify picolcd_data::lock as a
  spinlock_t in patch 1. The code changes are identical to v1.

Helge acked patch 2/2 in the original thread.
https://lore.kernel.org/linux-input/CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=
=3DxkA9acsL9TSQ@mail.gmail.com/

Thanks,
Aveline Noir

Aveline Noir (2):
  HID: picolcd: Move output requests out of spinlocked sections
  HID: picolcd: Avoid framebuffer last-close deadlock

 drivers/hid/hid-picolcd.h           |  4 +++
 drivers/hid/hid-picolcd_backlight.c |  7 ++--
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
 drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++--
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
 6 files changed, 93 insertions(+), 58 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
--=20
2.55.0
