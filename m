Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32049B1E2
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327695; cv=none; b=l9EXFrmhvLtbt9xG4RjLNn4+e3aPOwE9+w4roE8MWmI2hNGoKegiTouIazycPOVgq/XZCRQ8QgUul1LDdWmjpuTmrtpn4IP2BMivR50HLF2oaXJRd5TOvP4fp/nNolYjUrahSNMCVwwnKxYEOUwiVexCsBItTszk3iv/OsX0R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327695; c=relaxed/simple;
	bh=JGXECXC6xZr/Eyn43PpFIVXEFthBlTFDxiV67azmVEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8fO8ZB3fusfp10fbZdgGEm3tOwPs+0ax8Hb54+RX9QxFYoIWeuNFWjuahyKXInj5OwbLX/XSJWPf9/rNcamKN1Mx8tfan8Qkmt9KtOhF6yJEmgg6bonASSnnhtt6KH0IpqCsEWz5/D0D7thpIfSETr3zcDUeYuMcgI3maHygyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQrrX12S; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQrrX12S"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso196950b3a.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327691; x=1792932491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBh1W1r4OnuF4Pt6IO/5HABgD5isNR4NzKmXEXpqF8E=;
        b=KQrrX12SO66jkI/AC27cpLAHLSkR7MDA3Zyx0nEfeNVfcrjvCRhU7Ztfw2jlxK+ZDr
         8oXgWzugu7dWcAaCgzpq2nBGuqQPkrpGkU5+YecciRCz8kHKSr3rrVYnC6F/TJLltp06
         OlaKCoDrHz1DPH4bjQkcvPNdrQILnAP8NvnZEfG+j6kkCk2ShK/T7eUCgOC3L6ku2gI/
         H6IyvSm4Oc0WSgc26/VEadLEep4h8RwrSjL4JK7hhPaxHGjTdfORYU20UOgU03+zaGo1
         9GTXr8M0WLEj3LHtj+Ph9mwFxJHC201PXFc/donYznz7kWARrs+8j3OU8DsBY7zFlpeW
         QBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327691; x=1792932491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBh1W1r4OnuF4Pt6IO/5HABgD5isNR4NzKmXEXpqF8E=;
        b=RPuqL4TfoT4Ul8ZQfgTFLxq9JiVKeMuQbu3DXdTScdE9EkC9CJ33IBhRM9rhU4jDB/
         lHPuubiEm1JdqlQoLK4ecjtL94IHVLaRCgxGmd4N0NIpwkP45LLlgDqVY0bEDcJMTUkT
         TBcnU1L5/dBJXe85c0Ikis+bfXhkow9c0GUWba9umHMZDmkdBZdzKXbXJEh+bAGo9Ph6
         h099k9YFl4EytjniQMVXqFEhqp5dxxkvDKxseCPD3iB4QoXrB8rJC3KDV+TbrbBZJbIb
         +C56hgyTONT/QZAJkvgD5il9H4dxxYPsm5sq4Mxd9hdidbLbAEHIYBCGruks1VkgmGA9
         CMsg==
X-Forwarded-Encrypted: i=1; AKwUvBw5Yn/iY6Byb2uf/CkuuY31+02tLPtXAWmHiGNzFAqw4oNC5PB7lf35uQKiK2xucGX9tdGuLhkMxG3rBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJBIAdN0e7obLzSGnPVRMX/x1UvRSfEz7gvZXRPkIm7J2Xp4eR2
	YXX7/9f6RjR/h0aFBB+BQmTXyWI10j/eAAOmhAwHS1XqBitmzwgZph+OqrY4Wg+0
X-Gm-Gg: AYBFou2zqPckPOkvRtB6kB45exGcuZW4rxvmrBTPSgQLnnNqp4CWOIJUsc8j+8ofEx9
	cr8zRqSmEUKkcck3t84E7ODCV8TF6EEFNzb/KTzC+TcpE+r3IVyHwMBwmabKj8ulaj+N93MiMVI
	Fb4GV33NsoJPyQWmIo9rQFjalBs9fSIYoDO/96+R8dG1VEKyz0FXyerUrRoW3h0PsoOSWStgUY2
	2be28i/vWIx/KhftI2S70l9PeJpHSvS97EhMZ7uyXtrQzkhPaXZ6RFz7FK1VagfZN53UkGvRAQZ
	cjGMq1n7fMl9UjztWZJ6nBYSgKY+IvuXHL5Sct2uny+InCGRy2gXK2TpwBmRZlWo4gMWidIWyOv
	YPJBbKeoO4TyoukbVzRFa2rZ+tC3dwloX874GrlcdKzuvYGAcRrrNHji7s1iumO7Db23zhUl/02
	9pz790V8DHXbwRuqLSNpIpZ638nEjcLJjBPlp8D0EPJfa6wV0Pulfx+eLo9Gm8Wk3bFVUr1Tj4G
	tuPHTgmwTGD5uVEcoXmvN0=
X-Received: by 2002:a05:6a21:4c13:b0:3e1:7b85:5a95 with SMTP id adf61e73a8af0-3e2260392c3mr3625358637.28.1792327690991;
        Sun, 18 Oct 2026 05:48:10 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:10 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 3/6] HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
Date: Sun, 18 Oct 2026 21:47:52 +0900
Message-ID: <20261018124755.850888-4-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() uses wacom->pad_input throughout, but pad_input can
be NULL when wacom_setup_pad_input_capabilities() returns -ENODEV during
a successful probe.

Place the guard after the data[0] report-ID check and return 1 so the
report is consumed. Returning 0 would let the caller fall through to
wacom_intuos_inout(), which would misparse the pad packet as a pen
event.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bec8dbec5bc3..65829de86363 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -581,6 +581,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	      data[0] == WACOM_REPORT_CINTIQPAD))
 		return 0;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return 1; /* consume the report to prevent fall-through */
+	}
+
 	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 		buttons = (data[3] << 1) | (data[2] & 0x01);
 		ring1 = data[1];
-- 
2.53.0

