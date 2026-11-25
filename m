Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591337;
	b=ldZg+cPhVUxVBNNsgP4rwxWcFx2LRbkMYtDXGG831w8ZFGbp5WSNn5fcY3K1ZGVyHWKc
	 5zyTXafqvwiO4xlVy/L4ewd7XvtYbTxaxOPw0CXpxJcio3x7GG6IiA6gQ00tZIvTZL+kc
	 Js7NeKMHSpvMJJLJ2eTO3yEw7y5ho66M243YGP3P1gnTU/2+gDrKwjJ0DQRT64Qu1IlnI
	 fUWzuEbUVAWp1GHtEvPiZxFl/RlkX9MiHwTGNzp/f+k9pAkXQe5CgWivkmbQAEcsPh4+A
	 8OsCqqaLJFvXk8a/Fw5zbZn/vqIc8NkDUC2J46hH6qcBaEzbglYF9nmecF3Wdn+zQSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=LbHGa8CBMSDhFNcKDxCWCxCZ3Wso/asSCKUZeVJskNI=;
	b=K0Yyh43JDsOhTQm7eqEcSmbO1Ja+QdHmDktaiAv8GjqKljddzQlC9OyVpSyvbv9P/yiR
	 IP8UkVkgazG7hlFKFcIRK8oS/WQP3yAWuambcwM0mpoQQM5JGO3bLpKN2oLWxakOxe7yG
	 UIwCW4Q2OSJrHYATj7zbXQjxNiQ2IGihtISfMGBIBWRMM7QFHv37zEq/yi7NjvWo+VUHq
	 fut2ZWG4hN5nKzdr9V3s/tsAqgUMU4byGrYa6VaYDaoLj7sg7fwSaKJ0mh4hewf6Yv+M1
	 cuREttBqbiSoOBWJST6I6uEFzEuI/Y2qn5r1qfn4NIVs7Vax5KlhA5de4H/pYpsvjcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UJ+JuWzJ;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54155606A323
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54155606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UJ+JuWzJ
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so46274175e9.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591336; x=1796196136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbHGa8CBMSDhFNcKDxCWCxCZ3Wso/asSCKUZeVJskNI=;
        b=UJ+JuWzJ6WgsYYDpxssK4m5o9I4QVyYGynPtLjvWIO97VBhTcrckE49VY6jyxo3w6K
         RMUMwRXtPyW1yemCOLroeaihwvqhXINbsXY6ddGX8DAM2qhhOObbwXZu/d5nDf5dNGgT
         8L8kR1e/k4tjyfluA+za3Og2aR4ZVX6y1q6DwA+XtvbDWrvn8nbmd3Z15VigDKwPerdz
         xG1wbAdnQowGDNeDmLEFtYpWbwxPstdgOkvYo3vfy36GE3sUqmcfbQsAEp/x6pHJHCah
         hVXc4NQ+ySL1W4DuXv1YK4xxXIehVr0XptLuY0xIPg7xtp0dptq7xWOUrI8Uh2Gg2PQO
         djlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591336; x=1796196136;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbHGa8CBMSDhFNcKDxCWCxCZ3Wso/asSCKUZeVJskNI=;
        b=qaIDIsm9BORLbMlJlvlG2XqZa/uMAgKsmyGxC+Kjm/MfDrAmyMuWcT5i/MMKFJDcab
         qV0Kx7+MG+r13TjPP6nIMzSmg7m3XRiEbdJbO3UefaFHgyZhMms57+c8fxAvNeBjg+u3
         V/evbdq0GB9r6zyaQyZNR5ypLZhq+yuuKp30/I7+lrpgZQBCmhGvJBAFiaI03nQHs6bS
         NyjhaEQtofrR0VrscBi7A/PyWWMVu5GJWLPgAJ0E6BL0m6Djyqitl7x4uI2vXG7MC8hC
         Vw28N8PZIpL2tqpA7yI4hHeDVG9GeM8MXU3+Syhk/Cq/VnpyPMZWmc+ILib4CgTQfQHG
         t+Xw==
X-Gm-Message-State: APuU4Z+59kqHxPOGvi4Z8WyhTJK9tjei11ONIr/u8xVsjBdZaBoy1Kay
	NrgXVgDO+N7fXJoWRzyIyijSpCYpe95yyPYaTsAfFaUqrFAI/9Yg1jNdQBvekATmrP8=
X-Gm-Gg: AZFdTZdv7Oz+oco/icSlXG2yRSvIcmU+g8E+kVfWlry4DkrIRQS2U6hy8omCjTafyI9
	g4NzPo1iWb1xxpKBzx9j4dDlUF3iiV2PlkWrdWHNecW8y8Pp1rPVyNNIxeFx415w/UT8fx3rGwg
	Xv/UuD+/O6hNWaMwXnYfLutBWTWZ8Ob2RHJJMSGCRToYEPbZUMz3CqoPFuLNXsVyLBSp2DKxI5c
	T4SkcEvznj1lYz5Z4d7O9uVy7tVtadZgSbLv13hGxDNTrdBKbTLF4sZtc9SJM7IUW+PrSJQ3x8n
	SF14TbfVNatI1T18aYmCeGpeP5bn9Q/S1Nz3/bWTcuTGOFqJWp3VlKZiC/xObn7sYTG38v5YWs3
	FfiLuRSaH6F3ewXzy3j+w5Nbb/wk/581Svl98AxRn9qLZ/00LcqUPNbye4JkdQs/Ush5cjOaeuu
	++rDZ78oL8bpB7RK94qOSwHFi0BoprexB2rqj33WUdN0QQnah3VYql2kAbU0RXPIvBRHS5RBAUU
	W862v2ukAC7HdV1bdkZHW+1ypJbnMG3MyiEuWOa+AUUfCXov+hwNpGW/buwjr0KdEsD9mKuNb1G
	B9xkatl48hqY1vCEUHRZqA7Il7HOPKa000w=
X-Received: by 2002:a05:600c:4e0b:b0:4bb:68f1:5bc0 with SMTP id 5b1f17b1804b1-4bb88920967mr341061195e9.33.1795591335675;
        Tue, 24 Nov 2026 23:22:15 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6a67f281sm30603434f8f.22.2026.11.24.23.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:15 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 3/9] HID: input: Use designated initializer for hid_device_id
Date: Wed, 25 Nov 2026 08:21:35 +0100
Message-ID:  <0c3d37fd0698a6df732502400520f3d1f67b0780.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6039; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WDPoAMHMGepy2iME5YW0cmcs6WVm52ZbwJsErqnUzUA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBoyDpawRIlRSI1EV7J2eCGoRcbOKkZiC7iY4y cty7nScJOiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMgwAKCRCPgPtYfRL+ TrqEB/9rDBI9fXJmNY1q+JVkIG1ckcY/9OUIkmD9jJhLqDOq8okhD/lmB+w2kgvTVRRuvhzW1A/ EROa87xfi1UdnW2UyEuAWnCHDw7UNQIA9JiqxMznxWns1x13vuh33l84aEYwSaXih+/BGUXFplJ H+5tCf7Cjg5fG8ma/5m8+OlI8zryIo0j0unllIvrN6oRtD+flGSIyF8bLIVjH1vX5RIKMCBGQd3 vNDy7JsjtH9TP29wHiI1YDOEOhV91u6jqrz9PXzzJqzvhK3I/ATm7167Zo9WoXMkUot96cXDR0p xCbFx1huDasuF8Cn4BtJRthh0XcKYBFKjtpabNFFhk8A0QhG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct hid_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hid/hid-input.c | 114 ++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 80cdd2f2beff..f588195ae39b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -358,56 +358,78 @@ static enum power_supply_property hidinput_battery_props[] = {
 #define HID_BATTERY_QUIRK_DYNAMIC	(1 << 4) /* report present only after life signs */
 
 static const struct hid_device_id hid_battery_quirks[] = {
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-			       USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-		USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-		USB_DEVICE_ID_APPLE_MAGICTRACKPAD),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
-		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
-		USB_DEVICE_ID_ELECOM_BM084),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
-		USB_DEVICE_ID_SYMBOL_SCANNER_3),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
-		USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_PRO_12IN),
-	  HID_BATTERY_QUIRK_IGNORE },
+	{
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
+		.driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE,
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
+		.driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
+		.driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
+		.driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
+		.driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_MAGICTRACKPAD),
+		.driver_data = HID_BATTERY_QUIRK_IGNORE
+	}, {
+		HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
+				     USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC),
+		.driver_data = HID_BATTERY_QUIRK_AVOID_QUERY
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
+				     USB_DEVICE_ID_ELECOM_BM084),
+		.driver_data = HID_BATTERY_QUIRK_IGNORE
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
+			       USB_DEVICE_ID_SYMBOL_SCANNER_3),
+		.driver_data = HID_BATTERY_QUIRK_IGNORE
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
+				     USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD),
+		.driver_data = HID_BATTERY_QUIRK_IGNORE
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+				     USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),
+		.driver_data = HID_BATTERY_QUIRK_IGNORE
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
+		.driver_data = HID_BATTERY_QUIRK_AVOID_QUERY
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW),
+		.driver_data = HID_BATTERY_QUIRK_AVOID_QUERY
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
+		.driver_data = HID_BATTERY_QUIRK_AVOID_QUERY
+	}, {
+		HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
+		.driver_data = HID_BATTERY_QUIRK_AVOID_QUERY
+	}, {
+		HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_PRO_12IN),
+		.driver_data = HID_BATTERY_QUIRK_IGNORE
+	},
 	/*
 	 * Elan HID touchscreens seem to all report a non present battery,
 	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
 	 */
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
-	{}
+	{
+		HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID),
+		.driver_data = HID_BATTERY_QUIRK_DYNAMIC
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID),
+		.driver_data = HID_BATTERY_QUIRK_DYNAMIC
+	},
+	{ }
 };
 
 static unsigned find_battery_quirk(struct hid_device *hdev)
-- 
2.47.3

