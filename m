Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380204;
	b=ZCaoGHqFP/AKoOkimlp8wB4B+9MKx+SKG6rojB+iUHq6i4o/msSuoYbRE5COx/Hv/QNf
	 NswhjAF6nqduT75n9/BrMFEcu4PiVSKkyZDA3xjd3d5vXdHFpq+06QoBaEkEAarQqQczj
	 9mKrEn2BMVATyEk58GS4fzEq63qXXdh5Bu8T12UxLaUU5a432CB/d/8uS61N1qiiUgR2Z
	 3enUbvum9uq7l0hvfGlWCoIA3zEg8tKUrkxVT+ioz2H21sOGkCB1NSylEutuKOw6QBlQP
	 QEdLN0d/IlP4UrFamYEd5KZGWhnVCa/Ox3ojwZ/0/aFblXZzkS8Y1MNYkR8A0buW0jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=s142rQGIYqwFuKUkekSLUqq2un/ylJfkIxejVPS7Jqg=;
	b=GgOxm5T06YfNvsGIGRDiC3ozQlu5Qmrv7uWB38uEm3IL1++rtBFBUW2nSbj87QwIeKiL
	 ESP/f0qJEInA8e19jmSQfm8Y7DQWMkw46tJkOCZ8DBNAlcPNCPvSOgaVISTjhkRrEfo4O
	 qUwWWVql/fvGH36MqQpn0GHHA0WcXv0xL5xgdD5vFkeEY607X1uJtlyOMdpw2Q1Oj5IA9
	 cGhmOr2IPE+jzZBJ3VENx50F23624F8+SVLWmPw9OLQ0ca22VApi6lS1WFAP4cDVM5jB/
	 z1kz42SxtfIsaKoIX3qBpG1kF+MHLiVB/N1bNNazmu3ow4ntmNg5BkLkeSxCJnM+aaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv6oAtCV;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F060A6F5B
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80F060A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv6oAtCV
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so4894417c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380203; x=1794985003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s142rQGIYqwFuKUkekSLUqq2un/ylJfkIxejVPS7Jqg=;
        b=Jv6oAtCVj+V0OSEebtHUvH7w1tD2PVnjPhlkv+6C6YHxE9JtzJgPnXBEate9YhmSTm
         XXBJCttF+EVZZOcLor92H9uk4QI0X4I6DbkadxKU+zPhjIISmVwzCU9nl1MFO/q76BsX
         m8nVl3qY8Dj0tDi0ZbIyeKef/1rztkeMkspKt+62Eu9OOL0pSfzP4vAhjBgyi5m9lYCG
         h0p2qCf6rHmHJkZU3i+ae4zEfXTOvr+6S2W0xCsfPV3VchXQyIsdshSA7HSkkmAOONR1
         oB0Yfwq0Q3jTOwVHroCiAPEkAHXDBF1P0MtuRHRwgPKd3nOPFUf4JqJrnwHRjpUa/5TF
         KKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380203; x=1794985003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s142rQGIYqwFuKUkekSLUqq2un/ylJfkIxejVPS7Jqg=;
        b=JNpgUScDnytoyhmmFkFNwkbu4xLzddkdP1+na6BMfuQDNLsYi48AQNjOTPpnGpoeR+
         PTTtX7J+3S9oQGCyraGg8m35omJgdqQN7jt+GEbjzuEkBHO+UI3KwR8WLp0SykvRphcB
         N1RLO2/5K7ZBrZcGMJfv6yMAdym+kXh7dYB6YKwSVnjaFYs5VGSjjKzAmJaV9qDWiCAu
         VlEpJtVfZbdC26mnRLtRDFXcMQLjfiA7csGWHyMErIebTRo/Y4uhnN5U8owmqFlQmkJ3
         9lrnDpOjznkwHSm6bwWw+8TB9GfVDk1nTgEZRVn862mDnJmpts/QoTwgq1B8DEoTllV9
         9ihg==
X-Forwarded-Encrypted: i=1; AL+hErEgwaHPXqLkRoBA09dohbSVORw0I9wvxLAE2gNa90hI0O+tAntNKBDegwK3N+phYvSunUWWD97z19UzQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QxhkZntoayJ4/Kc3AoIdN10bMh21ziJ+rXcf9D9IJ0LDV/yVr
	+U693nYy7zQt8GBLgJVK0Uike+VHb2ZLXEnFGyODTdhwbRU0e16dO9IE
X-Gm-Gg: AYBFou39j0hQQvsI723OVJyDt2/nOx6hsObgwProKPQY+BQ3xI29Bm7GVn0c49adtHb
	nEFmTBV1qt3GR/hSM/1gbh5vMxAzqwm8B7dPi1+dW8Y4e/bFEeRbuzyoUk3gsKFf0jNz89pkN/d
	jYERpvJa/k3mDHKU+tQW55QtzHFfWBt7E+tHXkpO0YVCa7zM57X81NWZ5Y0NQEQLH297zE7oKr+
	2c7TcXPyDw3jYVoQiNlcZjRTFh6SX44k9LIc6015r8iggzXW8yKJEnSor5I8FiNzpEp6gQdzWef
	5nn8QlGanA0QbZOyyDvhxkWjsUMfbUnIjSipWlVvc1Gs55J34wVLNs0tv0Y6Ghn3QUzFG2Ru5Jj
	+a3Tq6YVYenuj94un+cgjZfpVRaQ3zp9qu1tA5co3N/cwfZx++jbhYcm9iJK7N9KTqpP+6ePEF6
	nD8MSWsOki8wA8lqkfptjOTcgnRWjeVaIjdwNNLihzjoydxqLTOQ4MfE433kI8wMifyHGIKfdQ8
	G3PF/2F4EUaK4dBDRsRbw3CpVGqskYlvls+nnNUOFzHme7vO0rvZiDnlSv/8EzreU8IB62vkAp7
	jByXqMU/jC7Mrb9ejn9Bs3APvdvR7C9sfiKJgkzHd91SPw+QqQwD4PkcgWGJ8UvuWynIbIt3wB4
	We5EGN7kst7UFiHVYHg==
X-Received: by 2002:a05:7022:f519:b0:1ab:faad:cba with SMTP id a92af1059eb24-1b3c034e284mr1319869c88.34.1794380202584;
        Tue, 10 Nov 2026 22:56:42 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:41 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:11 -0800
Subject: [PATCH v2 13/33] HID: logitech-hidpp: fix K750 solar battery
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
Message-Id: <20261110-hid-logitech-hidpp-v2-13-30743e91d83b@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f717f0308454..cdeb1b3c2f21 100644
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
2.56.0.542.g3ef89b7020-goog

