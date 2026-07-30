Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40E7262E
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415425; cv=none; b=gDN7a4VbgrsxEJUd+xMjT/8BrZ4jclfZMYfYdHCgwELZ5KqbMneEh256vZba6lnL20nqfEuoenUMBcT0NQCkz9S1hWTE48agFyJ5+xzybFvbosgigbPT2s2IO2KjCRpAzcRcUf15BwqZ5A7kayTXQOjdysaeBMpd31d0wh7q/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415425; c=relaxed/simple;
	bh=HKj2+OMJdjPXviyhdqDIB7/f7wKaOPX/Y+2YRl8D1J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eaL23v8jJxMFpBBtCgdZCyg4q+R8HEdIPHKa+tjzh4IQkP6TLIxpNC1pXX3xCs5zoTbw31PiV65Qw6ZhxVnIi5IUPPW+N8ittum0vSs+aEliq7zU+1g8t5LjDY/7TkjaY0kpIsLW23lzJ3tsPntkgIq/rJC9xvCcmCGnDLTGrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm9zFQG8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm9zFQG8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso131634285a.3
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785415423; x=1786020223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMHmTpo3ZE5F+kFYkZNv9h5vYv5Oe/w9mfWYxdpya5c=;
        b=Cm9zFQG83D1ZP9PdD6tc9rIz9kV0GuU68TwaRcb0UjDuBfGQjh8Koio+PNDVhTk0t7
         cc1UtvQFxi/RFbPAjdgOQN4NBXSuROmLdksLvYD3l9kARvcyAPn41dHjYQL3h/LAejt/
         hVOFKRw+8GV691i7vV6Q+4RRdiyuxa1E7pkTnXDV0oqaFnBUSYwHorugUdk7xzGBHjNu
         QK+wR4+PhInzENDUzLy3ymgERctZwSmXK/ctBL2d2pDxK2s9UZDaG07HE13ldYRanx8i
         frtTWKbdClGe/tSUAys6dT2xABvMQheEOfgI8p8I1OzavjWYyYwsl379WD2oveT5Diuo
         ggfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415423; x=1786020223;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMHmTpo3ZE5F+kFYkZNv9h5vYv5Oe/w9mfWYxdpya5c=;
        b=lAOLeuIusEx36aXo2tLSVo3wsMYo+7WgqJukcioCi8rL/DxZqQDMW3hyLNns+K3/rF
         4IR8THJnPHj7nHhdn/IPPaEeGioot5vHxy5Tv7GXlEXi54UeSaMDPxELc62hH5CavPPu
         hbfb9fQAnfJlWbSU8JRvqqr3BENKbKvHGcDV90DrJBrYGnQu+OHTqvGkToGyoItJHa0b
         fVEs5l2j71BljrkFqrOqdi9wghOIkx8F4MG9SamXFUihsRd/PAEkw7sZPBm06FmBlL8H
         Yruik4tCJKnmaRMPmWi8rXxoNwSIvhZsIoFVSL1VbBqSF44VyPio7MwE1EDGt/qZbpyv
         rZcw==
X-Gm-Message-State: AOJu0YyILNgzcA4RnWyUoM4pZ2+ACI5P7NMM/a2VDn7ywNKtUtFmu3Pa
	BfKQzmgMADTWfrRPCxZh3x4zi8+jDthiv+/9P49kmGBEU8Ol2n7mKFh9m0a+nQ==
X-Gm-Gg: AR+sD12FkAsmuacknzYfVHNsydIU0N/mYPYVRFVRZQB8sXDFwMgHsWUI16EE5eGYun6
	72Z9b57xUFFMWWWB9kC7cnpIefhXJy1UT0g4cY2xr2sjoOOY9jOnVtbRgN7s69mlH1cftrJ9nNG
	CKIWHaiCDVom61wHqMY+a++KsTq8DvcQYEwDqq0WnZLwT7sx+VzNuEAHnJPDIN0e6kEDwDxm8mv
	gSbH3xXnndz5pQDM/5oZygiN4T+gU+NcO1icEF+SG6d5L12PjEpfi3RXOiO7QzzXjb5a/QI1AFT
	Lk7mO2slbhoJCxg7w926QJe9qBqftVj+LIWfJmSRfwBcEUp8SBe4/I9PfT0op1LeMH4NmMNPNgn
	acKMDIL0zfinJRywKxioZl+Xdeh/W/VZzsU79Fw6JX33LkeqriSVD6ydu5J3OZg3Ks898wFnKfB
	/gU2UkmalI3irhuoHIu+SYno/EcolhNBIJ5UeC3Pr/A7r30/DL1dgjZl3AhA==
X-Received: by 2002:a05:622a:2993:b0:50d:900e:c1c1 with SMTP id d75a77b69052e-52b3837440dmr22478631cf.7.1785415422788;
        Thu, 30 Jul 2026 05:43:42 -0700 (PDT)
Received: from fedora ([2600:383:440:7bed:54ac:9f45:f987:a319])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b78d0esm40245761cf.13.2026.07.30.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:43:42 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v3] HID: multitouch: Fix stale MT slots when contact count drops to zero
Date: Thu, 30 Jul 2026 08:43:36 -0400
Message-ID: <20260730124336.637339-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
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
v3:
- Resend as standalone patch; v2 was sent with incorrect subject "2/5"
  (as a ping reply to the original series) so it was not recognized as
  a versioned respin by the maintainers.  No code changes from v2.

v2:
- Restructured contact_count block per Benjamin Tissoires' v1 review:
  replace three-branch if/else-if/else-if with a cleaner two-branch
  form, dropping the outer if (contact_count >= 0) wrapper.
- Add prev_scantime != scantime guard to the zero-contact sentinel case.

 drivers/hid/hid-multitouch.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ec04dbafbd99..56a3f29d4938 100644
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
2.55.0

