Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19147DD7E
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689976; cv=none; b=BnjfpCnZZAAzt21FLrq44mvUX1ZWjdAy/KMGQZOEtPWbfiEygC+xm95e8g+xvqC4fe28L4BAl5V398/HWRM8dXtqu7Hx8KA9/faLWy1o7w54BVq6T3ifSwTokD3BRAFkXv5YPeIjC6LY0/G0qE3F2Q2rgU4hORN0zAIu9izheOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689976; c=relaxed/simple;
	bh=6m+/GUgVbjbJdJ41gaIzp1LrN9mCDfeJTE++mxH4M9k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEklA4pvZ1hupSFyq+uKGYp+tgVpWyVl+M69+gxd+SZCdZ2wS9EILh9ImmfaCoqquvyUyv3Pns7ZLUhGb4gnDF9EQW82g8cn/LVbdbFf5qR4vAHECuJwQCzdE1d8XIIplrOv/GLIaCVQjh2qqoPY1HsPBtZ9ZOrKpsgxkYYmv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe9QA8Pv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe9QA8Pv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so47789555e9.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689973; x=1779294773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYFmcG5GpEyz682qrb2Jn3HtdpsB54HlsZqG1981YS4=;
        b=Pe9QA8PvNCArFoUU9zjFd5LgY+qW0h1GJaECHqivni5EuToG7U7mmDfNZ8ud5V/b6k
         SjSivLqb8amCDWWwgsmRqdMb0+vVe2CA0j4aw2TGYTREJXKo/oM3g6/wllLazsC+UG+T
         5MNggkIVlBok9d08bj0oEt/MVXz9qPKkFyxJpl0t+PduRLaZVyNes0I8G6fnkf/gL8Cx
         Xn1wIP/nnCsAS2Ph1GIOKUaSEzHdk69SbMowUazcVrfT5P6V7qjJO5g+4DKX6YI8+nEq
         TKGZDK/lUAw0w1pfxVLBeChqhLOrjLaz2f4tVSnssMRvtWPeuJYHK9LJG8x+4aw//Tsf
         gHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689973; x=1779294773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYFmcG5GpEyz682qrb2Jn3HtdpsB54HlsZqG1981YS4=;
        b=c0/euRROXCZg/jpe7kHBq7xPsajzyVbgwnBd11SMnj1afe1YDcSA/9j6XfotP0Ofka
         U8+kEFjkgYg99zkU7DDvZsRXzJPW5/0LmVTn7LKz7IDpZ2dieHe+XUJg+E824+3fkCQw
         bgerR6TS7Oc05hl3v15uF1fjp1oDECrOIgbCe6wYCayh+gwncpjr00KF8NjZaZypMxJN
         GpABUq8kH6YsP/pc0zCtAeAC41gHAeZCVJnVMvx8ENQlh8Sevv10H/3cTe2ZkLFCtL6m
         n16vw9m6oGCySkaSBNabbkZgzFSpSpLb4/3l7aJ8iSokKAUiGI282fyaF6KF02GgZuaA
         KhlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+T0pJacSp7sOc3C0jNvBs3vwtacXVErV61uKW3JM2zytADHsPYm/sxzi/GPlfcP4u7kHqom3hCKQ1lVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YykDH6i2oAyUvsV5Nb5VUbMTWiinqYb8AqSaTQS6YMU3Fwdtymt
	p44CRHcTa/g2BIz/+ufD/itKhFYQIxgl7+yurSg3Ej7zWLI0fpiB+I27V5EXjEWM
X-Gm-Gg: Acq92OEFLxfIWXbkJwwonJ9E10MiPIvuWiyRY3X7sD23Kugzd/xoJ+jsdgWTNHX2Nz9
	OBQuCf9AwSSPOuaZngzBqY9Zp3AatWn896/A4V2Hru/YG17HyxLjcy1jGqCwG4e+EPmAj385Fp7
	Dt1k90Tui6C7/VtL1a3wfwWSFgf3n6kKfPF7IdnMSvdyCRjGdSVFjYkuGn/T4QYCwOq5u/1QbVn
	C+K8A3hc2Qg47lu7KkQSNE2sWGUWU+YLGcTirlb+yqHSWowvL1cMYCxxgsr42jWZ6VZVROakhxE
	xg5+w25IFC6HlYU+KJkgSAvhxa6B5QDzor0EuSbfjhER/KN1J+v9OoOUUwFOUK3bWc/DUu9i2xr
	qcMDBQpG0zPUNDkGoIZ4ORoHNL9infQxCsvGq16Sl3xlPLjnZ9va0YIGMYV9YKsgbBsvBQP7TyH
	KFF7kv36+UO6kb/twz8dfJNXp7+RBU/69MYvtbzK0Mwo8fLjuE3X/nLSN5IruMyxdSQpXsRDKNh
	CWwSpQ=
X-Received: by 2002:a05:600c:c0ca:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48fd6332fccmr2765075e9.2.1778689972658;
        Wed, 13 May 2026 09:32:52 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64b5271sm1976215e9.14.2026.05.13.09.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:52 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 2/7] hid-asus: Add missing Zenbook Duo hotkeys
Date: Wed, 13 May 2026 18:32:43 +0200
Message-ID: <20260513163248.16483-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ce246efba74d3..cba638b19465f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1046,6 +1046,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
 		case 0x7c: asus_map_key_clear(KEY_MICMUTE);		break;
 		case 0x82: asus_map_key_clear(KEY_CAMERA);		break;
+		case 0x86: asus_map_key_clear(KEY_CONTROLPANEL);	break; /* MyASUS */
 		case 0x88: asus_map_key_clear(KEY_RFKILL);			break;
 		case 0xb5: asus_map_key_clear(KEY_CALC);			break;
 		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
@@ -1066,6 +1067,18 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xb3: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Left next aura */
 		case 0x6a: asus_map_key_clear(KEY_F13);		break; /* Screenpad toggle */
 		case 0x4b: asus_map_key_clear(KEY_F14);		break; /* Arrows/Pg-Up/Dn toggle */
+		case 0x9c: asus_map_key_clear(KEY_F19);		break; /* Screen swap */
+
+		/* Mutually exclusive section: Special keys from different devices can
+		 * bind to the same keycodes without concern, as they will never
+		 * conflict.
+		 *
+		 * Note that devices with removable keyboards that connect over a
+		 * standard interface (e.g. Zenbook Duo UX8406 with USB/Bluetooth) do
+		 * not belong in this section, as such keyboards can be connected to
+		 * another ASUS device that also uses this driver for its own keyboard.
+		 */
+		/* ROG Ally */
 		case 0xa5: asus_map_key_clear(KEY_F15);		break; /* ROG Ally left back */
 		case 0xa6: asus_map_key_clear(KEY_F16);		break; /* ROG Ally QAM button */
 		case 0xa7: asus_map_key_clear(KEY_F17);		break; /* ROG Ally ROG long-press */
-- 
2.53.0

