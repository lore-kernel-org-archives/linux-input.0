Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488267;
	b=g4jb8AdRs9EoUO/SQv0ssPVrBwJnawZjwtjzjI7nU1zfNi4Rcl1oAoDzMshGvP4AJorF
	 XD9xsqDvxxMPptacaXB/YM6AqIFC2A5DFY0XEaKB5FKn6UiqGyAkKnk7+f9na6O7aiS5L
	 bjqhnD7YMaSIHLytdvm6h+6ohxBxp0BaXvS/rE5/BN3P5d68un53PZBFbZtbAIKvM7s9H
	 HlZMh4E4L3h7jQ2nKcxDmC6G9fRbORbwRY8uavoKgvmpKLgQEClJ/Ftcgn6URkBCCtgN8
	 LlHHWMVK8TSUX0+OKfGoPxj5cr3sgZV+LA6xNglR5FUpUtGA3gTc831mTo6JOfgzx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LqYp2jDdq0W9fKFQk9ND3+DSgEsQdJquTqr7hfk12NA=;
	b=2aeOoP/EcQIHTXeRPfHIsJ3dn3/9HJiX0Tf13Eq5gTKjFt6y0RQ/Wfv3Sr4gh5TyxzGw
	 0VHAyQ/nYLlr1Hu9Y388SPd9nSOCrB0WmhE7PRnMLHyi9OMr8j0wXsWBnlUzv3jGJn7g0
	 slRrPEDjNEMK+1XsiDetQwDSjM2HSqnFj9arPjY47dvvDp14Mn81lEoP/ktjfpXPt4DYV
	 sN3cvJwapfxdkfAXzSDfNoCohWLlO46tNsdF1odtpYU1rX/jrl/wVYoa4ynQ/UmVdlMmT
	 vIchfHKc0ZVK5o8z6/iWtfvNx959ISCtH3U2Y0hbif/wq/ONcDnFOoq8Y3Ag9ArspOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dzv+rNNR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82B606A31B
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D82B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dzv+rNNR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1788714f8f.2
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488265; x=1793093065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqYp2jDdq0W9fKFQk9ND3+DSgEsQdJquTqr7hfk12NA=;
        b=Dzv+rNNR5s2tn7bapmQt/IO3zO+UkMSOr6xNrXoYXJKCIPBaEPzR13dUcBLRsIzXjo
         25q1w+ivzxlzS3IdfUSPgbUGfu8WXFTdz8I7ZYIaK/BsFoqkx14CN9rO5Dn242Q3rbEn
         zG8Vu/ibkVgdNprGqCdYE8ppGg3rCE7eiTr0KI7SMAIao9KqwMLikK1QqCijp8tVYEvh
         Wjybe/P41OmVBjImmycIZTThDeNJRUkqvrz3LRmemnBmjZkFlycn+2o5AElc/iXyMzMx
         qUqSsfFLi89ZtJws7krKrOB+0ML4xGbVwYo2E1VWthgANO2IJukpKUZjV9bOmrYqFf4h
         z7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488265; x=1793093065;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LqYp2jDdq0W9fKFQk9ND3+DSgEsQdJquTqr7hfk12NA=;
        b=kuU90uO7LV69PpT+ru4TwZIYLMPIuWCVvVSjUz36lP4KrfPL9qxLR3NFqZQ8kkOoZ4
         dqfNoi/H0r2QA4V5fLuXIZrP+XMK2oyuXMIIWWw4t3YQPj5UTi2dc9cFzzlk7NxMCGOW
         lYbs0WZvL+Lcqg23k77p6Bk1q/xF1h8c28bqvue0PdJoHu5tvWfY/oQpngTwZgkLljnF
         7WFWOlbRWX0VVL6ph22kBej3foHr5FxQl4PRHRhuVIL8yU09iqj7H7Q+1MTzoe5H0+yk
         mOqH/0rn6aX4NeaK4USlLbVnvesS40Ojz3NJdZMeql8va7NzmLYMgMUu2UFBvOfjqACR
         9XBg==
X-Forwarded-Encrypted: i=1; AKwUvBx8aBm8CQPZU1SJB8lh1Mn1VW9q9XApsjmlvDxkmQFXVMoe24xeDt2Cz49+nelyCXF/xAOKARjm4uoJ5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6qvsGsNJWCv0APzMRUShSb0/IVGEBf/hELH6WSQKMJkRdStB2
	Zh9unyvUWD7MnTms5FNLyNKrsWnjjKG02mBvB3YBTtam6VwfpWUwUt/n
X-Gm-Gg: AYBFou1f6vCrlh/RtdKetQTHjx82vMii+Jb4c/d4PnwGdYGtCdBkWK+tv8NoVN62KU0
	YRI7y6gK+X53JIEa5EC/T6OFnCI4Y3upGQIrMSsMyQiDqASHWplLRsNI0qCGziS6Oyb1PDbxAUc
	7VKTsaMrFeyvb1JWJDHSZ6PaoBof++R2rBth53IzzmPDVypcaKBM/ydOHzwrxboThvOZj4Mz+wL
	LebM0pu0N1koG74xD+k8KN4M/DZx+x3N/FUGskFB2M51vLZ1CL7GaS58WZ4QlT15aEK6JzOC025
	vW78L30grIRboDLl0iI7e5+agkl/xR4zj6QJRqjImdw/XWIq+OG2UYyEzNwxxU6ORn3j4srS/PN
	NIkJFhb47lLbv9QMYriesSuY0qswYuYPP5afoxKFY6qpaRia8X3v0Av6CBTPmKIF39ej08gImq7
	h0FghiGq/lE+5gtXqVm+9WRd2itqOS7vVBp2nYX//SgtJLCwuh7MzY2mu5asH0FPEVuDk2hYjjC
	H++nYSRmk2Cj9t7ARw5II6wGXJD1fbF/9O8WC4d0A==
X-Received: by 2002:adf:f9cf:0:b0:486:f42f:6860 with SMTP id ffacd0b85a97d-48e07fa7c39mr12821637f8f.56.1792488264931;
        Tue, 20 Oct 2026 02:24:24 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm5006879f8f.16.2026.10.20.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:24 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Tue, 20 Oct 2026 11:24:10 +0200
Message-ID: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the detachable USB/Bluetooth keyboard of the ASUS
Zenbook Duo line (UX8406MA, UX8406CA, UX8407AA): hotkeys, keyboard
backlight and the platform profile key, over both transports.

This patchset is a collective effort, gathered here:

  https://github.com/NeroReflex/asusctl/issues/25

Tested on a UX8407AA against 7.3, docked and over Bluetooth: hotkeys,
keyboard backlight, Fn+F profile cycling, and the touchpad staying with
hid-multitouch.

Since v1 the series has been reworked with the help of an LLM coding assistant.
It was used to analyse the review comments and the code they point at, to
draft the changes and commit messages that address them. I reviewed every change
and tested each version on my UX8407AA, docked and over Bluetooth.

Changes in v4:
- Rebase onto hid.git#for-7.4/asus, now with Denis's "improve the
  driver support for laptops" series.
- Drop the delayed handshake re-send: Rebecca measured that the
  keyboard stays in hotkey mode without it.
- 1/7: check one quirk per branch and the transport in a nested if,
  initializing rsize_orig and offs so that clang still sees them set;
  use u16 and declare new_rsize at the top of the block (Denis).
- 2/7: shorten the comment and put it next to the mapping (Denis).
- 3/7: shorten the comment (Denis).
- 4/7: only handle usage 0x9d on Zenbook Duo keyboards, and take the
  worker lock with guard() instead of a goto and a label (Denis). The
  IS_REACHABLE() checks stay in C conditionals rather than #if, as
  coding-style.rst asks, so both branches keep being compile-checked.
- 5/7: list the report sizes of other devices in the comment (Denis).
- 6/7: move the entries above the existing HID_GROUP_GENERIC ones, so
  that they do not conflict with the T302CHI dock entry in for-next.
- New 7/7: keep the input device names the keyboard reports instead of
  renaming them to "Asus Keyboard" (Denis).
- Add Denis's Reviewed-by to 3/7, 5/7 and 6/7.
- Drop the Assisted-by tags, following "docs: remove Assisted-by
  references" in linux-next.

Changes in v3 and v2: see the v3 cover letter.

v3: https://lore.kernel.org/r/20261013104033.36079-1-p.pisati@gmail.com
v2: https://lore.kernel.org/r/20261009153459.124752-1-p.pisati@gmail.com
v1: https://lore.kernel.org/r/20260513163248.16483-1-p.pisati@gmail.com

Joshua Leivenzon (4):
  HID: asus: Fix up Zenbook Duo report descriptors
  HID: asus: Add missing Zenbook Duo hotkeys
  HID: asus: Force hid-input to bind to the Zenbook Duo hotkey interface
  HID: asus: Cycle the platform profile from the Zenbook Duo profile key

Luke Jones (1):
  HID: asus: add prod-id, quirk for Zenbook Duo keyboard

Paolo Pisati (2):
  HID: asus: Do not send feature reports larger than declared
  HID: asus: Keep the Zenbook Duo input device names

 drivers/hid/hid-asus.c | 154 ++++++++++++++++++++++++++++++++++++-----
 drivers/hid/hid-ids.h  |   6 ++
 2 files changed, 142 insertions(+), 18 deletions(-)


base-commit: e16927855d822a163099ffb2d6a449913fe9487d
-- 
2.43.0

