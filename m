Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5C4749D2
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279353; cv=none; b=dgNdBx4jeL9rHJ/ooVWDWog+hOPl4/DlfFJNl8w+r7/jT3Ik2EjT9d/UgtZyOFRpTnrd8DQGStH9SHfmogeAxvyMWEhoQ6Uit6IcdywjVL+PH0ZwhjafLnaHcC7/VVmFlQutXDnRr9JfbCesTXUpG1HcZZxVKzIkgnzTwu1lM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279353; c=relaxed/simple;
	bh=wGG+q4pz1CgVXZkEDLp7XhSIpDfjEXz2RsC6cIFmzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RkHFngCUXuqhBAC8Xf4c3dbDqve4wbb+QASJCzx3JxZ1nOz+7ZJ+HLSa2K0327TdbxD+wySY2+NfNcA4+jQIpoump+MaexEIFKhIUl7xpsNzRh7zG0OE9zuqGqc7Jzd5UyqgK6EOGy6SslmXsFdRJL+UFl7kimLVK3mpENbz4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REGDt0wA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REGDt0wA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2b2c9eccso2766871cf.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279351; x=1785884151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02IMskWChRHwzu27lUSTDGSNx/5Zmv/TbofsfiL2H30=;
        b=REGDt0wAfWwc4cfvVHPyk2mhosy8199oRJZU1R8oOgpWyq4wUjRk68bB5433qVcq9q
         Oe/tujBmlY0vbou++9Ldrl8PhU9Q48maAgWYE5qEiUzR6ivnpyH7JQsMYX4ReYiWzesM
         MmsXr/PORCeTNL574JQwwXMQT0vabJ2vMNnBcYEVZ31roN+0J5/VWerl8q+xz5oTTZw5
         Vdb+HdRQlEZ+2MCPG2dPBfIuuhyi+eHMRyZCLvq2cWLcZ6A8GZdaKeLaul5Q+/Rkra0k
         LP7yKv5MTvE1s7OfSVmgww58zvXGnRXycfYTXGoEzVhsCw9Fh//blIWYpmsHXu2pJgvd
         5kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279351; x=1785884151;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02IMskWChRHwzu27lUSTDGSNx/5Zmv/TbofsfiL2H30=;
        b=azcTBtwSxhOies4qLcZve/cAkBN3QcjcTKl6LE62MmwF7VGTWHklswbIUfj0x1M+SZ
         d7MDuo1tgbv8UpWggaXh7Fl3miuWXD3hlvUUcMz3E59IEcnU1qm42GpE64EvCE4bX1pd
         tB3rAVURyaLocnUXpCD6rFQCQfPoyzzEs+i9mLLFc1jxMRborufbDXNfRc52JPhyAsVM
         DVsupau46y2un5aLpZGoZDLg3tAE2/H1jy7+5lApVuGEkccPyTgojP8D7D4m5WflE5h+
         qsN1O/arKvd2eP5UNZwzwUCrnQTMP+YS9oZ8u7Pue7rgGTiKxUKSfJoAs7izd7DseEGx
         1JhA==
X-Forwarded-Encrypted: i=1; AHgh+Rows39lWBWQp9ukQxG8oI6C+6gTY9MzNI40jTVOTxlrLaqv6Kq8MXqraC162X1NvHfVy+qhv0pK0e59gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLvtcriXaECjG5yr//nOkFvAE/L6RlX+fT4dZ8Jp0TNvdGhHJ
	hMlphWPM9Etb+KwQLtreBAYKINyZPRJhtvGu9GeuAR02bt2tBcpyEuW6
X-Gm-Gg: AR+sD13UL/F2IoT32ihwRi7Kt2cWkUKddSXdhjzjZHzKWdBbys/1b1lFtiyevKyvgqX
	xoC4Do8fg3JAGX+u4cnIXhvDtPUdxP2udzI0sBSktUba0SZRcrlncMr33lrpLMTqYw5YBykaBV9
	9kZh1f61Wm5+6Wzfqs1FlJAp00jLIjusmSpS31sFHET+a7JLDNuvdf02bPk5L2MqF5b7qjZVMJ8
	KNOGnAdJoXkwG7AyIEM824VyV7Ze1yBBW91K/hx58ZbtGwsDG79554BDLdruCxBLJqyd5+kqDZV
	HxQZuhiORBYC/XCm6Mc67A+VZm8999t7UAjSfDmIkuK0x7Trp4vd9o1hMRjE5SEVcxeTNiTSl9O
	p341AqDLlSle3VtLTWrSaW08j+zZVywSgsIdeGhDlV/o2A76j4j6dFQfp5pOcbutxkqREbmngbY
	aTKrtWNxdSS77B8n2AKg1DttImrB/W2A9Qg3oIJjBGxErZpZ6K6IbJbd0KqDaxqLV/IjW7MCza5
	RQO5dxknlMb2S29fqshl6+mM4yG4APhng==
X-Received: by 2002:a05:622a:408e:b0:526:f963:2d0f with SMTP id d75a77b69052e-529d71daedamr43127151cf.53.1785279351294;
        Tue, 28 Jul 2026 15:55:51 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b4f241sm8017991cf.7.2026.07.28.15.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:55:50 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	W_Armin@gmx.de,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v15 0/2] Lenovo Yoga Book 9 keyboard dock detection
Date: Tue, 28 Jul 2026 18:55:42 -0400
Message-ID: <20260728225545.1333610-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v15 (addressing Ilpo Järvinen's v14 review of patch 2/2):

  - yb9_kbdock_notify_new(): restore .min_event_size = sizeof(__le32) in
    struct wmi_driver and remove the manual buffer-length check; the
    .min_event_size field was present in v12/v13 (added in v10) but was
    accidentally dropped in v14.

Patch 1/2 (lenovo-ymc) is unchanged from v10.

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
 drivers/platform/x86/lenovo/yb9-kbdock.c                  | 323 ++++++++++++
 drivers/platform/x86/lenovo/ymc.c                         |  19 ++
 6 files changed, 383 insertions(+)

2.55.0
