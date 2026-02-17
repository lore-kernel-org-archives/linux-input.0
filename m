Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3036B079
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344105; cv=none; b=YAWkorthrdcvm68MEsYCjLi7bPvtB9qbjo+QU0CK6Zo8HswrMTumUcrdbzMgPJk0p8fZDWTMk9AshHsrB59aqXEe2Fv8U1BBVRFBGpqqSXat+PbQwrkmV6UrXBzZ1+39NDhKlyHyXCh8NZ5WD1Ds1xt8EluA+axqcBFVBfeJnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344105; c=relaxed/simple;
	bh=iHmZ4x5Vn0J649Q2pkliTeC1eYINFiSsHq8vKWdGDDE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=exZbMiMmUNaptQB/bimN9UmkFmJC0vgRrzNwfonZ/Jycuo+NA5abt3rGz18rXjnmEn5UHUVddhgWDIQIBxvndCqfafpcHfjFVzzonaufXI3mjIYz8BY5c46ykNkeXiy9m8Qib1TDr/23P68bpXCm0gh3PqwaegdZhx/ZHBLm2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDUaOtSe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDUaOtSe"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43591aacca2so4183612f8f.1
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771344103; x=1771948903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnRh0lA3B1U30SyK+gpMCmGhg6iwBc2oClXC6RFEEY0=;
        b=PDUaOtSeZhkokyiiAJmO2wj/w5y3TpzvNfAAreHpmgAFerUnH0LhEncvQmH5z6oV5D
         E2ET9o33zDlIWoNnHPhDeGENbWf+b+GCwPpEIkbE2zmlX4D+MW7/c8TDGlnO0uGyc52s
         XATVsdj4fEopwiZV2JRuJ9z6Xb0mx+Z3Ftz/O7GStO1JwLIqdNlsUXApwKoV7L0Mo9n4
         Ykg8byfLQrsDfP3X5QvazFgne+eGV6XNTkbNx81L+xff6o1KDIW3cF2/POojhBAwx8hh
         xTeJLNR+zSKefw4JTFbtJ5fvWqD0Yd2+WaRvMp2tL0Nh5cisgpKWklR7Ae9fkr3ixK91
         W1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344103; x=1771948903;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnRh0lA3B1U30SyK+gpMCmGhg6iwBc2oClXC6RFEEY0=;
        b=EvoBna1zEuVNsDPi+0+mNp74C2piM3uHOzD/eJDc2dP0aY4VSR1w7Hsdsyb1fmw0DP
         5bSHJiZYwxTlCrrv7LA98jsqn/jLIuk7eJ2L/4TRvjTbFP/ik8d2Rue7opFfVCt8oo6U
         U6f4cv20VVnMKE5534+twzULPCEyrytl3EKypzlkZ2TDxLTZ6s+M6N1pqgNCn6XIR023
         Bn9wU6pxk+tpfM1hxmZrl1MtWhh3blFLJbptOf6UeK7Ciw4TRFEZ0Ndi7SlsBIDR8nhw
         7V7sHXFWekpu0m/dDxgutFrrKGxxZy0AAJ5/ewp9CH6rzDI6hQXXNzUnODSJhrr4pjP5
         Clmg==
X-Forwarded-Encrypted: i=1; AJvYcCXz5qjm9/pEMYJrg5kC3jGsgBJ15+j/lCUhu39bcyw3PL7jUXPN+txbgaU96e1UCk6PivmyrGuues9Sdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOMZ6DPwGGNdEFYeVVo4PCy1WfVG8H8hBsGCq8QWvpTPi07SG
	czW+Jm0JOKv+YmNbBitSB+4dtZOE/+z3D+FirtU5j0ROdb1uyDI2Fl+5fpvii48H0sYZT4iivUc
	O2ifUxA==
X-Received: from wrtp15.prod.google.com ([2002:a5d:4e0f:0:b0:436:198:b7af])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2403:b0:437:75c1:578d
 with SMTP id ffacd0b85a97d-437978c792bmr27445209f8f.11.1771344102413; Tue, 17
 Feb 2026 08:01:42 -0800 (PST)
Date: Tue, 17 Feb 2026 17:01:22 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260217160125.1097578-1-gnoack@google.com>
Subject: [PATCH 0/3] HID: Fix some memory leaks in drivers/hid
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
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


G=C3=BCnther Noack (3):
  HID: apple: avoid memory leak in apple_report_fixup()
  HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
  HID: asus: avoid memory leak in asus_report_fixup()

 drivers/hid/hid-apple.c      |  4 +---
 drivers/hid/hid-asus.c       | 15 +++++++++++----
 drivers/hid/hid-magicmouse.c |  4 +---
 3 files changed, 13 insertions(+), 10 deletions(-)

--=20
2.53.0.335.g19a08e0c02-goog

