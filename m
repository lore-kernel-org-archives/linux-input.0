Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532642C518
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345008; cv=none; b=DR6pz6C7sTz7Db6Cgx0OWgIWUbaDfwlxQ7JgBGrXkTEiYPbE5EaDxXk6Qg2fcf2VKBWxvneq4vcBtTzvFeLfmk8F5vbHdreZWynBm5DSq47/0xCTTa98oLJtbUaq7UD9eomfMpnuiWfxtc7wbdvBGcM/AO5ZHcx3RftlaUaTDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345008; c=relaxed/simple;
	bh=WsXGpbXIu6GxKGXE7l0+bSLeE7QRMBDy1W1Iz0fVOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxCX0v1kQXFo6kwEAOy/020AQxWYTa2WqnhPna38I3Yc2Py8NftrCnWuMpFW9i1TASFHXr0PVisPvJUsYWkgvu8hWgVKFwRqC7Sch8TF8ETwRbMxpvgbAlhrLHScDWPKAg2vC7VvQwpDtCeVCaWEFFR5JkmmW3zT1Tbb9c393HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ4JDzqE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ4JDzqE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1382548b3a.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785345006; x=1785949806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TPVDTrduiuVX4VmCbK7NTqZ/bp707VKiuFKdVexETQI=;
        b=AZ4JDzqEmGHAdX3MScQ97FpZoI5pTUKg8L2UlE5bVD/5gCs9/YI2BzUN7sVi3j8Bg3
         3NHH7GxkrejNQSSHk9HKkKOJLIKlWb2AIaYc8zNtPQiux5muunTTDx1n6OlXRjf80/72
         0ZoDOAJ1PQH9L/l0QAx+wwG1unU1Ho91Ow14Y9MgDAlVX2WbA1hsUarwt5zIC5aMucf+
         w03jLtPbDemxd8bG1itr9VgAX5f01zDKA1wskUy72I1W9McEe1F+dzugKevuKYKvLWJj
         BKGbIWCBN+vHndU7sURuZkydrGobeWHQ7ohqhA0QBN/xNo3SuqWl0vXtI3UhBhZ+USyW
         NnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345006; x=1785949806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPVDTrduiuVX4VmCbK7NTqZ/bp707VKiuFKdVexETQI=;
        b=KowADD/EWrrQ0fLBz5qzYwp/rVpsQRSNMP+cmWN0UOUq/pluiYgw/sko7PQJGc5ruw
         5AeMXd8sCkZrF0FTKeVOWj92MuvU9Q8azjWAAOHcSPzY9HJQ6Aot+Qg7uitYBPg+bPKO
         vSORt1ztbsyc2XqTPSfdEt50aESNYzGwgCSdfINox4BIwya3wpk7whXM1eeduKKCqau3
         PFeEsbmieyer62n/k62FGkneuZp1OUwr1zQCYVxzUNJcIYnTQyn4GCv/fU6ON3goouqP
         3GEgaf6tu3soHxPq2Bsk5hVkANcCCO3+Id8TzS9lE038vD9mNkkLqaP5enNcP2gmU5wa
         LF0A==
X-Gm-Message-State: AOJu0YwqCCw3v/WI/yd/4WUs67HZekfCUSMFxFKZcbhqH1koz3f8E3Ml
	bQ8irYUHNgXMOWp1P+4Luq2XO01PJsevHRS9s8vaEN2CjfwZyZj7iC2FBP2napGk
X-Gm-Gg: AR+sD10oDbiYLR2ryRNQ486VP/G5oB6xH1mKSCayODgd3qmpg7u6XNGPMj9C0yidZIw
	5QK3i+5BsiWNcSJJy/CHsLnSI9y8IuchyUOAhgg4n54sralDMrmg3nWXi5JinaTKE5S3s5k04o/
	9OUHSh2+E/n+1XSjoXBdAk0Ba1cBPS22oOjSXczQYEpDBJZsXgdW0acxO3HN8DKyXC42tm/UDvr
	+GAKNkS9Rhf0JqBVdbYDrlJjcyC3B8z2s7KFqpgGNUdoiiwIuaYY/68jOyAoAlGccHaNVVL+KHC
	WdROjkXmvBt4pqxzJGmaSRn4D629Bbt4SnGatDSyEBcf+P12ZP4H99f3yFqZrd0MfMyT7B0sTCr
	OAMVOMDDTt1lshWY7a/YqieO4iH8yZWeiUqjsYWZKj/tTOW2OCvBK+uTZaXlvwY7mIea3aXACwq
	UJP0Seygdr9JT+XCI2Os4Fta/FaVM+RnyAlXrOVRmbRXvX8tX8/wVfQYj0jvIl/xjMxw==
X-Received: by 2002:a05:6a00:9510:b0:842:614e:cc94 with SMTP id d2e1a72fcca58-84e931f69e4mr8380240b3a.26.1785345005989;
        Wed, 29 Jul 2026 10:10:05 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm1694231b3a.22.2026.07.29.10.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:05 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Input: clean up conditional returns with no effect
Date: Thu, 30 Jul 2026 02:09:32 +0900
Message-ID: <20260729171001.260698-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series cleans up conditional returns where both branches return
the same value, so the check has no effect. The Input patch of the
treewide v1 series [1] is split per driver and posted separately.

Patches 1-2 are generated by the Coccinelle script, which you can
find in v1.

Patch 3 keeps the check in synaptics_i2c_reg_set() and returns 0
explicitly instead, which is the preferred way when there are
multiple failure points.

---
Changes from v1 [1]
- Split patches per driver
- Change base to input/next
- Filter only Input patch
- Return 0 instead of removing the check, as suggested by Dmitry

[1] https://lore.kernel.org/all/20260723184538.3888637-1-ekffu200098@gmail.com/
---

Sang-Heon Jeon (3):
  Input: pmic8xxx-keypad - remove conditional return with no effect
  Input: rmi_smbus - remove conditional return with no effect
  Input: synaptics_i2c - return 0 explicitly on success

 drivers/input/keyboard/pmic8xxx-keypad.c | 8 +-------
 drivers/input/mouse/synaptics_i2c.c      | 2 +-
 drivers/input/rmi4/rmi_smbus.c           | 7 +------
 3 files changed, 3 insertions(+), 14 deletions(-)

-- 
2.43.0

