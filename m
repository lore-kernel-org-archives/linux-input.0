Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0C35674D
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730441; cv=none; b=sqo3nVJrjBj+rcXahH9dypbMM9USJ33J1dYqgZNX+ikkLEVyxkmKOrExUrCZsRsfnYe6gb36DgKJmdysY4Y2QscoduT3XFaKMb5qHxXgcOyR0yZlL9tiv8tetMTQZ8MZPNAc9AaYkEFitTxuACNegsKutuU8xATbl+gtrCIfx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730441; c=relaxed/simple;
	bh=uHv6Z8xOfCFeIc5aKMjsqa4BpxvESOYAG3MEgkL1tyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZY0Q2NRfL5onXVjqjeEnpvqcys7VofOQ3d4DcgnM2oF7ZwQtRgEWVPHQyKkuG1jTUQQP4uJtIXjllqrdeODc4hkuc5Yo4JIIhUQsy6fvaU2CoLb7Fu4TqS+Eo5WAFBj9p1tyser116k4wK80wzRsFIfpX2H1uv0qvcQHJ40mVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBG0Gxmb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBG0Gxmb"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c149c5722so77329461cf.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784730439; x=1785335239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ib4XZylJ9w9egs25zIiG4greQjW32kkCzwW9LOhfZIw=;
        b=HBG0GxmbX/GL9YsziAPfbPHH2CeVMcxVjoLv/mFNWVzz6FVXjuphtb4Lpecv8tazrO
         hUx0JxeKKzKr/O92O9pQmyN2k6Ih8r272aWHq2/eRFxaJo6FeK0QVBx+Wso7bJnnvbx2
         RPb69ir03sETbGaQWjyUtAGz+J5RSac8bKHek8sUcJyeP8jmZ3w9CYLuw6GveZEGOP5e
         lPvmPUf9vJV7YjCln0bptJvlHSNR0LNvs4ww6DUj7OPPAmkQZNl6ksyp5Xp2tarqnZUV
         w5iyrFKNh9icH5nE1RZLQ1fkeLPhODivcdM3QoZl5LNKRDvvPq+fczHVGB3PgM9Jrwwe
         Egmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730439; x=1785335239;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ib4XZylJ9w9egs25zIiG4greQjW32kkCzwW9LOhfZIw=;
        b=kuMp3mKM4cu+hTnfBOCSO5OKyHpUy1+dcsxYkBtiy8JOruqgqJwckEmqXekKBVxKLh
         RGWzx1g6VyuBEBKMM9G2Xb7xEQfuN68bmD/gLBVhhP3ngI2CniqkFjP00MTB9LK2xRFl
         apDxPF6a4SPghOlekH4/AbFwbgBH9lsqyXgG0uaj9Q8Fez07gz/iYS5de+2ygo6r5kaE
         XTup6aXA2hFyeXwlIcODtiUabXMI/Xw/Vvb9pyAg544GFl5ue7uk9BRkGl2TSOtPqJQP
         jJORwNeZ5Msttp5XTqqT3xQ1s+hX0sFq1puTbSSYCiu4RxX8Nfk7vaqqIcWlN7nkgxBp
         OVTg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9/btUaZTdup4YzKcRW/URh8NBY8P87DmQmdOG/sKbdmj0pNudXv9vzZz4U0pGitvBLYF6A7e8+9tW1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvyani0ydgvr33TM0OlFBrkb7n1s/paKw2RHBscUOpPLN/dsd
	fJhqUkkTRR6T1oFBrgu877DyPOdBapiOl4AxaclaB2Q1yDblD1Gj8axp
X-Gm-Gg: AR+sD10p5a1w157rQq2Lgf9iU9Jm4QnhLBWWeJgsfoOJYJGHoisqAsc2M0/D6KxI9S1
	WAz2tdg1vSkGQ0KuL7KrX6PoVvsvS15AXDwPiNxeuHz9uRuzcrqQyOMhn670C1huqJPSMvmQbDL
	8G1phcUUmvXQskuCcGNnFXltDLY3Cr0GIPuAY6UL1hcz0s07Dptmm9DjlKdntf22zQfZwza7Fe2
	qcgGSWHZ3YmwqMD0FVaFJoyRO0iC3i6Fon1EjSZ8GiESA/7Q8x1RupjkIjTkNRpSXB4nBL/fFgC
	aHJ94hq8rqQSqBcJF3g+/NVIFkkM4tfNLMdRD7AmLfFEVhKFP6Bf7UFHvG8r5FOYx+0xU6cLsnE
	xg40TXNoigTjSuJUq3E9flv5n0z74cp3lUd9/uPWCjMU0SbW6RojGaLnr12eFCxAfbv4USte+1E
	Y=
X-Received: by 2002:a05:622a:296:b0:51b:9873:e37b with SMTP id d75a77b69052e-527a5d0569bmr43874981cf.9.1784730438837;
        Wed, 22 Jul 2026 07:27:18 -0700 (PDT)
Received: from fedora ([2600:383:441:9b80:8f82:4b87:4a4b:5554])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4fe92sm16224981cf.11.2026.07.22.07.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:27:18 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	W_Armin@gmx.de,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v13 0/2] Lenovo Yoga Book 9 keyboard dock detection
Date: Wed, 22 Jul 2026 10:27:09 -0400
Message-ID: <20260722142712.814597-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 drivers/platform/x86/lenovo/yb9-kbdock.c                  | 312 ++++++++++++
 drivers/platform/x86/lenovo/ymc.c                         |  19 ++
 6 files changed, 372 insertions(+)

2.55.0
