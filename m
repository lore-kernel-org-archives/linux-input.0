Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1B46AF24
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264080; cv=none; b=RcFh3Ae3uZfCv5SX6Vt+VRtMdYtWEJErbno5sIIq8WRYNpIvrJSuge8SPCno3+uIFLC/mPOwFW0PcsI8Nit7QJglLEq/GjPI7mH0DiqxaQkjKeUgSBtkMrWYixDhPmbaWOFA6MfjvV9M+Df5dSyDeYOkFrkjyS1qAx/LmQ49Oh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264080; c=relaxed/simple;
	bh=S6xh4/8NiTa7ChYWZ1h2X4Uq+wR735kNcCvU6dnXzH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcwe84XHC1JSnwFWuQeAKOmzWtkdj1SWYWZeftCwp11ZCx7HXbmi+gjFiAlI91eS3KiA09qXe5llZXA1LHOAFf5xw/mlvrTd7utkxwxnYbSiRWMbNi6V80HxjUDUGpCE9Besi8aEQZ2GNN4MspZgOFyEi8lkFiY0RzCUR2cMcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBXaEU4V; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBXaEU4V"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6128bd9b3so110805a34.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785264077; x=1785868877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mNu6PWtMyvNAK0aPQFqc+HS8pqxvEFc07RUgnno339Y=;
        b=FBXaEU4Vgf1wlXF9c+p8GzCyXda8wsmg8QW4+ekPBddEi40OIubzhu96/TrSCWZXsu
         Lmo4Elq077PvBB90cwenfDCjjFd3B2emTEpCMujB12wssj5dQMpSVPCuITqtFO2FdGz9
         PhoZ/pSOpDMumNYbhoMC6HHRR2qek9Dh9VjhUDimnth6bGdZO4Fu9WMvie3qguvl/hAe
         +K5t3VUkSuXn7dZVYUfRqpmxvaNyQ5Nf4uzOOO3tGN/pN6CnMro4PST1t1V/8ZWnpOFc
         0HiDneDzC2KZIEx5rnhqZNmI6JRIGqW6KyN/iw/RGwl+cY9itUP6mzrtcErj+zWiJxr9
         09dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785264077; x=1785868877;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNu6PWtMyvNAK0aPQFqc+HS8pqxvEFc07RUgnno339Y=;
        b=YMq46e4x8ngD4jcDZbqgi6LgLOVQsJ25jAM12DZlaj+vBhoazqCvJGXF7NtHGlz9ig
         QXUdAhzEOquXBbOdAAml9CmCDfsj9A0CFQnTFr/DIwOAmlujLflaVt8CXnV1ih2Vw3iy
         bBATA3b2GnPg0jgJxJrx2ySFlwRb+zM+TwJjFpNZ1BBav/rm87w4SCH9HcZ0TdS8u+z3
         sXbJZkCEeRTeY24yL+Qt0Y5yFLx1zXsBx0v3Lj7/Xpp1AO5VTShPOLO4aYzDO7fUY/Lb
         WrfFJ8K/ySPFd2e0HmmWZPh1XRWUdH2W/0JADWyduDOQKrnIzHXr5HyegFvmMsrx4Y7t
         js3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq8ia1Z4bl+8paAEiYXn41oLWSUK3RJ33mHOxaagCbW/sLLecNe1BIiLDrptT1d9MiihYsJ+wZ2mZDXQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpnkfbO3AHmeA9+QS4aIMZHkt1QZ5yIaN4OcucDUPsl1p3k22
	KrMjt7sVVfO3d6xslkVPS4kKt5aG/6dfllO1Oejsh7qACcscUg/IBwaXGgNOdpE/
X-Gm-Gg: AR+sD12W2OELWYpg7FyoMP6j8Z0k9mRXc9sFGPFWcV27z4+4y3Qf5wcDjDSa3Oqsfd3
	PTSuieUwswItN12v5Ee85bJ7S+4qh2Pc7uVqi7JBUMHPvK4GpJjFziC3Uuh2bE97BqTo6pog+bQ
	YEBKMaP3om2pdrEKISOxsArk8eo2W655+oAotikrpNByLny+otFFkufb2tu4BNrooocf2etK1vV
	RHj8B52uw19bF0AGTmvq2RCV9QQslLI2TyMPJQ09wbkIg5RsiW/c4Elq1mgQ8VSOGWsXT0vN7tp
	F1F1l1cSvt/4EaLSjDwoIFttYfR2+2+h8luOr6d2wPJwN3ddl3Y72p9oQwGt+G8InQLbzA1jbVr
	B1ZoBAIYkZJkxn87GydRl4SAlzD5usG2wz2kT3SR7zkdZoj6szVw0bBTQsnYKsQfbGwiLNaPKE3
	Jy/w==
X-Received: by 2002:a05:6820:1528:b0:6a3:87fd:2130 with SMTP id 006d021491bc7-6ac96cda0ccmr1886791eaf.67.1785264077076;
        Tue, 28 Jul 2026 11:41:17 -0700 (PDT)
Received: from desktop ([2806:107e:1a:2f14:d204:ec3e:fc64:563b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca5254057sm177341eaf.4.2026.07.28.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 11:41:16 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Alec Hall <signshop.alec@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: [PATCH v2] HID: magicmouse: avoid NULL pointer deref when there is no input device
Date: Tue, 28 Jul 2026 12:40:59 -0600
Message-ID: <20260728184059.688513-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715195853.1302765-1-pepemontfort@gmail.com>
References: <20260715195853.1302765-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

magicmouse_raw_event() and magicmouse_event() dereference msc->input
(e.g. input->id.product, and via magicmouse_emit_touch() and
magicmouse_emit_buttons()) without checking it for NULL. hid-input only
sets msc->input when the device exposes a usable input device.

magicmouse_probe() has an "input not registered" check that fails the
probe when msc->input is NULL, but the USB Magic Mouse 2 / Magic
Trackpad 2 path returns 0 before reaching it. Real hardware ends up in
that state: a USB Magic Trackpad 2 exposes four HID interfaces and only
the first two register an input, and a USB-C Magic Trackpad (05ac:0324)
exposes three with the same split. The remaining interfaces are
vendor-defined, are claimed as hiddev/hidraw only, and stay bound to
this driver with msc->input == NULL.

Both callbacks are reachable in that state. ->raw_event is called for
every incoming report, and hid_process_event() calls ->event without
requiring HID_CLAIMED_INPUT -- hid_match_usage() matches everything here
because this driver has no usage_table. An input report on one of those
interfaces therefore dereferences a NULL pointer and panics the kernel.
A device that binds this driver by spoofing an Apple VID/PID, with a
report descriptor that does not produce an input device, reaches the
same state.

Bail out of both callbacks when msc->input is NULL and leave the report
to the generic HID paths, which is what those interfaces get today.
Rejecting the bind in magicmouse_probe() instead would unbind interfaces
that a healthy device legitimately exposes and drop their hidraw nodes.

Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
Suggested-by: Alec Hall <signshop.alec@gmail.com>
Link: https://lore.kernel.org/linux-input/20260714102540.3EB2E1F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260728072554.47069-1-signshop.alec@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
---
Changes in v2:
- Switch from rejecting the bind in magicmouse_probe() to guarding both
  callbacks. Alec Hall tested v1 on a USB Magic Trackpad 2 and found that
  it unbinds interfaces 2 and 3: they are vendor-defined, have no input
  device, and have been claimed by this driver since 0b91b4e4dae6, so
  every cable plug logged two -ENOMEM probe failures and their hidraw
  nodes went away. Nothing user-facing broke (touch and battery live on
  interfaces 0/1), but silently unbinding a healthy device's interfaces
  is not a change to make in a stable-tagged fix. Report:
  https://lore.kernel.org/linux-input/20260728072554.47069-1-signshop.alec@gmail.com/
- I confirmed the same shape on a USB-C Magic Trackpad (05ac:0324) here,
  on an unpatched 7.1.5: three HID interfaces, all three bound to
  magicmouse, and the last one -- vendor-defined, bInterfaceSubClass 0,
  two endpoints -- has a hidraw node but no input device. So the exact
  interface count varies by model, but at least one input-less interface
  bound to this driver is normal on genuine hardware.
- Reworded the commit message accordingly. Those interfaces show that a
  bind with msc->input == NULL is a state real hardware reaches, not only
  a spoofed device; and hid_process_event() calls ->event regardless of
  HID_CLAIMED_INPUT (hid_match_usage() matches everything, this driver
  has no usage_table), so ->event is reachable on them too.
- v1: https://lore.kernel.org/linux-input/20260715195853.1302765-1-pepemontfort@gmail.com/

This is a sibling hardening fix to "HID: magicmouse: prevent unbounded
recursion in magicmouse_raw_event()" [1], which touches the same driver.
If that one is applied first, this needs a trivial rebase: the guard
moves into __magicmouse_raw_event().

[1] https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/

 drivers/hid/hid-magicmouse.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 802a3479e..7164ced59 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -390,6 +390,14 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/*
+	 * This driver also binds interfaces that hid-input does not create an
+	 * input device for, so msc->input can legitimately be NULL here. Leave
+	 * their reports to the generic HID paths instead of dereferencing it.
+	 */
+	if (!input)
+		return 0;
+
 	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
 	if (size < 1)
 		return 0;
@@ -538,6 +546,11 @@ static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	/* See the comment in magicmouse_raw_event(). */
+	if (!msc->input)
+		return 0;
+
 	if ((msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
 	     msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC) &&
 	    field->report->id == MOUSE2_REPORT_ID) {

base-commit: b7556c8e713c88596046a906c7c4385218d44736
-- 
2.55.0

