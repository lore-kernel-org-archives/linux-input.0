Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF02BEC34
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206673; cv=none; b=qWDZghbDT4fFT/e+8npS2XSrH34u8tjacdbusSP6lPg1oODkaFi+6RFrXmH2VL1yHpx4gqyY3wb6bMVD03i1cunQruXcQJTTljKLp7WSKGuU6HvRCXMjY5rW8qtPQ0Pb6bkc7RL15S0nJlWr9VrHLGAdS94dnO3HJxencnUDVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206673; c=relaxed/simple;
	bh=cjWpWUf9JVI8TCn7SGZYPnijJgSfbwyKKK9pYmm8U0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvAAJNR+qkitjWRgYcSIDfbCCF+9O2/Xc/W74uESacMgR73PjjGTn2xt39nEml3ka4Z6fkcWNhEi+jZ5Eg+YaBUCcGPLkgDD5gzs/bgTPEgBEFzawcewI00AFxjbZYaKIvJxK0z/cxHhn39Ej1AtQSa+b9AhPqdZ3AyrsBFX3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8oeQeX3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8oeQeX3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1477872f8f.3
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783206670; x=1783811470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FtZSKFNiz07pIzEetGtrSPhdzPnXrxlvgbBRsebkWvE=;
        b=B8oeQeX32Kku4Rp9ciLN+LvRU7beUofEt90zwxhaMKXpjue4z7BOO0C9jxhcFyIB21
         MSfsG+4uhR6CfFE+BbtSNf9Clky2VkJ7F118PSWLMzxCwqmimxRFtoGTKMa3FxSA1G2E
         ZVpCSnYS166qmnzuFR7WawVwXUuECPfc2NJ5rXSLDHhU5GDzQe1uDaqSxgWR09KU8O2Z
         4Rw47t94wd/8U7S7uv9Cd5oxHXM2WxfHnsatI3/HpWQlO41gu1jGyc3Je00ITsg8MqTX
         IqGb4u3EI12/tcad0xymMYVoUIrwDfzOF8gMQbIg+wW5ucXQ4RJzoNJVegt+V9Vad03L
         gRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783206670; x=1783811470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FtZSKFNiz07pIzEetGtrSPhdzPnXrxlvgbBRsebkWvE=;
        b=JjseoN1lOau4y1GfdOtHvpYU4ESPDLPh5c5ySFZhOwGZOx1+TxkoGpdWt0IgGA0TOk
         Y8gIST4wIB8RGT0dPcn62nl/qeDCtpXdMUdCl3QHAz0KTa3hhVXclMvdOiTnZrdFSnX0
         u4OZ0cNJDDIGRU9iJ5z8TTtKgA+qcWyWufuTrSblsTc/poAfRoar/vNw3F2YQTotXZV/
         Zq2nCza8zXlOBksxZcOyzHuPXsSRETqur52twPO0aDOYhyJbAUslm1VS4oXYPaJIKpGU
         gEvuOQbIxLbW0aminK7KNFPsksBoSu9mP2XWyko8b2ZtUoJIGAEnCe66Zvmswx6wOWRp
         UDmg==
X-Gm-Message-State: AOJu0YyNL+EpnpKNAnqF9QkkcL79f9R/0dx6QwfKjRdMQWv5dXyUWTaa
	JkOP1pzZ1+oLif7MLmXJld0CrJp5cL9CNPJUbqOhDW3qBq1Vglu4gnSReqefhRuD
X-Gm-Gg: AfdE7cmmzQKScc5OCuBe6j36bIkh33IrbJh4Akn+Pz4kR2sB5uIV7D/UuL8xmbGQ+ns
	/pFR0Phv7A2hLMgwW/P8jHyX/kzOZEs4DxuWz0Uol/zgFOEY0rf45/dVoCT1rQCPerfY5SIbGSd
	f3s+eynT7zeRthXiQ1vRR5hALf7M6foxFaaZ/1uOW2vfg3h7OCIz+/KZB824O1fCf6dL2TKqQJx
	yZA2oVth0ucnRWnR+EZTpi5jvTXjC1bIApNRfLV1MXd6rOWZR24zbsNk4YW/RG3tvHfZxjN6qIK
	mmvHuU5dPMRqZcEA3llRpZHkmSaZdZZYZ0pH+hQv5v62muy2o5HRZl0CDycw/rEkM3G6sA6Z3yD
	We8qHtaww/IoYCryS4ZHRWmxAQxXHgSrgtv4xVZHqLXSrdJL4u9Oj/182hfL5egYWZ4LHwS7dRz
	MLfCZOoTbpm7mZguqeYFeG4RIfnt43Qjr8pG+220p4VDbuOnBd/rLk
X-Received: by 2002:adf:f392:0:b0:46d:1433:77ec with SMTP id ffacd0b85a97d-47aab57d1cdmr4046239f8f.2.1783206670293;
        Sat, 04 Jul 2026 16:11:10 -0700 (PDT)
Received: from localhost (97-115-81-230.ptld.qwest.net. [97.115.81.230])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa09608d4sm11870922f8f.25.2026.07.04.16.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 16:11:09 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH v2 2/2] HID: logitech-hidpp: enable reprogrammable buttons on Signature M650
Date: Sat,  4 Jul 2026 16:10:35 -0700
Message-ID: <2e719e56029386f148d748a7d555023f4efe3862.1783094954.git.edouglas7358@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783094954.git.edouglas7358@gmail.com>
References: <cover.1783094954.git.edouglas7358@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Bluetooth Signature M650 exposes its side buttons through the normal
mouse report, but the observed events are short click-like events emitted
around release rather than physical press/release state.

The device appears to use the held side-button state for its built-in
gesture and side-button + wheel horizontal-scroll mode. As a result,
holding a side button long enough can prevent the normal mouse report from
emitting a usable button event at all.

HID++ REPROG_CONTROLS_V4 diversion for control IDs 0x0053 and 0x0056
provides real press and release timing for those same controls. Logitech
documents the Signature M650 side buttons as Back/Forward buttons, so
report the diverted controls as BTN_BACK and BTN_FORWARD.

The HID++ 0x1b04 documentation lists those control IDs as Back and
Forward. The driver still verifies that the controls are present in the
device control table and advertised as divertable before changing their
reporting mode.

Link: https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-Signature-M650
Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f9189e14fb78..e71dd2457e80 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3624,14 +3624,30 @@ static int hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
 
 #define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED		0x00
 
+#define HIDPP_REPROG_CONTROL_BACK			0x0053
+#define HIDPP_REPROG_CONTROL_FORWARD			0x0056
+
+#define HIDPP_PRODUCT_SIGNATURE_M650			0xb02a
+
 struct hidpp_reprog_control_mapping {
 	u16 control;
 	u16 code;
 };
 
+static const struct hidpp_reprog_control_mapping m650_reprog_control_mappings[] = {
+	{ HIDPP_REPROG_CONTROL_BACK, BTN_BACK },
+	{ HIDPP_REPROG_CONTROL_FORWARD, BTN_FORWARD },
+	{ }
+};
+
 static const struct hidpp_reprog_control_mapping *
 hidpp20_reprog_controls_get_mappings(struct hidpp_device *hidpp)
 {
+	switch (hidpp->hid_dev->product) {
+	case HIDPP_PRODUCT_SIGNATURE_M650:
+		return m650_reprog_control_mappings;
+	}
+
 	return NULL;
 }
 
@@ -4911,7 +4927,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX Vertical mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb020) },
 	{ /* Signature M650 over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+			       HIDPP_PRODUCT_SIGNATURE_M650),
+	  .driver_data = HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
 	{ /* MX Anywhere 3 mouse over Bluetooth */
-- 
2.54.0

