Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C75757EA
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179360; cv=none; b=IQjq9+tsidnCPJWxFsu1MRYnX3YL27h2CbO0WFTN5TPFKn2fHIhBwhVrVpPNtr7n30TZXVaUpxqPQUMSb6fDdgjj6a0aZoTI3nHi4OuWHswF+01YBbz3c+wbeTsLGCfphDkDrtvlHHt4GIMR+nfjcBhPcE7YqtQiPP8Ams8GX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179360; c=relaxed/simple;
	bh=jciMuaYmnzo+mtp36oupoEIVBtKsklWrRPPPIkVfFKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9etDxWqQOeRCkEgM/+8ml+Ywx6aMf4lkGG7l3h2yXyAwpdhemLxhivKroi9jeYMmaCmsFbXhRgJXpS3PuVxtq63so/ZD2YmwEtxWTUagwTOUuVLySrKbdmpR4WN8Mf/PxQGj+TZmrx2+nE/6kIoswFxlBobC+L5mprGDOF/epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SROKUFP7; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SROKUFP7"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-127380532eeso1157197c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774179357; x=1774784157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5QP4+gpkrcOs9hWryFOf2PZhJepTBzbr0wxILj+zwQ=;
        b=SROKUFP7nJUezJAuws8AQoAsYxYL1fVinWOzfFJ/MaN6KX4MVRnejhvLSwcilnSo/U
         SYm0EtRTf7qPOu2bBT61lRddG+FKM4WoICmpRLMjJsWUR5kcRT0AGieb/b9gJizXLpti
         EioYzrbRfTL8TX/wdrdY1yEWCNOyMySMe3PGgiTvB/TaD8YyzOCq/di2HbWbrbwkS17B
         cSa7OIXMnbHeTUA2CELdQMLG+xX7KSjrkkFmhTLzDl80M1bcck3GTEH8lW9tiH1iRktM
         ZU5TK85qfVQwJmxMYWnKrTis1lY2AQGKdA/HMJteLFNfA6oLBzKp03rdeu1GKgVsR5+V
         i/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774179357; x=1774784157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5QP4+gpkrcOs9hWryFOf2PZhJepTBzbr0wxILj+zwQ=;
        b=IeVab/Wx3D9jkTDbZoW5uzWc0FjoYb63dIO2Qltv3t/ANzoXrFGO8h6LMTGQvK27xJ
         EKe2RYxs+ifH2kICi2LSN0fncCLTI0bMVjLrACTi93p2SIuoa/BUKhAy9Fv4TAt5GEhn
         a90QJgiVVXDHhPN4SlGqvNz3aKl5ahxFKAz/o0WSeF2ilAVsxDe6uHLfJlbVs/IvkTCZ
         ZBgOAo9tsj3erSzECacKYPfQ20yXDikW45/EiIriNgQLKrymJs52NwQp6Y0tqFpXWZP2
         +MQgtAoYI6zzybC9C81yeQJAbIuL2obRDyiwnCIA7+H7wo65nZ1sQPt91cK5a0/hpYVO
         IM8Q==
X-Gm-Message-State: AOJu0Yxy1h4g044GLrOie+QX13Qsx8i5ea1cLvZKQ5l2mHCD4wFZzS7S
	CGUst93oWnficABPVF9FHzJaTvlou7l2bDcVxzG7SEXj6UYorxIkVTpZ
X-Gm-Gg: ATEYQzyfOcyEB4wGFZi8A0ZOE7xq7ScGgIlWZUXzZCtQaHJvswuL+3NOz1CYSnQW+mx
	LOh34H8DPVOm6EpSygeac82ds4oQaZ0TqO4EgL7Z46yiqq4wxPSBbn9TClFhAdOK7CryTIo2QQ6
	YIle7/i94cCG4F9a6azDw/ENLsurGC1PgGdfIBfK18shAx+ZT0qH+DxCPwnTi/cjrDYh1/H7CRM
	kdhoHfo1TDw346GOxkt3an3HTDnAjrt6D0qpAT/T5SWk8VlmoqRXH592iIWEYbBuNdhYA2mkH5I
	M8OONUAQHYWG1iO9mYLsa7+YcRthpZP7dMr7PabmwuaDzbLOm7Htqvx0xqfdKMt9rtFfeDRjxLE
	DSPw+TbPCr+kjXUL6aGZee/BuqC4hkS80WQZrG3g5loPgZlsOaPazCIvM8Iu4OvxQZm4luc2CPW
	9GrDEo5SmF/mgn0DRWWZyNBs16LsWIX7pC
X-Received: by 2002:a05:7022:100a:b0:122:2f4:b24b with SMTP id a92af1059eb24-12a726c16acmr4055938c88.25.1774179356733;
        Sun, 22 Mar 2026 04:35:56 -0700 (PDT)
Received: from localhost.localdomain ([2408:8409:ce0:691:14fa:6bbc:50dd:e268])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12a733fe80esm9022181c88.7.2026.03.22.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:35:55 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Nandi <xndchn@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Ingo Molnar <mingo@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v2 0/3] Input: gpio-keys - add full support of EV_REL and EV_ABS
Date: Sun, 22 Mar 2026 19:35:05 +0800
Message-Id: <20260322113513.9380-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ab5CXO6Fk7lhGazv@google.com>
References: <ab5CXO6Fk7lhGazv@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add full support of EV_REL and EV_ABS

v2: Split into 3 patches as requested. (In reply to ab5CXO6Fk7lhGazv@google.com)

Xiong Nandi (3):
  Input: gpio-keys - set EV_ABS axis parameters at setup time
  Input: gpio-keys - use shared axis counter for EV_ABS events
  Input: gpio-keys - add EV_REL event type support

 drivers/input/keyboard/gpio_keys.c | 65 +++++++++++++++++++++++++++++-
 include/linux/gpio_keys.h          |  4 +-
 2 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.25.1

