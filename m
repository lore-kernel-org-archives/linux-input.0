Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCC3EC80C
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789310360; cv=none; b=Sepek4i02eDyE1PV7Ueom73qIHZ2EHDL8EXXDhqSbMJXLbRUFCFyZfaBD5IM/ZfX0+JGraAjQDjgmkDVoNUA6/qU2qI+hcXn/z9kfDgo4qxkB6Bld3dbcSVAfXt3uLBh/tnuW1EQfCjuNZ6QgDm9rpJBqJU1is7BYvdrEjziy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789310360; c=relaxed/simple;
	bh=jiMrzmDOfg1nWOBVZ7m2UVnsQM7VW5f1VNF2Ud+H8Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTGEh6/Yr0Ylj8iHAZ/gUJf+N/0Cb1VJHiNPbhGMZLye2r0eGUPN5+v4uGYzLiW2UpnmWi5PhR+eU0ORlG7jpFHJup9ws8QHPDhLPuFJE7Wdi6C6XNrxGuKYknyGFc5MmMhr3JVGnf/Qg7elzzvzQ7D88SwjARbdGzW0Q/L7QhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUxtCzFk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUxtCzFk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd6665a10fso421265ad.1
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789310358; x=1789915158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QV8gjzCfofnh3QCpS/nK9Zmu81UQ7ALKKOBtGf8NykU=;
        b=cUxtCzFkLmq6MFlqJtPpUjAgHRMRTt+4EBAGEr3y4fg4ShlXgcRbqe5QIDX1jGi6Lq
         20CY8MnscPil2KI5hf1g8fE/ifrlr1rGdoapzJzKYAp+y5ZGOUYQLzX0CbyGtU0cjgCS
         l0ovV4LuFLwe/O8rGSwTbozIodOafMBrTj1sswZKYoVyvDbaEuRCFbkxvswcCS3SExUa
         UgEWhUOm4X5xcMg0nfZcGvOx/wFkc5PW2JJ9GgtLlQenmn8T8GV3GEKcfXHSTfxlNVvL
         XnyMt84vNnLxdm+fkdDFgFpxWU22xTWRP1EJRarYEaG1YFVUkSpLA8ZGr9NSozD7JdK1
         2FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789310358; x=1789915158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QV8gjzCfofnh3QCpS/nK9Zmu81UQ7ALKKOBtGf8NykU=;
        b=MrnUJZPKx6j/kS1OLtuaO2TA1HB19MLVCotkWJerI5vwjbH1JMtUq/egzGCUzqS42H
         8mMn108H1ymb7Y6an5J3xxMdEWqd70DEO7eA65NfjFFUfq4aUjUIUPmrCfHPG7Sm2FfT
         jzIjT9HEsxbY0j8Aa5M5BShpikg4tw9nfGcwGHa6AfG/ereMaSKK1MQN5z7FZnRY43W8
         eL4ixpHix+ak09t+2OJAI+1GOgE7P6Nq95dYdImiN8GqSSU3z0eP2ifoHoIL/XklgyYX
         OY3cbbEBvawoyWnKqftTzndpOPWSCdDKuLFm9xNf8K0QJV1BkkKSnTrYQZptZO8g3qMN
         1ahQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGYoSstiYRzDSBTPRUeelfKNuM3mHbKtHCOi/iG8g3CktyhaCtcF47F+fnVnU9dxcBmoqH0p4GT91q2w==@vger.kernel.org
X-Gm-Message-State: AFuF++krSpbQ7IxJf8dO6yGT2oUjSUHesYQPGFFr+gbFRwroKDlsf480
	4/x7GSM7DRFx/v73oPIwYbsrtyHE/kIEdYYCmfc4rtdrVVQF/nI/xYZueHE+ng==
X-Gm-Gg: AYBFou1QCAbwwCeF3dV1HZhifq3hIdK9kKL9RzxGydUtPA9gM6xtVzcxyKUBSFeK6gQ
	n8zMvQbm9I2d3jKQefUyd9dzEr2vO0KVw2NnMUeeiYv9IgR0Q4+etBDeCNUw8fUWXliPXW44ReE
	eClIf2XnJyVc66WZQb5QEU/VJPRAkhGJrwPRoPStdBpEEXgBrIsAmYjrj5b4J2X7IEzjRKCL+qj
	8gZ5vtWKwAYjiFiN4KA5Qrh78vxQcBCiLZDcJr+MvVrMhmtRBN9/PVN/C7XrLjY/vKWXc68N5JR
	oRq44qG0EsNeTWsig6w32uiC0MYPNa4STJwO5kE7crZQgtvUJi7PYiSt8YsF3nxAwI+iwD9DUhr
	KC0fZJuHe5s2vAyRrJUzeRfHSR2xuEfhfsDgD8raF0dlve+KSKvuU4+mP8z/+KcCMPOmRRFYWqS
	aWjajI2fHziS/DWQRLYG/ZtY7D9AYTRm0Kqa406UWRgf83hTwr9Rwu8w==
X-Received: by 2002:a17:90b:4a8d:b0:39d:8222:6436 with SMTP id 98e67ed59e1d1-39d9bd8f51cmr22611245a91.7.1789310358118;
        Sun, 13 Sep 2026 07:39:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bb0119sm16289560a91.2.2026.09.13.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:39:17 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: winwing: remove unpaired hid_hw_close()
Date: Sun, 13 Sep 2026 22:39:09 +0800
Message-ID: <20260913143909.1589019-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

winwing_probe() starts the HID hardware with hid_hw_start(), but never
calls hid_hw_open(). Despite this, winwing_remove() calls
hid_hw_close() before hid_hw_stop().

hid_hw_close() decrements hdev->ll_open_count. Calling it without a
matching hid_hw_open() can therefore underflow the count when there are
no open users, or incorrectly consume an open reference owned by
another HID user. A subsequent legitimate close may then underflow the
count instead.

hid_hw_stop() disconnects the HID users, allowing them to release their
own open references, and is the proper counterpart to hid_hw_start().
Remove the unpaired hid_hw_close() call.

This issue was found by manual code inspection.

Fixes: 42d020b54edc ("HID: winwing: Enable rumble effects")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/hid-winwing.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index 9cd25a77999e..e18728f215ae 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -388,7 +388,6 @@ static void winwing_remove(struct hid_device *hdev)
 	if (data)
 		cancel_work_sync(&data->rumble_work);
 
-	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

