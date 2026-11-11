Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380199;
	b=xEcJL42YjlwGdn9z726qr/dmVPIVGeKPchmj1Rv/BPdpJOPNfEOmCvn6+fVkW71UKogu
	 2kjQvdQOIK8uM0w8SvXvyGO8ClGVNiSZSkCpDkhiSvjybH1qQ6KnUgOjmwVWet5T4tjv4
	 zPA1++aNGBAPJ0aqhKC0FN+8WFWZrFDO4qsecMeJv01ef5KHwJT0G4wJ8lxNyvLmRS0FS
	 eBSmxAjR9Qzb4dAdXZFSukdnA01CLr46vpAV0D6ypU5wAn71mQnKKYNxOBH0kZXzkndMw
	 lE+7/lIjeR4d+/Q8Pr8bqeRpOFi1guvdUoAqIjyB3YQeh+tRfWploTZVvMdeKNguGbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4PtICXQgYMF5gi3lR+RueE2sIoPdSSjd+glcQFFLPog=;
	b=ce+ZnieHWZ/b8OKwmUjbrfBi2xiQK2PUaRirVor2FzaMZlBFRG2pkQlmnaUyY1Zwdrlc
	 NjVmjSPdltCyERbTWZYjZei7aTo9dAQCy/UTxD6wYagpGX/aW76aAoEls5dQtkbkQHcqn
	 j+qyYUftvlxh9nyJS9nVY1yzj9P51GmsuK7fJ1aWqS2uV1hf0mMIJK+/KGsJDIV1HDmGV
	 hOnvIxObOxryHrSS7ESXY6E510cUtayxP1qVg8obrcjEc2ZTXcbKDO4oDn4hvhQKDa5Xp
	 LMbhvWFSmTypnqF2HN6LnonSDPH5KT5rXBTl92yDkkObI0Hgw9xTN1bMc8p94aG/Gzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQA9R7gP;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9460A382C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F9460A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQA9R7gP
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1931ff67a29so4165058c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380197; x=1794984997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PtICXQgYMF5gi3lR+RueE2sIoPdSSjd+glcQFFLPog=;
        b=KQA9R7gPgWoq5fnFAXy74KLk14GsFWmhDVpN4+RCIoo6MItoK+p9j7PCe7iJ+pBFwl
         WzvErcP3LauXWLrFZJ5g/VE8O6cMvPEpiJ86rjL4zC+3lKybDwvGA35mJZeoU20Kt1vE
         qoQ1s8Wxlbdl8eYhrkz4gcmNsFD2lTS7eU7P75tVaK6DdDIwdWG3tXF5lu8F2iWC5o6T
         ikhlrbsLvqSD0R4J9HWOoY+kxpZRQxi/wHozKMN7zwAjxYzEW5bvslhtU53sn8/HlPEb
         ieyWfkFjaBbFcA0eM/ZbZ9cHJde2X7yoY3vySesKMe+nfhKt7uEquVCNvO0B3MFmrWsk
         hmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380197; x=1794984997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PtICXQgYMF5gi3lR+RueE2sIoPdSSjd+glcQFFLPog=;
        b=OP0HF8MiaSm30ajqzdHMbzKTCHRgW/DIHBvS0Earf8xJoI7tZ+TD4o2q5HRoo2bpLg
         GclTZI7S2IUe2ZD/HgsvY70xUx9Or1dJXIG2p8Wb4BhlE5G+Mt3QqbOSknxWkYhIhWu9
         kY1CY91dgLYg3QYi6NFPOE3qdixJIuziIdqMMRd48CKqo1J0HBfLv5CI0JeuPWQXAncS
         MFCijd4Luhc6la2fBOJ8UOWoXeGv2a4dQE2V+H8nNtqkjo7Jl1ER2xA6K5nXSGKF0xSu
         x1dk2Fwai8NCkznMXPKThiIeVvS8I68/Q8dwwm4pNLazdvYE3Xj8bVstCPKuVABWgYHb
         Y+Cw==
X-Forwarded-Encrypted: i=1; AL+hErHou1tsV4umTAxYnbGygwGMfFQK8EUA6znx7pvJv4R4NyMd+zwH80EHoN9jfCOHhTiCDHVv1wpD25EDyg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sq+dax/ZNM6sC6G5rr17wwkfU1VTS3y/KJm4Cbrk1E4n2pXkP
	6biZGMthMg7jHFpMtZ1A7RuG+GkvjEKadTSqovxSTlBYOW88URg0n8TE
X-Gm-Gg: AYBFou1CFi/X71f1UYA0ScYehPzMP5o4dxkn7DUAOG/LzvbQ2ed2+1g+YchZ4xGw7yW
	xkVAJYrfXdXMNcDMQAE+tXC61zKJqFlHrIfisAg+72zI1tmiJGCo9ScEolCX7ITdle0dl41Nkq7
	RgtDnuyXX/koJ9pyWjIUCHIgENqHSiL8kQEHEtfoGP5BvrXljV0iDakqzxRnGHc+Z3PkIUDQcWI
	GBjENpqLWx5LcWfoKPnBUabGXKZ3xX7fGtS0qBKj9m9pchmX7elU4/tpfDMnmUhYqIqzcWsbcJY
	NK4DpAmZbSlt/VKizmD8azZcxJ1O5z91Ij29MyOvzxp7e/tSv9ZtNLp2ZWmF93kKH1ewGpXwkvX
	rtJKBfk4hsk6Rab7diwOGSg6XAn8SjNn9dnONFRj95J1x8T8oLZpcPQoD3ebh01StCFCBYaV7FY
	niHpIJJK+lfTBvMnGMZP6CZrtroB5t0x9m4xHlaUNhlV/Z/A2qymypfcqns6krk9oAMpQQ3otYf
	HMfHg4kyvE+HrtxctF5nOvHFgxTpnStG8yl1/OGvgMlRrr0R2kDXS5QqDc77l4DEtKLshYMv6Fy
	Wab+W8cTeL/UgJHvQr36nDUkht96pD5ETYXDKuoxPJBWA0AjPnR1hZp50uDbOL356ysHVUuQoZr
	i/N+uiGiLLUzOBp0WFA==
X-Received: by 2002:a05:7022:5f05:b0:1b3:aee5:20c5 with SMTP id a92af1059eb24-1b3c0318483mr1532305c88.22.1794380197358;
        Tue, 10 Nov 2026 22:56:37 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:36 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:08 -0800
Subject: [PATCH v2 10/33] HID: logitech-hidpp: fix HID++ 1.0 battery
 mileage event parsing
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-10-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

In HID++ 1.0 battery mileage event notifications (register 0x0d), the
register address occupies the sub_id field rather than reg_address, so
the payload bytes start at rawbytes[1] (parameter p0). The driver
previously read capacity from report->rap.params[0] (rawbytes[2]),
extracting parameter p1 instead of the battery mileage percentage.
Additionally, when a change was detected, hidpp10_battery_event()
updated level and status but neglected to update battery.capacity,
leaving capacity frozen and triggering spurious power supply updates on
every subsequent event.

Read capacity from report->rawbytes[1] and store the updated capacity in
hidpp->battery.capacity when changed.

Fixes: 7f7ce2a258b4 ("HID: logitech-hidpp: enable HID++ 1.0 battery reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 16dcd79059d5..0ec2f2fd6dec 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -829,7 +829,7 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 		status = hidpp10_battery_status_map_status(report->rawbytes[2]);
 		break;
 	case HIDPP_REG_BATTERY_MILEAGE:
-		capacity = report->rap.params[0];
+		capacity = report->rawbytes[1];
 		level = hidpp->battery.level;
 		status = hidpp10_battery_mileage_map_status(report->rawbytes[3]);
 		break;
@@ -846,6 +846,7 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 				status == POWER_SUPPLY_STATUS_FULL;
 
 	if (changed) {
+		hidpp->battery.capacity = capacity;
 		hidpp->battery.level = level;
 		hidpp->battery.status = status;
 		if (hidpp->battery.ps)

-- 
2.56.0.542.g3ef89b7020-goog

