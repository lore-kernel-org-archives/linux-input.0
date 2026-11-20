Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164074;
	b=ay1K+LUb33u91f8znzN74BEsvbwPwML+WpIJm/81h3hChsFbm1iVelwPDypkR+3dWNG/
	 njVET9xWMdvUq/Nd1IXtDfeUxNmVhb3LpAjHCFknU6Vn7gOrUy9HlA6hmqISZzq+qWaU4
	 YoBlm8elRhDKa/lbSsElIbDHJH0nlwKA2+LzaIc7tYorC6ayFgW/UMzRS6q2WJAZtfKRD
	 g5N+ImV+3R6UhOqbY4urJVITU2z+NWZ8UnKYK3doV+mOdO/hh7Ro00qV1B7QdmzOYbITt
	 S2TXsNiUYGfjoJCuOcipF9n0Qy1U+74hffjeSAp2lFQWh/lnLAHRiZ/kD/w6UrAFTwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=cgMr5qNlIMfJEblzb0pv0k5MT6Z5DtqCm3U1oEMsFog=;
	b=fI0tgCgwu3T3ui4J25x9PU4oLs81WQEBh9RgaDnPP5vfvd/9qw3W0TxDGfcehaedEIpc
	 pYESqpcJa7lmKP78Un1hVuWkqvgEyHkgOppfaaNHic9suQEopI94hRCFLtVUYNoiWzzDa
	 /l++qHlr1+JelqJeuZk5I+vkgRNnsXhikNOrIhTPbUwAo+vR5/BWE8uIUcEroJ8hWOS9C
	 r3FKHKykgtyRLF7SbefUJqPUlHwkSPvINM39jpsdAQ3RlBb9cPR9lERiu+RjOHYO81r2q
	 PFotGGfuPaxn9aKDi2BNUq+pbU2wrrt++551OkbWBRCCjFyoxdC3C1OkodrCRtmSUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIyoIe78;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589D60A2622
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0589D60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIyoIe78
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-372bdb942dbso825221eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164073; x=1795768873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgMr5qNlIMfJEblzb0pv0k5MT6Z5DtqCm3U1oEMsFog=;
        b=dIyoIe78vmMKmgjI/H1qq/CRdqmVnjiI2Wctq60aJtCFmCkWM6KWmikYWRfJx3VdGe
         b0WLL8wOt1qG25CCSOxCrukPNq1gSOVm4QiHhzXE5/bw8kwgPGNLCGRW0vGiWrI09bwz
         Cv51G/xXzOu8ey1N3patrzhkybZLv9G9cl4Q37BXpcablTrg48/dX/a2ItKBbfOjk9hv
         UIUnp9WfT8WbgzshbujmSyZiO5k5GreQziiu6dhv3HkA+ySKFmBg8Mt/ftMx2bd17NHw
         behbKRSgs4PPZEzlfOvRyGVBgkkj4pTa6fM15H9cFk//A3SiscRvuM79GdyZ4kGYCZXk
         Zz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164073; x=1795768873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgMr5qNlIMfJEblzb0pv0k5MT6Z5DtqCm3U1oEMsFog=;
        b=oqXLRDsm/4/vn9y8gTpIMLv51L8DGTC00LQakLhvs7T4pviPcz2/zBBjI+JUxey32E
         6faoKlpcZula55HQbXloUANuWR/hxTX61ppv4VoGWkts/ZiZ0hg5r2heG8D6Lb7eis3r
         gWVjsPcRnvHpQ+XJ5AIlCwRzAHQ70RBgA3geGjdB/t/b+wWPty0VAAn2Z/02aBV9NJl8
         tqH27cm8x/vFmvgz3PWFZeNMgW5N4VFaaABo9QrlL3JOZPLpiSnTts2Cj7VbZPVHqX4B
         4pteVNwNnzxpMBcsXCDvGqCUA92+eCRdhlw0XD7dmwdu4lf2mY3doMyZbTdD6bLcEkK2
         q+Aw==
X-Forwarded-Encrypted: i=1; AL+hErGm3DKVlEgxOQB3Z6V/qj/M7a02vkIBfOdMHdyRU39wPfTYpluzgwV+kheXBwjScoeVLFQCxFvEwpO0cw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/w0uWhZwx14GYtpG4bkpoJir6OMiZ+zGlcZu6PUCzDKlWvZQ5k
	kvOI6AsA+YtyO9xt8DT1yYnmAAkuT8rrvhFqQOHxy4KgEAkLZ81GaJMu
X-Gm-Gg: AYBFou1cTIzJ+zKB2jBb/TH1D0H75w5Wr6Hc8fxSuhMv4EAZ3lJ60rr8L7N9aIS5J2E
	DtDP87rEEA5BcyveDt4grnvnuFRu7oyrXVY4Vh+egIT+YXnJaDXw9n2djTkIT5TBXWtEkR/nSY5
	2nQ/onOSYmIVojFwMnFmHtyWXsGJYMYx0lO6M4K9VPUY9PSjEduJJxHLAwPkKHBudIPa+GO3zZh
	sfideaCrg5bbalmLClNAYLrPejMeAfWiDMShLGpecg2wiBsugYROajcKAWyzMhRrjw4jHrPeNy/
	bgJBkr5difWmXFvXgcZcIdP2GxBAfganvPWAKvpG4bCXUDSSpaAhTcqt7Hmmz6kGPdFdPE61N5i
	hMrANRQV/6U4J6ppDkq3ppnNlOdM7+QprmJ6yTNYK5XqDyvT1R4rew+OZVwLStsxjPPlOfOV2M+
	UWqDfi6HSa51o+FHUnPEkcLVCJZ1v+K4v8pxVIg2FVCNgwrNDNDixV6FEoj0mIMDFcFXzMe2u06
	fJYnfiRB/wfNb8zLYSNjj9WvET+nmMtc/nj0oT96rxblU5SbAvxV/Xe7eRH6m6cwDGEqcvna1EK
	WfMlVwstGHg5JjY7Wie8yba3rg9HaGGjRuM59Y832+lqf9H2Ss/dD4UowR7WgeQJqNYzHo65Oug
	OeXg9GYSbQqOm5C7CMg==
X-Received: by 2002:a05:693c:4195:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3856f0511fcmr2053564eec.10.1795164073138;
        Fri, 20 Nov 2026 00:41:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:58 -0800
Subject: [PATCH v3 10/14] HID: logitech-hidpp: fix HID++ 1.0 battery
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
Message-Id: <20261120-hid-logitech-hidpp-v3-10-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
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
2.56.1.750.gf70dc682cf-goog

