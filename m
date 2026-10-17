Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751C1DA57
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245828; cv=none; b=dfAcDUhPCpjzjIWEpS9UiJM+52XBWrjdxk9yEkNdFGh1lLKjOGsHNGO9kz77tvsORGY3l174/6dVv+fmvcv8nuXJd+xrhwMFe6WFXrN/ZdMruGjROnQs8vyPHmgB3Q+bKYLdkRF5n6QybPa+8Oo6KTByTe26QdpasPwxm4/yqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245828; c=relaxed/simple;
	bh=Ipy4jjW6gaWuEzPanC91sb5Z60RjQ5DQx4uG0hnW7AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYl/X8ltcyYP1yXgUZmnbEZlpH/4zG6A1wMYBblfPlBCOw9XGza2KZ9Ns4v0aw21jS3Rz0TT0mG8K7pkLQGFYccF88Rh1wfzZyT+nH4sU+R7z/EXKuRlkmMCPyaevfUAwLCzECk19JBCOyU+4W8gfoe9E2xzv0YIxMRUGlP2vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUWel9es; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUWel9es"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so2053904eec.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245826; x=1792850626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=js+mUJzMMvVUHKyI3sEc56QXGWR7/Maia0gNSzvmDKk=;
        b=jUWel9esvVxhJpIaJ+McShb0DGZzjCF7Cj6cRFFI93uj9cYAxakCI0t5R0xaB9Dh3d
         2m0GmBguYK7GsfQfbp1X4FGhmPsNfd+6K00N7ANr4MLED6ocwExVZVgrTIitugv/Jb1g
         QFBvE9orlx8UTkIE6F4adFPYv6CWh4heyBLqPZQtX30A2PfYB1HHzJ6zskQvlT1H9Ywl
         kH3ZLBIpe1tt0ffOdFv1+2bQnUSG97tgV2cXmnw6rKSeEQC08l5zqY6BvI6zHzzX/sCv
         3VKnnRCh3ry+ZR4bIuTNe7OnEeoMEUoNQTVWZ6HUJqQtwyLpfLcq/DyDjx4sIZXmU8Sl
         iHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245826; x=1792850626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=js+mUJzMMvVUHKyI3sEc56QXGWR7/Maia0gNSzvmDKk=;
        b=R1jwuCyOaCRHPaiSVj8AVHa1oJGR8ESMVPEHRQaprNLrA/bySvfwNjZ5za8gGio/G6
         akbSkY5VnB/nOeTM0VoxmlQlRgixk/LS+Nq8Ktalkcn2V7i+4MJuZik6ydBW4qbC/9Wh
         nYLHgCtmVvJ0fVg6rESP30nai5QtAzWAB1+dsgRY58AA9b2DXSbhoTNGBNCgvlh+I4wN
         tx7qYwR6WiDS34Xx3PBgrRQ0ddJBLH3oXBy6BDAuXSiiyjNTNAmXAvl6AFYaPN6jMkjt
         9SPq6Di3VfX47GVAmDGXFGRaM1hlbQonwIeECjC0uZupLMoaB8NwohwaOAmEUwE7MS9+
         jOWA==
X-Forwarded-Encrypted: i=1; AKwUvByAXAUaECKzqDo1D0oQvcmZqPdmMKSS+Rc8vuHn6UnfrDCzh0fg8Dc2HJMTDKfvnRP9wBthc9MKU0ywFA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdI7tf5N05k+b0m2k+arFoBdEXCul94XjVLBBOP2fiD5ixxrCl
	NJAruZ4XduuzYMkrIY/0Kxe3N0qldg4rST+6QtaqApdCYCHn4zHzDbax
X-Gm-Gg: AYBFou0ybJiVubMbMMzBmC6i2R9VTvnAdSRWzfBB7SdtOyLY7a17FKHaXLV037voEJM
	N0MzcQwy+/i0noh4b6Cy86jm68Nu4W9iyKJGkzWrnEH4h6lzHFeT72HMqvk9mAWrD3YEIzx3ly+
	L5EL+XFI33Q7nukJjAU9jV4ENhiKcVRTVsBkvrm94lFnFeFYe0J2H/jR5rtSSMI/UsCXW/qb0tU
	PzfpHTPF9j8w5B84fvpf/woIeKG6iOZQF84dfvmR5yk9TLC82zvhNptPUl/ObSHYgT73sEiSXsy
	efZmOBdRXrJfXRkGeGStYrlNcw4EGCr5orWfXfI99dik2eILmWAB32AsdWC5bgv3BqBVQGXcq0O
	G8IrH4xmFeuLHEDtGf/ozpRmr3KkWwawV65LAZ1ZVPXIjKTWWO0mFSu83r7TnogVWTyYGXcmJkh
	XBTiRtQxOFM7+UPUOEiGqud1IGRav+HsWEs+53CkviumRQ6PFWpzI7BzoEgH9J
X-Received: by 2002:a05:701a:c90a:b0:151:8280:2c1a with SMTP id a92af1059eb24-18513d85782mr3987345c88.42.1792245825503;
        Sat, 17 Oct 2026 07:03:45 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm12727648c88.14.2026.10.17.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:03:44 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v9 0/2] HID: multitouch: fix haptic lifetime on delayed input release
Date: Sat, 17 Oct 2026 11:03:30 -0300
Message-ID: <20261017140332.1480375-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open evdev fd can keep the input device alive after HID unbind.
The haptic state in ff->private must remain allocated until the input
device is released, and pending work must finish before HID reports
are freed.

Following Dmitry's v7 and v8 review, hid_haptic_init() now clones the
devres-managed mapping state. FF core owns the clone once setup
succeeds and frees it at final input release.

Patch 1 makes input_ff_create() the last fallible initialization step,
uses __module_get(), and drains pending work through ff->stop at input
unregistration. It also removes the extra HID device reference and
propagates haptic setup failures to mt_probe(), including when hidraw
lets hid_connect() succeed after input setup has failed.

Patch 2 allocates the clone in hid_haptic_init() and transfers it with
no_free_ptr(). It keeps one FF instance per HID device because the
touchpad inputs share report fields.

Changes since v8:
  - clone the mapping state in hid_haptic_init() and give FF core
    ownership of the clone
  - remove the devm release action and extra input/HID references
  - use __module_get() after input_ff_create()
  - propagate haptic initialization errors through mt_probe()
  - drain haptic work at input device unregistration

Build checks on x86_64 with GCC 15.2.0 and W=1 passed: the affected
objects with HID built in, a minimal vmlinux and modules build with
HID=m and HID_MULTITOUCH=m, and hid-multitouch.o with HID_HAPTIC=n.
The full build reported kernel-doc warnings in unmodified files.
A QEMU/KVM boot with KASAN ran 10 virtual UHID haptic cycles: upload and
play an effect, destroy the HID device with evdev still open, then close
the fd. FF_HAPTIC was exposed, output reports were observed, and KASAN
reported no errors. Physical hardware was not tested.

Base: 58161ead29e50d70a317ea26b472e0c7508e69da
v8: https://lore.kernel.org/linux-input/20261016173056.3397211-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: make FF creation the last fallible init step
  HID: multitouch: give FF core ownership of haptic state

 drivers/hid/hid-haptic.c     | 62 +++++++++++++++++++-----------------
 drivers/hid/hid-haptic.h     |  6 ++--
 drivers/hid/hid-multitouch.c | 18 +++++++++--
 3 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.53.0

