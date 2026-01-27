Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F229342500
	for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510419; cv=none; b=XbYJKAVulp4fymR9JXAP8zovd4/dQpBYdZcJiGUkKe/W7jmiIvZ2CELC+usBUyq1dVXe3QWGmiL/VqycJ2xAO8E+vja63NsaH6bEPd7Knw3TgYEHEf6nIkSJnANXHHcTy6Q9UDBBWOE3zcrq3ylSHudAX42JAVvycWcG5gIzYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510419; c=relaxed/simple;
	bh=P9g5e/OuAoGiuTqQFV/COqX22+aRYbcTZ9ZxgA8VVto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sfsh5kucXB5tQFpLI8CCKn2/yFJX37LwnO4iselEpe389dBrCyovULeEoNR+XIVC6bPwVXKwR9cQOwflNvwlJ2DA1UbNSwxzipqEP6PNRzp0k1Txx6S3oGVi1NKgR8hwKSlKGtyuewjFZJCT/OsngXmlCSEJmB8Ko/vC36gINag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts8K3hqd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts8K3hqd"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso4736236b3a.2
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510416; x=1770115216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4iJWQpRhO1oWXfwOzDLew+HQSAfx5T/zlqt/osxBI4=;
        b=Ts8K3hqdaYDGgU15AFQgKXg79ULuhVhMMThlWVDPc5ft6vGrr7WzTDQ0EbXAvCdgJw
         8h8XrFU9009WSns9Wuv68eX6YOpuhe4JoFqgWQKzJEwW8HFsv2IJ/xd+0x8y+T/mq2yW
         ZLBN2IOYF0zwHe9J3frrItf2ybOT7otk9Qq/dKDYerWo/c8sJ/44mbdnWObPAGu/1444
         g5t/CfvJ2KTF93vDWmUrvbAWZ7YxeOAcy1mt2YEttROsr9IBYRF5+Bx3T/YPb1ICUoh3
         OFzG0zHTU485PQGxKOArQ8EfQ0BqCZhjpp1/s6hrL+4w6pMy9prBMefbt0SA2tpXzyvU
         G6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510416; x=1770115216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4iJWQpRhO1oWXfwOzDLew+HQSAfx5T/zlqt/osxBI4=;
        b=h9QDdWp2BQZZwZikz0E4mZVjiZ4fdf6KPVGnYf2Lh8HCu4j040pH2+EClMhf+KPGyw
         5/i/Eo6y3VQHwZQU9oYQXCt4RfC0Wo6CyyVPgkgBGQfRq3z8ppDpAWDEMeY7lbpzvvbz
         KcvOqy9DdaQxQWqBs4APc+SVTz8EtXt+o5jH5lKKpPlx43c0EP3lASMjvvkF9ubd/m5w
         j9suV9E9gmDfkyOsTL4CA8sQu5VetXOx05nghquA3Y3aVuB9l2lSzaM7ivKpljMIsciQ
         n3TNe295Uz1NbGY6iZ1MgnhkVK61a/PWF+bpQ1fHnwdOiEe2BYl8Ns2hgGxGmobLbvcP
         pnEw==
X-Gm-Message-State: AOJu0Yz4pkzeS6wIzZA6Og3JZmwDOEKUOBFREFRT38ywN+4XDlkvrqFB
	ojBxzxSLmdj1qVqmjzJivlsJwQ3a7bUrZvqgscjj2pJSz9ZWrm4N/zPu
X-Gm-Gg: AZuq6aKc9Ur/jHUKn1z/1kdabsWqJaHV2JbMRh3AWBsb9Vg28saDdHaVXvlyNKOlh4y
	WQ/LAzUjjQx7SvmLJjEDBKLHdlIyuz3D+8VAixfKRZEoO0vWV5UamUmUnRihbSrYMgiVyAEPYVr
	7ndT9V5Cpq9S7/RCIcuTdJBdP0uPdau5hJwlk2Ce36v41SnBJtRuYS+K+Napekv/ekNJphtIGUw
	lWqwNKDjNnkaXpbuSqk040hmWAzGtid0byR9Hh0J//3YagSELcDySe8VGo3g3lNpPZf5++nP924
	QlQ+D4e4ChOzCabfWtDd4Pend3pyWJWnwx4G+glvIRQBbZck1uT6SJxJyURX7eyutfOxkZOsK+V
	lWsU7QBR3NgssczIMXk0W1+aysoa0qdbhrMQt6XPSnZ04TlntoDRkXTSiWKwid3vRFrz4nsUNIU
	881fVIXIvrZvieKf6O2ZbpcpkAHaJUqs4lWdK+9Q==
X-Received: by 2002:a05:6a00:1f0f:b0:81f:4dc7:d39 with SMTP id d2e1a72fcca58-823692a3787mr1400668b3a.45.1769510416317;
        Tue, 27 Jan 2026 02:40:16 -0800 (PST)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:38fe:3edc:7f99:7e99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82339095c85sm7218907b3a.67.2026.01.27.02.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:40:15 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: mpearson-lenovo@squebb.ca,
	dmitry.torokhov@gmail.com,
	hmh@hmh.eng.br,
	hansg@kernel.org,
	corbet@lwn.net,
	derekjohn.clark@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v6 0/3] TrackPoint doubletap enablement and user control
Date: Tue, 27 Jan 2026 19:39:04 +0900
Message-ID: <20260127103907.20269-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for TrackPoint doubletap with a clear and
simple separation of responsibilities between drivers:

1. Firmware enablement (trackpoint.c):
   Automatically enables doubletap on capable hardware during device
   detection.

2. User control (thinkpad_acpi.c):
   Provides a sysfs interface to enable or disable delivery of doubletap
   events to userspace.

The approach follows the KISS principle:
- The TrackPoint driver enables hardware functionality by default.
- The thinkpad_acpi driver controls whether ACPI doubletap events are
  delivered, using existing hotkey filtering infrastructure.
- No cross-driver APIs or dual filtering paths are introduced.

Changes in v6:
- Documentation: fix formatting of the doubletap_enable sysfs attribute
  description (separate "Values" list)

Changes in v5:
- Rename sysfs attribute from doubletap_filter to doubletap_enable to
  reflect actual behavior.
- Fix inverted logic so events are delivered only when doubletap is
  enabled.
- Suppress ACPI hotkey delivery instead of injecting or filtering input
  events.
- Register the sysfs attribute via hotkey_attributes[] instead of
  device_create_file().
- Drop unnecessary helper wrappers and debug logging.
- Update Documentation to reflect the new naming and semantics.

Changes in v4:
- Complete redesign based on reviewer feedback.
- trackpoint.c: Simplified to only enable doubletap by default.
- trackpoint.c: Removed all sysfs attributes and global variables.
- trackpoint.c: Uses firmware ID detection with deny list.
- thinkpad_acpi.c: Added sysfs interface for kernel-level event control.
- thinkpad_acpi.c: No cross-driver dependencies.
- Documentation: Updated to reflect simplified sysfs approach.

Changes in v3:
- No changes.

Changes in v2:
- Improved commit messages.
- Removed unnecessary comments and debug messages.
- Switched to strstarts() usage.
- Simplified firmware capability detection logic.

This version addresses the remaining review feedback by correcting the
naming and logic inversion, aligning sysfs semantics with behavior, and
fully integrating with existing thinkpad_acpi hotkey handling.

Vishnu Sankar (3):
  input: trackpoint - Enable doubletap by default on capable devices
  platform/x86: thinkpad_acpi: Add sysfs control for TrackPoint
    double-tap
  Documentation: thinkpad-acpi - Document doubletap_enable attribute

 .../admin-guide/laptops/thinkpad-acpi.rst     | 21 +++++++++
 drivers/input/mouse/trackpoint.c              | 47 +++++++++++++++++++
 drivers/input/mouse/trackpoint.h              |  5 ++
 drivers/platform/x86/lenovo/thinkpad_acpi.c   | 42 ++++++++++++++---
 4 files changed, 108 insertions(+), 7 deletions(-)

-- 
2.51.0

