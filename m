Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A299379C33
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373099; cv=none; b=ZaM8mAYm1RZIa6ft3bYroJMgPbmrudZgBPiCaIUJoG9yACrS1wvsLCUPwXBA16VglttpYHIAfERE2dwNsUOQKEtnvqb214PE+QXPaDNroc4Qcyo8yQFyiri1C2voDF2tXBefxl3CJQ6MLY35zIdK4KW+t7I4scbDk87wfcCDFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373099; c=relaxed/simple;
	bh=D6mo5lL8BXn1F6JUMRL4nZvmSxUl5EyOPXKc+HrizpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLWtZJyMT5+s2SITcAQooVICqke4mjamitnlynKrOsqM2esHFMifqROgWTZ9L4+O7WKuT+o/qtJaQySeGkgCXLk2a6HEu8sEbO8Kd55yMn94LK4IkqQ8WNNpH1S9g6kAcAjGODARgwCJdrDZm+BKPzZ8LghoSlNxZF8TJ0+aG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6GlrTER; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6GlrTER"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso1341666f8f.0
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781373094; x=1781977894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiUuEZMXuY2KA8NP752vXyuw8+K685EPS2wquFqxvfs=;
        b=N6GlrTERjd8BtIH9+BUmqs7pdHzQVLZMEVI9Mngom+kATp6gbAQhr+0gANPKRCWO0v
         ed4nsGqwIG1ja6uuCQSUfZlWS6PKQW23LsGb0KKl+t+knW9nTaqT13/9IuhqjNTDiObh
         LvSWWjzoWSwGSZ7W6mKAfwInjVyU3/0pcR/g8xKR+BaDOqa5CnHU0E+lYFusWsmEzYuy
         oPX75icMJ4bPFn/ow0ikRMNNIHEx9CF6uWLE87AIwNQbrySHf40Lbv5sj+q6MzJg9a+P
         UKzVkfmvsSFFKKYTwBA0TiN7arFThsRej3SaxhvjRiCE1f6vgGSJyRRLzkZuaYKn354f
         thcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781373094; x=1781977894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiUuEZMXuY2KA8NP752vXyuw8+K685EPS2wquFqxvfs=;
        b=cOk05mswSHJO/036eK+0N3gCPE2uHCiBp+l8uGk961gzBnCVXvXIy/+bCcikdnUtGh
         6AoMZYfz6YUxGKSH4J+9q0ecSCb8wY2s2heyrdocNNzqW4qrYiObWDcr1WkVeRjJ37V4
         +LOLU5er7+6rG102LVBRFp6gr129F+8kn1sA35lsEbebzW85TmkYk5bf8zxC74TQZM89
         0Q2FqN4Cq+A8i2fXcQ4AwjD64/+jSqYux50N01RHAsIBXbAq1XxnJez99Ilsrbl4GGU+
         WROi60FQevWMCIzmB/6pqRTy5HbzqnLRBWkOjxuHtAJPXWa8t1FoOBiXe8iMz4U5B0pI
         anKQ==
X-Gm-Message-State: AOJu0Yz7NNUWrr900U7atCF0Rqkj/OJl4nlUXZvTgHOlxj7I6gELZvni
	DHSwkxRHVtF5iPIE4gaBsG8+tNSosq5PWhJo+nNVwxt4u9sM8TWoruSMt17IovETU78=
X-Gm-Gg: Acq92OGiIqT7jdV/0pgTLrkk8WmqYvRtNCL97zgMIDu3oxCHk5QO/0Y6HvtcHEA9bw0
	zo/bR/Ldu9cABkDODeyHvSBaEU4r1QGudxdWeWdelTBJCtN6JVCfSEky2lw6HTPcsHnYDXL00FX
	bVVq/oQRh6htQVkX9h7QZE4EWYU63w8KySXwZ7J0aRco87GMXhHUkztibJTnEP989gwuMYSSoWc
	frrQjmmI7A0IX8sP3jFnl4S0xdH8lfIvv0FeJmH5OCbBNznOJubHy6EXZi2hhqOdHx+WvxpYQJG
	tx0wRJQFPYgwaKmmdkGaEzJZhxXDCVB5PReLWww/0GjMXKlOQBae/i20nifdDBBj0tkq47OaAlZ
	8G4uUY3vw5J9E6i1zQefu82yAqKI2D6cs5URnWBZsoom9bTaxEQBlea+j2mRh/uw0C+2AJqMMoe
	SeWZGR0srbBTYzyhLgP2x3iH9wtg==
X-Received: by 2002:a05:6000:4904:b0:45e:f302:95b with SMTP id ffacd0b85a97d-4606dbac755mr8978276f8f.37.1781373094191;
        Sat, 13 Jun 2026 10:51:34 -0700 (PDT)
Received: from localhost ([2602:61:7351:e600:a1d0:8426:3923:d48d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f26f450sm18733492f8f.10.2026.06.13.10.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 10:51:33 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH 2/2] HID: logitech-hidpp: enable reprogrammable buttons on Signature M650
Date: Sat, 13 Jun 2026 10:51:09 -0700
Message-ID: <20260613175109.44365-3-edouglas7358@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613175109.44365-1-edouglas7358@gmail.com>
References: <20260613175109.44365-1-edouglas7358@gmail.com>
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

Link: https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-Signature-M650

Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 24c9cfaa4f37..80108778ee80 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3621,6 +3621,9 @@ static int hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
 
 #define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED		0x00
 
+#define HIDPP_REPROG_CONTROL_M650_BACK			0x0053
+#define HIDPP_REPROG_CONTROL_M650_FORWARD		0x0056
+
 struct hidpp_reprog_control_mapping {
 	u16 control;
 	u16 code;
@@ -3631,9 +3634,24 @@ struct hidpp_reprog_controls_profile {
 	unsigned int mapping_count;
 };
 
+static const struct hidpp_reprog_control_mapping m650_reprog_control_mappings[] = {
+	{ HIDPP_REPROG_CONTROL_M650_BACK, BTN_BACK },
+	{ HIDPP_REPROG_CONTROL_M650_FORWARD, BTN_FORWARD },
+};
+
+static const struct hidpp_reprog_controls_profile m650_reprog_controls_profile = {
+	.mappings = m650_reprog_control_mappings,
+	.mapping_count = ARRAY_SIZE(m650_reprog_control_mappings),
+};
+
 static const struct hidpp_reprog_controls_profile *
 hidpp20_reprog_controls_get_profile(struct hidpp_device *hidpp)
 {
+	switch (hidpp->hid_dev->product) {
+	case 0xb02a:
+		return &m650_reprog_controls_profile;
+	}
+
 	return NULL;
 }
 
@@ -4921,7 +4939,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX Vertical mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb020) },
 	{ /* Signature M650 over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a),
+	  .driver_data = HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
 	{ /* MX Anywhere 3 mouse over Bluetooth */
-- 
2.54.0

