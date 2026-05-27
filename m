Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694D3C1F37
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920499; cv=none; b=sf7F6QulILKUiVjX3tjiDnSKl13gJki3BBbYNkX5xvQ/31PIAJMjvSnKkW5sq6rTT2BdN71KQAV9QJh8xtlIRTfuD/yQmVxANyGxhYSlkWnQYIuHOH4ydsN8oDiTSNJbfySBKCsYkYGmu704rnnbt8nxj20LcQ50+rDosybyFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920499; c=relaxed/simple;
	bh=2fk6fhOD8x0q1aTeVxYSSNIwdBVsfgLnJrKq0BISk/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+XCI+ZC7bq+QDtK7ZbBGh95OLP332m7ac+/OfTgQtZkM0UyLOUoyGVzQc5csQsiqh4i2EPLQtiNHf/4XB5kFCUOYcElUEM2S9f4TOyZDV8GK0CA1+Edbbt+owVpyEUivMrzsY9TPcLtuuqqs1Q/fphFgJ3gKdG4D9YsoK+P/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYqXbpm1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYqXbpm1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2baef9f5ecdso98577485ad.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779920497; x=1780525297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siYXoV5iUWIO3iQmwXOwY7S//bY4ZAgbalu7pJCn+ww=;
        b=kYqXbpm10faSerYDpk4SstV7pAaWpDuECmny0R8ae3IOOXFG1dYGGYCUeUi9ETg8r3
         QY2GjYoURfiR/FP30uGoiIpalSXS1DOlu2LPeG6YOVQ5Tu6hoclSzBcvTFKsIC5Oe8GA
         0wynN3pc+iV0Y1BAeuPJbrRlhIktOhMeWmu41W0IYJs+5VjrMbbDOcmoRIWtWjiuEOwG
         iew0uQ8iK3H/Wkxpf5heOi1JJRTUy4GSypsLY8jAQKAK6CT3uJtJihnV3QsYW2xWJgIF
         r/gd5pAJs+dZyM3BwAfvWis7wVeTLS10x2l0q9WeHkBKRUihj+SIFbaWdchG/A5ItJMh
         d7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920497; x=1780525297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siYXoV5iUWIO3iQmwXOwY7S//bY4ZAgbalu7pJCn+ww=;
        b=PaNRKG8cgSeQ5RBA4tbNBGxwP7OqgRfYkjaYl8feqEaOlfR++ZziFEfMp9lusNTMNr
         PhptR1oiH2x57WLvuq6mZGlcWBKEWu3HstDMGXzZ0VPwDrkYwnzEGbMq04e6tBooFtF/
         cb2A8aZYEAvKOPD0fH3RuryW413kibkMANDku/Enhvyo24X6gJRXHcmTl1yeJsuo+4gC
         G5wJ8wtrnsGySHR5MSsfK1bpRxxQiUAZfVV1TWzNFhWBXWV1MdNF4OTjapIl8qeyVOBe
         JS3ObDhd+P+yQ/HYS5ZYtBNqaovUhMI4M/alTASEFocUI/V3oh/ZHfYEOgYcIxeKwGue
         X3Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+9UD3gqojv2n/WH8jQQc014E1y+sKRbheRxEgegvUc/NvFmEuVjhOzTLyd9HnZDCsMgAcMBSf56TnFhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8iXwnGuVL3RxJy9bdBnyq6WwNKiA8f25IrJHFRftrDINiceW
	1S2ssGcew4vAQ2mj9oumfepJf9kcKyWrD9Ux9WztOu9l+DQhv+1OIEAH
X-Gm-Gg: Acq92OEQraM4Y2DZYFr/Plq4HDX+UsfODxSt+YMOsQZHcVtn1T4RxGznasrjn5Pomzz
	cxVYmquZ7p95agBYSjNGfcVcZ37PQwjbstMbCGiwEVYj8Y1kuYld5uqQg05jh9cTsRFQfEpeC0K
	7b40UXE2DdG9/bHauldAB8dS7m6WUQv/R/2YWj/MwTXafNFdJSsAz8loCWEYeWJUyvu5enGffYb
	GqxTjPimpB6/r2cvbzFB3BE6m6+OQ5+TcAE9TFmVP6wZVxUrX38OateMiOF+NVBs/OTRq/c2Qkh
	GkKaG6IsIp0uDtdE/a7RBUY+UJMlGi7ywO8vDotkkzFAikgUB+j7OlMen29Oyyvo9FqrqTXKFdO
	AfwmOiVc3Zb0vQYfffp4iB653a1xiiEzlZ4ENlW1YIKCRLbXZUhJZqx3GMosEB6t9T4xlELmSf/
	FCgu3CLWVRc2CmJIYl2XnptGhsfcyLE2a54f98+89cKWyckPmr5LwUDMw=
X-Received: by 2002:a17:902:ebd2:b0:2bc:b141:8551 with SMTP id d9443c01a7336-2beb06f81f3mr277899805ad.19.1779920496943;
        Wed, 27 May 2026 15:21:36 -0700 (PDT)
Received: from lappy ([203.105.74.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58fd888sm167783445ad.73.2026.05.27.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:21:36 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Wed, 27 May 2026 22:21:22 +0000
Message-ID: <20260527222122.10620-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527222122.10620-1-derekjohn.clark@gmail.com>
References: <20260527222122.10620-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds intensity adjustment for the left and right rumble motors.

Claude was used during the reverse-engineering data gathering for this
feature done by Zhouwang Huang. As the code had already been affected,
I used Claude to create the initial framing for the feature, then did
manual cleanup of the _show and _store functions afterwards to fix bugs
and keep the coding style consistent. Claude was also used as an initial
reviewer of this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v7:
  - Match on write address for rumble reports to prevent late ACK
    from causing synchronization errors.
  - Use spinlock for read/write profile_pending.
  - Use smp_[store_release|load_acquire] pattern for checking
    gamepad_registered to avoid possible races during teardown.
  - Use struct for rumble reports.
v6:
  - Make all timeouts 25ms to ensure at least 2 jiffies in a 100Hz
    config.
  - Add spinlock_irqsave for read/write access on rumble_intensity
    variables.
  - Gate all attribute show/store functions with gamepad_registered.
v5:
  - Remove mkey related changes.
v2:
  - Use pending_profile and sync to rom mutexes.
---
 drivers/hid/hid-msi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 96710d80543d4..17b0707ecd46d 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -266,6 +266,11 @@ static const u16 button_mapping_addr_new[] = {
 static const u16 rgb_addr_old = 0x01fa;
 static const u16 rgb_addr_new = 0x024a;
 
+static const u16 rumble_addr[] = {
+	0x0022,  /* left  */
+	0x0023,  /* right */
+};
+
 struct claw_command_report {
 	u8 report_id;
 	u8 padding[2];
@@ -308,6 +313,12 @@ struct claw_rgb_report {
 	struct rgb_frame zone_data;
 } __packed;
 
+struct claw_rumble_report {
+	struct claw_profile_report;
+	u8 padding;
+	u8 intensity;
+} __packed;
+
 struct claw_drvdata {
 	/* MCU General Variables */
 	enum claw_profile_ack_pending profile_pending;
@@ -332,8 +343,12 @@ struct claw_drvdata {
 	enum claw_gamepad_mode_index gamepad_mode;
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
-	spinlock_t mode_lock; /* Lock for mode data read/write */
+	u8 rumble_intensity_right;
+	u8 rumble_intensity_left;
 	const u16 *bmap_addr;
+	spinlock_t rumble_lock; /* lock for rumble_intensity read/write */
+	spinlock_t mode_lock; /* Lock for mode data read/write */
+	bool rumble_support;
 	bool gp_registered;
 	bool bmap_support;
 
-- 
2.53.0

