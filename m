Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEE3AB476
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327690; cv=none; b=uPRCmeIcL1zTdD7uz8ngpcYfrtFJ2/58XaPr93ck4mG8gCvoRvogtMLcgaVX507AN9uPyLPylzFVoqqLMeBqC+x3TPahYJJ/s7SP+0EtNsKDWQfxz5ejmmesMb15V5MDfaKweOfVLPuCwIep78JtAqaoP/JOJQSq64taK/N61GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327690; c=relaxed/simple;
	bh=KWNhaqXlqeub4WAFjIf/rh7HaSpvWJdsUc+sIUUddi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=segiFJd1v1oEozr9AvpgKXL2dWi8gOrI5Z2kgIvJk1/bI5u0XJR+cwCMa+c469EA8Q79HAc/ZLIaUOyRxBN8mBJWtJ0Y6cv4oo/wmC5jSQcGDM33ffaGzXzQAoS2akRqsNvj4NCO2xefLnJbhGUOAbZDIcNWZ4Eu7JyBbLPE10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA3VLeO0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA3VLeO0"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd633ef819bso400239a12.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327685; x=1792932485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
        b=FA3VLeO0zyonyrkLCQBzgJQLz74AnMhfFSTEQGcAwvzfYkvewVSZsfkN4n0bIchavK
         RwoptaEeP8yURaejEMd3OUZUjZYcYt/9RTaznIhArxQsSOW6bLMlAyxfJmr06cjQAfas
         vxcFBgrBF2kRKd7unkEU3hR5KfGrtgM306HGtzDw2JPu4iy+M9Cd4pZ0OqhZBMgosidV
         Tf44W+aHUx5QvZt3ANpqjhDSYDU+ccX8rMv/MZllCIi5vth8ndEN40t90lZ5D0QLVzg0
         D41Dou+LmeEx6sIoleVl4vbjDUqXGb6Y8b6Tz64DmtIZpVuY2HXo3O81uXd9ytuWUMd0
         I2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327685; x=1792932485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
        b=KtUB+2z0XkF3+ha20tMM8FrtWoGrSv/eA2tpmkyXST1iL+gnpq25dNzZMbHYkyFhFq
         lbIGA7w0rwPp1SpkokomyT2U0mRJMx14sNKKTrUOZhhne6xUhm5kCUn3Jms0n+a/UdJB
         qff0ujNiO6IVBU33D+w8gg+NMIZWhOsI3llFuf+sanmvJB9ycpg5YlhhPmn1kkPGbDVM
         VA12K4l5gELAC5s5uSjSPNvCBrALY0gRiJF7q2z0tivWrLt7Mj4Kx2RNOzOxO6VVlbBV
         xCMIue613N+eej4vuK2Zqn0FBvBl78SZDg57s8X8fkQHvXWOEBYMAreQpBVBxL4LgiX0
         axBw==
X-Forwarded-Encrypted: i=1; AKwUvBwo4IjnDVl2vLUY/9B6y0O7SAtRIz9qkcCKosjxrBQtebQQYpLYC7e6c40y68r3WETj1JMYSucCjxJ/OQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK7Gp75n91CM2EAkFEFZ+9CpuBCjQihwWVDXNR6c5NQmJJ2r3jW
	h86aGBc9lSABczUUcLdqh5AqGa1wGDPeagoQ2muEUA7QE4S3OG646q0S
X-Gm-Gg: AYBFou3Lp/lOYAiVn1jZ1gLKxbTA6mvMG4JYEHynWZfrDU9Bk3QWBoYJZ+vwv4kzWe7
	EQMMu0AKOzCLR3Wca+weSFWzPDBT2EPIKRJz6ekRi8UFI+adu/JC3cTDgR02OabzrfakWEEo+og
	QBZSUgy7eyuM3izmvEa4WxeTIb9kswchZdRKwKG3y6uV3SShlengmIpoUfhTFVvr9Vly5EFyu4l
	Z7oflLpVPcbjPSiihUBo1F7eH8HJfNLYZawIYPZF2fa3F1dgBc826/W+wf7bOSTtT473509HCWE
	Dvu95b/rcXuBr0xwsNPtbQRDp9rBVolZ1gPH7/3NekfBZGJltM4A+7CaIPWRT3/uCySxDKlgDw6
	KC4OOGSGjBpp9gEw1H6+8db0nQABk6lMICSXLT1qr5BIcmTJJsIeDYsCiQpReOxQa2r+3atdEze
	wi/2d4dEnsdq48h/ZfRv3Zteuaav0XXyYnoFjlE8jSK60S0idO0XdrHEWPUrWBvKidC9cpUJOss
	3i/5/S2ZupzaAbmULTmY+0=
X-Received: by 2002:a17:90b:3b82:b0:3a7:cffb:8b96 with SMTP id 98e67ed59e1d1-3aceefb00fcmr4343511a91.18.1792327684749;
        Sun, 18 Oct 2026 05:48:04 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:02 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v3 1/6] HID: wacom: check the input device in the shared report helpers
Date: Sun, 18 Oct 2026 21:47:50 +0900
Message-ID: <20261018124755.850888-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
reached from several report handlers and use the input device they are
given without checking it.

Both can see a NULL input device on a fully successful probe. The report
handler is selected by features.type from the id table, while the three
input devices are allocated from what the report descriptor declares.
When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input device, sets the pointer to NULL
and still returns 0 - the "no pen in use on this interface" case.
wacom_wac_irq() then still routes reports to a handler that passes the
NULL pointer down.

Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  BUG: KASAN: null-ptr-deref in range [0x290-0x297]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
   wacom_intuos_irq+0x29e/0x3300
   wacom_wac_irq+0x1b59/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check the pointer in both helpers, following the convention the driver
already uses in wacom_tpc_irq() and wacom_wac_pad_event(). Log a
warning on the first occurrence so the condition is not silently
swallowed.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..567b01882eb1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,12 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (!touch_max)
 		return 0;
 
@@ -4226,9 +4232,16 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev) {
+		pr_warn_once("%s: input_dev is NULL\n", __func__);
+		return;
+	}
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.53.0

