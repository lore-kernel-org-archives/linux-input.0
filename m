Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014809;
	b=YLNx0mRjWLzxtT8Er+6sGFcufGD+fodIxs+aoQLo2hAQBjAk3eNUp071vE8mdOkMR4Oj
	 i8vl08xbKs9eu9xYdzkMy94VV582QSd4D40DOTZUzKAI26Rsy02DDl2WRRdOyF1EWVunJ
	 Ro9UBRNrsNiTnmVWrKP9G+CXUhT/toNfHjQF9svq/jV5Yg8B96hvEVkMvK6uTrg6PCwTG
	 OLjgiQczc2OxRRR48mivOxzrEbqR0Ry2rBR+Yx1K3071vVHUba5RUKFYOVNEavUnFf0/P
	 MnkNPs1WOFksCfHGINkXCnRLqMED+csnxS3EtGxZRbx1kulB5QcLIyGT862+u1T1j2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wlXk6HYre5osGueEzlFOqp7fwiA8+1yEGjyN3cM9QVU=;
	b=Sgd6A2kk1FvGhtmLKF2PRI34udvMMmppsQiXJ4nmvQD2lBEL2aAz/4OAXUkyFt9l1K4e
	 7QWL5n74zUhOsPMJREW38UeTQglOxjyDW5iYUOecxAdR5MBfX7lve9osH5EAiuWGrGNGD
	 jWR+FV66rZmZe5Qzi99nSrRlP1ywZzFwCOM0crKTVNXaO/D+NG1PC5ssPji30DPYCphgm
	 w3OJU9bnmsvwtnQdgXUNDAEUcLqaPoHFQjvV3B4VDMafJoS6EMG3ivUFvDbsL33hwIv2K
	 Ff19nkdyU6yG80VdqOjgKIFGOXS03KzwNXB+Ene8yPdHDyZpk65NPgLjTff7i8/xDsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhgaWgwd;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84909606A32D
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 01:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84909606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhgaWgwd
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a208d93758so12585615e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794014807; x=1794619607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlXk6HYre5osGueEzlFOqp7fwiA8+1yEGjyN3cM9QVU=;
        b=EhgaWgwdErraFHP2TfEO3j2VLtOc9jTnlpqMvMk9e4xm8Rg3dfkoUOFnStr7CAHL3r
         9ASP/OzoJtz363Fn5iQ3S5HtI7QzGV6U2Kl+R+zSTR0Yq/FbQYSGfYcBg+TayNYjDUVy
         i2grb49jxpLX2BmhxhhPocm1vxflVuDEsfSAGHSzGaJ7kuoJwamRaiBUaafu5Ko/qops
         3QvJ9jATcicC8RJlPQG8d0/xw//LDKWkpqn3iQ1ynFwVHvJFr2OSQeVFhswaaXXNLWJg
         0/XV7SfDdOFZRhmLCbPmA2gzhB38bSnMNWPWjDMn0w5RB7WLrdsryj4kSx+eYHPsZM/l
         PZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794014807; x=1794619607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlXk6HYre5osGueEzlFOqp7fwiA8+1yEGjyN3cM9QVU=;
        b=kTllzAhtE1L7+bcuMdCMHR80Rlkcnw4t2GmbVCrQJT3nTzGW/+4mk5U2Qli5c87LMa
         L4lWnSukm5p5qdFufuJTZ3EXpdGK157rMomoGL0TkI4Sp5zjiBz77ULx6q1VxJ1zgF6s
         bmMI0JWS0Xl5FOSrUBm0aEhkZeVswGuWxc5NZk8O1gLYIFzfjjaUWtIiV5dHhVS0jAT3
         EdF4UWyXrYqpoV8Tx68k7Vqmp9We5NVR6ajrQLOq2EtxG0cokpVWpJksXXyfuYQAZHJn
         oE4/Z0nsLpXtI19tmR7XtRi8lSpHwTT6T9vCRay3sRG4ltTx/kKH19VJ3U6YynTAXpH1
         6TGw==
X-Forwarded-Encrypted: i=1; AKwUvBwlXxU50E+esEHH6ICklAoOjgSq1J2kPeoUVC92erEQ92nWy+HIc2MFsAIewkoAnnkqkjT7KvdMeEFCvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z95ExN1whV8YQBkuPZLQDQiAx62ACPCKGVoIwo/HrtXU3qiey0b
	kZ1PFTZrFfR5V+8u8G4X2X2/KvWdi0N4tlzkIx+1GL/uzZb7kx8/wQvb
X-Gm-Gg: AYBFou1IFemKnvB+yqf5l7F/TBXtXsAfQyED/8mvr0f430NArrILdYHUxj+/4cX36pv
	Dm0N5ueBr/oag68fSPk1zXQ46CHTM/YepT6ooQDXzHlEzXLNCYkz1HTZaARjPXXVUkg1qbrVKYo
	Tp2BDV+ZtGKNm5Nqx9CBOGUuxlWWWeQEwK27mY3lnr47gXG/aOT/LsUYHH3tcLU+0fJ6CklS1p2
	8LqaEbhF758dQIFNbn2HU671o5pgHeqs6ymqVx20dYW4s5xbIIYYbwcCuJsPozHp44t9V8aH5b+
	61SAI5gRDqSef/exNb1VghD5zsDHVnmA8OHBSMXcjx9QPnHXxksm1tMOdWSTLUB1W8uWRAtQ+bd
	pjXPZQAwWE6OzKj/XM0pD/2qx+Q90SZu0GpR3d5pdSUUQ+ELCbR31Zd692y420uwOdYM+/y9knn
	C28qXCVwcPlqQXvr1bvVcDrd9A9XlFuXiOG3NF3lW5dwVmKOubH3VRqMcCL81fSts5L1aYFuiFo
	pIJ0mwpE48PTnCZutlfZqUzMNFthzoo4dWj4aAYlFRok9838sClwB7MSLVGwn4AymFhrDHDQcWX
	P1KrgbgFvFJRGO9YCdJ2sHjaRtaF/FlAF0YUCO7psw==
X-Received: by 2002:a05:600c:3f06:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4b6dc6ded37mr61622705e9.1.1794014806720;
        Fri, 06 Nov 2026 17:26:46 -0800 (PST)
Received: from beelink ([187.13.199.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271abasm22773105e9.4.2026.11.06.17.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:26:46 -0800 (PST)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] HID: wacom: validate battery range before scaling
Date: Fri,  6 Nov 2026 22:26:36 -0300
Message-ID: <20261107012636.1008932-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106213526.3393779-1-qwe.aldo@gmail.com>
References: <20261106213526.3393779-1-qwe.aldo@gmail.com>
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
to [0, 100] as an additional safeguard against out-of-range
percentages.

Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measurements to percentages")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v4:
- Reword commit message: describe clamp as a defensive safeguard
  rather than claiming it handles a specific ADC scenario.  The
  caller already filters out-of-range values.  Code unchanged.

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

