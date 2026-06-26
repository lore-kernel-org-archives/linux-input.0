Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA83F7898
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478865; cv=none; b=N/VhtBkVNp9jrdabmu+HRuz9y0Qb/FUdGJrnmIOmV9aYyzhdRfOOxmkphDTmpGou8yHSyDcu/n66doiRshAVPF0eWZ0iDoCxQkTOEjnDV+bRBYGpr5OF7XgW5erfT9f48GiemQEdwhAr/ZjiAe7WRneWSy+Ho9ZTWfe5lHHVNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478865; c=relaxed/simple;
	bh=JkZi4hVDHcCCZsBfm7YqGZn3PdRmgaWziQhFofkbaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eF6W3MboEZ7GMP28mgrxh8G5SEM0TSlJByYZj6eHUIBIVTi+xmrVhejF1Xevl37+MTJZtg0ty87NCC0qIRfPes7+mxEOeIaffOd0YXSMNYB4DwZF4oXlcgSRcQE3/wafHdfhfrCVzwqRVM/5ULRBxV8U9m1YT/YWlYV3AuLnmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/vukIEA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/vukIEA"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso345946a12.0
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782478859; x=1783083659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2YPNBvNuBCeG+eopPMvsfTU3fFLr5zHcu+u5wa7dHw=;
        b=p/vukIEATxgcgNeBVGbI4PRinbNsBdkLpl9WfD9pvtke5e8ivO0vlvyD1Pbu7t+7rK
         hdFt5WgPZsBf6flBIB3RfaXY4lCP8j3gp3Ku6t2ok12BwIDnsFTkOwK25dyS2uYyLib3
         HJtTz28fSgAT29hgrMLujRtcLbaek28g4xBoRXYxmTcIoGPLdeSz7e85SdDePf36+rSQ
         gfXMQxrrHH6N8mOYjmEAZdpg3nia4ZKnEKC/Gl+PNmX2pLUCYVnXB9VLMEA/5gIz0neT
         UXd+ZAId6809LXc+Ra/fkq0Y9hf02KJsz+GJULum6tox6Cybxx366EAcv74zCZlaJg0T
         RL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782478859; x=1783083659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2YPNBvNuBCeG+eopPMvsfTU3fFLr5zHcu+u5wa7dHw=;
        b=hhYSSkK/z5uoLdrfGQCQ6/LO1yPwJPXKPFQJl7F6uaLHI6u3ko4/ylxAfxDdwj6iGI
         Q+Odq1OYQGk2vG27mQjw9v4SjQir5zJB0WXCwmoMtbpCEbpHlAIXsxysxzVeupdnsC5A
         BT4CYhEoCnZ4csZqxxz3cyQaB36axFUKtEqGck0EDEYrmJroqdqEzBPiyjdNqdwNGBgy
         6/tFy5KIE86T1JnUgA7NYYhj3eN4DN/jArFJKX9Rm2qY+ef3k/mFqmTBHYM1l/Zc2s4b
         DngWpDEdbKPZhI8a5oR5eHVzU1G0w93yfK6WAWgh7BN0Y2mx029YJt4Us1XCdlZPRvm9
         EbPA==
X-Gm-Message-State: AOJu0YxUnPyBdEBTzEA+UBf/5damXNEzSn5tDlBoaau1dFCvaI54SrNu
	vbdgCPJnOA9U+WObLd0qThPgkx7ok/15Hn9+DakMIIJ7lL2ZaTaeSONO
X-Gm-Gg: AfdE7cl8/tW0iMuRKm+JQ2+W1dpKRRV8F2ApR3zDzOA2V9ofju2jXmYa9U2Fl+ozgIk
	5yYVh+6zdD4rmFIzPbk5+2Fqn/3ztnAOGDFAr5b/TFtARbqoO/jH8xFOiEP3dnuyXzyWjgAL/KZ
	mmm6PI2NdNGBAcKOvlrzx5WdFi23WUcqzRmz8iM+2aonCYnUFw39aLAh+hShc65i1dtDtH9YM0N
	Jey72sCLu+leorKBfR5w9o/V7yU1PZaxYX8dEkb5HnxrULw3H5HOSBkCQfgeHuhNew+oWvrS6UI
	5gP5OON+narc9e7n3BiIqNh7FwRj5LXzzohnIKo/K0+68cJ6R6MCLTKvxNyCch12ak7V2ezjwzL
	Rk3YItOS/ArFjFJnsmkH4qD8f88R4RIuYwVIpCDl/oOL5qBMkIcmgIMomWTGCtPilFhca24bpY3
	sRBMHX8S+fw5OtErNi9dauRA==
X-Received: by 2002:a05:6a00:94fa:b0:845:c4e3:3c6f with SMTP id d2e1a72fcca58-845d25f045emr293125b3a.36.1782478858992;
        Fri, 26 Jun 2026 06:00:58 -0700 (PDT)
Received: from archlap ([2409:40c2:705c:c67d:dc8e:e453:e08a:4145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c7ecsm7453257b3a.56.2026.06.26.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:00:58 -0700 (PDT)
From: Shashwat Agrawal <shashwatagrawal473@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shashwat Agrawal <shashwatagrawal473@gmail.com>
Subject: [PATCH] Input: synaptics - enable InterTouch on Dell Inspiron 3521
Date: Fri, 26 Jun 2026 18:30:51 +0530
Message-ID: <20260626130051.2574-1-shashwatagrawal473@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synaptics touchpad on Dell Inspiron 3521 (PNP ID DLL0597) advertises
InterTouch / SMBus support, but is not on the SMBus passlist, so the
driver falls back to PS/2 and logs a hint to try
psmouse.synaptics_intertouch=1.

Add DLL0597 to smbus_pnp_ids so InterTouch is enabled automatically on
this model (and other Dells that reuse the same PNP ID).

Hardware: Dell Inc. Inspiron 3521 (board 06RYX8, BIOS A07),
Synaptics fw 8.1 / board id 2382, firmware_id "PNP: DLL0597 PNP0f13".

Signed-off-by: Shashwat Agrawal <shashwatagrawal473@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c70502e24031..2170bbe4c589 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -164,6 +164,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 #ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS
 static const char * const smbus_pnp_ids[] = {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"DLL0597", /* Dell Inspiron 3521 */
 	"DLL060d", /* Dell Precision M3800 */
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
-- 
2.54.0

