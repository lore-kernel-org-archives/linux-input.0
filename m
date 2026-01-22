Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF432D061D
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046004; cv=none; b=MQbLNh4eL/1NAq/MHkKQ/uLitoaR3U8zLImkABD+NwoZLo+2VQLjGF83MyW3+/qDvjLDMnTIUFFz4+JqiNCe4v4Q9bpI082MVgbQvnhyDxwgC6Z1ahnBSI0MWwbf6aLIl9u2Ke9ANqHvCKbJ/QuQlsgFLBeem9CGe88y4JgtPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046004; c=relaxed/simple;
	bh=4KJ3wFruns+n+EbwI7XCDhSF8JUhnbAmyhujwBOOj9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uDEKHKE/7w6Gm+zg16iKJVh3NR/13O9LSCKKQ0MnoP1v+7rhPbUnoJHyHOdoaA+8IuwazXytckCG7K4aJvzqWuAiJsKI39Yk1MxNA6/iDMZD/4Z4EIwFe72HrDgx7wPu6cOVtmI1ItZ7VY5zG6j6ef9hyBvEDkLTYOeseP1QGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnjEaNnM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnjEaNnM"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6d76b9145so53174385a.2
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 17:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769046002; x=1769650802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNH2DwvUnQISovvm8DSOPw3COjiVlo/7yDSNxGLRlOU=;
        b=PnjEaNnMh/56jyeeAeO3PFR69q410cKRFSFZOZ8m8+IrtZ0mSHaPyDFM5UZZnAYWUy
         G0o3Mpj7XBgn/IiiKRi78VsxboS5NvaUfWdjj9NDMp6ANgaa53pWnT+jNeF/kWQn5cbp
         mfKH8Joay54FN44XS5892jDiRkzTlrkpR5fSJxgYoyNW/yCaxarvTPHjckW0RlN0tQi4
         PtFpDVDiSLA0MJWBVoLwTCKfOvf35a3EmOlGslblrUY51WezRBeCU5huVLZfhSt4cbPH
         lMJnC8hMtNxwkqDijL4xxGvAtMmHZRwLCzdpdfZDxSJnPUjPku4TnwwKsgQorbd8ttGd
         a8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769046002; x=1769650802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNH2DwvUnQISovvm8DSOPw3COjiVlo/7yDSNxGLRlOU=;
        b=rSBacfy8rTV96vMVD3pS4VeZ7kl4AFwioCLSTRV26DkpBcJkrzd6VxlBiqSMQhiP6R
         xwK9ZRingnZlb21bYph9YpL150Na/9E8zwE4877xgOb3Q8z600laqyTF12X+aeK144x3
         aWNDad0fhN5UXAyKwEjoB20xejpVrOVOQDLZSHIyL11TC5PyLLdwwpCaomt3iqfbu3a0
         APDKIsHcRciLol0uE2pzMyX3X0iZWXCXFwLzT1mdBv8OD+KfFAb3fgZYV1ziUB6D3PHG
         YkoEmbw2q8t3EiOtNRqTOcVPRDW+2t8z6CowLR7A+n4pA108O7n6YtOpbhg2vX18FImQ
         X1lQ==
X-Gm-Message-State: AOJu0Yzpm9aN9AjgUmlrkpJ7qmP5TyM0mTZCikLiqp6IXqMdiXGqAGE/
	Ixva7ZB4YXsDH9oSrKDWzaaSlYjE2wLPBOEIcdBYSnUR0qoG5kEHPCQjuiezbg==
X-Gm-Gg: AZuq6aIoDCP5CWMh+BXmt8930XunsiU7F87nw8tHsT6svE9Rb/rVvTiDoQR+oTWU/0I
	RX4IvSIPrA5M/8M9/+Fhkt2WrYCM6ZMWs2vxj2h1tvfNlkbNRxzMuZc24rfBal7uyku7UKtxeY1
	gBZoTnfpdZJh2LGSUE0yhJ7eSrCuLa8Dkql0B3Q6hyTda5dnE7rUw/8oOl5WKIT0V5aC+zirpMr
	uOHg1gNQJuBMQbtTipUdoiLdLl44k90Fm/cibnMcJTzNUeiTVjyenkTJZbpxlqy5V0ipLxiO4RI
	ZdgxKoJYtZCkem69zpkCx1hSt9/f++r+ycxTEcIelyU/kwrfTP00aAsE7EhteBkpSzRziPjVPGW
	5beitPda/EgbeHAncgCD1Ha4oOCGUG9fc+8+wzpuZbADsABfF9vx2uuXvcD0qL7ETntwsUnaisU
	VOLepsqLGHiQ==
X-Received: by 2002:a05:620a:3186:b0:8b2:e9e1:400f with SMTP id af79cd13be357-8c6ccdab5e1mr913925985a.4.1769046001797;
        Wed, 21 Jan 2026 17:40:01 -0800 (PST)
Received: from jiangbook.. ([64.72.232.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a729543csm1350843885a.48.2026.01.21.17.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 17:40:01 -0800 (PST)
From: feng <alec.jiang@gmail.com>
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	feng <alec.jiang@gmail.com>
Subject: [PATCH] Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA
Date: Wed, 21 Jan 2026 20:39:57 -0500
Message-Id: <20260122013957.11184-1-alec.jiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS Zenbook UX425QA_UM425QA fails to initialize the keyboard after a
cold boot.

A quirk already exists for "ZenBook UX425", but some Zenbooks report "Zenbook" with a lowercase 'b'.
Since DMI matching is case-sensitive, the existing quirk is not applied to these "extra special" Zenbooks.

Testing confirms that this model needs the same quirks as the ZenBook UX425 variants.

Signed-off-by: feng <alec.jiang@gmail.com>
---
 drivers/input/serio/i8042-acpipnpio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 654771275..b34d922a9 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -115,6 +115,16 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
 	},
+	/* ASUS Zenbook UX425QA_UM425QA
+	 * Some Zenbooks report "Zenbook" with a lowercase b.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Zenbook UX425QA_UM425QA"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
+	},
 	{
 		/* ASUS ZenBook UX425UA/QA */
 		.matches = {
-- 
2.34.1

