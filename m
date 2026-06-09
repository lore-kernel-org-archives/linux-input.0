Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B66800;
	Tue,  9 Jun 2026 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999877; cv=none; b=S7TkitXHC0ki0rCQxnaIyqMlYRbQ1YwYSfD5z5sJeCnO5N3+9JRLkp4F9vWGczRK4jXYi1wtci7oTe6CiwxUlikUI++LxtoxwC4c/MuEHaLJQFsQSPPDt7LBoPymW1Y/Fc6L2NiaqrHFH/IZ2+wZj7W6p8RLVH/BxrMATRIy2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999877; c=relaxed/simple;
	bh=9bZuQ4kq4VGaEO8PaaudLtOZvGMjXwHJs1ftQas7yFg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpgPwaYegXmFDUO0fepgroEauj2KjJStx0Sie5Pm4Vd4VbJnyDBQqO6bHP9u2i8Lj6zFGH82+sTZljd2C7EFf1N0NU9yCi4dtJ31QvNS5eKJI4JDgAOknURAWSx4SxMGWe29g7vV5tiGZmPlHyUpJTaPAOEypwYr6QkrIBKIEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=E1bJ/tN0; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E1bJ/tN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780999866; bh=9bZuQ4kq4VGaEO8PaaudLtOZvGMjXwHJs1ftQas7yFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1bJ/tN0XDsx/6hP1j4dNoxUQ6H1nv9ZzNoE7MWwenzVP34VPwjoLO9k+vVT00Ugj
	 oI1ZBUwMIGC/cuOLiV9oayLp1J3q5ZQbn2cvZ4d+bR7MKoV1p9uX40iaYMcRju8krl
	 D6tPG3+b+fmJ2XlnGNFQuBNl9kOG7y+G15GKFO6Y=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2B13D22C; Tue, 09 Jun 2026 18:10:49 +0800
X-QQ-mid: xmsmtpt1780999849t6ghuw5q4
Message-ID: <tencent_C2BEF7C0584BFE713DC7B41FFD7007B6D30A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgPA3YretqFCwk/SJKq49tIQXAOeaPisRev7ofmcvwQ17WtOEK60
	 AZ95Ntzi63IAxXNnafm2jPCjhwGXbBZrXiI84RLgNukaDxiH60MY1rs9RYFly1zsyvQQq3xmtX+K
	 5U7G4FN4HpjFh4VngS1/DxeMdGvkLR/oUrZEWsB8GkQ2OXXv9G4R0mjToA+p20+TTJBMYNY/9SeC
	 PCsnwFQTWif/szjmLUluR3wrz8wz7ZPt8cMboL5o3brc50RqVFdJSIVYjnUm9mfXuFO0enHXLCLm
	 8MOHpMr5UGiGUjAt2MIoyCoHNRLgxew1gXJ3Bl2YwNqLoJa1Rn7jRCwzXOC+YDks+Lq9urnydanD
	 8pxQbmKv0hXGJYCTibQMjKzciDCY6vkGLp6wd72BwAJgQ8CA1QBaVPg0xwztdzD5wRbhqvu2vPdW
	 EBxMM21y9xpGbBoQMDHfSx6aDBE9+jYvOOc+uGC0uTE7rTZuHgGceq42XbTdfOdr0S9zwY25AXJY
	 65GWrVQRf3HsOg/fFUTC9mD4YwjMG0PMzro5LzLY8/9GDy0bwmgA+KPfbE0zJav3I8WTFfhCPZqK
	 5c9+2oS82I+pUhHunWeg6h0S4tbPPcEtiPNUUQqE++Ryy0/MK0H7t5XZ81btD4P+3Gl4BTSrarM/
	 z72MZYns0HQxsxiXTntcOd+/vlaaG9wTEpSqrlse2OFvoaIcmL4hHIFMDASNHiJPx3x+/vK0IHCW
	 fIu+yH52/g3TB8d78F8KqppXShzkPhuxUreu0kry/ZTigpoWmf56MRhE3iZPjZ+qT3MgGR6mp2RK
	 xx/dWNqbrJvoBqAr3WoJCX07qsQ2vGZvLYBbxUN8mfMik4hXCJc/b5oHXBDwOuTcFMd481Y1FPkp
	 Nvi8RhA768L6bD1vBZ1786TiZ0ebMRpWlhf3LgTv7uOnvgRnB+bLOT/W98nupKjlmk1zEYEYU6DS
	 xnSV+C5z4cJ0p3ZyxKXK/h6txaJ8BdyRkSaAqItrnrN0FCXTiA/vLymBgP2/SZeJVWb4uKjC/+NQ
	 nGNZdlktmiM2ncfN6Di/SCegOa+iBzuc6HssIF0A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org
Cc: Yeking@Red54.com,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	superm1@kernel.org
Subject: Re: [PATCH v3] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Tue,  9 Jun 2026 10:10:35 +0000
X-OQ-MSGID: <20260609101036.106013-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4243c594-6535-4111-86cb-69784b0a34b7@kernel.org>
References: <4243c594-6535-4111-86cb-69784b0a34b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans,

Thanks for the review.

The current header-based approach lets i2c-hid-acpi-prp0001.c work
independently by just including a header for the _DSM helper. Switching
to EXPORT_SYMBOL_GPL would force prp0001 to depend on i2c-hid-acpi —
a Kconfig "depends on I2C_HID_ACPI", plus module-level dependency at
load time — all for sharing a single function. I find that hard to
accept.

I understand that adding a new header for one prototype is unusual,
though it contains only a single static inline function and introduces
no runtime dependency between the two drivers.

Looking back at the full discussion: Benjamin made it clear from the
start that he doesn't want i2c-hid-of.c handling ACPI _DSM fallback.
His line is that ACPI devices and OF devices should each go through
their own drivers without cross-contamination. If you still prefer
exporting the function from i2c-hid-acpi.c, then prp0001 would have to
drag i2c-hid-acpi along with it — an independent leaf driver turned
into something that can't stand alone.

If you still prefer the export approach, then I'd rather take a simpler
approach: add an of_match directly to
i2c-hid-acpi.c, and return -ENODEV silently at the top of probe if
hid-descr-addr is present. Same logic as the prp0001 driver, but one
fewer file, no module dependency, no extra Kconfig entry, and no OF
driver touching ACPI devices — which should also satisfy Benjamin's
concern.

Regards,
Zhibang

