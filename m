Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A2360ED1
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448537; cv=none; b=J2ZD/3I0o5WZ4y1FiSH4UuHpI6Dhoj+7a++oAHrTDoHUn41Rg0lftvCZvqfFoV0pSPe/WFTKRGfyO78Y3CdRnSSq5eF7Femw55jN3+wL6ekAy9DtTSphARh/lmnnhKb2Q5n7y5KYzKM8Qlo7ZSlKPAE/5wNUWK5hKl8AIiY4iL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448537; c=relaxed/simple;
	bh=AMYrxYdA9FRYv9Q3mCCMzf8djMW/KW1Qg/yUarE2AfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqApxbaDI0n2OyMVUCu6UawUYvUHlVj/RiooHzhdcIXl0S2bTcmhrvyxreS+oCvX+vCB9OlRBz25JGk264uCW2mCvSbhV3Sj8MTcqbGNmLXcfnj49MZXnfI7ONimE70Qo26fNSh096PTUx8tetfhqclZpQQMdw1eeNHWtbiIZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew/E8gGu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew/E8gGu"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914bf8abeaeso9645485a.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779448535; x=1780053335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKJKVTseUcG8+b8RERg7E2yGGvVoPibusKcYNOJYIuM=;
        b=ew/E8gGu5KoYUaLKairjPFQB4BdaMXpj9PQaLJzkpo+rHNJJIC6vrYjYZgA/EzSzvz
         pYjycScG+8lTlvQxE+Zl1NSlW/vRkYv8AOSgkoRPe8Mg7u8vV54NGhvsV7jEnpGlL+GA
         7v+RRmaBYv7pnHduwjfosZhTw5tmGk6omzSmRs2Z9pZrHwaXwewvSmVZs3cIuPfKpdFj
         0b0GvH2NsW4l9a5I6U3qcYsN7Hoj/XZgzBEVTU0gW8kYEVFgWU5MjQ3kZKSqjkCe7F/O
         9KgHfV75E6axt3E73+7Eg3SS8rC6pu51JARJ2ptSMZc3sBzEfzGoss//W8exNR6spmmQ
         WjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779448535; x=1780053335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKJKVTseUcG8+b8RERg7E2yGGvVoPibusKcYNOJYIuM=;
        b=iI6eEtsyCcNKvt1Gy1sjYQ9rEQdYDeTMhZCktJv2m40FVjB8ABNsTFXLmJMcZPPQr+
         LRrS7ONX6LsjUaKj51pHyMw6mURm7bFXbvyseWj3kTy5Osgdv4Py67nzrBRBoy4J6HF2
         FI7q8zvcErrY+UN89I6/ahWNloMD+kjSkRqYGjfbIusKkU1kTzGLsnRuZZsTvo/FZKVb
         rwhT+8m7MGPcrpS41eI7MRb0eEflWvDN3kbgidgnwq18zOEd3VNtJ//gg3/cnNwuX7pN
         d4Qm2DFrMKkK3u/fDirO4VPXe8pqGHVAyDRnBv+GIg+gip/ei8pc+yJv9zUsHztF1Iq7
         ZzNw==
X-Gm-Message-State: AOJu0YzdYfZUzyoobepc6ohSmB+DD9UPWnOe1MUS/+4skUeC2fTtX10y
	xtsq2KCqucLtHFT1V5o4zKLCZWoME9xtIdXFBfj/HZlcFH87tchporPmLX1WYSBX
X-Gm-Gg: Acq92OEckwoo1MkzQ06ja+Kx7OLjmhVyrNUkRgY0GF42A2hOsf3dEImqZpmIcWiiQPT
	YpSfZPa95xp1jYwNqMVpMQQuC0KwaLNguFIJrsGdaXRcwqNNvPru/ToPrIST3GGLRYpyoT8agQE
	VoqqOHk/CBq8hjv+JdAzHps7MKwz00SlFG18GDTwQgWajQbCWspCTrjVwKCfCqZKtGi5IrEDfFS
	+rZmyxrMrLjxMvAXf3LqSTk2pz3/2QhG6pL+uqMK1VuEGsXEIc4KFfPsfYn63cXZfVos5j/EHeb
	mWQ80dDcdGR4YR1L7suAC5nUeME9vOi99ZcQBHqUFRF9dvAMtSVNnObYaKA6rcjRrrgEgGP0PM7
	oQpuitpBPYSepBkyQ8YlQPRAzKj0ukoQizMkC5f+Wfzkb4fzbqGpBfOw3+k3FKnLDkHfIefmGE0
	rORZszaUcUCl5ybW8b72MeYLdEUNJCj5o/wvnNV0zwnzRmkjllvOSIgxI5CF0N2BXCowuz
X-Received: by 2002:a05:620a:2688:b0:914:a18a:164e with SMTP id af79cd13be357-914b4970721mr452758985a.30.1779448534561;
        Fri, 22 May 2026 04:15:34 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb397a81sm94204285a.0.2026.05.22.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:15:34 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH 2/5] HID: multitouch: Fix stale MT slots when contact count drops to zero
Date: Fri, 22 May 2026 07:15:27 -0400
Message-ID: <20260522111527.69428-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515175253.873796-1-carvsdriver@gmail.com>
References: <20260515175253.873796-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The INGENIC 17EF:6161 touchscreen (Lenovo Yoga Book 9 14IAH10) reports
HID_DG_CONTACTCOUNT=0 in the frame immediately following the last finger
lift rather than omitting the frame entirely.  In mt_touch_report() the
existing code only updates num_expected when contact_count is non-zero,
so a zero contact count on the first packet of a new frame leaves
num_expected at its previous value (e.g. 2 for a two-finger gesture).
The sync check "num_received >= num_expected" then evaluates "0 >= 2"
and never fires, preventing INPUT_MT_DROP_UNUSED from releasing the
stale slots.  Those slots remain active in the kernel MT layer until the
next touch, at which point they are released in a batch alongside the
new contact — causing the userspace event consumer to miss the intervening
finger-up sequence and corrupt its gesture session state.

Fix by resetting num_expected to 0 when contact_count is zero and
num_received is still 0 (i.e., this is the first and only packet of the
frame, not a continuation packet in a multi-packet sequence).  With
num_expected=0 the sync check "0 >= 0" fires immediately, calling
input_mt_sync_frame() which drops the stale slots via INPUT_MT_DROP_UNUSED.

The num_received==0 guard is critical: continuation packets in a
multi-packet frame arrive after at least one contact has already been
processed (num_received>0), so they are correctly excluded from this
path and the existing multi-packet logic is unaffected.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
Tested-by: Dave Carey <carvsdriver@gmail.com>
---
v2:
- Restructured contact_count block per Benjamin Tissoires' review:
  replace three-branch if/else-if/else-if with a cleaner two-branch
  form, dropping the outer if (contact_count >= 0) wrapper
- Add prev_scantime != scantime guard to the zero-contact sentinel case

 drivers/hid/hid-multitouch.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ec04dbafb..f1a2b3c4d5 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1321,21 +1321,18 @@ static void mt_touch_report(struct hid_device *hid,
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
 	 */
-	if (contact_count >= 0) {
+	if (contact_count > 0)
+		app->num_expected = contact_count;
+	else if (app->num_received == 0 && app->prev_scantime != scantime) {
 		/*
+		 * New multi-report frame:
+		 *
 		 * For Win8 PTPs the first packet (td->num_received == 0) may
 		 * have a contactcount of 0 if there only is a button event.
-		 * We double check that this is not a continuation packet
-		 * of a possible multi-packet frame be checking that the
-		 * timestamp has changed.
+		 *
+		 * Some other devices use a sentinel frame with 0 to release all contacts
 		 */
-		if ((app->quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
-		    app->num_received == 0 &&
-		    app->prev_scantime != scantime)
-			app->num_expected = contact_count;
-		/* A non 0 contact count always indicates a first packet */
-		else if (contact_count)
-			app->num_expected = contact_count;
+		app->num_expected = 0;
 	}
 	app->prev_scantime = scantime;

--
2.53.0
