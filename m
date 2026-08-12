Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BC31717D
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564751; cv=none; b=hs5s05MjybmtBPdPpphNIxv8BOwiuMxTpXyszXBzPAuf7ODsL4GGePbs59AmcboFuX7Puvx3OiyNl1b+kzkekfTj1a7pMtjfn77yBad/VKPkQ3z6JxiMbn8H+4l9qNe4Z4KfOIwrFhFuaK31gh3oXeqObTIe71AZfojOzQ6lWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564751; c=relaxed/simple;
	bh=SxhLuZhNDLQB7P8JmA5d0v/iTsujFzWA4xG9cUNjap4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0YGKB59R/z+f1DW1qyEtrB/TUvx2V+e9fzUQ8JSDJdbsHiQRK/q1afszfLEYpx0CrVdyeht4rPzGzu/4/FidWzw0uicYgjJ/fCjZIK0Z6WqUJqyVqySQ80NLqRMPnltnvN8YjzAp3x6ahd7m/Bp3fHpAAdJfJVA8OmbYaWk430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9WKgcL5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9WKgcL5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4813ea321cdso146373f8f.1
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564746; x=1787169546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQJkp7F9XSMUUp3rtI8dEl5NT/CiVfWiLJXvzZwRDEo=;
        b=K9WKgcL5euEzMwjN2GJb91Ahgso4DC6pj6zwCfBkVurTTOTsrtXMuJ8shtJx45Ozsp
         zfNq2t0E73gbNE2p6+H+yCoXOeUYBO2qtQl6BTNKt8gknOiRQqg34uug0Q92U86b6+v3
         b27gSr23OOeYcxU0ZQcj3wY0kUt00PHzkEU6QnjgigoJB/PHdh9V5CK0VJilFqo0ksKR
         M5PiTs9e7vkUjqF5VDRkjQ2uFbyEDx+4WxWPOQ9i4f8jFpZxStewmM2OnfYMXs/4NaLw
         1Qrec1OCm9FhZKmaO5ipWxg5wglfbXuekAljR5OMqVaZHOZFn0uf62KbH+O0f3brvR+j
         vfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564746; x=1787169546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQJkp7F9XSMUUp3rtI8dEl5NT/CiVfWiLJXvzZwRDEo=;
        b=edrxYrjpApDGtoJNa3bdLfXsh3M0DPrf/t+fCiIYK3iEUqQ/tnHU/uZJYv9H+1u+p4
         oqVlqB7pXf81bfFDQruvW67l/RmCM4jjR623FJ2pVPAK6ZfC6L+g76rvadphAyY2TVLc
         dr7RCVKA4LrggyvWyvg+WiUUk/DXPM6KD4i2fCqsuEa0qSRCOLF25urkKwEUyIsJwwjh
         JWrc7KoAYacT+2ckXAZsJTjqzP80KiHjCEvponQLmAsGjr+YDCyvUOaMd2lGy2Af8c9i
         yw/ZrpXU4ALzLlVR52kTl1la3VdSzlDovY7FLMP+UwHPYOxFpPdxfMF9quaU7sj4zwGr
         p0LQ==
X-Gm-Message-State: AOJu0YyIaMHCi5F3/PfaM9jq5XlKt+KN2gBZTaUAVX4f1JgbKz86F2UL
	qcRGL9wPr0MaAqfHSBPZlrusYCwl1aPnaEdpgWs1McBM2BYAwci/X3BtT9B7tJY1
X-Gm-Gg: AR+sD13df01iIUIY3kPm+MtGt3LAL4/IpwCfbFh4gXE2OavmORGKziv4vQpvT6fv3hU
	/nwkGzNEa6TR9bBGy0zYdLTVQY3qtIk8FTzjGsZREfAPHwBxVkcM76FdfAL4DsxnmMiPyf/iC/a
	bJnlsOtwfpzXfPKck64Mbq3w99PIkCSmWmU3DXlCBqa92OV/8zQW6Vt6QT/okq08gy9gFT6f+KG
	5KnV1dwDxV/RUPeb2ksc5u2pTSNO34riQbUQoA/GSIQsv74bey6HSfP5mz27aShprBnRPq3pPG4
	Jl5foxTWl0ZdUvMUGdnZxmb6s2OW4VQ5W8kyOqMELTcX+zGqbZUIXq0L9SQY774PJkFf/YbZcIY
	7Sqb9/Oy5/1H8aRoMjY9l9/wg94NYgzvymY9za0wh/aFzVxn2GozCQpmZ+B/TofeNa2Z2dj/nPr
	ztqtRRX53jvyluj8rYQ/1jCq4Xz9QbpAEzEh6eS5c94YdwFoAD0e8Nx+UWqRvS7bOrry9/c4gTq
	XH5SW1Xm8vhNhWU
X-Received: by 2002:a05:6000:2883:b0:47f:eb38:26f9 with SMTP id ffacd0b85a97d-4815a502bd1mr325002f8f.8.1786564745846;
        Wed, 12 Aug 2026 12:59:05 -0700 (PDT)
Received: from localhost (97-115-90-76.ptld.qwest.net. [97.115.90.76])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815a5612b8sm148920f8f.1.2026.08.12.12.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 12:59:05 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH v3 2/2] HID: logitech-hidpp: enable reprogrammable buttons on Signature M650
Date: Wed, 12 Aug 2026 12:58:42 -0700
Message-ID: <20260812195842.77724-3-edouglas7358@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812195842.77724-1-edouglas7358@gmail.com>
References: <20260812195842.77724-1-edouglas7358@gmail.com>
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
holding a side button more than approximately 2 seconds can prevent the
normal mouse report from emitting a usable button event at all.

HID++ REPROG_CONTROLS_V4 diversion for control IDs 0x0053 and 0x0056
provides real press and release timing for those same controls. Logitech
documents the Signature M650 side buttons as Back/Forward buttons, so
report the diverted controls as BTN_BACK and BTN_FORWARD.

The HID++ 0x1b04 documentation lists those control IDs as Back and
Forward. The driver still verifies that the controls are present in the
device control table and advertised as divertable before changing their
reporting mode.

Link: https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-Signature-M650
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
---
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-hidpp.c | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 426ff78c1c03..f4a23662888a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -906,6 +906,7 @@
 #define USB_DEVICE_ID_LOGITECH_Z_10_SPK	0x0a07
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
+#define USB_DEVICE_ID_LOGITECH_SIGNATURE_M650	0xb02a
 #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
 #define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
 #define USB_DEVICE_ID_LOGITECH_C007	0xc007
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f9189e14fb78..8cd762e1eb51 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3624,14 +3624,28 @@ static int hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
 
 #define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED		0x00
 
+#define HIDPP_REPROG_CONTROL_BACK			0x0053
+#define HIDPP_REPROG_CONTROL_FORWARD			0x0056
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
+	case USB_DEVICE_ID_LOGITECH_SIGNATURE_M650:
+		return m650_reprog_control_mappings;
+	}
+
 	return NULL;
 }
 
@@ -4911,7 +4925,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX Vertical mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb020) },
 	{ /* Signature M650 over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+			       USB_DEVICE_ID_LOGITECH_SIGNATURE_M650),
+	  .driver_data = HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
 	{ /* MX Anywhere 3 mouse over Bluetooth */
-- 
2.55.0

