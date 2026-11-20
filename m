Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164077;
	b=5XTHyjPzQ5qDkLKh/xcU+THpj7nX1yIJK0Bvm7O8BF/IBzm8LFUhcy8CUvgwD/XcUVLy
	 Mijmx382B0L7CuDtOdYXpKbLwXsRib4A0binBJwfAMpMnAUT56PiiQ0X6xT7r/o/2Jq23
	 l3wmhCdNAR1OcNwGx+Wh919TbNNeoMUfMQnwS7GoGrs0o9b3RZW73oShbwV3LnMIepxFB
	 HgT+XPcTU3doyEbh/zg0Q96+vsaqhzk+1WpPpY8yQte0+PrBKzOOxBp6l6W/zW57fXTPF
	 arkd+HXSS/o/QC/isGonurFeOAlJX1KeZXHWmrKwKIJc8p/QHT9TiBTzNWMznjHiWPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eakGv17JCMk0nAPgz+YpjcrUUEGyOYJEafBX4gfQmKo=;
	b=w+9aIfOob5ZgXDcc2ZutMvmCFuW1plIbMR5R6q0er15F680VJdyWGIKEuuzLVW7NIyXj
	 98Jt0yitauhtBkmuXfMdZ3LmiSat4fhOnq3jPgKH/+h4pLpxQrkC7d069uTE+YmuYBXSu
	 mNY6CJWqn0TqMjhbXeQKUuEuTJQdqVMXTfcmhaI474p2KL2ipHB4ub40kGE1wgVnGNvLz
	 hVO/ex42ypXm+NvvOusau2a+EQfHRKZw3qmOLKjHmYZ0kXBU5sT6W66fmzDp1Kst/4BKx
	 qN/Ec2HiA9Kh1zj1iv7l6R5x+12ASKJkFOZOpUOZd8zaLHgZmtNZc2e+XguUY/J8dow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bdPYE9ai;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50F606A331
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC50F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bdPYE9ai
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a315ed211so689238eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164076; x=1795768876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eakGv17JCMk0nAPgz+YpjcrUUEGyOYJEafBX4gfQmKo=;
        b=bdPYE9aiVRydFu3htQdbcm3SSeRg0s2d487qMGOc21hs/5ORfzVPIBeDeOnIUNEqLa
         WOOTe+7dTC7wLN7x7RPOWn3uuo8JkVtSCFyRbOPm0ElgnC0UhCdecYj1nQqnw3PPf/tQ
         1bVx7tuQNZbFDQsbgQnjXasdmUkQvV8lY57sNmkc1JRVy9QT2u8wmzmUzINNDGuRmXyw
         TuXeDDLzPfSz7VUHyzP3VUtl31Sx6s+289t678najQ2deQ7ZfndQ9PpGVZw3qHmQtDZu
         EECjGd4CzFALSP/OzgCQxT2SQXwLo8ItSefNfaDanU7Gz/pBmN+1zAZUTKA8nOabRWds
         Y7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164076; x=1795768876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eakGv17JCMk0nAPgz+YpjcrUUEGyOYJEafBX4gfQmKo=;
        b=jNZDONvBiXvwhRSEnQjyv76UIfw0e5hhUS0u7tWVt8W1mX8dvb441BJ2EvvkQGwnjV
         SbwVVpjuUBuPf56NOIxrr0+Uy9mxxIQ/B1fPL5M9WQqQkdIjp70pvoV2aA7lZHCtckni
         8HMAe8F1TD8bkcLsMV9gYJ8cnA//9sSmbCZiQXevQfITwM+LrTzXa3kAdm6VZkVEzDBe
         LVTfcf2+kF5wQMz5AxPCQfkWB4+eF79TzBwI6fWCJ92XgOioralKpaHcuxCDQo8GQRgQ
         ULeY31wht3sksYnYDlOTkcp01qoNkzxwm0tCk394Fk12IW51cqmc6Vr1hkiYnNwVvFWZ
         H8uQ==
X-Forwarded-Encrypted: i=1; AL+hErF63U9PsZ58up9lUWlZAqZgxLCbvr7jHWI8h3IqjI16DJVHJGBii/y3rIhNiS7Y2OTaWK+wzg1UsOCxxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gYB2fmF024tBtLJS2Zo/BlsHvNTXSsuPFdFgLEP6uN55z+gK6
	xTsLiKA29giACYZTAQHIy1Cq9RSn1xVhNmGIIgfMemm215FfbSbYOGxn
X-Gm-Gg: AZFdTZdDnbjieK/RXYZFoZknLsHB+ZyePWHSONfLxJQry2VvacKQu4RRAVYxrCBJ8Jr
	f/WFh+7IvJ9HhXrBh1ca/cbzTeUxX2yO4GLZuehrefxJlF4XwwpnQwpannCp3gz7GQefxyWs1qk
	Umj5rX0c7epqDfrmJALPajRTQZ2OOQh8i9CGaCjqa8AK0OdKS6IZcwX0f+Aqy/8t+86q6pKEv/8
	4zpCCfHzffDalklHmcxs0ajtlXUqhwkPEOS16E4rqS8O2c7gOriVODTXpbJB8nbLqyPm29n9GEF
	QIFsy7FOp3cqf4Apr6CQ/B2kfBmqmMNzlLYsyNDVwVMbmSrsDN1jjkHh2shkn9ENngyodmGpqwE
	3VwroxhTv7RZrltJz7swzfaw9lN6GuGA82ilN6BSVDPxRe/mTs8upGBhz/arfD5VUj5DiC9+ysH
	irAvxCdntG/20XQJrkBRhgkzYSUg3CzacrVmLjOgTVZyBlalkWiQioIsowG8xJVMg0cVa99rubW
	4zZ0WVNr5UPWbr2XC0+wB7qSCett8bUOyAyjesmA6d7be8IcWul86mEfE7dYX4EVhb19qaz2X0M
	EL/1X2gmC+TJPPw07OHkoRaZDidoQl52LxdqZzioo0TIn3F9y0lf4/JEOQmWYC9U/J6hL5gh4QW
	GQeIbJb+RhtMGA7gp4Q==
X-Received: by 2002:a05:693c:414c:10b0:37a:15c:b8c5 with SMTP id 5a478bee46e88-384b11ebf27mr4053020eec.2.1795164076070;
        Fri, 20 Nov 2026 00:41:16 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:15 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:41:00 -0800
Subject: [PATCH v3 12/14] HID: logitech-hidpp: mark device online on
 unified battery 0x1004 events
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
Message-Id: <20261120-hid-logitech-hidpp-v3-12-cfe2caa1d0eb@gmail.com>
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

When a wireless device disconnects, its battery state is marked offline.
However, when the device reconnects and sends an unsolicited unified
battery status event (feature 0x1004), hidpp20_battery_event_1004()
never updated hidpp->battery.online to true and did not include the
online state in the changed check.

As a result, sysfs POWER_SUPPLY_PROP_ONLINE stayed 0, power supply
listeners were not notified of the online transition, and the 0 to 1
online transition check in hidpp_raw_hidpp_event() failed to schedule
reset_hi_res_work to reconfigure high-resolution scrolling on reconnect.

Furthermore, both feature 0x1000 and feature 0x1004 share the same
hidpp->battery.feature_index, event ID 0x00, and return 0 from their
event handlers. Because hidpp_raw_hidpp_event() previously called both
handlers unconditionally, an event on a 0x1000 device also matched
hidpp20_battery_event_1004(), corrupting the online state and decoded
battery status.

Include !hidpp->battery.online in the changed check and mark
hidpp->battery.online true when receiving a 0x1004 status event.
Gate the event dispatch in hidpp_raw_hidpp_event() on
HIDPP_CAPABILITY_UNIFIED_BATTERY so 0x1000 and 0x1004 events are routed
to their respective handlers.

Fixes: e037acf0b1ae ("HID: logitech-hidpp: add support for Unified Battery (1004) feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 28402baf04fb..c960d26a41dd 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1761,12 +1761,15 @@ static int hidpp20_battery_event_1004(struct hidpp_device *hidpp,
 	status = hidpp20_unifiedbattery_map_status(hidpp, params[2], params[3]);
 	level = hidpp20_unifiedbattery_map_level(hidpp, params[1]);
 
-	changed = status != hidpp->battery.status ||
+	changed = !hidpp->battery.online ||
+		  status != hidpp->battery.status ||
 		  (state_of_charge != hidpp->battery.capacity &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE) ||
 		  (level != hidpp->battery.level &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS);
 
+	hidpp->battery.online = true;
+
 	if (changed) {
 		hidpp->battery.capacity = state_of_charge;
 		hidpp->battery.status = status;
@@ -4200,10 +4203,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 
 	last_online = hidpp->battery.online;
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
-		ret = hidpp20_battery_event_1000(hidpp, data, size);
-		if (ret != 0)
-			return ret;
-		ret = hidpp20_battery_event_1004(hidpp, data, size);
+		if (hidpp->capabilities & HIDPP_CAPABILITY_UNIFIED_BATTERY)
+			ret = hidpp20_battery_event_1004(hidpp, data, size);
+		else
+			ret = hidpp20_battery_event_1000(hidpp, data, size);
 		if (ret != 0)
 			return ret;
 		ret = hidpp_solar_battery_event(hidpp, data, size);

-- 
2.56.1.750.gf70dc682cf-goog

