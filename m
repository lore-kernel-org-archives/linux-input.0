Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9C33F8BC
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515825; cv=none; b=Vc7LkIxqo/wgwFuteOyDeVkdvau18eRMVITS6BzPThV6W7NqTgz8+BgyPfK3CZTWWUpIG+ywRwx1okB3SJYZMJQuSK0+6lhX8gs90toyP6TGznj1X3SBnogFHt5Ss7gWX33P+G5dM/v+szCbm77WXxgP6iMBtC1XBuBl0EkbdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515825; c=relaxed/simple;
	bh=k/mZGNFbYJVGUQLTPBRFxzyhjOSMNfSriHKxNk3JQbE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jtt7wrQli5YiGjeJx0jbvEA64ucIFov78/8Rk6J6s9lhO5+m4Afen1yluFQYMtmIrlV0n+I4WOkcB1sa8f1d2HdtRyXsEADhP68siUkir8ne0g/H+JBW5/ghdktb1F0debm/hmSI1JF9y3iCgCRboOhuH6lkSCWYdA3qifQTTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkREOPF1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkREOPF1"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b7903f3so14507665e9.2
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 07:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771515822; x=1772120622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNR1MuA+Pyvpko/0Fgd9uDMMRmZKO2L4hGIPiJga7R0=;
        b=TkREOPF1f7aK6uaELhccsskPpizIQ+FLcvP9pJtrchXRj6UkdU3bJAExL096AjhxRH
         XYb1Uzmbm0zIO5XHk+7mKU06vAngVASQMBGn8FdNX26WToa2TqMCE9+9dwrzjEeCkGWQ
         AoOZgxKvLOCZh+TmT8PYJSP2Bs4Je7ogWiBQHoUQs1N86WmdFEL9mA/giuOBDUNSk4Bz
         Fa6EpslYG1FHldC+/LWF4ZDylhSpDzPaSz0Plnur2Rme4xRbuirjpl+xNrg6dk0ArGVm
         p83Th3LuqHo3vmFqqtzx7jpa7Y86bJFVS2EDErGeSisTykRctVzduRgEBequ0LUikwEa
         IcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771515822; x=1772120622;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNR1MuA+Pyvpko/0Fgd9uDMMRmZKO2L4hGIPiJga7R0=;
        b=gOi4e0QITMJ6ffV9hR3ANqfrTvJkbXr9fdMknmOqUJfOor17NaiXW0FQCeycOrlptX
         G0amK+kJ7rp0A4Kwiak8EHAU7B7WWOUAHGfrKFG3jHQHFcm9bCQYxrKlUD6ax0/Fh1kv
         nEL1x6ChRbHCzyswDL5lHvjAg73IUIOlFw50GR5YRLi4GIAisOFa0VxZvzHANcRzJWgw
         YDEL4q03MmgyighOWPNcsDMmcvoVw8PNJ90LszqwfY4EjREOwMxbf9iVKasaas/9dgCp
         W6aAoNI0OZGMCSO9gsNiL5FLDX6NxqaZkfe+XttTsnlA6mTpKb8eNKZ7MBBozyGD3EOX
         tFAg==
X-Gm-Message-State: AOJu0YxlFjLtVLINhJVSpfHbwybNMAlxp4R+A3MHus8IIWOqiBekLruu
	YYWfqIaWrOTjvkGQya0du3Kmv4E3I4N+QCWiLaSqP6+jW6lI+oXRwviKJD2TVh8gEINMOnggMhx
	Evm9pFw==
X-Received: from wmhj10.prod.google.com ([2002:a05:600c:300a:b0:480:4a03:7b59])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:310d:b0:47e:e57d:404
 with SMTP id 5b1f17b1804b1-48398b0acdcmr119294285e9.16.1771515821777; Thu, 19
 Feb 2026 07:43:41 -0800 (PST)
Date: Thu, 19 Feb 2026 16:43:34 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260219154338.786625-1-gnoack@google.com>
Subject: [PATCH v2 0/4] HID: Fix some memory leaks in drivers/hid
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

These patches fix a few memory leaks in HID report descriptor fixups.

FWIW, a good ad-hoc way to look for usages of allocation functions in
these is:

  awk '/static.*report_fixup.*/,/^}/ { print FILENAME, $0 }' drivers/hid/hi=
d-*.c \
    | grep -E '(malloc|kzalloc|kcalloc|kmemdup)'

The devm_* variants are safe in this context, because they tie the
allocated memory to the lifetime of the driver.

For transparency, I generated these commits with Gemini-CLI,
starting with this prompt:

    We are working in the Linux kernel. In the HID drivers in
    `drivers/hid/hid-*.c`, the `report_fixup` driver hook is a function
    that gets a byte buffer (with size) as input and that may modify that
    byte buffer, and optionally return a pointer to a new byte buffer and
    update the size.  The returned value is *not* memory-managed by the
    caller though and will not be freed subsequently.  When the
    `report_fixup` implementation allocates a new buffer and returns that,
    that will not get freed by the caller.  Validate this assessment and
    fix up all HID drivers where that mistake is made.

(and then a little bit of additional nudging for the details).

=E2=80=94G=C3=BCnther

---

Revision history:

V2:

  * Add a commit documenting the memory allocation properties of report_fix=
up().
  * Reword the commit message for the three memory leak fixes.

V1: Original patch set

https://lore.kernel.org/all/20260217160125.1097578-1-gnoack@google.com/


G=C3=BCnther Noack (4):
  HID: Document memory allocation properties of report_fixup()
  HID: apple: avoid memory leak in apple_report_fixup()
  HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
  HID: asus: avoid memory leak in asus_report_fixup()

 drivers/hid/hid-apple.c      |  4 +---
 drivers/hid/hid-asus.c       | 15 +++++++++++----
 drivers/hid/hid-magicmouse.c |  4 +---
 include/linux/hid.h          |  6 ++++++
 4 files changed, 19 insertions(+), 10 deletions(-)

--=20
2.53.0.371.g1d285c8824-goog

