Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0298383C7F
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714090; cv=none; b=Ur/4pduuE3sAflkUK6lRMIsIvQZPF4y6+O7ACm2iHCPX1KZXPYZzya+nztZKse/Gy4QUkHL2CFudOmodm7IJkugeh4xp6BzZrgVmOUidG2ITKiIJnm/Qgy2uKR7YU7KbMMDYfkalSfH8MD1toZ0WyhCicpsiS3b/XHTrEaP0Rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714090; c=relaxed/simple;
	bh=K6PKd4H2GUDjEMG535NEhISnX1SdVID4QkqXKWAf4Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WeDZPu7jf3EOqCDHGuvw8MTkUyBfmaOsrRUdz4PyBwEjFdzj1QWnzgDsPPrYsVaUFWarbxB5n4pw5eIUsq5QX/bShWuPqzq+t8/rJaTs3vo3KSueo0rMqlf+qlh3Ksfw1rAa3QvujIjkT+K3TCAaAcUkWt4CROLvO9BFpDWGvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cueGf/yS; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cueGf/yS"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-134ac81c445so1408176c88.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714088; x=1779318888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7boWG2DePp4L/Rr95VCxMXwtbh9aReFy99QRlnNGMs=;
        b=cueGf/yS+IsQSvuUPfCcE2cybvmdviF14UAzW8Zi74zEM6tS7gWqnGX1ez7bczkkLn
         18uLVvgOFk6hsFVAjulmr7QGq8CCqorcQ0jSchsVc2DI1Ff6bk/ETzvtrpw/ub9ZLC3h
         vPdp6l1gYlL4UC3y2w+1tfKt0V5U4w/+83Ky1V+xtst0qe8G88tFMUqZ/TTa+9IuzGcE
         MHqPJ0VneD3xcACMYZOj97n5QGNQfYYYvfgerzXslt2nz/ezgTXX2udy9pD3ae2mshTA
         mIz/9R4vlFM8rH1CTy830CvzZIsUVfiMB4ThrMw6rs//ibm1gO+IX1FpGbV3zPEnZaTE
         AVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714088; x=1779318888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7boWG2DePp4L/Rr95VCxMXwtbh9aReFy99QRlnNGMs=;
        b=e6J9tfeIYmW6cwNms8n/WIA1v2QJwL3mlrqx/Mbfts+uzqduw+JKgJpBXUCFSfbRVO
         sm8QdVQ+qk8NGLYjq4DLzid0B8vM5Oyzu+D+K1ZNcd7Tt0qsBS6mQu6KU82SnfbQQ066
         mWvwSJkleh2MBwi4WFPTPUS7nO9tntnpO8+JBaGhU6NdZ+D/idJeYMt+/KvBINcQ+ho2
         74ge2I2oZXTySqYEVkW/E9GqHZlKjC3HllccAYV2y/N2Ki5m6risbot7vT5f1wdTROrA
         gKRnP9+imF1md5CbMGsmTK8x2g65swXi+rSpa2BJJN8h6a+ewRC2CzJWVv3zBWl18j8V
         GUeg==
X-Forwarded-Encrypted: i=1; AFNElJ8rDE6vtMGzRzqfudvXkYVJIf4mU4eQWZWiAXs/oAlcq+CzlOUG5VHO4eRTY7myCRKHZhpAK8jJwg0rMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqm9hdDD7yoCQpStq4BzaPQJV6LkSSiKx/jqwzZc5X5xpwAQu3
	xXmg98sdN80cn+dmjqsEPFJ1XuPQ8B+OA1IQHNptcw1TiMjsx0zcjCNIj2jgsw==
X-Gm-Gg: Acq92OHJrn02Yx33/jQmzrPMXLGWRLvO6Aw5rQMS/krW2ouUOmClLsPLDpBxXRjHWjW
	USSVxkVpg8vIQfAjvTTDiu/rBMGfKWN1lNkBWDqiAuLOZMhIHqUm614uWPdQoQ3P3N2lbHDpD5l
	E7m0Dj0baRH3BODsMpfRPzA8cBD8dF4OSVCG91ZbX59sc1EhPYAkP4Dd6sYWiVrQbxtwCNbwz2E
	oLsg6ff+ZH1jPooXkRNykRAyZxqJfmkLhzbj4WkSU3YiQiMGK7JnEUT0BoI2m+4bAmTilxExPVv
	kJeNX6Z++WhV7dqKkxIngfa6ZhqHd1tUVmoNvCJa+rDdhQN+fZOJ+Ur09uJOuVvhQz5SiHQoqQg
	hnSUT6F9OuVwIYTqOy71RQfK/Zw1DeMosS0PiPF3tX6sP0thcw5ZmmwU5Vhi6n0i3VWFC6HH7EW
	NuXgZcErvkSiVzF9TJ+WX5BEHAcZJIQkMBWw93wsxGR7piedNrLMGdh6iifwDCy31x3rbe6jTRj
	vbN
X-Received: by 2002:a05:7022:ec8c:b0:12d:ea4f:99de with SMTP id a92af1059eb24-13428b94b05mr3497543c88.0.1778714087958;
        Wed, 13 May 2026 16:14:47 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm1379258c88.10.2026.05.13.16.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:14:47 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add MSI Claw HID Configuration Driver
Date: Wed, 13 May 2026 23:14:41 +0000
Message-ID: <20260513231445.3213501-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an HID Configuration driver for the MSI Claw line of
Handheld Gaming PC's. The MSI Claw HID interface provides multiple
features, such as the ability to switch between xinput, dinput, and a
desktop mode, RGB control, rumble intensity, and mapping of the rear "M"
keys. There are additional gamepad modes that are not included in this
driver as they appear to be used in assembly line testing or are
incomplete in the firmware. During my testing I found them to be unstable.

The initial version of this driver was written by Denis Benato, which
contained the initial reverse-engineering and implementation for the
gamepad mode switching. This work was later expanded by Zhouwang Huang
to include more gamepad modes and additional features. Finally, I
refactored the entire driver, fixed multiple bugs, and refined the overall
format to conform to kernel driver best practices and style guide.

Claude was used initially by Zhouwang Huang to quickly parse HID captures
during the reverse-engineering of some of the features. Since Claude had
already been used, as a test of its capabilities I had it implement the
rumble intensity attribute after I had already rewritten most of the
driver, which I then manually edited to fix some mistakes. I also used
Claude to review the driver and these patches for any mistakes and bugs.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v2:
  - Use mutexes to guard SYNC_TO_ROM calls and pending_profile calls.
  - Rename driver to hid-msi and add generic entrypoints for
    probe/resume/remove that call claw specific functions in order to
    future proof the driver for other MSI HID interfaces.
  - Fix various bugs and formatting issues.

Derek J. Clark (4):
  HID: hid-msi: Add MSI Claw configuration driver
  HID: hid-msi: Add M-key mapping attributes
  HID: hid-msi: Add RGB control interface
  HID: hid-msi: Add Rumble Intensity Attributes

 MAINTAINERS           |    6 +
 drivers/hid/Kconfig   |   12 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    6 +
 drivers/hid/hid-msi.c | 1663 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1688 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

