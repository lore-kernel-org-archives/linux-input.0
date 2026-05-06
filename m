Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514932ABCA;
	Wed,  6 May 2026 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096022; cv=none; b=YPOgrYmUAqCeG1zODdaFBDeeLmEx2/edXZcO+MRff2/wtVdzRzcTIDDnh9BigQ5kMZU41FbdyFyanGai7AU3w1/0GpDCrL74KTHeZe/Cx7PnDdTtLYjAdfEeY+yZ8wzF0q1SUBeWgUtz6ieLelonTCGmS2Iyin9D5JYicZu4SFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096022; c=relaxed/simple;
	bh=OcjX/QZ0KxNwV6F3ImlUWEKChhG8t/1AQGVMkcMdC6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUF+oVX+kq5AWf0Ghr4zR47HXzMjTgLtQg0XGjlZtuIQSUn3bRuBBNA9tXUHeDqei89xroLWLficKWkvk//R9ceug708VsmNBNIHmxXv8bHiL3e0I8Xzsqjf1ukLTBr3wUuVREbYX4sjfYKzD24E+Cye9FSkbxFxIB7tMGx0ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=ds1szZBF; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="ds1szZBF"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4g9lsz4Cqmz1DDXX;
	Wed,  6 May 2026 21:33:27 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4g9lsz2XzBz1DHpT;
	Wed,  6 May 2026 21:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778096007;
	bh=DGkAX6i8roG5XGvYh0CY51wl4FMXi1vlkqDjVzGbJus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ds1szZBFgU7KIc7ACgwlAmybGRNUo24mdTSbsmr9NxSq+Fm/jCraoK2OkhSK685Z/
	 TUKFCZmnMpalLOOn3yVcXJ/sj5C20+BGmP1YVHPnvJpXKoJVh+C887Qy8Ikmp63nay
	 QvoLHigFF8hMo4XGqPElE1MkYzc6APSQli8OMcJzoFX6EQIIyfBvp7HAtypCtWWOp5
	 wS/DGHC84m7fCMT+GgmxJTTQ4qQ5B50DkJtasBQpycrzzIIOwGBKyYoFUOaUw359rn
	 1EJYTItgT8sOFDalqX+J5ZquhSV1LLkArc+ZGUJ+jUPBW0yoka6xRNlzikALdm8WCn
	 izf8miN16m+eA==
From: =?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
To: platform-driver-x86@vger.kernel.org,
	denis.benato@linux.dev
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	corentin.chary@gmail.com,
	marcus@grenangen.se
Subject: [PATCH v2 0/3] platform/x86: fix fn-lock on ASUS ProArt P16 (WMI DEVS no-op)
Date: Wed,  6 May 2026 21:33:23 +0200
Message-ID: <20260506193326.5862-1-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of the fn-lock fix for ASUS laptops where the WMI DEVS call
for DEVID 0x00100023 is silently non-functional.

Changes since v1:
 - Split into three patches as requested: hid-asus export, nb-wmi quirk,
   asus-armoury attribute (the NULL-ptr fix for brightness_set is folded
   into patch 1 where the second listener type is introduced)
 - Moved the sysfs attribute to asus-armoury's firmware-attributes
   interface (fn_lock under /sys/class/firmware-attributes/asus-armoury/)
   instead of asus-wmi, as suggested
 - asus-armoury now calls asus_hid_fnlock_notify() directly rather than
   routing through asus-wmi; this avoids touching asus-wmi.c entirely
 - Dropped the asus_hid_listener::fnlock_set callback and the
   asus_hid_set_fnlock() / asus_hid_has_fnlock_listener() machinery from
   asus-wmi.c — the direct export from hid-asus is simpler and avoids
   the module init ordering issue described below

Regarding Denis's question about auto-detection: unfortunately it is not
feasible. On the ProArt P16, DSTS reports DEVID 0x00100023 as present
(ASUS_WMI_DSTS_PRESENCE_BIT set), so the existing WMI probe path finds
it. There is no distinguishing bit in the DSTS result between "WMI works"
and "WMI is silently a no-op". Attempting a test write at probe time would
be unreliable (no readback available on HID-path platforms — the fn_lock
show function intentionally returns -EOPNOTSUPP). A DMI quirk is the
cleanest approach.

Note on module init ordering: asus-armoury and asus-nb-wmi are both
compiled as loadable modules at the same init level. When asus-armoury
initialises it cannot safely dereference asus_ref.asus (set by asus-wmi)
to read the quirk flags, because asus-nb-wmi may not have probed yet.
asus-armoury therefore uses dmi_match() directly rather than an exported
accessor through asus-wmi.

Tested on ASUS ProArt P16 (H7606WI, N-Key keyboard 0B05:19B6):
 - fn_lock attribute appears under firmware-attributes/asus-armoury/
 - Writing 0/1 to current_value correctly toggles fn-lock state via HID
 - asusctl fn-lock -s true/false works end-to-end via asusd

Marcus Grenängen (3):
  HID: asus: export asus_hid_fnlock_notify() for direct fn-lock control
  platform/x86: asus-nb-wmi: add fnlock_use_hid quirk for ProArt P16
  platform/x86: asus-armoury: add fn_lock firmware attribute

 drivers/hid/hid-asus.c                     | 43 +++++++++++++-
 drivers/platform/x86/asus-armoury.c        | 69 ++++++++++++++++++++++
 drivers/platform/x86/asus-nb-wmi.c         | 13 ++++
 drivers/platform/x86/asus-wmi.h            |  5 ++
 include/linux/platform_data/x86/asus-wmi.h |  5 ++
 5 files changed, 134 insertions(+), 1 deletion(-)

-- 
2.54.0
