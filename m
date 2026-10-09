Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04B4DA9D8
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560105; cv=none; b=bf4w+cBih/KDbBaMuGSh4IJqjks3y0nEA67wIqFlTUhcLtGhzDuTScP41oEEwUvXnxFcLLqnbkeoOINMiiP2H4LhbHnfY7DO6WaJOGfde8mXJdXiRzggEK/MmcJRBYeiMO2nT4G23Xn42YtsLAa95QtcGBJfalo7s2aVQ/VQKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560105; c=relaxed/simple;
	bh=c6wjoMLezGt+1qvFrPvuFBmBI2wAdXf/+8SkfzdcIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avbsasca+zsIc9nVMldjvEoVzdy/2UVm4D2sDq+6YrJC7d/m5BLHAgBADm1WhPxSMGs+P6LRJP/WcQJBdQ36UqSCpi4jbPeQhiquwAg5MKJo+0AQvgdpCD0A2X/+dAsUEpEmLAwuZ55ThBTrk5UyRN3S8v+oRy4sl5LD9WZGvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kreYhxW0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kreYhxW0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a02718da81so32089475e9.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791560102; x=1792164902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HX40uebUCwGUFad0GZVg0pdumV34ufo62vgvgVs1SV4=;
        b=kreYhxW0sjXOuUvYctzCCf9kDUL0s9UJIbHCna22VxPRdYGUwLd0kU3GXhY/IiQpMq
         6evaQHws1TZGEY1/P2XNUBJONiqM8JvvZMY5FSdJ6lmqIC/r/d3jnr/JTbz7qiP/jHJ/
         Ee173s22wTdlkZX9xAuDTQeQbw+eAutqNt8AEsNcWh+I2/gOomJBO+7NWT7jadQvKDs1
         iSSUrY5e+fzYTKHwIiKoFlRRJjgCpwwYFo0LOmo3MaZS3D10NHrRZrWrW/jTpMwwG8f+
         Pjrkme1POuPsH9imCTC+PDr1xJNhcYj2/4kS/oj0eyWcfVzfmVx/mgF+D7XkXuDmEoKV
         5+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791560102; x=1792164902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HX40uebUCwGUFad0GZVg0pdumV34ufo62vgvgVs1SV4=;
        b=almpeNHXhTK6y11zVR+wgIdWL+zECmpUTaYbpwNMqzecs1UMqXPUUGtuXUbd756nay
         Gr8ugH/nIGkZN9kpaqsFwkz1Qc/OQzKinRVZqcq1/NRXypPhyWpfh7nTAOifOZjfXCPE
         /fVY7WQS9ejKx9cxHKJ1kfpNmCZqxCSpyTQVe6Rc1m96iQHAspSuKAAB/Qc1aWuexc6K
         Jm/v1lM21yUDewb0uutRWupvyNH66Ek6+2fHqoNiemvp5wCkY8pMuyxDYX8ns7SmOdoG
         vWt1V5z+6c91Yjq9f7gM2D3f+eK8jhDXqnNJtQB7L32xInlFHjO9qAOvnUoHEyFLNZwY
         o7cg==
X-Forwarded-Encrypted: i=1; AKwUvBxeDgCx02NhkkggYlj0HoeqWErB/vmprlXRglKcLOnUWq56raAG5ak2x/jaofDdxxGNpYXiHq4jb/JSug==@vger.kernel.org
X-Gm-Message-State: AFuF++ks8FezAaU7W3UrbpM0VRUuFqxCMPpVPOynOzXZYMNxlc+qNRb0
	VnSeN/7hCguD9yabEw/eVwoNXtbnzim/H9dM9azxozSFmXlCcTG8L8a4
X-Gm-Gg: AYBFou2kEk4Hgc3zkkqUlkpxkvC1dF76mlnPLR3mu7vJMC9h9bf4CF6XWZ9vGkl/34M
	amikS5ufXd2/6aIpMmyq/ciV+ctJUNPP385VOIgNgjesuSajueYU+MtwwgDyw7uYvTOy/2EtoFV
	tmXn+sk0WeYT2J/kKVV9usQc246TlhQL9dpYA2UUEZUBtYh9/UWY5Bw9+NKQToJvgdiAK5wRL6O
	aD0L2uhy1zN2duatqODmSlRhvVPmMJV7lLRxJ+sgAMGdPyNtO3+ABz6Re/yOEOuV8HC0g+ArKy6
	zzAwxPWAXukvlHsAj6cfouyPkJ+YQqS573NuQ8P4bwZ0nzWVERo6bUsw30yV850nao7geVHv8fk
	ORgJJgt0IqDM4VLLZQfaZv9Eb5rLmqmYnYZ2IDE6E2uNoix8ldwnmxNqWzFth62KX8YHBG4dMar
	nWQCkfXTRzuncm2ZW707UmTmHDJezeP8+3tjq7sbCAIK9tsBVdDWWoxDAKnQxnM/0lM4wzTCrX4
	5QSOpddEQcRthU61sjYjiTo7xp5modmyhYn0c0f9I8Q6a60QKzdrZ6X+w==
X-Received: by 2002:a05:600c:c172:b0:4a0:1c0e:b2a8 with SMTP id 5b1f17b1804b1-4a18e4cc2a2mr41216075e9.28.1791560102186;
        Fri, 09 Oct 2026 08:35:02 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:8516:411c:ea75:bb84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190344032sm40352055e9.15.2026.10.09.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:35:01 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 1/7] HID: asus: Fix up Zenbook Duo report descriptors
Date: Fri,  9 Oct 2026 17:34:28 +0200
Message-ID: <20261009153459.124752-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009153459.124752-1-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

The Zenbook Duo keyboards (UX8406MA, UX8406CA, UX8407AA) ship the same
broken vendor hotkey collection as the T100CHI/T90CHI keyboard docks:
the Input item of report 0x5a is preceded by a single Usage (76h)
instead of a Usage Minimum/Maximum range, so none of the hotkey codes
get mapped and every key press logs

  Unmapped Asus vendor usagepage code 0x76

Extend the T100CHI/T90CHI fixup to the Zenbook Duo: the descriptor is
90 bytes long with the bogus usage at offset 66 on the USB hotkey
interface, and 257 bytes long with the usage at offset 176 over
Bluetooth.

The dock fixup only moves the 12 bytes between the usage and the End
Collection item, as nothing but a bogus trailing 0 byte follows them.
That is not true of the Zenbook Duo: the collection goes on with a 15
byte feature report (also ID 0x5a) after the Input item, and over
Bluetooth a further collection follows it, which a 12 byte move
corrupts, leaving stray 0 bytes at the end. Move everything after the
usage instead, after dropping any trailing 0 bytes, and allocate the
two bytes the usage range adds. The result for the T100CHI/T90CHI is
unchanged.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: fold the USB offsets and the padding removal into this patch,
 bound the padding removal, move the whole tail of the descriptor, and
 end the branch chain with a plain else so clang does not warn that
 rsize_orig may be uninitialized]
Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/hid/hid-asus.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bd46aba6622a..34739198d90e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -100,6 +100,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
 #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
+#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(16)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -1579,43 +1580,56 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
 		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
 	}
-	/* For the T100CHI/T90CHI keyboard dock */
-	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
+	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo keyboards */
+	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
 		int rsize_orig;
 		int offs;
 
 		if (drvdata->quirks & QUIRK_T100CHI) {
 			rsize_orig = 403;
 			offs = 388;
-		} else {
+		} else if (drvdata->quirks & QUIRK_T90CHI) {
 			rsize_orig = 306;
 			offs = 291;
+		} else if (hid_is_usb(hdev)) { /* QUIRK_ZENBOOK_DUO_KEYBOARD */
+			rsize_orig = 90;
+			offs = 66;
+		} else { /* QUIRK_ZENBOOK_DUO_KEYBOARD over Bluetooth */
+			rsize_orig = 257;
+			offs = 176;
 		}
 
 		/*
 		 * Change Usage (76h) to Usage Minimum (00h), Usage Maximum
-		 * (FFh) and clear the flags in the Input() byte.
-		 * Note the descriptor has a bogus 0 byte at the end so we
-		 * only need 1 extra byte.
+		 * (FFh) and clear the flags in the Input() byte, shifting
+		 * the rest of the descriptor by the 2 bytes that adds. Drop
+		 * the bogus 0 bytes some descriptors end with first, but
+		 * never the Input() item that follows the usage.
 		 */
 		if (*rsize == rsize_orig &&
 			rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
+			unsigned int new_rsize = rsize_orig;
 			__u8 *new_rdesc;
 
-			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
+			while (new_rsize > offs + 14 && rdesc[new_rsize - 1] == 0)
+				--new_rsize;
+
+			new_rdesc = devm_kzalloc(&hdev->dev, new_rsize + 2,
 						 GFP_KERNEL);
 			if (!new_rdesc)
 				return rdesc;
 
 			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
-				drvdata->quirks & QUIRK_T100CHI ?
-				"T100CHI" : "T90CHI");
+				drvdata->quirks & QUIRK_T100CHI ? "T100CHI" :
+				drvdata->quirks & QUIRK_T90CHI ? "T90CHI" :
+				"Zenbook Duo");
 
-			memcpy(new_rdesc, rdesc, rsize_orig);
-			*rsize = rsize_orig + 1;
+			memcpy(new_rdesc, rdesc, new_rsize);
+			*rsize = new_rsize + 2;
 			rdesc = new_rdesc;
 
-			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
+			memmove(rdesc + offs + 4, rdesc + offs + 2,
+				new_rsize - (offs + 2));
 			rdesc[offs] = 0x19;
 			rdesc[offs + 1] = 0x00;
 			rdesc[offs + 2] = 0x29;
-- 
2.43.0

