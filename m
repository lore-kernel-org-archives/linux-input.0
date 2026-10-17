Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684947F2DE
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247915; cv=none; b=ScniQeDKQQEZdSDviUO486604XDxQlPW/tsNrKd2RdQ+eLjFQ77jkxjZ0VRZY2FjRXxJp5exWrziblHzohFTb1kw7diWYkOtrOrijMSHfLBsX87BLP3mc3FHYcKP2HvrbBtkAjHqYgLe3mVHYxl9SQeq+ZgH8owVQP3ZclTEkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247915; c=relaxed/simple;
	bh=Z3NdKlWVlqAPME95Aop1Z/FVVgK4zViRb+bOxx34PFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bn+e1SJmpjvwq3XmeE80OjSmmFTniO/zKqeVzK2fZjuUbqfTQ3Vi+407z8S2+viBuaJ3duLfjvOg2/6ujnYnuhneJHjZr9qZOZAi//t1nXlP3JtMqrwmTkIMOLjQHlci2ZGCi4AwZgJyXIPq4ZxIHdbsH+WuiSr6emm0Xcx6E/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlkJVeV3; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlkJVeV3"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1673615eec.0
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792247912; x=1792852712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=omiuJv8MmcCiww+ZKW5+WdH4aNs8y923/45k9gUA+w0=;
        b=BlkJVeV3eMuFKCt/XXbJy4lf36A39tyThlzudex+GVxyzqgJaSSGGzHWD6xNZ2v2IP
         aHy3ueNTjT5hq0RawjIqHzwiT09WYNOY7MhK5XBRodV/7o+V8cDIjsKJEjf4zORxp3qA
         awBXs744HsWNhW9dPa/wO/kVXaoFVTZmcx+EgEFmtgmKdVuZRZKM1+3dVrqVNu9sW1kO
         aiQ6bFpqw1Ylip2c/ZyTNDlrbD6LGaK9cEb70ZeNDkPVZ1+XRKp07V19tIDu6nXf+4vR
         f3bR5/lpmi2OfoNItNAH7pByaPOgd2KiWcbVA5bTBbcsbn/rvWpknSKN8ltCTz/L0gdt
         RpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792247912; x=1792852712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=omiuJv8MmcCiww+ZKW5+WdH4aNs8y923/45k9gUA+w0=;
        b=l1WpbSZ7GBZBd3WCS1h+B/AVj1hV/8RiXEBPYBFL6OgslztyjX4nCDU1UKXk0u4nHK
         rQ8K/C8VmKbBS6B8coUv68PMq0skNwIxzyLF3cQhjNfEiTxs/O5XjMMXvGiPJCkES4UM
         j3dSf38jrhhdrMvtSKJMDcvfmvHLG9l5m0fQKfTVHEtSSicRUWTyCEVvXUlEHwNZiWau
         ceBOXKa9oqZvIiZ9FLughNC0Ztd/yk1+8y0PhrYZNdTmLD/VOTI94x2goT66ygAGnt+L
         W+zSH1Sw0+yCOA62oikvGuCCwO+eVdmjo+f5OC+EZ237j77uoPIXM7iL/w435+IToiaG
         8Nlg==
X-Forwarded-Encrypted: i=1; AKwUvBzB23MqpOKgztI/2UfjwHQE8kQ1lLLYsgYyA+4+pcgmHun+2Nn1qPhJPyYLInYQISVPhB+7Fj+BA4FZbg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmB1Z+vQGDpLFtoGmuO6WOdaVu4pto1cD7mdglPSgLiNG0i2If
	SKHwvDNGo4dhi1nn0++aiODdKkXANFlVJjpRL1b+LCLvOB4hIF7q4gGS
X-Gm-Gg: AYBFou2qJh+MdTXFdZnyaE0M347YEcMmXL9VCnAHAsCgu0ftkYKpmoQtHSaGVBFPQet
	3hTeXGXjp7Ebl4Q3r5ks5X72mLsuPaBUziSMbbWxq3IKVMtF9us2UDvR5mePIWNsgRJ6mSzbhIp
	ch6+tI3DWaHiNGMjPeKD6hm2KA/yXIfZ65v+L9QrTH958ji/aiBmr+VTQwiCpa8fAkKrnpCb1oh
	foyRXvTeHsIAdzwnwmMiCx2L7CIiaG94xn/NTsbOyCMmb+espshDiona1S3Np2qv5/W0aNzX1Na
	0Hcr9EkRqvJlxxDxdyfx4wk+0qwLIQdFZSFondyMBPGnATw6D99LMIIPNyNbvnqiWY9D9O65HVO
	zBCAh1uWNfFcWNaSS8vhXnFReBZSYmWxbcHjCh+HGG6S+YEoWPRZsMbmckhCzNN/ODpwCCJliDs
	LgEiFKCJGyaKTg2flfgb3oNuuQSBWjwNZbC5dKywoJRCrUJRBqz7s3vUhrBf1g
X-Received: by 2002:a05:7300:880b:b0:361:7ab9:47b5 with SMTP id 5a478bee46e88-361a2e393c2mr5031610eec.36.1792247911459;
        Sat, 17 Oct 2026 07:38:31 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm26652075eec.12.2026.10.17.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:38:30 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v10 0/2] HID: multitouch: fix haptic lifetime on delayed input release
Date: Sat, 17 Oct 2026 11:38:08 -0300
Message-ID: <20261017143810.1567677-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9 review found that a non-multitouch touchpad report can precede
the actual multitouch input on devices using HID_QUIRK_MULTI_INPUT.
The first report could take the only FF instance and become populated
solely because FF was added. The multitouch input would then lack FF.

Patch 2 now waits until mt_input_configured() has identified a
multitouch touchpad report before initializing haptics. Only the input
that receives FF gets INPUT_PROP_PRESSUREPAD from the haptic setup.
Patch 2 also uses scope cleanup for the cloned state and all of its
subresources, removing the mixture of __free() and goto labels.
Patch 1 is unchanged from v9.

Tested on x86_64 with W=1: built-in HID objects, a minimal vmlinux
and modules build, and hid-multitouch.o with HID_HAPTIC=n. QEMU/KVM
with KASAN ran 10 virtual UHID haptic cycles and 10 multi-input cycles
with a non-multitouch report before the multitouch report. The tests
checked FF_HAPTIC, effect upload and playback, HID removal with an
open evdev fd, and final release. No KASAN report was emitted.
Physical hardware was not tested.

Base: 58161ead29e50d70a317ea26b472e0c7508e69da
v9: https://lore.kernel.org/linux-input/20261017140332.1480375-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: make FF creation the last fallible init step
  HID: multitouch: give FF core ownership of haptic state

 drivers/hid/hid-haptic.c     | 161 +++++++++++++++++------------------
 drivers/hid/hid-haptic.h     |   6 +-
 drivers/hid/hid-multitouch.c |  36 ++++++--
 3 files changed, 107 insertions(+), 96 deletions(-)

-- 
2.53.0

