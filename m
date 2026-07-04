Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE838422F
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144655; cv=none; b=UGNrVsmd0gIU8uK1KcmkI2tZcrV5zAI7L9055SySY1UbpjD69xX7BRgHqRgI5CURQSF7z0pfTAaoV/iRg2gRH1XzDGZl0Ia20PvN+9U5yLgylqiZYXJSr99KbDz8kGWqmC3VOXN8DgISY/u/ju+sjdX5gfv0zARGytKjgXmjEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144655; c=relaxed/simple;
	bh=Ix7/Y+EVEU+dwYPaF05H+bOo4qBH5GMr0TAV7TzgV/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jS7J3SmJGnM8Fwc01CfeWw5CJQiawjTK5YiKqeey6wXglv2kjiTSvWQcFjCLOB+/Ioe99t02JMyi1stR5QDTv1lE4iVcv7NacWZQNIVsfUNNTkBnWH5ale4bOrJxLhXnmgj8rWdLuNX9vrWIbhjnTR5/5c49yBx6yokT93hSlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sirSMUFy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sirSMUFy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso941930a91.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144653; x=1783749453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+rvElI5DJc+LADkj/yI5i5ZTCILlIx+N3s68Xcqphs=;
        b=sirSMUFyc+mPqhNdNVT4usAvQ6eTAPsTEAYqeiUD7wzSPDPvw355bFs2iO7Sb01BA9
         HLRBm6KHqqr9BfI6QXa2OjyTL04RVO1MFskDl1unSH00IyQwH6Jx9BSofL5BrhdYnayw
         vZzvJeuCkdE/w0VZpzt7eDGil1MsY5x5Kao668Tz2kBTrL6xKTSgl0K6o976PfFb8TFq
         TEBp9Jr6Gsu+s7wiIvedTIsJQNQgY6dwvlQq1wdx8Dd3OgrVnic6VLcyryXtRn6s/Qz5
         XnoB+dpbzHqcAWDkViV4qsajYAorobYQUfSc5TPG7KiRHXIqw12j5a8RzNMER9wTqhOY
         m9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144653; x=1783749453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+rvElI5DJc+LADkj/yI5i5ZTCILlIx+N3s68Xcqphs=;
        b=VNDXE7lUn30h9sSuMFHrNRB/KWz0mAasRBY+P2n9GKFwDeuFFk92JC4AZeKPzVw17f
         Vfogw6dpzIuNgQVPygbzDeay9oXmL3kN6nSTKxjhcd1/D89alQLJd+5ndl9Va+w5k1Hv
         WNrSOZRTBV/qTgockRkp1HvC6aiG0F9R+Rge3dKuegCaj7X3xV6z9umsXe3DViPdGjKc
         Ig5gkBjZrp3Qk+C/4+KAKWuVRuX1owfogbKg3AWr3wqVSx2vzDOvVd3pWVgYptRcXfyG
         btgJaH+M0d9DbpK1n13D9jb45SQQAJEpBjZoBHOXkKpDBTTLdsIhciYqLIgo0OmzJYKm
         gPLQ==
X-Forwarded-Encrypted: i=1; AHgh+RomOPNBUxN6p8ZhJnMg26NtH3aPHwlB/EEiH2tQUD6zT5+R/pBOaLgGcmcmmz8R1wG4aXe4k37cMr5X0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlpIAHzHlmma2GOzh3qI6jfcNKxhmfuM6koFCEbxruVxUd1oh
	w5w5da/J8ro7yZY40uGvtH3sj/wzamluzB8Z4H90td9pJtzqXFdi7eOK
X-Gm-Gg: AfdE7clz3Q7kseHY8cyJz0Z6nt8H2RP02p2TxDudXSqadO7ovNadNYwHT8bC2ZRotUy
	RX1/VDKTgtk5/FqmwIZuyNopdcESVK+px/+o+oF8osdBICeNeMi3Y3UWsmMY2DQ+kj2d/uhjO8F
	DEiVKkW4KObXBHZX/R9DFIh4UPIAA21nahccGjH0A/PVK3c9krIUBy4blYgeV5wosCTDGj7iLTi
	dBgKNJQ6TE0tOOG0Sf6liFNfvXqH7OMyNZVM3ubNBKgXGLpAvjM2H/Frdme1YSOplqlz1rruliI
	JoKF3mr/nBiHHvx/GX9rkpuWKfmwpfYeadtdH+XCHpMVjZ1hi/7AN/sGh/mAM6YFnq7+cQD59J+
	FLN3TKK6qjHf4eYPu4KpRz5DsWu/jTHb6Eqo9RQmvkxUu+XtO8Lzt/PiJVdv4FW0dhUrckOXhia
	e8NXokZ9eJuz3zO8cyp+yUoOE2UNqIsjEu4FdySxggLQUHA5YWDZF7kEGQocmEAu8o+sWwMgpsg
	+w=
X-Received: by 2002:a17:90b:17c4:b0:380:40b:f30a with SMTP id 98e67ed59e1d1-38280d99e12mr2630038a91.13.1783144652797;
        Fri, 03 Jul 2026 22:57:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:32 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 00/26] sh: maple: cleanup and modernize input drivers
Date: Fri, 03 Jul 2026 22:57:23 -0700
Message-Id: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSgSGoC/yXMQQrCMBBG4auUWTuQhhKGXqW4SOKvTmljSKwIp
 Xc36vJbvLdTRVFUGrudCl5a9ZEa+lNH8e7TDayXZrLGOuOscBh49XkBxwU+bZlFBifWozcSqGW
 54Krv33I6/123MCM+vx86jg9nwHB4dAAAAA==
X-Change-ID: 20260628-b4-maple-cleanup-884682ae108b
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

This series aims to modernize the Maple bus core and its input drivers
(keyboard, mouse, joystick/controller), addressing build failures, race
conditions, and coding style issues:

- fixes a build failure in vmu-flash.c due to missing include
- fixes keyboard press detection logic (eliminating a 1-poll delay and
  redundant press events)
- corrects D-pad axis limits and optimizes event reporting using
  branchless calculations
- implements open() and close() in maple_keyb so all Maple input drivers
  only poll when actively open
- introduces callback_mutex in the Maple bus core to avoid potential UAF
  when stopping/unbinding the drivers
- removes the unused driver field from struct maple_device (write-only
  since 2008) and eliminates the redundant maple_unsupported_device dummy
  driver
- implements standard bus-level probe() and remove() methods for the
  Maple bus
- converts all three Maple input drivers to use managed resources, and
  fixes style issues reported by checkpatch.

This compiles but has not been tested on real hardware.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (26):
      sh: maple: include linux/device.h in linux/maple.h
      Input: maple_keyb - fix key press detection
      Input: maplecontrol - only enable present axes
      Input: maplemouse - stop polling and clear callback on close
      Input: maplecontrol - stop polling and clear callback on close
      Input: maplecontrol - simplify maple_device retrieval in open/close
      Input: maple_keyb - implement open and close methods
      Input: maplemouse - remove redundant drvdata resetting
      Input: maple_keyb - remove redundant drvdata resetting
      Input: maplecontrol - remove redundant drvdata resetting
      Input: maplemouse - remove unused mdev->driver assignment
      Input: maplecontrol - remove unused mdev->driver assignment
      Input: maple_keyb - remove unused mdev->driver assignment
      mtd: maps: vmu-flash: remove unused mdev->driver assignment
      sh: maple: remove not needed maple_unsupported_device driver
      sh: maple: remove unused driver field from struct maple_device
      sh: maple: implement bus-level probe/remove
      sh: maple: introduce callback_mutex in maple_device
      Input: maple_keyb - remove redundant mutex and remove method
      Input: maple_keyb - convert to devm
      Input: maplemouse - convert to devm
      Input: maplecontrol - convert to devm
      Input: maple_keyb - fix style issues
      Input: maplemouse - fix style issues
      Input: maplecontrol - fix style issues
      Input: maple_keyb - remove redundant 'new' buffer from struct dc_kbd

 drivers/input/joystick/maplecontrol.c |  98 +++++++++------------------
 drivers/input/keyboard/maple_keyb.c   | 124 +++++++++++++---------------------
 drivers/input/mouse/maplemouse.c      |  55 ++++-----------
 drivers/mtd/maps/vmu-flash.c          |  15 ++--
 drivers/sh/maple/maple.c              |  61 ++++++++++-------
 include/linux/maple.h                 |   8 ++-
 6 files changed, 140 insertions(+), 221 deletions(-)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260628-b4-maple-cleanup-884682ae108b

Thanks.

-- 
Dmitry

