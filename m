Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E451E4BE
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783816271; cv=none; b=F50OFGRefAnvkFa1TvXrsuPzsrwwYDbtHKJ0LhcdbJfFYyuRFMoZMeyIBIt+SdRtG0r5Lhi19g3BJWWGrNutlVxq6BUbYeRnuh59CkqRws6NmqkJYNyT6vIIvHOpRAewTTIJgs0iZ3QzHpQjmERf67dJcEB/kNX6JarX3zrSYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783816271; c=relaxed/simple;
	bh=QW/DqtcgTIEuZEcjwOA9Xat6ZosEjDq7fTUvR09jomk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9zerjBvPcHr9HfCwwAnRJZ9xtNDFrFmBvKt1zROHgWTZ2Pj7tCaI5XW41QuEzq27REPY4ZCDR9vMLGVdgeGnVfwQo8Vv1FmZ+wbIwb/cR8GT7sRkB+HQGa6CYNDJRuQQE1XlsabgOuMBzZAzoIJuT04zOHJjQKYyPT91O6oyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AboVJQYX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AboVJQYX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso2947538a12.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783816268; x=1784421068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RupjQbYS7z5J3gjU9n5onpT/UxaPgszo7BvC3f39NP8=;
        b=AboVJQYXKcQUuFAxjdukpTOzk6Lr+IkQvww53YWrKkM+tGpWV0syfXwXzo4/Boodst
         lDGPX71iW2t5t5Rtky+ujhTuXDO36diz6rONpWXgaHai+wxTi719jl4wMHMrB1y0kPFY
         zlhFYdRWhvAZa5aIsJz0cVGBjzGIrDE36mXjU6VJ1t0A3fBFpf9hc728lbdlUdm++8hy
         J0YwUgvoPvzc2FBSZpaPy2kezBDoqch8L3URE2PP3TMO5VONSD66bPB4iNX0LOLsEsUH
         WSmZkQEcKNUtd9RbulgrEHPHLkZqKE9GaDkf5cgjqDkTwI1ZuMzs0x01QOBMUR4gv0fg
         BqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783816268; x=1784421068;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RupjQbYS7z5J3gjU9n5onpT/UxaPgszo7BvC3f39NP8=;
        b=LNSIwp58V8YKTQV5FRJnEIwX/sUqHIuNpNn/k5pxDyXMfRitP6Zkxo3r4kCYoHSNQn
         XSMFerXdvH88sQMEj3XsDbzEbrkSL+Z/Xas6aOSO5uoNd9/E7lpuPipuvS/XeqMftgBn
         JP8s/3qRY6E1XgywpzfmBNodL1C7NTOGZOJrXcr+DXyLG9qBMiwtyXEnSv6ZuuYPUWFT
         zo/mh+CTEJxCMYqZmsQrL0Sn6ZNMSR3zezIlBMFK5MEhtdx9VcWkqRPtbK86X0avA3rL
         GLx7gwS7zEHjGdvYgdocn1x3HfK/Nzqi7VJCNyf0pl3wCBQu2LMJP7EnVkOnWew3Px81
         34LA==
X-Forwarded-Encrypted: i=1; AHgh+RoVW3NnB2XCsjUeHhpxSZGitJMXVVfwPQYzoB++n9047G8lRN3jyOJrMahMcpplRVPsEJR/oJUP+Ry6lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3srudi/RraVRBbSgEvEsj4ajjXBRoXQNTi8xBYgNsSyPbSTGr
	XYUZgDQOPjD5W0wq3m6Zb9FUk4VTvxJl0mYR2sHtfQuc8JkF+9uzqlar
X-Gm-Gg: AfdE7cnQJ4T0ZILQzIsEdqwaVJcgshSGJ3HRfNRZpRBGISjDMHZHyK+I85S0co2Lx1Y
	p+YxzBgMiWwlj16zQ+/9MoocqdlonjcVa0ZygIQsh+MBKqFx/k/dOJ2zRDDhPQWZy+DwptfUU8n
	opL+Q5zIoJQCYUbml35H/ZxttcW9FrpeWMdpRhFqu/Lf0nZ3BHgA8F+52dMg5SgDv7MlXrdgC3W
	YXUoz89/X2KyAg/fNiFam0mb3Jc1XNaKC4T2AUtmTwbc6Z///h1uamgNiESyUzCaHCezbNKeo6f
	yPl4cTKC6ku4pwLYlrOmF0IJ4mZ+UrPd0VS4NoAiL1l8Jm0S2wSrj15OY9qozGBR/51FwgZ7yLm
	+RYf7uqoQOJsqpL7qeO+8TzPZ+lEH3WeRouKXRO1VFmN49R6XFr+owyUQDcvWM7vXyT/EEJfGLY
	+yr8dHYkULoDycKftUyX6ZIQNEMG9C3X+VruRWylL7s14YxVKK+hF7yhg=
X-Received: by 2002:a05:6402:321e:b0:69a:a4bb:bfc0 with SMTP id 4fb4d7f45d1cf-69c5ef9cd47mr2092948a12.11.1783816268177;
        Sat, 11 Jul 2026 17:31:08 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm7512380a12.0.2026.07.11.17.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 17:31:06 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH 0/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Sun, 12 Jul 2026 02:30:50 +0200
Message-ID: <20260712003051.338194-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds Logitech Bolt receiver support for Logitech HID++
devices so Bolt-connected HID++ peripherals can expose battery
information through the kernel power_supply path with the correct device
model.

Tested with:
- Logitech MX Keys for Business via Bolt receiver

Erik Håkansson (1):
  HID: logitech: add Bolt receiver support for Logitech HID++ devices

 drivers/hid/hid-logitech-dj.c    | 10 +++++++
 drivers/hid/hid-logitech-hidpp.c | 47 ++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)


base-commit: 44696aa3a489d2baf58efa61b37833f100072bee
-- 
2.55.0

