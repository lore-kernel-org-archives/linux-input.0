Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC941DEFC
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329712; cv=none; b=YL6sdH+tGk/hGKNuM+rAM3rosS5G3dUNk3IZKtr6EDPKeKF95nyhHFGSn93cz5xNztHZle8ch6JIISYPq8CiBL+NE0YIkrJwU4Y1o6xacf54+hT10DwNKHVwtQUxQOHBNuyyrbWe9EjhCFKgSYwCke+r5GeGC9IvfSlILFU9ctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329712; c=relaxed/simple;
	bh=qN/s+6+jcOijCDtFH6JXmdzahX8kEL+Jjr26AmwVAsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tV5kDaX3u54jANL6uShXYnEdFoBSroJxchb9+26iGU89M2E8bNSUOEcCF+odBB8RlrlSswfM2f4p2YAyYbSagCyvmBbETnPggF8ioyuqlHY0FtZoXsBles2gxoW+16OUWGUHxlapjAZ3imMllVlqWi0Ap/Ks1FRgFWNCtCAvVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WMdWT1SB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WMdWT1SB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c83474ddso25667225e9.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783329706; x=1783934506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cltteBVJmtERqD1BShUt1QlRDc85wYK0vEFkkroj2sU=;
        b=WMdWT1SBOEczS20HHCRpPaYfeqR7HtVFrhFEH7yjim3pTBbXsXFThQJf5ZMBhuBBsi
         0z0z+MKl+OT4suGTHEsZ9WU4VvdvPAU4gGjOBuQqe0P1CmKdeIuJQ3jK46l0Wse4R72u
         hkEMvfzhEIbmlVpJm9m4glXQR8yajbtyRNK30Hxwhasud4n+kUOiXDNn7fUdAWZGY4v5
         36O8U1dd0aSuS6DZCP0LLLQJXTPi9OPuCpGAIxqjZq1ZYaaY9L0t/n/8+7c2vZYvCvd2
         bNUWvt0v4caGGDgxpNhrT6SgzxnAk3fBKxQtJ/ZsiDgnC3utyQCphN1qABY/m6ouc2SA
         05HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329706; x=1783934506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cltteBVJmtERqD1BShUt1QlRDc85wYK0vEFkkroj2sU=;
        b=iBT5yLLQcUUeGm5gBElUKpRMu5m7onbCLseMKpLqIC+nzzArcm0kDpHE+ODx/AF9O7
         ybl7e/s72Zb7idGVyx57OLN5Jcpda+3Lqurf0o/jQUGOpsro1Thw/2rFiRcoWt+SuE63
         43+hShpDHx4zAE7NXyMT72FLkAsrBq5ivgHe/XpS0Hc/gSCvOsHUBuVN+j9/qvynEZPS
         T4PN5zwXjMgcnjlAE++B58KIN24OBAXFBnpE/2f2EQQJqSfjB2rLWtUrQbDRVAEhjKJ4
         PvMYEZ2MwIOuwwiQzuve48l3mdj1uS5d9q2DKhfEkYGUnTwZ6cQyWeElCF4M2/JGAG3t
         yCkQ==
X-Gm-Message-State: AOJu0YzuIx6tOc4tLOsCWZZxLoEStaHTIlWk4zqw4e9AX+CfuDm/knaG
	RiStlmv358SKnud+mitzaogLARehNGvYWccG9Fzve1j6EZus3UV86LRwuYq3+N7X2c0=
X-Gm-Gg: AfdE7clQ42QlZ+/9Su6cVIc8EgncHAomS7tD3JIOJ42ZcmotoRsx2QFdplWxLF6apC6
	QlkasjV8TMxu1xAbeypVCjILihdlAXfrpqoxXRDEdgeb5e5uciqZ7FG83Ujbt7+TXfphXCPKTAy
	oUKQfc4t6b2/2y3xLcyK2+viA+haV79iUuaqIpDsEPC5m/fEm9zZ04zd/CsYzRKnmPo+DZth3Cw
	I3FxF7TkBpgeehcT09U14a5HBs41rtbLkJ9q1TdSbxsZaZdFk6a7Pq+jd6YHmp0/odMwo286pVc
	F06LdaGX8KpT0LLLAoxhKt0T/1pGgWUI2mteVJB+XZKbXgTJ6oNVnDmma3NZHX4lI2H5dpHBhhd
	g/NijXE6yIckfZ4Pd+YbJP+WeIBOkfe04gxADBJLOzzWF494ARYewqscLfywrDQKsd4w/NVWa8N
	jFZFO4qzmCmVeKlSsZZ//i9tCVMrT1TETP8TSLmlalsxiEBub3i/VsegNFzXUGlNXXylG+dYS4f
	h4G
X-Received: by 2002:a05:600c:314f:b0:493:cfd2:cd06 with SMTP id 5b1f17b1804b1-493d11cef20mr103193855e9.6.1783329706299;
        Mon, 06 Jul 2026 02:21:46 -0700 (PDT)
Received: from localhost (p200300f65f47db0426af56a07ec3b32d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:26af:56a0:7ec3:b32d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493cce040b4sm354497695e9.10.2026.07.06.02.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:21:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] HID: wacom: #include <linux/device-id/hid.h> instead of <linux/mod_devicetable.h>
Date: Mon,  6 Jul 2026 11:21:40 +0200
Message-ID:  <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qN/s+6+jcOijCDtFH6JXmdzahX8kEL+Jjr26AmwVAsg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqS3Ok7ctLxQmgRDocJwq/gsqoOd8c0dFZfANxb aMJvMg/UgCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaktzpAAKCRCPgPtYfRL+ Tmn7CACoxoMBSrS/8y5JexdkPekt1sZKNirnRditFekYJon/Bh+N92yI2W9ttdkVggIQzYNkDiM 7Af2zctQb/mqXIrcwH/A8+8rzwsCn5svGQ5jlnWsMTP+M3E5DrKb1o66LWFhPh4E+aMlUl34+pP 8/BT0dhV9I5jVd3DpHHkEeo0UlNh5BMo3Iq1kw6DpwR/uP0B/Mi0CynPzgx+N3Y7uRlLgYnNTKq pTVSj4UlLa+eDxOK/tivWRTinY3qwKVb+xIj+eLJGiOTVJ7J9xo/Hh1Ar4/1cB4nd9yDiVvuT+k YtHr8jTMGhZvthknL09XdtsJmlhQ6MasZ4MgiqnaJaKAgXLr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The single device-id structure that is used by drivers/hid/wacom.h and
its users (drivers/hid/wacom_sys.c + drivers/hid/wacom_wac.c) is struct
hid_device_id. So #include the much more lightweight
<linux/device-id/hid.h> instead the full <linux/mod_devicetable.h>.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

there is no coordination needed, just make sure to apply it to v7.2-rc2 or
later. So please take it via the hid tree for the next merge window.

Best regards
Uwe

 drivers/hid/wacom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 1deacb4568cb..d2398b1cdbb2 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -82,7 +82,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/device-id/hid.h>
 #include <linux/hid.h>
 #include <linux/kfifo.h>
 #include <linux/leds.h>

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.11.g153666a7d9bb

