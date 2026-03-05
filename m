Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496F36B07F
	for <linux-input@vger.kernel.org>; Thu,  5 Mar 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710567; cv=none; b=IXOMAjuhL/vA2KuIFmceuqkkJHsE6g8JhOnu0edfXEUuXC1AoFPcyAIj+EjbnfSPGHWJxC9Sp+R7yA8FRFMh2xjycbHQJAuFGjkGDAgYBYWinTCiJHEgRpAI2kv292tt13RsAwPTBffSkQMbUHuQtsc4Ihd7GqWeIBK8j0WWFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710567; c=relaxed/simple;
	bh=bslnI6zzDAblJ6or/5cmZXVJm5WyOHjDwWTu/m0o1fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOETGjZheaVHsvYdzDy9+40YAVtAp9Lgcm0GDVuGUz3/gLc9M6OCho1Ao6Ddmb2P6TcdiPMBl90dzTF9xS7wdJElb1CatTUJ18JeLV2vVHEus827gCtE7HE95wZUXVs25s9ijvM5BkNw/OVJtPZJJLvoXYwRYZma1ZSAkWaFmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnwyEQ43; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnwyEQ43"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7377119453so805521a12.1
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772710565; x=1773315365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyy5fA9H56ek5WkTEHHXIwE3xgEKy4C1ClouQ5oXj9w=;
        b=KnwyEQ439aP4ZAEPEPBFlb6u1DrsxGcA7uvqBiRL5YZ7M4QlPaRmRomENd2iuE6sMq
         GxkV83emPGAUCfob6rrX6NmCyToxzeyVy91FdFIYYdTwgkTfZBPKn2S7vGa9BDoJPRAN
         CLU/zAFLiVOhygDNdbaKnIeG7sRrjDPaysOKtSTGnmlHX/w9zW+M6VcTRmvDHUcE/Tef
         OwtWY7lOCVzuE9QQweTGNCrPSOuliOjrztKVi7+d10cEVsmh1ugH8U7ecKtgZsd6oeMO
         827lwZJqwrvh4DMtyti7+ukgi/IIQvE6xN/EikAGtjkN4NM04WfQSi2GULxMlBiV0RY9
         zCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710565; x=1773315365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyy5fA9H56ek5WkTEHHXIwE3xgEKy4C1ClouQ5oXj9w=;
        b=qRfHqaWJDJeJ94ztiDSCbUQZv5dMufVyWIcvhTxRWnEUKThD64KZj1wEmOb6oH88hn
         jhIrUkTGPXhfgzF1f90rujfnEGmVNoo7VJYFol7/O1eYs6D3ZMCsFRY3owOcnXb62dm/
         yZlY6eiLFfsceTHARZxh21/bqNOmXW+kRhcR5quguE7CCWOpLGBftxYkfXHxb1wgDxrw
         qWnX41nqBoME2PuQL+aOHoebxof8n6YvDN5QsfcsKJ61MVnfL7V4eY/2/k3Z7BIUC/Pk
         b9IqvyzVmJUKmJJaavDOoeRRRoGYfeBUUzGgIT0NWtAPoJ/1pA3Hc9XDzYTo/MrdjPSk
         Ry+g==
X-Forwarded-Encrypted: i=1; AJvYcCWMR3ll9kp0bZJMTU4nt/L+fkOup+VAt+pf8xik9INr+INbxgx6eWh2q9mP+28ZiG0HlHAqCo2XNQAtug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwgRr7FW6Zi+hYfTdG46i5uCzQFLzUNWrfQH/8NOUb/nj70AU
	+ua+W/xtkBZcVBnP85LmSsTzVSpZ1B3sGXAiNXHdBomEiHxfjRXzOAsj
X-Gm-Gg: ATEYQzyoNPy2Ez9DDxjQMqaJ5ym2V7YYl3SfLvAMfaaUDinih01LSb5FrDEMUZ16hgw
	D/8gqtBEImpZRPrd1OUNm8ZwDmNRjs5ez9Yr3BaxlAiVqTD08npJ+pasKOo+d9hCfcmh/nX6iQv
	Sp/Ij/bantLTlTfbADCTA6ILGBzJ0e7QT0uduaad2AsGnO0b8AWq1wO3ejAwZBjFmIjyCfw/dM5
	7YZjuq2/6eIMLMlU10Fe77OQe/k2A/ZBBurAape01RtqngfhKTOFyFTGKWN3s9i6eL3gm9v8V2p
	SqNN2qCLuQ42JgLRvpa0B69aHCbXOwhsBjWMJRRdn6lsPH1UiueK1BIEGEWxOjRY9bf153PgL5K
	ym2YSlTeSM3mXyZJLRXerf9dFCC2owwR67A/HL2xarLT/jZ54qNYw6DFGoLSWwjUUuQJRSa46aa
	SZzSMkgaDAqPdHxdk/9Yox0Xd5BNLdMozvbQ510M8wNrk3NcD84M/OCMzEPlqNdAArYX1+
X-Received: by 2002:a17:902:cec6:b0:2ae:491b:6f8d with SMTP id d9443c01a7336-2ae6ab1e1fcmr57386325ad.39.1772710565364;
        Thu, 05 Mar 2026 03:36:05 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5e1699c9sm78796995ad.10.2026.03.05.03.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:36:04 -0800 (PST)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: javier.carrasco@wolfvision.net,
	hechtb@gmail.com,
	wsa+renesas@sang-engineering.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH 0/2] st1232: Add wakeup-source support
Date: Thu,  5 Mar 2026 18:35:10 +0700
Message-ID: <20260305113512.227269-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

This patch series adds support for using the Sitronix ST1232
touchscreen as a wakeup source on the Armadillo800EVA board.

Patch 1 documents the generic wakeup-source property in the
Devicetree binding for the ST1232 touchscreen controller.

Patch 2 enables the wakeup-source property in the ST1232
touchscreen node for the Armadillo800EVA board, allowing touch
events to wake the system from suspend.

This series depends on the following patch which has been
submitted but not yet merged:

drm: shmobile: Fix blank screen after resume when LCDC is stopped
Link: https://lore.kernel.org/all/20260226054035.30330-1-phucduc.bui@gmail.com/

bui duc phuc (2):
  dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
  arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to
    st1232

 .../bindings/input/touchscreen/sitronix,st1232.yaml          | 5 +++++
 arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts        | 1 +
 2 files changed, 6 insertions(+)

-- 
2.43.0

