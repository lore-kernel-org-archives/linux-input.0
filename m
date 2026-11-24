Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529614;
	b=Keif7tHZrfRJERnX/u3SulPWA2Wia2ZCg2T6x+MNYsd/F4SXDikhiObTZ1E+IH/IEmCw
	 fsSkWd4vNfy0vfGGXuBydxUbON+hSwpr96K/8IVbtyBIuiPhtSM5BMgJT9Ve0VKcsGk/C
	 4WiQdf31QhUV05QMtzJ8X2b06z4GMGwd1dKabZPWt89LWyWnsxdhOP8KzfikzM9fUBUNR
	 kAEsKmZogrHdyLtfXRNKw0TJTG0fCKdN/jbZ6opj+exl1Vctlja75SXMsz/QcE9gVGimL
	 kmDHfig9qyqkU4sIOZGaebatv8Jxvx1p3mPgXAtIfizvMOciLktWY7/1kuxgj0yAQrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ixFLFM/i9bW9h7edXsUI8gdg/e2EL/RpMHA/CDE/zk=;
	b=QkjNpRJizhYC9GJFPA2L/w/usdgcKb7u87dnTYv/TJ31t7zL2aQhj3da2nH7B0ddZcKJ
	 yB9QMt9/c+8HLe24ySpzvgdGS9wsCV3AtMLyUAMKx/nXhjhHMIJKcal5uVQ9oYur7wq8b
	 4HLj9iKamqG/58SSN5tzhsk4IZwtHwG1PqAMBXOO+7yaU5tZ1LxsPlUA6ANXzHC1CQCBh
	 k/8cCxxZ4INDibCUHLUArwnuSDS+bAGFQGG7+nf1TQEXlwzQSnl20DQfpZylcm+KbFfej
	 WO1/EGq2AKOBGR80kkEuebnWcAN6zhDsmS0dBpMtbpdtVojNkyAg1tsdSk1b1Gpkf2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zyF0tHix;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A0606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 14:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46A0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zyF0tHix
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so41367771fa.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529612; x=1796134412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ixFLFM/i9bW9h7edXsUI8gdg/e2EL/RpMHA/CDE/zk=;
        b=zyF0tHixnUtCbu1mfMZ8qQl4ffQAYp20zBKixTRjw4kYzPyR/YUgW/uU39pY3QxBut
         O2hvzFTAy0rIWNbRPURupNxHbatD1ylWccngjJSjjxJI55t4+iP0QxTd2moAOy9+/KD+
         3MhzH3CVIoxvyDH/jSd6/vc+d6CmaCNClVptDDu2DlD0IHgOWq9pMZAP8v79ZlrDZOkL
         w4hwR00gBEdQEGafmhFsJ0tf87v2SjB/BwOPRn3ISJVWznciwnh05KbeL728OfzUus6m
         yu/JKeV7UYv46fzwRegrx7EMmIv8bRqTyI5IChR5Swwvr7Iua6gLOlBRUzwEwImbK687
         FP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529612; x=1796134412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ixFLFM/i9bW9h7edXsUI8gdg/e2EL/RpMHA/CDE/zk=;
        b=02KXpG2qIvgh12Cv79OpNxcpT7WEPaghfrBLpMCO+/EXbTrjI8DBHwZIMLu5lXsSpH
         08fP/TgwMNXWrt+V+75/6NeRSk8xB4F6Cv3XgWu0xie5QY/8Xp/OO2Wdt3Vv0IIlvLFT
         IUn4V9W1P1XpbFfWrrAOtocy+ZQskAgeyD/bsNMKhk81efGITl6wkB827QQtGjMLKSf0
         /s50feIgHU3JiDw5IAsWEybPlh9CPme4DM5mEGSvViRMx91uimEFmM1yQBauxcyrcYZM
         opAWilrW7EVElr2q62O5T/PillOH9nESl8gEhg7+pPuh5Olk62u+MQrdLglQtP/zedot
         Qtyw==
X-Forwarded-Encrypted: i=1; AL+hErHO/1QV8y5XcY+VUPojcbR5ZEaSwfs0EqDdFyTD2uufqhGgmQFfm+9PMaDxoJaEe1s1+EVr60rK77zEFw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9BLyS7S/L8rmuftTbXY50OGyt0P57fjHp4SlLDeka+GSXpY4f8
	3vQETZ2Wtjho4G3OTTX06YT+XjSlUYCESIRq3xGg7FbcB7WZipaov1yp
X-Gm-Gg: AZFdTZehYHvR1JcM+V203o4zDkd8r9fzpncGlxfHa23V2VwyGKS8EDt6erb2unFgtRA
	ae2OHWsN91QR9myoo/nxFTMT9lS5EW9Z4b+t3ppe/9nlZnyS0dpQ/Lep2dDitACEa0XzHBR3uRx
	x1QUgg3u+VZA/F2dNbUGhgu5CqCMqlpLbclttr5GhcZwWDScTXX+DrRCIEPQyjllZnbvQIGVKkR
	f5UuLP/lPStJkVvqbedozeSrUfnhSF5fO4pDiPPLNU1imVch5Ijs7PpnxQND4CQcJb0vjiw07gy
	j9xqoiFaZVd3629YmIEFnoMqnCWzxESalvEwAX4fCHVOEJmbJ8FT6lLJBw98Lfg9dpr6Mj3zxyg
	xNP7v7YPu+QgGc30aJDmulBSVcYsJGHzR5iFvfhZuHr+yToh27ntQxYHo+2AuXTFTWpuwFgXvz1
	SS0uEzBrnZMUdJaotKDY13SN7bGeqS27Camnb3/iOXMYDntbZ3RpLr0c4UqiExr02WbRvveNsUH
	zdf/EwQwRLV7zWm852dPqcgdbqT7anF4AjnrQn5eqAULmJ0DXh/CcUz8LfEWMRJt8Lp/tS9ptRb
	cqizkP3tkTtZ3OCk
X-Received: by 2002:a2e:a98d:0:b0:3ae:7eee:15d2 with SMTP id 38308e7fff4ca-3ae7fa63ad1mr44716351fa.18.1795529611571;
        Tue, 24 Nov 2026 06:13:31 -0800 (PST)
Received: from pc-i7 ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae80536529sm41169621fa.27.2026.11.24.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:13:31 -0800 (PST)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 1/3] HID: pulsar: keep battery online across RF standby
Date: Tue, 24 Nov 2026 22:13:13 +0800
Message-ID: <20261124141315.6745-1-mapengyu@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wireless mice can enter RF standby and wake on motion without sending a
power event. Reporting ONLINE as 0 when CMD_STATUS indicates that the
mouse is unavailable makes UPower stop polling, so it can miss the
mouse becoming available again.

Report ONLINE as 1 while the receiver is bound so userspace can keep
polling. Keep PRESENT and STATUS tied to battery availability so an
unavailable mouse is reported as absent rather than showing a stale
charging or discharging state.

Fixes: e55cf379e822 ("HID: pulsar: add driver for Pulsar gaming mice")
Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
Changes in v2:
- Keep PRESENT and STATUS tied to battery.available; change only ONLINE.

v1: https://lore.kernel.org/all/20261123141542.8128-1-mapengyu@gmail.com/

 drivers/hid/hid-pulsar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index a1f0dcda92df..86b1050230e9 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -378,9 +378,11 @@ static int battery_get_property(struct power_supply *psy,
 		val->intval = drvdata->battery.voltage * 1000;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
-	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = drvdata->battery.available;
 		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = 1;
+		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 		break;
-- 
2.55.0

