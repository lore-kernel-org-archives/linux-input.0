Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000940;
	b=DdWWPU/vYGDoTlSImuL9rwQ5tCxvKNQQaYrdxNuvgZC4BoChUtxHYfy375YY1RJUiPJN
	 e8QEAgdnabgkcnZ88kXQdSHwWB5MdlTyT2JCdkwT9Tj6fURWWQ1SLoO6dZahHa3NLwMvO
	 sIoPNfK/6bXov+47nTlVRNUaiWtpmsPpZPWF4Ffry5fqjjnFXvdP86sz4a+YTHHS9eRze
	 Qseay7ZJ92/nil3jSwQEfW//ri8ut9XeGzdOTjIatgNSP/p6/5JMehxpdQ7VhqcJi0DWd
	 LPh7qFH0nhMpLxg2inXxeAfKzli8+yboAaIOkuVgEGsLwK37I4vyfBY28r7YDqUbm2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wdxh+aljoFBv60+IjwtRPv+nHnuCCpie0lKl0KHTOho=;
	b=dgslKjzJVIDQd6eyVCzDNjUKD/jPP8PHw98OLm47zLm/FA+cHCmHlw968/nVLeF3ZKmy
	 EiFn6tPK/yQCoj0R5WbNFhcuaJKpno2XNrPYBbMP3NzZRG7iehSJnMGh+8avq4lr2PBxr
	 f2nS6AxlwkVJwMmSDu14gcHypWzzNB4lTeAUSlsQO/bLGYkkcnPCFxnJuAQVgugOGKMMz
	 bAnNW16V1zF0xojBaFiDBozMsVqB4rne0W8BFZINOVDQ5IGpcAPrP/NvH5MyDxNS3Hvd/
	 l6DrAS70tlVtZGZM/7d5uMRF2WULIiyXoCqViTXgqIVNNuEYXarEhrsJcfzd9zxgiGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbjcMn5a;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707B606A32F
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 21:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8707B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbjcMn5a
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso1555021a12.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 13:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000939; x=1794605739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdxh+aljoFBv60+IjwtRPv+nHnuCCpie0lKl0KHTOho=;
        b=gbjcMn5aR2wOI66yF8d+3Zdznq6J+xtRck++4A5CylDDKDYFMD1vrtwMjIXwoAMRPV
         7PSHfZM7laJuwt7BTSoG4hK5GtRYoreSBHXcWlz8iwKL/r7Uu52MnMXY3DFwfYz+++Zb
         xgBq+ZQsYZUR450/S94cTt7zKKlZbmAuz8ffMA5RvOpGAPScO3qXhpXLZooh95yq6sRw
         CKM1ybYpMYJP4N8QJT7zS18I8LJMfLiDRTnzEleICPtfBaLVxPkdOg2xUlN0nmcbVuzV
         LIkQI+4Jx5bN2tiTuxUIc4VXa7Qb/xXrc/1xZV7Z+uqC1wAR/YcHSEwrmqdw+mSA8qEy
         7laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000939; x=1794605739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdxh+aljoFBv60+IjwtRPv+nHnuCCpie0lKl0KHTOho=;
        b=eMTnMNgblrWplQX7kjysGPKQ2JTKGyZUhj5PtDLSZXFRDoY9oQyP4+7WNkVL6qaEDV
         VMbM/+PMp2xkDXd13luwV2P1S3R8+U5uc61hwVjuzsPLutM5BqRyu374joaJdDJs6yHw
         8Hw9QsFJdr/AcWOOw8r23kb2SiXMkw7BMq8un/EWcAGlJIcUz8sl4EDEYfb3PYtdZ5G8
         abzqYBYLUPq3d8eFrJl6v6nZBJxkFFPq9djHDDQ2cHfL9yH2YIqCS+e96Yi4rgC54VgF
         Sb1lfkk+wxSeTrmTLEGuFxT57sbibVZebtCW9ylyRERYyEO9C7Y3nwHw2NcoSSohY0UV
         15Pg==
X-Forwarded-Encrypted: i=1; AL+hErGlfP47zToWzgJm3VOkcE/mj7ymoHXQPfuntX9UlKmlWUzqobmkuQFlJxLzYQwAsYRVZJOoD2zpfTT8CQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dWlt6XuibZzvJFtQWnxDO1l1X2a/rAdmUTkH8yq2/Zb7Znxlx
	uAq4CM8LSN4sVipkqprlygCH67hoXpqRrp9H8hy3r1N7jHOyxRpdolj7
X-Gm-Gg: AYBFou27DZum0og4yV3GeL6YO/IOqHEeDaKbubGW5hPcrpjq4vwzK3FqTqdbFKi+hGO
	dM77GF4iNJYSr2BtGkGVjGvcRNko+YPwrCfrf8H+DlksiKn+u+gz2HNlf2CMr/esWQBDLtQSRfB
	Cc8gqgxFRHIw3WgROH7kqQQ+4NvL1CB+yipkqGM540ZvtLJZcHpcki8/ezfGIlwe5Ifdb0NQJUn
	L9hrLXD2g3OyFAW3JJuiNuMhYE5XCwd6gex81cFf83Qnz0MjpwwfAVpDSldssR4jhqzbWSQizse
	oVwFW/AcrMYDo/MoqBAkL1t1rV35Xlzu6iCQedBeB7rfCuM6lA4d2oyGNiZyz0pUTF6ZR/s4Gjc
	PNKaggFz6OybyZi/Fh2tJ3kJe9XzYo1YgMngIU5p/lsly35dGGpXgqBus47nGeLfSP9ffloD6/t
	OiJfTZ2Kzq4RPay9ZtAILtMpEg4vJ13nDq8z8Vtktupmkf7dn34winkN3IkLJJ7rs2MopyUNw3J
	YRUJINLWXd0Xu0bqV6Eozw/TOiIyU+JXy9ksUx4GYRl/yi2LV2IvOU6FgqQYiIl8rtQxvs4nR4O
	z4DDiU0bxY5BOAvSIsxPKA==
X-Received: by 2002:a05:6402:28cc:b0:6b4:5a98:2628 with SMTP id 4fb4d7f45d1cf-6b5977d5c9bmr2608295a12.23.1794000938821;
        Fri, 06 Nov 2026 13:35:38 -0800 (PST)
Received: from beelink ([186.247.78.219])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ad2cd6sm1118836a12.7.2026.11.06.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:35:36 -0800 (PST)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] HID: wacom: validate battery range before scaling
Date: Fri,  6 Nov 2026 18:35:26 -0300
Message-ID: <20261106213526.3393779-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
References: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
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

Battery events divide by the difference between the logical maximum
and minimum without validating the range.  A malformed HID descriptor
with equal limits can therefore trigger a divide-by-zero exception.

Move percentage conversion to a helper that rejects non-positive
ranges and accounts for a nonzero logical minimum.  Clamp the result
to [0, 100] so that hardware whose ADC occasionally reports slightly
beyond its declared limits still registers its battery and updates
capacity normally.

Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measurements to percentages")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Thanks for the feedback, Jason -- you are right, the s64 stuff was
overkill here.  Much simpler this way.

Changes in v3:
- Drop s64 widening and div64_s64 as requested by Jason Gerecke.
  Use __s32 range with a <= 0 guard instead. Keep the clamping.

Changes in v2:
- Clamp the computed percentage to [0, 100] instead of returning
  false, so that slightly out-of-range ADC values do not prevent
  battery registration or silently drop updates.

 drivers/hid/wacom_wac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 361738b..36bab07 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1960,6 +1960,16 @@ static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 	return;
 }
 
+static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32 value)
+{
+	__s32 range = field->logical_maximum - field->logical_minimum;
+
+	if (range <= 0)
+		return 0;
+
+	return clamp_val((value - field->logical_minimum) * 100 / range, 0, 100);
+}
+
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -1973,7 +1983,7 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		}
 		else {
-			value = value * 100 / (field->logical_maximum - field->logical_minimum);
+			value = wacom_wac_battery_percentage(field, value);
 			wacom_wac->hid_data.battery_capacity = value;
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
@@ -1981,7 +1991,7 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
-		value = value * 100 / (field->logical_maximum - field->logical_minimum);
+		value = wacom_wac_battery_percentage(field, value);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
-- 
2.53.0

