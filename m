Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FE42A144
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751430; cv=none; b=pJEEP9CgIqA3tp8k7yYZ08JRMUOxT4UVn7GmIUFQHLNhWEmco1rEXOpz702wRychrZQVl+bF4zTaSLTD2f0r4YYB+KugKh0gDMs0WB8fYCn0yq3wvxphWRUkSrrKMYPCjKXCMK49VvtEP1M/NXWqFYoXsPhb/gdvT5QURQXDizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751430; c=relaxed/simple;
	bh=CkXQ1x3oeJNIdd4cmfTiDTkVVq3FxkjfvK8beYDM/Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKYgY2YhU3X+/9f5owrm/TANuH1wdYTianYL30YtGCFLZsbx/5nxyHXeRLYG/vLrQ31KCijUS/rwtPsWyxF3JHwFXyhS6uLRKiOdHxoUO8f/IqeyjF7m4o/9Oucb0H9/AqfVZoY/qmiS5FudGFtbqNsNwEdZZNQqxaCt/APKeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aORSr+pD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aORSr+pD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efcef23d21so127103446d6.2
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784751428; x=1785356228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wScJxbDCotcHJa1bmVcI7hfVZUFz5dr4Ecmyh/0A6DA=;
        b=aORSr+pDk+XGuZWUR+nUl2NfgoHLTOA7kF2OqbpX1hl2iyIulobF+kVi9cR/Vqxx0B
         igJ+SH+1TTtj+DnemZB38ZbvqaX4AxtLQ4BK95mHkSnuTZxoo6G7Y4ZdZJJe/xjfYrFx
         k8sZ1u9KX3RQWHTIosJTk1F7+WHMRzOoz3hAvH/7J/fVysx0NZzqJcv8ovkpbXic/zb3
         /aOGyiuNDDlIOtdZ31clGXmL2uhQyVGYAZlGXc5NGZRYQJDbrfoNL7wVPJP/a6e0j0qQ
         1q2gRkCtUAvzrztFD2rOXHOelJow64KQgxaPhuR6V/BT7peiemm0rkIHaE2KJRrKfuce
         ylIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751428; x=1785356228;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wScJxbDCotcHJa1bmVcI7hfVZUFz5dr4Ecmyh/0A6DA=;
        b=aOyfrM7b0Jin6meWnhvWjfvqKl9P2Z0tleqSdTwowH6pW6GDl8BboSbFYvpR2qQhPn
         uCzM1ITJ9qYSAonAJSXHPwy+kk5CSJ0iQQN9Rm5qzE0WDfch/qVFqghddAhV95/Het7j
         42V0adIn82/x2WDajreBmN+PR3YB4g1yB571qbxMEj5ALrAuXffDwMFt8aEyJb2WFbn4
         040EllDUv7NXTTUpgKnnqLJKHnBUSb4M5dB08OaDViHwr2pMGkzvmmwBGslzaWgot0Aa
         htZr3O8Rup0ZcoWOLl+b+jIurbq382Syhqp1/UmXUfqp+i0damOPZow/rZSTSui02vIi
         1U/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq5nfNm/CEjO/YiT6gULEsxQnWIGAhYLOZHxr+CFvL4lLsgnb1PH2dQBdnh92eGnar2dDRq076X5dSAEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcDp5DIHNDvBf3e/jTKbx+2zemqplAyVbDbLJ3lXjZG6XrFqq
	pd6NWSDYaiMLek5xpp6xiO7IRvpW9SZ/cAsXx1NMKbNL46hN/eeEGqpm
X-Gm-Gg: AR+sD12wfKBMfJmfTHM1aNU361c2ZfHXqfUjhxd9N9nX626voLrWGuo2L97A2XeP8Xg
	5XEH/Y367NgnBuBQqfu4z6/TDgbThu8D7tkWRV+X/pj6jQ4+gw+I1/76LK2HrBSwfwPjiFlR4MH
	GpIn+wEElhujn7dFsR8m1v6qGwbIK4TXtHL2ezJSivKpGNAtXkJVonTPyk4W8QLZA9i8fMwz9Tz
	yegrapK0aDaCwqY//h7J7QbWpBBEz66wTpPnNh+HkQg5RBqfx/SqMmxuvRrPu8M2X4CEuUncFRL
	p1RxNSioOZ5sb7Y532wLQdGE7eH7L7bmGPijtc64DZrVqHeSxvBC3BXEl5gsHWjC2RDfI+O0iDS
	x1Y9mQjAp3cVwDsBH2Zk33a7ba/J1UYhHERy4b7gddnzsQX/oSFBOeOvCeJmzc2t3U3DQ3OdY/y
	P2m5dRz7xVHw==
X-Received: by 2002:a05:6214:e4e:b0:906:7fea:354 with SMTP id 6a1803df08f44-907ca588f91mr4383106d6.18.1784751427708;
        Wed, 22 Jul 2026 13:17:07 -0700 (PDT)
Received: from fedora ([2600:383:440:3e74:66f4:dee9:6d5b:1526])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b7494sm28767506d6.8.2026.07.22.13.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:17:06 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	W_Armin@gmx.de,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v14 0/2] Lenovo Yoga Book 9 keyboard dock detection
Date: Wed, 22 Jul 2026 16:16:57 -0400
Message-ID: <20260722201659.874469-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v14 (addressing Ilpo Järvinen's v13 review of patch 2/2):

  - Restore #include <linux/compiler_attributes.h> and <linux/spinlock.h>,
    which were accidentally absent from v13.
  - Restore spinlock_t lock in struct yb9_kbdock_data, spin_lock_init(),
    and spin_lock/spin_unlock around input_report_switch + input_sync
    in yb9_kbdock_report().
  - Restore pointer-out yb9_kbdock_query(d, u32 *bkbd) and removal of
    zero-initializer from struct wmi_buffer out.
  - Restore int return from yb9_kbdock_sync() and error propagation in
    yb9_kbdock_resume() and yb9_kbdock_block_probe().

Changes in v13:

  - Resend of v12: v12 was corrupted in transit.  Root cause: the ABI
    documentation uses RST table separator lines (==  ====...) which
    contain '=' characters; git-send-email selected quoted-printable
    transfer encoding due to non-ASCII in the changelog (UTF-8 author
    name), encoding '=' as '=3D' and breaking git-am on the receiving
    end.  Fixed by setting sendemail.transferEncoding=8bit.  No content
    changes from v12.

Changes in v12 (addressing Ilpo Järvinen's v11 review of patch 2/2):

  - Add #include <linux/sysfs.h> (for sysfs_emit)
  - Add #include <linux/types.h> (for __le32 and __packed)

Changes in v11 (addressing Armin Wolf's v10 review of patch 2/2):

  - ABI doc: correct Date to "June 2027" and KernelVersion to "7.3";
    these fields should reflect when the ABI lands in the kernel, not
    the submission date.

Patch 1/2 (lenovo-ymc) is unchanged from v10.

Changes in v10 (addressing Armin Wolf's v9 review of patch 2/2):

  - Update ABI doc: Date: June 2026, KernelVersion: 6.16
  - Add #include <linux/compiler_attributes.h> and <linux/types.h>
  - yb9_kbdock_query(): change return to pointer-out u32 *bkbd to avoid
    a 0xFFFFFFFF status value being misread as -EPERM
  - struct yb9_kbdock_data: add spinlock_t lock
  - yb9_kbdock_report(): hold lock across input_report_switch + input_sync
  - yb9_kbdock_sync(): return int, propagate query error to callers
  - yb9_kbdock_resume(), yb9_kbdock_block_probe(): propagate sync error
  - struct wmi_buffer out: remove zero-initializer (not needed)
  - yb9_kbdock_notify_new(): drop manual length check; use
    .min_event_size = sizeof(__le32) in struct wmi_driver instead

Patch 1/2 (lenovo-ymc) is unchanged from v9.

Dave Carey (2):
  platform/x86/lenovo: lenovo-ymc: Suppress probe on Yoga Book 9 14IAH10
  platform/x86/lenovo: Add Yoga Book 9 keyboard dock detection driver

 Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock |  19 ++
 MAINTAINERS                                               |   7 +
 drivers/platform/x86/lenovo/Kconfig                       |  14 +
 drivers/platform/x86/lenovo/Makefile                      |   1 +
 drivers/platform/x86/lenovo/yb9-kbdock.c                  | 324 ++++++++++++
 drivers/platform/x86/lenovo/ymc.c                         |  19 ++
 6 files changed, 384 insertions(+)

2.55.0
