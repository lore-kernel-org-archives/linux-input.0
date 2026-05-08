Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0243ECBE2
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247198; cv=none; b=bWA6BnETyVZPG4j14M0tJnCkht3z+MHmsxIV5riPFbnwjV0AEKs5FC4kyZGgw9Hd6RacUNvytZa99tbVYLs5BAqN7H9ANX+P0Fn9Cm/JOpcam6UOskTabSLayAQvM/EKOxSbD2riw5EC+KQW2hvJnQAcfIt6Mft36L64wfH2P08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247198; c=relaxed/simple;
	bh=8n0yehS13iNVaDAZix93kasE52ngYyCUKVYh25E7r34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2DdCOSbkVpZ+rf3LNJ71nDMv/XXHhNX1vUDFiqHIuPeZy69gAEcsypykIBaD0X6TA+uGUWKjaPpdaG4h3BZ1gCTb4H5HFFr4vgwdDtQtSPdznDFLKju+XkiTrSUrdatrFY5hBWjdlVkMU0xajU+Mq5qa+pn5yuxSmSyVXdgrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d33cSOfo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d33cSOfo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366070f71adso1751270a91.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247194; x=1778851994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZd1eUiorRwFr05rMbeKoJFFzjjS7oQqiyJO7dMlyuI=;
        b=d33cSOfoNeMDrnnZMZH3o85QGUXPZwl3oSsBZbu8P2QYcYtj3wZFrqHiU0atDlX4ce
         PCHduBenEFvXPQsCXMvMGSxVLZVNSCAISf6YZ1Y46DQ5sBEZi7qYA057JnUKmpGCG4fH
         +jGjwPoINgTrkerf+E3jGsqDuzgFmxzfawmC8DqGlfDJk22MQU2ipriwnZ8Sg4TRecpX
         HDQhwBi+9svT14sxHy4h9FZzEc3Nt/qZWJgA8i+H4bONkmMg2mlp7+V37m5mc/9U7q6+
         q+v0Tek8/XrugWv0M567hlox6m8kL+0xB8AZo44hjBWyQHamS0JoyIaCG4Abxtg5W0ZL
         iSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247194; x=1778851994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZd1eUiorRwFr05rMbeKoJFFzjjS7oQqiyJO7dMlyuI=;
        b=cSIn6sJpr86YkPoME7n+jSXAoLJoBkmhRNDrkEBifhYoPXFv+HOdTdx08XHQnhtT06
         Q3ux81XZdlmPknYw5K8OZS7yl5W48DG6t+UZe0kx+gqv+ztxQ9kHBgCuiAiZxOSYiMC/
         P2MgF0ASv0Ieh3ndIx6nFolRH8xNO5digU56O78HZwyf8rqL7I1KNrCL3kpV/rkIoHvN
         tL25c6irf8n8LxhGATnnntT/I3ztnE/qlGn7SCac9rPTOvpgSkIv0UEwhWFPeXgcKTAz
         u3hgAUrL0w8N8+axuAmMC9wFjMOLRPMJHdcjJsuA01UP4KlHRD4uW42NMwVGLpvKx6sY
         zNrw==
X-Gm-Message-State: AOJu0YyDemHvYllWECN/5wz0PUWLWjX5T7wGi+CvCn8kJu/X9mGhfM7W
	kNP0SDo2sE3fPh+zVDO0yk+7O4Bh4IUIVhOIpXIWXjL3WzBPh5V1BpWM
X-Gm-Gg: Acq92OErQtpNFrIBO73dyuRBOMbooWVTosA/WrdEHSh+VzICda5qHPZTjSPOPcTMD+m
	JbZrQo/X4/kpjIfJ2SnBRAnQz0UHDktdoTbvZc8oHw6SUA7gmd4XAPMdYRGZVw73AUKGQbEGf9y
	oEa7RCqbeW4nRntFwx5RX8pWPRGwYGTa6AcU6O7aaejwL6d5Bf3kxgWkY4Vv9V+U3ddBoieeo/B
	sx3jvW9F6g3WXQtV+c+bKy7c3ih47GjLUe+VCa7uC9nDj5qJxeDtOfvwIz9AD1vevf8J/oqE62k
	STH5SnItNcieQJ6ewjdt23UyHAXM8QYLZZdzbOdJKnWdOcaz7pl1DI1vwNilkHb92snrbN+y1KK
	YUo715IEfgyZ5EBR3VWVWY8YSbopP0QIr4/y/ig2xkgdrafABqjEuDhHnJ2gBsLcHiA6sanfSPe
	8TpJVYMKcQj3+oo21XUA2RJsffawE=
X-Received: by 2002:a17:90b:4b87:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-365ac76bae1mr13243292a91.24.1778247194322;
        Fri, 08 May 2026 06:33:14 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664d936a44sm2377149a91.0.2026.05.08.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:33:14 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: marcus.folkesson@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH] HID: pxrc: fix slab-out-of-bounds read/write in pxrc_raw_event()
Date: Fri,  8 May 2026 22:33:11 +0900
Message-ID: <20260508133311.3995013-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxrc_raw_event() accesses data[7] without verifying that the buffer is
large enough. A device that sends a report shorter than 8 bytes causes
an out-of-bounds read (priv->dial = data[7]) and an out-of-bounds write
(data[7] = priv->dial) on the report buffer, corrupting adjacent slab
memory.

This can be triggered from userspace via /dev/uhid by creating a virtual
device with VID 0x1781 / PID 0x0898 and sending a short UHID_INPUT2
report.

Add a size check at the top of pxrc_raw_event() to bail out when the
report buffer is shorter than 8 bytes.

Fixes: a2dccedac664 ("HID: pxrc: new driver for PhoenixRC Flight Controller Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 07e20ff6018e..f2524547c7a1 100644
--- a/drivers/hid/hid-pxrc.c
+++ b/drivers/hid/hid-pxrc.c
@@ -53,6 +53,9 @@ static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
 		 u8 *data, int size)
 {
 	struct pxrc_priv *priv = hid_get_drvdata(hdev);
+
+	if (size < 8)
+		return 0;

 	if (priv->alternate)
 		priv->slider = data[7];
--
2.47.0
