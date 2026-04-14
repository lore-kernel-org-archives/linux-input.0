Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563019CD0A
	for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173956; cv=none; b=EhmjDUrWScgOD3Ce1RBKqNMZTIHWPqw1VVl7nTuDLUTBfkm/kH/ljqfo0URM6Fx5pfZakdCQCUWXzWygEFGByMMyrBnAmegSNXGypR833pZMkb0N1b9Y65bQvniZYw33GCygDLhikCK1Ppf4QH3adjVYk6JkU7w4RuoFqGwMYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173956; c=relaxed/simple;
	bh=sf9my1VbQPsbr0hqAYI7ZMbiqsS3M05KaEd7xQc2aIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d5Ct1S//d4uX5Aa05QR/AD1bcXY7mdzOaCWjyoSpsajoOBCTZd2s7i2O3UbGvkEvyH3EFx177BrbJQsDUg8r532DALYbHcko7bv2TWsoYj6Id8kDs4MkfpLxdICGUZsEBXy6v42oSV1j53HVlAr1JhVPM6yUpZa7pJo5VsmTy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--damiendejean.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cShMYgmn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--damiendejean.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cShMYgmn"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so45882975e9.0
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776173954; x=1776778754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UInTa7xD/DFbaG4guymmVZBWYE7vemAmyI2N90nYsP4=;
        b=cShMYgmnkSA12mS2kYT0hCHjisdRzFyLKA6dVCr8iT0sVgt+SPhwlkIbELi6LQNllE
         ZHY1ei4MHsiSqRgllSpsZ0RDazxQHl4X9IdwKD10sTodUDWkes+IZ8Kfz5YI5KhqwUK0
         LcSaUyPyoRRbeN4OmyOPkrznkRgN2SrMRMaEMqcN3kZtKmt1Z/NyJbhlbB+CVivuaboX
         bJSnLUsKwVNb4VNdyE0KeSGyd977gG2fmxxzNdjWg+Z3YyvRfKshNi2BVzCSJlFgSgu1
         Psy5+uIpZ2xZnE1poVuOjELdA03bz7ocJkdw0c9rBsmUyE+VWTKeHMYYFJJZro2FHvhc
         AzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776173954; x=1776778754;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UInTa7xD/DFbaG4guymmVZBWYE7vemAmyI2N90nYsP4=;
        b=dF5ZxY1sAMTiFfJnSTmOjL2BE+RvRFlLBewZWq2GQQBkPPWGRddTxTcRny0Et00ZsL
         pMrN1YyEi4Mc6PYs6oXh4MvVywi5dK1HeyXL7eJ/ZBjIm+xQ8tdw3zSK0iHOj2HyDfcF
         wONTdD3UMNddnAmgIBKJDVplcEtHMK9cOXPK9rW+WqeAmU27RpveSAJ/dU7NneZV7Ds1
         9J2mpaf29BQKAdgHcG/JoieUuSHPNSOu1fp3O2TjmU2y/lrlkihlbssZcdMqwEz1vt4J
         twfGaaJ6rzAAvkTP4R65yhLsm2hMvVm14pfg9BlNaT78QtMNZSlqC3+Uru1W5A26G2nW
         WYGg==
X-Forwarded-Encrypted: i=1; AFNElJ/og2lDVXwHpJfTYaCvdXEVByc4d7ARxEP3p3bQbEZ5oTTRUu8dIYIOXooWEK2hEYKR24sPbyQP5bL4gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72AcJ/ucoPj/c9JhkrBrGJS/bGoh4CQ/OwVpygiWUO1BEd9U2
	wbqP3BF9XtQu2WBumi7IwxC11XxKe4uaaOy5kFyHqYcsSTlIt6wkf+EGioTn6DapfVocxXl6A/1
	eeu01JhszP8liZTUssqbip5zboCCqyA==
X-Received: from wmbh7.prod.google.com ([2002:a05:600c:a107:b0:488:81f0:1a27])
 (user=damiendejean job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444b:b0:488:9c3b:ff40 with SMTP id 5b1f17b1804b1-488d6acd9fbmr197485105e9.15.1776173953643;
 Tue, 14 Apr 2026 06:39:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:38:58 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414133858.3992799-1-damiendejean@google.com>
Subject: [PATCH] HID: elan: Add support for ELAN SB974D touchpad
From: Damien Dejean <damiendejean@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Dejean <damiendejean@google.com>, 
	"=?UTF-8?q?Kornel=20Dul=C4=99ba?=" <korneld@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Elan SB974D touchpad uses ELAN_MT_I2C format to send HID reports. Add an
entry to match for the device and parse its vendor specific format.

Signed-off-by: Damien Dejean <damiendejean@google.com>
Signed-off-by: Kornel Dul=C4=99ba <korneld@google.com>
---
 drivers/hid/hid-elan.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 76d93fc48f6a..0190ad567ce4 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -513,6 +513,7 @@ static const struct hid_device_id elan_devices[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_HP_X2_10_COVER),
 	  .driver_data =3D ELAN_HAS_LED },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_TOSHIBA_CLICK_L9W) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_SB974D) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, elan_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf63742315b..8cfec7dced66 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -455,6 +455,7 @@
 #define USB_DEVICE_ID_EDIFIER_QR30	0xa101	/* EDIFIER Hal0 2.0 SE */
=20
 #define USB_VENDOR_ID_ELAN		0x04f3
+#define USB_DEVICE_ID_SB974D            0x0400
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
--=20
2.54.0.rc0.605.g598a273b03-goog

