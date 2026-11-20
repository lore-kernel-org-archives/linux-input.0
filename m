Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164078;
	b=3XXoE+n2dR0HlC8DtG5gOlYjAnW8BxR4h6DtYbqCUEJJ6YLvb/aBoEEZdGJiQUWXZLQz
	 jTbgjdOwrEqhTZCD8Zz9EErMw6d2/YOV2yVxhMnJheZUHkc19vCYBHyBRFXej5+/fVIuW
	 6JZ/kZp3s8JygHGtNi2nLWC411CJw0jmU8a3wfaHfTg9gGAKAKRtS87oDHPzcEgAImF6q
	 00gGRsGWCNEWuv6y7rKrSc1ndw59txoBjMgMaNS5NTH0GaPNpwWTxIFGQulTEDERDZMM9
	 aKIKrDXkPpXAQcViUdS5yHVWH0+c6/IKfvnbE73AIId87hw+tRaObzuRbcCOIHDkcTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vX+acAcyFO4SrtgWaI02zFsEoaqyPYu5s5s/HN5VPPM=;
	b=s4haKBkt05jqLe2/aoaPVdDWKSFNth5csXT8HUBVP+wTA18ZmXrYgzz0eXpqlrOcbktf
	 wOdh/XweE8qpmItVboqYKI34J4SyscOWIQakequbag8elrPgrhUDWlzWYEr+fgsOCjKfV
	 kYx91U7HV6jIL8CO/qPp+KCJObZidQBlhRliuvcKCLHPkGoXMe9Y1dI+A4F47Vu72pYNB
	 31lwxuYAWPV0V5pfuyai+6JmNcPlHrUtxBEiYfbVh+laRloDcnvgblAeYS8pRj+CzSDhU
	 hoJV6aANGDtgqyla+zOYrBp8hZHjBozhJE04mo8x53jrVFTrZo3WYP2hyEdVO4giy9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rd2v0wPd;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42470606A8A4
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42470606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rd2v0wPd
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-380b40319bdso804722eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164077; x=1795768877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vX+acAcyFO4SrtgWaI02zFsEoaqyPYu5s5s/HN5VPPM=;
        b=Rd2v0wPdfwvMv2u0VK501gIGjVDdVP5U/7/e49sNppiED2l1CFH6HT+LgnKGvn3z5N
         tHup6H8TiXYsM30gt/1fJY91iD+QbHOnsBwNAg3UzKGXAaqWIN6GHqXgr/Ft99BsMcD3
         moUcv3/hSUlPTEob4twN4a9qAoyq6orC81eKYFRcGj1D6mOzE/ogsV5MH5IZC0QB11of
         drQOOrU5IXXNhqyehht9bP1z0zJxLkEvhiHHH9lisIj6Sf+4HCN9MPndaMsNILJrgewd
         QsdgDG8fhb/s9Z1IXgFXSjM1P3iCga8KbkXC/hCzygSupEFHWg/+BAibC2rm1Edt5Opc
         QYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164077; x=1795768877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vX+acAcyFO4SrtgWaI02zFsEoaqyPYu5s5s/HN5VPPM=;
        b=awaz4yAFNluPsEkB1jAuNfixj53ZdIlbegjadvy4eIB1rS6CgxJbAbMXJ/Ua86lEQr
         x+2h45xWrTQULvg8OVTOGg/mhcRQuBVMzBdVCmUBBBosbdxn+yYjLnCLbCaiBa6T5rPV
         SBQ6f5ALxHVHUq6xzFSMRd1TrT0KcGZ7fPoYRAcm7NwDWa450twrmciVnf/zD8eHm26C
         bpzgnQcrKRBwC3gfDwl2aX0n9lH2ZcPae7i+SPoy+4EAZPawhfzDHjvO0KuzbGKyYALS
         vhh+8pCi6mlHtvS+VsjBTcz96trv/wqEiof5JSU9KAIcA5Fq0oqZs9NT5T5qNVzIwpsa
         1kwQ==
X-Forwarded-Encrypted: i=1; AL+hErEXrK3hAkTWWsI5q2dvr44rMG0ru2OMox6ysh1+NBpHUHe13mShJ4jDfH+OCRETxHwvxeUm+TX4eVJmQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Nu7X3xEHMOFG2VCr2gzSJMaxvyd5HVr8vSHWScIB4GSH3x/n
	Sw+2noJTuYDDaFNgr/AoeISXmWpDBx4X8puhMINAwrmir4xl0E5xp01x
X-Gm-Gg: AZFdTZcFnYvXPjZ7H0x5UtJXWpj3jCbzN70WsDLyfMxxe1CmfVPhVZgI4HNjxnd359t
	byiSizztf0lnLUjiO6f7i5Kr0ZfXX+uoggp+N7m79gixw4KETBCdTu9jT7dSkPAt0qqjcZP5WMb
	lCrTBwJCluEJU/ZKalcdlFkQQFONDBuqCtaKljPaVicbECvA0O4p9AhDKZh2WqdAkTIFWoLPpfl
	NzQntKRhQskWcR9NYPFgaZCIdIf7eRoRVjezaxehHvrNn1LIN9UpL9cYnVSeXivMX6NyZ2yuiPu
	xlyDnLt/rthmFyVF2vrsQN1Lxzpm296ZyLaM422FpH4A/n8oWWvNXGNx7dj+3jXI+ObJWrh3avL
	K0h5v+8k0RR12GJAt0jodAqvu3Bw43h4tYD4sMXivN+5cnLs0H9cWHJr8gclXCKjJ29aTkKcBFt
	ziUIN2mE4lRUc2fYRzLPxEvnkPEnlQI2ckDpoaxIqd36jlJNZZ+OC8FJ0C0/JJ5nzTyKfsOCTLm
	6JjzgskCvAxVXtKx2gTij2xeepVMyuY8b+beobni9WUO+JIJrc2hxWWp42tPEIsDLY0OnmI6VNs
	/RhvGxV/oL9D5ufr59Doube/W2o8eOM5XPV60bdi/jWYL+xN7XG4C1UM9ZJIVqhjDbbz2UBttGe
	E5ccHKN0TmtslxcFfKw==
X-Received: by 2002:a05:7301:db86:b0:384:d59d:199c with SMTP id 5a478bee46e88-3856c2c3fd0mr1889234eec.1.1795164077449;
        Fri, 20 Nov 2026 00:41:17 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:16 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:41:01 -0800
Subject: [PATCH v3 13/14] HID: logitech-hidpp: fix K750 solar battery
 feature lookup and reconnect
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
Message-Id: <20261120-hid-logitech-hidpp-v3-13-cfe2caa1d0eb@gmail.com>
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

In hidpp_solar_request_battery_event(), the driver checked whether
hidpp->battery.feature_index == 0xff instead of checking
solar_feature_index, causing it to re-query the root feature table
unnecessarily or misidentify whether the solar feature was resolved.

Furthermore, in hidpp_connect_event(), the HIDPP20_BATTERY block lacked
a branch for HIDPP_QUIRK_CLASS_K750, causing wireless reconnects of a
K750 keyboard to fall through to hidpp20_query_battery_info_1000() which
fails because the K750 does not implement feature 0x1000.

Check solar_feature_index in hidpp_solar_request_battery_event() and
re-enable solar battery reporting via the solar request helper on K750
reconnects.

Fixes: 696ecef9b587 ("HID: logitech-hidpp: add support for battery status for the K750")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c960d26a41dd..dbf8f15f5a5b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2122,7 +2122,7 @@ static int hidpp_solar_request_battery_event(struct hidpp_device *hidpp)
 	u8 params[2] = { 1, 1 };
 	int ret;
 
-	if (hidpp->battery.feature_index == 0xff) {
+	if (hidpp->battery.solar_feature_index == 0xff) {
 		ret = hidpp_root_get_feature(hidpp,
 					     HIDPP_PAGE_SOLAR_KEYBOARD,
 					     &hidpp->battery.solar_feature_index);
@@ -4582,7 +4582,9 @@ static void hidpp_connect_event(struct work_struct *work)
 		else
 			hidpp10_query_battery_status(hidpp);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
-		if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
+			hidpp_solar_request_battery_event(hidpp);
+		else if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
 			hidpp20_query_battery_voltage_info(hidpp);
 		else if (hidpp->capabilities & HIDPP_CAPABILITY_UNIFIED_BATTERY)
 			hidpp20_query_battery_info_1004(hidpp);

-- 
2.56.1.750.gf70dc682cf-goog

