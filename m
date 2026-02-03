Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2836165E
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140740; cv=none; b=Bva+AP5J6OsmsxV5bEGzv58MkYZBIEW8cqogCKQ6rbKKPr0NIZQuQmsY4FzrcHAw3FmfQqk6EXN5OYBfsKt4nI2FvUQLIwwE+tq8hCYpC9i0pLTK+bTp/b1teCsBmYSEQrMCP3kU1k7aJMvqWwb42Rn0FZZtdkhFck9K8wLdjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140740; c=relaxed/simple;
	bh=PjBoSCeOo7msz0JVrLJ4aiInFOi4yMYOGU2eGE2fck4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ADAJNSmzhai+8UhvDKr1YPGIzSF45hKJHODdv0pDJALZDEd8li2+E1juQBFdcgRbP3NU6anHYnfEs38th3ddgb1LzxzPOFAFWUGg7WpmnPUqG6ESLyRghP0F6oQJu0OKO5XTeEubN92cXkPXwKDDLH6KGg1zuKb2Bl5cXuwYK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlDk/1O3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlDk/1O3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b6f896689so572295a12.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140736; x=1770745536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikAJlWJoBFJ8Th39EXP2JXSGAXDl5c7mooDaAeF8aeE=;
        b=GlDk/1O3NFhYr41U4i55jc4VCpJp9US1fwCWfbQ9zCjpExYjlWeDmYFwgfEWG22eSz
         3VGU4QCueFXKtFKPSrvs74O59picBLlBNIObb9liPQ8vIcrR2mlwIGf2bhPzyXA+ENXm
         CPWLRFAMXntCJRF1zlSQHJEUSwUtaYbooBAJyjfYYuzWpQagKKuNWFs3xl+brXpJsGc0
         Q39pyk/aRG/uoQik6vCodqvWJVaTZznq/KsFv9JhvCFE92OQqGQ4uXiPKt2N5w49Uunt
         nLnTNCJ5/Z05dbrsvweFHKmCDe3v3FY8Fhgxsshfi+NaVE+u0XM8wJTI2fEGLy5XBMpJ
         NyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140736; x=1770745536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikAJlWJoBFJ8Th39EXP2JXSGAXDl5c7mooDaAeF8aeE=;
        b=QhM+H61k8uN4aBsl4WDA+ee6TeEp9duYgK4qX9+yCq2od9RpDcVGy2cDV94ooH3JnO
         FdmrwhPWoQK7LXFwEJ/QAcrO3EyKkcCGI3ihCkP6kfHpdomS0/0adHGSL6RB9ZjYvTnn
         gc7muAZkfNDLrFHvGm7vLXw1GByCtiRmNVXZhpHcCsjWezoWtPndIt4hL84a4k44UFL8
         LtWtXPEw4YZ9n31tmdbqohE7fP3XMEKv7dbFUWxYv1kqorpfSTkX7XA9LzB7zaxlP4Gx
         Gxj0m9BhZtHc3GpRdS5xO4ZetZYDx614UHcK81n3iw4G0o+VvjXcA4iqONPFr4l95bmM
         HcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX1dsNIEXP0lKVt8pk6b8g5OuyXsho3D4HitG8mpat4iA7nYsF3O+TKi286I/JWIquUG5jAThjNx5AVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5PJhCVE+2sp4l/url+Q63HjZ62AXSSRsXCaMMxjbVDA63CnY
	pq2tx3r7DVWi62vGfyaL1sx8AnMbTxfvW8XazIezU2G8fGVEW+4ZxpN+
X-Gm-Gg: AZuq6aKZkpRyuT9uS3EiOZSavXxkot2jN9ZqS8KaJLEkrp7XFg+YZv8opQBAbmW+lC7
	G9TBC8DxPMO/FGGGA8WPILG0w1ApuTHiq4xgjEqxlb/7jKF/paM9R0wsvipi6TcySa+g3aH6oQK
	E1mhhoWeE7JjSb+aVcaouxmNnvpDH5N0pDWDQbM4LfzZ+0b5ZJy9RX/cex3p6VjbFCUxOU6izbs
	+mL7xvsgyCKJI7Op/3mjCfvVB8ot4xswlZfqyJphjTSIVLxZDO02AME9bbWnaUpy5fbcfhWrlmr
	6nkB9o3716rxVhT3ObbQJ0zYJpW1QTiNKsJdUyKGc+DBx0SYRIDfZrQxKoSnCeY8WJboyRmGvPt
	NpgeytSmVu5n/vPxdWnilzaatwX5MWIpjeFX0DZMfuvel6qPA5UlUdHLxtSNKnxwOK6m3RXAwRE
	7R+Xizn0D3iqdR3ilAP6K41raTgaRY+bT7pKFbINJccy4dIEhanNYCeHWr4kuLRgKb
X-Received: by 2002:a05:6402:1a41:b0:659:3cdb:5c4b with SMTP id 4fb4d7f45d1cf-6594a1ed59fmr127726a12.7.1770140736086;
        Tue, 03 Feb 2026 09:45:36 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef001csm5078866b.44.2026.02.03.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:45:35 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH 0/5] hid-pidff set_condition compatibility fixes
Date: Tue,  3 Feb 2026 18:45:26 +0100
Message-ID: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds a few more quirks to the hid-pidff driver to allow for
greater compatibility with HID PID devices in the wild. Some omit selected
fields based on the permissiveness of the Windows driver/DirectInput.

All the combined quirks allow for Conditional effects playback on affected
devices simply by following DirectInput and skipping missing fields. This brings
force feedback feeling in line with other platforms for affected devices.

Last patch updates MAINTAINERS to officially take ownership of hid-pidff driver.

Tomasz Pakuła (5):
  HID: pidff: Refactor field quirks detection
  HID: pidff: Add MISSING_NEG_COEFFICIENT quirk
  HID: pidff: Add MISSING_NEG_SATURATION quirk
  HID: pidff: Add MISSING_DEADBAND quirk
  HID: Update MAINTAINERS for USB HID PID

 MAINTAINERS                    | 17 +++++-----
 drivers/hid/usbhid/hid-pidff.c | 57 ++++++++++++++++++++++------------
 drivers/hid/usbhid/hid-pidff.h |  9 ++++++
 3 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.52.0

