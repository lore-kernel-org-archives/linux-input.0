Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6173F39DB
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091837; cv=none; b=F+ly1DIbhvstzX6k6RhkvRndfkYWUCKLryNDn0ra/+9EWPa34ChMj9YHzCsMgM9l3fYMrblgW+pziI/7r5O3McVrXGhqxMAuGNH8Q2hU10eUN03iJRL4eHCs6UXRlC8SF5te0yvFwGCObflIOmVOx0RKkJizif6rFJJwLkmvn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091837; c=relaxed/simple;
	bh=K1OY5zdM6OEN9fIZJQfz8FC5tyVYrDLdL1WqwSsIcPc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b1su68AEkGcCTmjhYCHoupFzLjYuFe0NQIUefB+T07APXAagHwtQs3gznmy/Wu/mXYYGAEY78LJMIU2gDtaIVN7kWxmm0E1Cqq9IJ64n5FgRIlXXNBCyIob1GbXaxuEKW6brNYf1a/hhvSeWG2uTvRENv84s8frcOMSRW3o0njE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I48RFdLO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I48RFdLO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c556ada3so106975e9.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091835; x=1783696635; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pl3+RrSlv3/F/20nNGvlpUqYwKsTuCaqWMZ1BmqCvGY=;
        b=I48RFdLOIMYR1ZCZmqRreuOguQ5SpCktwOkRUKWwlDwTTwBQyaH9BrINnM+JRhW8vq
         F8rA7aZvWvdOk+2HvLwBV5LYlby5fZMeZp2c12lmHO20wJtWUdOfb9KHsRDkzzfTkGZx
         MsfsovrMJ6tgKRRl6YCC+gqwyziLQw70y/lxjqM9eeIvt5+qvTE89AH7pJG7KasGVMvs
         /Jpu6IlKbwzThVvXXqGWUHmTXDYTmVcIRumvHy9YFUsmOsI07B6wwXScHbNwly+JIYCM
         HGja5b/8QYme8kIhBnAalQqGR/10BAZ3103SrBDJFrTsUjU/nRgUnuV6pub6yoWayiJY
         5pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091835; x=1783696635;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pl3+RrSlv3/F/20nNGvlpUqYwKsTuCaqWMZ1BmqCvGY=;
        b=TFyL6WqiTZIY5WQCvDCWl7uELUfYJ13P2Wo9QBiCJ1y93w46qiTcca9SgAubQrt1ky
         lOHGFQRysmUzEh4awhMM5aYReFV8Gy4Kr5Dnj9kcU6voYhvfmywDalG0tsa2uT/DzVh9
         3HYbBzcHSJgLfpY8ZI6LT5uZkZVwWwnG9nqsPwVqVDZ5+lUys+6ADCHzz3LcUN5Dk1Ja
         VJ1/e5kSGcPgKOR+C+bWi+MtuYwLbPHubiEGoewcO8yIB+oB2eaEknjC/yI/4+fAAejO
         gqC3fGwS+iMy2Q21T+O1sNY9RR4hPq1vX73K48o9+cB1JBc7J2vwF96Hm0k9J+IE2+vj
         XEoA==
X-Forwarded-Encrypted: i=1; AFNElJ+eRFbRwOYOnIQneEZkBumYrClwwkr3Nqdq0Ufm/FBnFfzjfYIy6R1migQwjPjEfvNLBgvby3xzFKqAFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfIrdlP+rAghV8BZvgGoaC6ghnnHcy2q1uK+8tEoZQPFVHGtB
	i6yjvb3vkOjhPM1ejuSwiMJw0shHXX7QibwesiOB+a1hiVFwwJPwfiF105mBb4BQiQ==
X-Gm-Gg: AfdE7ckCOYYAyarlD/NRWy+QVq4MbHJVHCULWEwG7UjXiX8EYna2vdZ1bH8Osanfb0K
	GHbFNL9WNWvE2SACg6MGQSt51mcqeAmhSROiRzAHWPokIu/CJzGRscX5ujXrRvO3+P0DHL6gIqj
	3yePzr8Tls/etwAdczJ6z0jVFgASuecsHieO0LDHb9tlA+F388gRZCwCMUyj2byBJmz6J0hbheI
	jvdbSLno0OTuapGM09DZ46BOzU/jTx8NOcDc+5cvaGYDMugC7WuA4KBPSGh1NO49qHJbdUQWDrU
	lyYwnK7gUN4JPM+UNoaw15W7fSlP2XH+njEo9lsKZD+XndGdUAsMvH+0dUPLS+i7jJOGzT03A1X
	K+29786oGsliO4NkLBXhRRrcnf4AP/ccWNVc5RMj4Ad0IpnDYi8TR1T+a8qrRcNs4R5cobIfngG
	zwtJsmFM3kuSLMEO+uVs+sY08UwNwKKqwZX2eO5WCTRsmaak/i4xdrZMxtICHgbVwHnIiNNFk=
X-Received: by 2002:a05:600d:6446:20b0:493:b279:6012 with SMTP id 5b1f17b1804b1-493d0fe58b1mr23715e9.0.1783091834470;
        Fri, 03 Jul 2026 08:17:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bf11eba5sm143481595e9.0.2026.07.03.08.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:13 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/3] hid: fix missing hid_is_usb() checks in three drivers
Date: Fri, 03 Jul 2026 17:16:46 +0200
Message-Id: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7SR2oC/yXMQQ5AMBBA0avIrDVpiQpXEQvG0CFBOohE3F2xf
 Iv/LxDyTAJldIGng4WXOcDEEaBr5oEUd8GQ6MTqXKfKcad2adERTqowNiWLvdUmg5Csnno+v11
 V/5a9HQm39wH3/QAQFqI6cAAAAA==
X-Change-ID: 20260703-hid-usbcheck-9163e6cf6015
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=760;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=K1OY5zdM6OEN9fIZJQfz8FC5tyVYrDLdL1WqwSsIcPc=;
 b=ZTFnHOYKP6v4nUghkdCwMVQ+kEASuNa8un//sNMk8aGmBQuJKy66d8zuStKDBo3Nkck68FfGH
 qKJi5WuMhoBDWoa53oFhUgTyhtynCPW3Y4pTJLJ1eLeS8UE8/KfKth/
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This fixes missing hid_is_usb() checks before to_usb_interface() in
three HID drivers.
I've split it into three patches so that they can have separate "Fixes"
tags, hopefully they are easier to stable-backport this way.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (3):
      HID: asus: fix missing hid_is_usb() check
      HID: huawei: fix missing hid_is_usb() check
      HID: rapoo: fix missing hid_is_usb() check

 drivers/hid/hid-asus.c   | 2 +-
 drivers/hid/hid-huawei.c | 5 +++--
 drivers/hid/hid-rapoo.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260703-hid-usbcheck-9163e6cf6015

Best regards,
--  
Jann Horn <jannh@google.com>

