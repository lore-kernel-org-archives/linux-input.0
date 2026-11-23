Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443361;
	b=N3GZpPphzniAdSs8wtzX9dyzvvXUQ7AcKco6kv2krM17nnYpUVEjdShtRkkN1pMmHuz4
	 n9iSQZyfSV6qF2cUWbAL1Wi89nPjit0zKD29nSjXFL9ULGcmOAbXThKkcvqmUPSVD32NY
	 7GDsEnI3ZPjT57au+lif437PuHV/RbjLAD/rrdnj/12r/leZnWGd6kYJELs1myRqQ5j7N
	 kAK2ImOjRlY/hS4xmqGXcb7uF5XPWyKYPAudUuV7xpPK16Dc6yc75daJ6LlMITLMJ5MfL
	 K5zc9nr1KV+hTH/VE7cGaxAxiW5zSxvnrTAUM3lIhv1qqC2mi40BX/90EJPyrTzRjtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uXc58AQIKnSVosQ4y4//VCEnNXKp3+RfnItc2ijL3c4=;
	b=zqtHCgMN9NWtMARCmOEeBki7K9In1w0SNDJbxdxlu6Wuk8DNBDACcjSHCHwmIuiShCbJ
	 2Ya5C4n94DXVCyE1Y7H3FRqG15PEXWF3cdGSEstCaCcfAxIEkQuh6VNtzqfhR0WaTzPob
	 wFgqLbRY4pPbFIrxDUiS/Cv5OtCe4g8XbTSGinmkWibPW7A20qIhKJFA4X/GV7cTJy3MV
	 slnPF81vEXDADsOuLjWOdRRB4GsTGXeQ/8xAhZiC5RPZ+e2u2nIJpHT2gy42QfVNccrb/
	 rqLz8BXDllHzJbjlSkRezAaunWDkxfFy1syUvLi4IZYKBroptWk/UX2etyOrJXBkm7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdTIIVRn;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3A606A336
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 14:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B3A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdTIIVRn
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b2d14968c9so30448877b3.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443360; x=1796048160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uXc58AQIKnSVosQ4y4//VCEnNXKp3+RfnItc2ijL3c4=;
        b=AdTIIVRn6Lxhzc6Yc705wIxBDbpGUgNUhfSKZ7GONm6tJ+3dI9gSC/C6Y79w2kicxX
         gUcNglSdGFx52HYLa7pOXPVYOwAUWMb1dKuPudB0MUTrEhShEOUSBUfsONTrgE7ZTUzf
         KlqVcIRuTqMuKo0jiuIhR9sLqEwQDHQjkxabbMv5QswxeufvY8ZpZ7jw60fMx/iJJ8AZ
         LR3mrqjaM5wEfwTBTUdwj5z4/BEMsNzXxGQq3REXQC+plIZlhB8eZHdNxEtH2WS+FZtJ
         9wNjuwA1NXZ/8VhWdWaEWogwHVbQbTlVNihs5qbJMUjRpRXjPycuFG0x11V9r4JbduXK
         rCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443360; x=1796048160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uXc58AQIKnSVosQ4y4//VCEnNXKp3+RfnItc2ijL3c4=;
        b=MnTDSa+MLl2NFnsTQu0EEsPv/1yeLdByjR/y0IcFtTO3vmBPwj1bLX9FfD8Hw7P3eC
         qWGXr7vn6Vpbxf0WpEZpsa8h8qalCZYcxmT/h1QS2QTRSxGr8EtTVqCYmOLVPKsfp2eH
         l44xIn+JqQYklh+jD37x8r6B192X1lvf5z+ZAIaf0Mz3t43Rm8+2+zYihsEce96whI20
         27xEcZPMYCeeywU/dHTEDt4/vHteLqzFOejT2r3bQi9UI0vhQnmdWgLVJStSHyAnyvJl
         2CBQOj8uS6+cPTFAZNOuAmCM7OXwUKTK3Smbd9rakOZBugjCRNBK4YrsJJ3tWsYZnNRw
         MYPw==
X-Forwarded-Encrypted: i=1; AL+hErGyi2xdTv0TAbInG/nHL6Sg4ulMI5zalhu5EDjvuXffR0/NgaQiTK7V2m9DHs4fgclOMuW4pm9XR0KFqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9q6EU/HY1IZ5+8P4SgXrPxNeyjGUI/cim/5nfvlNO8QbpHykU0
	FxB5AnQ6QnZihn4BmWYY6tAmZzbN9Xy5Fp57Uus+FnQPi6KmF/XhMgtP
X-Gm-Gg: AZFdTZcCNub9wQ6fZEO2m84NIfPZ2589or/s42SMutj5SmIzK2P7y4CTjZVHHrcwLU+
	uoJgL1Iqg80Dn3vcLvlO4v2B9XKxYZV+BRXkfMiqb1RLowfYabsauiMLfyVVqimdIeDS7qj8bAK
	dAuizSfzvKSn4+bGP7pTs3H+r8Zp1fDpHWpVyAqUi05iQWYHmfwCqLngbEZlYR6tfO+8Mp/Rv75
	XmtFA3GIfYszFQAC2RyJCaJQQz9LtZ8TKCwZGGz1wbZU2dRpLLD8zgYJWDzAKW3w3y4C/HBUARW
	oRjDDK0LzYfg2teaPiIHC0eCxMewtnRWXtwjinIubmpz74CsTbe7iWGMga3kUljsvvG5Yi0oLPP
	8Vn1ho8k4vKwiKbOM9XmuTtJUTFl3AzQnWF25bXRXUwtPeKtwJQKDg+Ti0Y1TebCXYMRQIZ0GT4
	gRcxhXCgU8ihliJIXf7GTy9voiCvPmyo7lWSTWT0v8TNzE56Q5CR47KbceM7G9Waf8Du9BihXD5
	NyV8x0kznVJQy6rkH8RuTmq4v3JKiw9IAiT59ZKQh0vWZTI6bKwvSp7MN5xLdFc95GMhZcQpOzN
	C4FYu08fF4XBwBLV
X-Received: by 2002:a05:690c:7206:b0:8b4:e51a:c4f9 with SMTP id 00721157ae682-8b52032b68dmr39735177b3.1.1795443359626;
        Mon, 23 Nov 2026 06:15:59 -0800 (PST)
Received: from pc-i7 ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202c089dsm45681087b3.22.2026.11.23.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:15:59 -0800 (PST)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org
Subject: [PATCH 3/3] HID: pulsar: add support for Akko Gaming Mouse
Date: Mon, 23 Nov 2026 22:15:42 +0800
Message-ID: <20261123141542.8128-3-mapengyu@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123141542.8128-1-mapengyu@gmail.com>
References: <20261123141542.8128-1-mapengyu@gmail.com>
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

Add USB device IDs for the Compx Akko Gaming Mouse in wired mode
(3554:fb29) and via its 8K wireless receiver (3554:fb2a).

Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
 drivers/hid/hid-ids.h    | 4 ++++
 drivers/hid/hid-pulsar.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa6516d..47e4a9cecad4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -75,6 +75,10 @@
 #define USB_VENDOR_ID_AKAI_09E8		0x09E8
 #define USB_DEVICE_ID_AKAI_09E8_MIDIMIX	0x0031
 
+#define USB_VENDOR_ID_AKKO		0x3554
+#define USB_DEVICE_ID_AKKO_WIRED	0xfb29
+#define USB_DEVICE_ID_AKKO_8K_DONGLE	0xfb2a
+
 #define USB_VENDOR_ID_ALCOR		0x058f
 #define USB_DEVICE_ID_ALCOR_USBRS232	0x9720
 #define USB_DEVICE_ID_ALCOR_MALTRON_KB 0x9410
diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index 299baf38a2ff..5133c87b1854 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -14,6 +14,9 @@
  *		- VXE R1 SE+
  *	- VXE
  *		- Dragonfly R1 Pro
+ *	- Akko
+ *		- Gaming Mouse
+ *		- 8K Receiver
  *
  * Copyright (c) 2026 Nikolas Koesling
  */
@@ -59,6 +62,7 @@ enum dev_type {
 	TYPE_KYSONA,
 	TYPE_ATK,
 	TYPE_VXE,
+	TYPE_AKKO,
 };
 
 /* ----- structs ----- */
@@ -756,6 +760,10 @@ static const struct hid_device_id pulsar_table[] = {
 	  .driver_data = TYPE_VXE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_WIRED),
 	  .driver_data = TYPE_VXE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AKKO, USB_DEVICE_ID_AKKO_WIRED),
+	  .driver_data = TYPE_AKKO },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AKKO, USB_DEVICE_ID_AKKO_8K_DONGLE),
+	  .driver_data = TYPE_AKKO },
 	{ }
 };
 
-- 
2.55.0

