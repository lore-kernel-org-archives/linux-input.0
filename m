Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750123F4119
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787192; cv=pass; b=lJHEDvmNbSmQe2xDDpUYZo0QNw/BmunZDoLqIpaPDmjKSuEGHXdE6wuf5oU6UDtVndNB1ejapQQzgzy6UkqF/rfAVq5ScfUeVMeW3LOBE4J5n9ZJ8v3n8YJb+klI9HZ2Dzp3M8cY89iMq3HJodPf6QXUouVeZJeR2RLlGrnjPJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787192; c=relaxed/simple;
	bh=2xWUYXS3hlwSVIS600L3aJiOw1CZNmt6HrkLyNyiszs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OGQG2grhfUfSGcUqB9Co9eRpvNz23lBy6v2mSpIAiUlCjySvNY+qWVcQDPnTj6NGpJvpD1iTsThTH1hdf/8L2Yl0c3M+4ge/ujY1JAyvx9ixt7QmLrZ3rX8PAeYRzu8AbzgpZ8tGjW1SGb7i4y/g+qATUVAv6mikvWC4aEiy8bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9CGaign; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9CGaign"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9106ea78cd8so259456585a.3
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 12:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778787190; cv=none;
        d=google.com; s=arc-20240605;
        b=cz/N4NMM6dnwuzXt0mwcSAx7vPi7gIEGBHDdJGypMfEwwc2G23mnURg2fvki0NIzoa
         PCU7W0ugtFgjcNIDU2nUwqQUOh1RB7yU4WogjQH8F4cTVdSGp58X6dboukVUi3t0bkpv
         P30wstNA0qc6ORenM9QNFJcSWH3Azu0GMpbAS2L2izN8JEuEPWqq5fhx+1QcLptiQqpr
         BUX1QtYv6i1i/5zBefQbNvF3MAYLdYr2wNJq+fn+ra0DndBigVqsfHAtwCjkPP5cw68Q
         HcUK1WHHOryNd0Bei+hNqNNgVGW2LpQ7MKi1fyYbczaNx6eEKnKrTUeWXgxjXO8MfuaF
         q7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LgwvaeX6TmcQv5XSj0XAJqOGRyULAfeIKKElkshuWeo=;
        fh=I5N2KTxEDKp55vczuccNG01QAsM1HI1uo2asqMFrn90=;
        b=cbsz94X0OR1elByfXcKia1ZQfkOXfyJOPcWANrLms7cIcW5vUlD7ak+DhkwTZioTOT
         6vh+IF6r2V1eQ4UyOo4GPgv0VR/uf5b/77TBI7PkGr92z6No9yJeF404ctoXQgi2mjBO
         RUSugUtpnUGTNS+y9oTA1QHTeP4USQOUxuj6eywPJmsGD2y30UjjHw5tWhxKe/f/n4ql
         8TdAU+uZBcZ9kZbcISOUfo0gohgO1FggMPEPc6+cLa58C680EVhaYKR8gtQeU1MYAzWp
         1PfxqnUwMmOYNc/p7iZZGharMKYbRcGLQnxNsm4aK8CnKRKteK4ivA2IJll9eCfFycr5
         dNLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778787190; x=1779391990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgwvaeX6TmcQv5XSj0XAJqOGRyULAfeIKKElkshuWeo=;
        b=M9CGaignIkgj5K1n0Xf51vmKt2QLanHHfCoiJuCpEBvAiNycSJ9WzGa/s635K3Judf
         lbrLMSgJ0qJ3W6BtCjxhd6UO5Xs+9KLePWYwBa33WMExTnuKEa7CYU95ZmDHE7hRUcyf
         S685XYa3N8ghV1Xhi2LZt3UArh4IUaMRnCJRkhd7e2si5OiodB9cZmZfetSTDjjGABjL
         NZtGNclxj1nP5yeYejvgn03JAwBm1l+lqrsyCpufR1apTWSgbhSieRkJQ606k4WyTAyX
         K3rDi4qRvQXOCyOEq1O7OHCTzYbFFHP8A7fADaZ/7TjjRwYA/eC+zc+8pqVRWWMhdjYy
         Mq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778787190; x=1779391990;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgwvaeX6TmcQv5XSj0XAJqOGRyULAfeIKKElkshuWeo=;
        b=cEXcSgutt/eId7qAYooqwaIDpjaCKTWnl1Eqh6tHT42Wi2+i+Ylk2KMOHyAPt0mTlu
         NvVGeketWTLTpGO1Pvwz1RaiL1rG8crw7IYLcXLymGeNU2AfcfEuuisFao0voRW7SoSy
         ln7Qpu6QflAxBKyMB+1QqlNXV6vnwSi2vqOawF6S0jIQPmY3WIYyKMxLBGW7jXmA+qwP
         0gEDL6Yg6XtJwgf/gEfLCff19vFU7VDtAHbxw9hNwyU9ZAo/LfKwGUgH0CxS/ylnpIao
         5+YQWtpbSrqQ01YlJaYka4pFIbRYdWAitbB6jmvp05oY88SOpxs16jw7VensHTt8X54S
         aLaw==
X-Gm-Message-State: AOJu0Yyj78YJxHXx7D+wOZDOfzqnVv5XwfCekTQ3QhE/IPmsZEqyO0LD
	/VGvEesIaG/YiZSXJwrKw/yHZfZdhycIouSZTuqbtXBvPsaXfQV5QxshWfUaEeunV+VFL8l1C4l
	5iwiJoig5Es9M2seESbmy+kHbb/5yovNDKQ==
X-Gm-Gg: Acq92OH9ayRjF+EucWC2RTaF+Y9gf3OvNZF4XwEQAdqCvqGZKCCnkhDg4xoTbEclBZw
	wTNJ9mFAaVBqzVvesbj9txbs82nGuoXBm8wHu9/3lOZpa9DWoVH4g47Gd8ITHOJewmP8uS80oP7
	rdZi7N0EL7Rfu/5DA4yaXKuRQEhHy+/NWMfOL46OdZCORC6ibeqVNjmryoLaooVO+h+5lx8Wkor
	jK85hwcORZuL39X4UWKJe1NzlaRVgfGdUgKH8qFQNZJaMLRmwLVaqqSwC4uy3HM/HG9Ih9kZD+0
	Tw7XCVWj
X-Received: by 2002:a05:620a:2592:b0:90d:3af3:2a6f with SMTP id
 af79cd13be357-911ce90c736mr150072885a.57.1778787190237; Thu, 14 May 2026
 12:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Carey <carvsdriver@gmail.com>
Date: Thu, 14 May 2026 15:32:58 -0400
X-Gm-Features: AVHnY4KeVzKrGAk34hMcBsrkJ0_q8P9Zw1fbTBxbbpm2Kg4C1pU4LWkIFBVaey4
Message-ID: <CALPvRORBFHpbos=_xpBVchK-oSZF9EnY6n5-sAQGr=qiL13FbQ@mail.gmail.com>
Subject: [PATCH] HID: multitouch: Honor ContactCount for Yoga Book 9 to
 suppress ghost contacts
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The INGENIC 17EF:6161 firmware on the Lenovo Yoga Book 9 14IAH10
does not clear stale contact slots when fingers are lifted.  Each
HID report contains up to 10 finger slots, but only the first
ContactCount slots represent valid contacts; the remaining slots
retain TipSwitch=1 with positions from previous touches.

Raw HID capture confirms this: across a 60-second capture with
repeated multi-finger gestures, 90% of frames had more TipSwitch=1
slots than the reported ContactCount.  The ContactCount field itself
is always accurate.

Add MT_QUIRK_CONTACT_CNT_ACCURATE to the MT_CLS_YOGABOOK9I class so
the driver stops processing slots once ContactCount valid contacts
have been consumed, discarding the stale ghost entries per HID
specification section 17.  MT_QUIRK_NOT_SEEN_MEANS_UP (already in
the class) ensures that any slot skipped by this guard is released
via INPUT_MT_DROP_UNUSED at frame sync.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
Tested-by: Dave Carey <carvsdriver@gmail.com>
---
This follows commit 108ac841 ("HID: multitouch: Fix Yoga Book 9 14IAH10
touchscreen misclassification"), applied to hid/for-next on 2026-05-12,
which established MT_CLS_YOGABOOK9I and added MT_QUIRK_NOT_SEEN_MEANS_UP.

That fix made the touchscreens fully functional.  With three or more
fingers and repeated on/off gestures, ghost contacts then began appearing
because the firmware leaves stale TipSwitch=1 data in slots beyond
ContactCount.  The capture showed patterns like cc=1 with 7 active slots,
or cc=3 with 8 active slots, consistently across all gesture cycles.
ContactCount was always the correct count.  Verified ghost-free after this
change across 6+ repeated three-finger swipe sequences.

 drivers/hid/hid-multitouch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 648201e..0495152 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -445,6 +445,7 @@
                { .name = MT_CLS_YOGABOOK9I,
                .quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
                        MT_QUIRK_ALWAYS_VALID |
+                       MT_QUIRK_CONTACT_CNT_ACCURATE |
                        MT_QUIRK_FORCE_MULTI_INPUT |
                        MT_QUIRK_SEPARATE_APP_REPORT |
                        MT_QUIRK_HOVERING |
--
2.47.0
