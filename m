Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754845;
	b=yOJjbT/dow2z4TKpPCSkXzu/iJdjv+XDOiP0HeqJkpG2VqSfJTKpLkwJhar8afJUuXgr
	 7vGqdiQViV0P0Aqkg0ytQnmesMdR+8hdrVTiS4+FKqFj6F8ufBCItLHbGA3XNAXQho9DO
	 p+JUPR1336G3GaNBBdp2jyn4pUq2pHsghsN0SZthklcNsmlN6WkEUZVY2AECzbg/y0BkZ
	 B2Romq04Pm1OMWT/JXwL2WQBKPWoYiL3hoJ7EJafWiXERe4owhxzDwrAeCs/xiCarkDbB
	 fbJIWGaROVcvI3/rjBgifO9U1/odrd5n7H4G6g6UKjSq0smg7EFVBbwV2BxN8FXgFjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9t2DbkE0vspryX+BIV9Sqh+KsqUVz4iGsjeeoIK/L0A=;
	b=g1sRgtLG608B7Eucwq2K8Mjk/SDY/4O52xYumTni4R67g//YO20ri7xajsZyZhkJFd8C
	 apOpZjHQO3VzDQYJ9OUERny1zPMfWtS5eYSp75b5pqquT1lSwolmfuZ6Zt2qoHnWeV7Pr
	 UytBhfpt3uIJDxIAAPpafydqjFj73AWYSm8DRzOxicszLlzZZpjcgthlH0cZDKyhsMlEB
	 fQ7v9BnXpe+H1figJvcrVLPQHl4vfKOfjfstbW+nFBiccXep1YH0tyvI3fTMpxt52PbwC
	 6YkYeVKEZGKjU68s3U9hCdk7/bLI/TjaQCVR00OaKEMldBHr3NmqCTDg3PSGRTzlocQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDgozVT8;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C1606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 04:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 466C1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDgozVT8
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-385d8a00598so11234293eec.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 20:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795754844; x=1796359644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9t2DbkE0vspryX+BIV9Sqh+KsqUVz4iGsjeeoIK/L0A=;
        b=uDgozVT81GzdoBupMhTN1YF9fAIrh0xhQXANC/Gy/yDIKLE8xqYze7Tn1N2EPh8UcI
         2CoINkQMLuD+xorQJ5M/iM0iLdr7A2ng0YQQwv/ByMyYNt2qBFKf3qVEovN41RSj3Gfv
         c6arWW61xtR3WbDt7gfzXBPubPWvD6V9+/CA/ekbfGPsYWUwe874e+UxLh9Alj2xeYKw
         Muv0yGasa9pZIs0C1nlWM+a6sJeppblS6ii7mEL2AX5+eeNC93wci+XpI/XWo1RLQa/a
         9iiaCcWgWQJsshSSvKVF6mhl7zfqThwks4YehQlgaqJLTHFWINaj4qrAOOmFRfV0h4SK
         q/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754844; x=1796359644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9t2DbkE0vspryX+BIV9Sqh+KsqUVz4iGsjeeoIK/L0A=;
        b=jocBlkEd2ho6XSjlXWQRqNU2nSxMKUJKZlc0roscnlc/K9mV5/j92pDqMHKqPbm0gm
         4LxyRIEW41wpoc+yXmOdO3sD6vs48yH1zlt5bAVKlAQLxpdR9qUZl/8L3clrOu3AUOlq
         xo3WXwzKICRY/+KjtIK6XaeiTqTxKafLvB0jc6gqTFoEeeDr4zNw2EYrV2ZvpAUplX4q
         pSow4CZLUq/q7Djta6sokvZb3iLb/JMKDFu8yhK9NGYZ/xUhoAMDy/TfQL+DSNfMsA7m
         bWWEdM8kAbriI5DGwlTVaccfZOxNWACEiFjCL3WrPUEsPFynoEk67fV7RCbm2XQy5NWt
         7B8A==
X-Gm-Message-State: APuU4Z8n6NmyRDULavhkcCSoPxD9q1FTlmJ71MVFbx7YAqjCvJl8H6uL
	x1EEdrHHQR71aQQRG1LU8X3tZEoJP/N8+A05lKuND8XdEDg5wwbSvzuN
X-Gm-Gg: AZFdTZeuqI1tGSNvm0958tqxPV3oRhRt12lAlEmZudPymJv+kNGrgN1WWT9m6GZcNDu
	pa4Uy27Gd0DOCf3+OMxsHyspXHBZGKq1Phz0Gik20h2vWwIjgOEdMx0NrXtFVHmjAem/JiiBW7c
	LYO1CtykbpFJH715OpjmRCeNqnQ6Cp9ERNsA8LF/ke/DeIZ1oKuG530GogsXCH470DTqRRdOE2E
	oRjHlDOlG2IAh1u/0XuztUaSXt8ssTF42YR1nreZtMC26cUQSWF8/M0oDqmZozWLMbBKFFB3jLx
	IpBT6Q4MRBF8xK2Nt5AmtXNEjYspmvhlvDdHwK/6tNsMlJHNck67I3zAVclywEaONgICVLPP/3e
	AMMWsHW7E1nd0nwR761Gs+wqOwvAbpoizJ6pnyW5NPFGgri+xT2Y1qMkhOrFSmk95Hr/LIMkj/E
	P/1EH6gu3AtVh6fvRG58T7mskWMZdb1Hv/Y6K4RRuKPfetG23FD9vI3OTX3Bed27q7qMPQ6UyAP
	yG3jFELsaSzrtNhDE4mHjJMvWf6OwThDp+Kov6OBwasqPIGG707QsEHkI6ThjwnZ3xCtUBNACnU
	x/LzKPJuLGgNHKykN9Gdzl7l/88Q7gSKog==
X-Received: by 2002:a05:693c:41cf:20b0:386:c803:49df with SMTP id 5a478bee46e88-386c803524cmr9151437eec.28.1795754844138;
        Thu, 26 Nov 2026 20:47:24 -0800 (PST)
Received: from archlinux ([114.79.176.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm77084648eec.26.2026.11.26.20.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:47:23 -0800 (PST)
From: Gururaj Naik <gururajnaik166@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HID: amd_sfh: Fix MP2 DMA mask and add Dell Inspiron 7405 quirk
Date: Fri, 27 Nov 2026 10:17:15 +0530
Message-ID: <20261127044717.129941-1-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This two-patch series enables working sensors on the Dell Inspiron 7405
2-in-1 (AMD Ryzen 7 4700U Renoir, PCI ID 1022:15e4 rev 00, BIOS 1.20.0):

1. Restrict coherent/streaming DMA to 32 bits for pre-SFH1.1 MP2 devices
   (mp2_ver < MP2_VER_1_1), avoiding MCE hardware memory corruption faults
   when dmam_alloc_coherent() returns buffers above 4 GiB.
2. Add a dmi_sfh_table[] quirk for "Dell Inc." / "Inspiron 7405 2n1"
   calling mp2_disable_intr so MP2 firmware acknowledges sensor commands.

Both patches are based on hid.git for-next (commit 4a30b295fc34). They
were validated on Arch Linux kernel 7.2.9 using an out-of-tree build
with these two changes: all four advertised sensors (accel_3d, gyro_3d,
magn_3d, and op_idx) enable with DMA addresses below 4 GiB and stream
cleanly via IIO without MCE errors.

Changes in v2:
- Rebased onto hid.git for-next.
- Dropped the HID report routing fix, which is already queued in
  hid.git for-next via for-7.4/amd_sfh.
- Replaced the global intr_disable = false change with a targeted DMI
  quirk in dmi_sfh_table[].
- Scoped the 32-bit DMA mask restriction to pre-SFH1.1 MP2 devices so
  SFH 1.1 and newer remain unchanged.
- Added Fixes tags and corrected patch formatting.

Link: https://lore.kernel.org/linux-input/20261113213533.13139-1-gururajnaik166@gmail.com/ [v1]

Gururaj Naik (2):
  HID: amd_sfh: Limit DMA mask to 32 bits on pre-SFH1.1 MP2
  HID: amd_sfh: Add DMI quirk for Dell Inspiron 7405 2-in-1

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.56.0

