Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A9343D72
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973535; cv=none; b=RLifSlzh3rUtwE9vjdO2P5USQqmqbklXZjmWTU+Tj4r7H8SfKlRUbjsgxGTn1399nw9fg99PX13UAWg0nKX0AitcmZqpHT2nQKPx1PwIO2ppaTvjD+SifHrk8dAbxjFVz9XoUtvtSy4qY6iV+BLIZul2HFgy1+L814BTCpd12h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973535; c=relaxed/simple;
	bh=HWwN8mDgSE+e9DYpgsa+EJ1W4OJBEGLHqTIBT2JQF/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSPIVJ6FPWmB4JQNbelxjUTUe/wm1eHetEQchapjUHwTJKQM5tEVydxJOqIqEMA++3lVkp/za9M3q/X91540G87YN2rQDENteYurpcXRcGJu2GCPtOLHnJj3e/k+l6SLUlyDmhWWPkno7buYTTkdvI8LI6IwvI/XOWJ+C6SGLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgN9CNV2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgN9CNV2"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b015532f7bso4172432e87.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973533; x=1784578333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bMz1BrxAYWr1TdTDKRgQMvDyxFwwGlOLOg7Ru2tLidM=;
        b=EgN9CNV2UqdFutNalx3y4B4oQPk2OVzwj98WGfar3cEtuFMaa4h/3s2ULXx3iTGiti
         1AYrrClfOo+bIYbC58l4NIO905jI6xcrttDUbCzBPQTopZeCohNe+Np/Z8YL5v0TW9QD
         WSEeBlzRzjNdZ5o7DcJur/dLOFbjj8E5x361bTVvivFlhP3tQuxwBi/4vvyN3zrxhEiJ
         BsbDJbQUzDdc1Y1nxcYXM2lEYUVK3GWethNlhXizVaCwnbhDi50CzsXZ/IxdkDkG7NYg
         42uE1YIkNypASA0fEYNL71PBx0yzW23KxTkeHmJcYzvVpmINI3cNOUzd8bOiIEs21baQ
         h3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973533; x=1784578333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMz1BrxAYWr1TdTDKRgQMvDyxFwwGlOLOg7Ru2tLidM=;
        b=lukwO7OZC+F2j2ZxtvBKlgmtxccbwVW0WQxbmm7LZIlnIOflfFTX6NcSZmufg6EcZK
         hZtQs2LTqgsY+K+u9IAcObU5ufJ3Aqy9s/cihgvOHuaNvCACDO5vDe3B0s+c4Rt/uzfH
         PSH3D/3gMB51sM0mynkApJn+jxdiEQ6KSU/MFLdlm849ma+aY3I7bo4XiCkmFtPRK+8F
         gU2m4P1VfDHQHPivi7y68LCNFXL8EnS1CfQDOfqTxDLDYfk22/9X2YfOroRIKTIO5oT5
         qQyDpojaClhsHNudISQV1RUnsl8+XJAEsIovR51JxiDr/jLg4uBwccnEjGwxY4hKeXWw
         ZzIA==
X-Forwarded-Encrypted: i=1; AHgh+RpxXje1uvwseZ5+xbjjO7irzk4atSWkDo0k/H/0RO1okgYmJd2Wv9uF4xhw5rucbNS/VoTJvh2J5XZJcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwnR9Xdn16f+9zo9kYMX/9mDQZfu4Z70f/9cxK1T0wA737EQT
	N5AmGxP5wJBAbO2Bj97vsak5SicnCQKgv+kgT/nI6xOe1BRyVX264dS+
X-Gm-Gg: AfdE7cnEppio4o3vDBxI1PSQ1LM0GjTnlrX9p+bFQUygnneQewb4FC1cRCusis3bb02
	cO8axMBJqGC9J+T8N4pWDmea9su1PnIlqEgo5lwJI01Bml13WAvQNtx8kgmrDtXlXNEbMgOq0EH
	pmWwe1FgIsS8Rr2+o9/GCLKYKbmhT7OXvaRHqpcvauKEdkRYyMu7kR8unPMPtM+0akxbPObR/c2
	g9dzh1AoJL+ultSm4eSyvDjNk0jxqqrdHKKPu+dz4VlwEWzJrts1B4ZUDmG4P1qh90S8P6k/MIl
	ekflejYtSWiwkZTbrEBd3/3+aXV3pEyWfVZzRMOfcbG8M+yFoQ7v3e76/eDjcDnqbVKZMzPg88D
	1moNGywXIVnOLpK4A6sXvyhs0nz1o43KdvVbDfl0qdG474aRSbgkQ0xi6Cs7S4oqUBA4KFfdh1x
	Mu3KXjc7NXmDv6577elEjI9O4h55+eMbodXhrXn9l1WMPv
X-Received: by 2002:a05:6512:3b9e:b0:5ae:a9eb:c5c2 with SMTP id 2adb3069b0e04-5b0236cee3bmr2785018e87.60.1783973532495;
        Mon, 13 Jul 2026 13:12:12 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b023b59381sm2303465e87.41.2026.07.13.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:12:10 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	k8ie@mcld.eu,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH v2 0/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Mon, 13 Jul 2026 22:12:00 +0200
Message-ID: <20260713201201.391538-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds Logitech Bolt receiver support for Logitech HID++
devices so Bolt-connected HID++ peripherals can expose battery
information through the kernel power_supply path with the correct device
model.

Changes in v2:
- Handle only the Bolt receiver/control interface in hid-logitech-dj and
  leave the other Bolt receiver interfaces to generic HID handling.
- Handle Bolt HID++ unpair notifications so child HID devices are removed
  after unpairing.

Thanks to Kateřina Medvědová for testing v1 on additional Bolt hardware
and identifying that Bolt interfaces 0 and 1 must remain handled by the
generic HID path, and that Bolt unpair notifications need explicit
handling.

Reported by Kateřina Medvědová.

Tested with:
- Logitech MX Keys for Business via Bolt receiver

Erik Håkansson (1):
  HID: logitech: add Bolt receiver support for Logitech HID++ devices

 drivers/hid/hid-logitech-dj.c    | 48 +++++++++++++++++++++++++++++---
 drivers/hid/hid-logitech-hidpp.c | 48 ++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 7 deletions(-)


base-commit: 44696aa3a489d2baf58efa61b37833f100072bee
-- 
2.55.0

