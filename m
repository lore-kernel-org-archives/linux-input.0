Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A312405E1
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751644; cv=none; b=ApCgRf1l5Xl8j7MJGZiqvtbCwugJ5+QUYllLOFcGSdPce8Fc604+RtMPC90nY5+6uZ9PLWACJL6KoP+3UPQdHy1tj5KgL1cJDga/kL10CmjP/rskYL6uGJyVVX/IJzKgbIK94sJEovc9C+lWJMUMDAVtij7S+PU42Brf7CsfkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751644; c=relaxed/simple;
	bh=OT6Zl/hHRw7EPQ1OQ6DYL9Xti2nBrEUcQwBVhNAy2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRljRou5A2B6gEmwiIyVtk5q6S8btD8crdIeGJOZ63XW7gpWssKB1Z67Qg2OJeonSl7XERvrdlld2yeatN28qf9e16kNl0XDzHw6wEHz+lJPNMOjGgv07VJdVn+UQ/8Zctc4KpT6fUQVX7YK+8f1VH/HqZJ8UNZ33Y6uzItxQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRKZ1Wef; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRKZ1Wef"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5199da044e6so5707031cf.3
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781751642; x=1782356442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjOWM8Fz7RsEt/VUPLUWR6H2bvEPTsT21fE+7hr3SSo=;
        b=mRKZ1WefKNFfh7xEjMWMfb57p3GPp5uRcKQ/LKKkYdjUXpRjTsAxlJyaseI9t+aR3p
         bIUzUlE0KaAaCAaRiT6qK27kNaBFrMFPbAgJAuf13fXW1uMTcFfTND6kxuSXokIVCId/
         8LhR6zbYjDxBlYG4iod7LYJuOShCFQ9NSqHkE1SI6xafejyD1T8DZXo6xyeJkX/8P5bt
         2ApTGVScqvY73QCiUwB1Tx0RhjhNlY3uG1U4APc9P+hvJ35bW1QQietDkwTdqtuAx7Sx
         ia2T38moG9AZlavPlmzaiCqAyY16xMeTktjQ/4/x2GJlNKEI8lhrCyFHPn68DsnVrQZZ
         7YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781751642; x=1782356442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjOWM8Fz7RsEt/VUPLUWR6H2bvEPTsT21fE+7hr3SSo=;
        b=S55EM8f0HoByRl6w6xSQeqsnskS5mtTpoTvUzfkRlngb0EVuEjxroqh6dnv/KEDGpm
         QWER7ZwkLViB6TGrzXfPVOzt3tVvsrvYPsWo3UO+HXWUMoF7cWxzIhZyaBLqS8yRreZR
         neeTitu+M0ij8YI4tRUvceZYypvImx3bKBGtIVJRpHQLJ5YFanhi2qXnw57thVIvvKP4
         poYgYbiipaGXKj3w92DlhFJYtsR5aB9hQTJw5A/85VYhguEK0THHcE6WR4bCwN4XuEx/
         h9tYjDgKtN+NJVwtLh19xws/Z5bsdRcQX3z9UqPLQPPpwA59idNHWvMyg8IShsapxOxr
         35KQ==
X-Gm-Message-State: AOJu0YwZ6OnOmX7mULZ4pu3GCKJTlzRQrV0YmdqkA1UxXkLGUbPV6KrP
	22iqcdBCiL517VfNkcldOVrWE9aVv/FNa6SGT8eqCq0S0ocW3cPpgNUW
X-Gm-Gg: Acq92OE3/fE6ah745bGZC8tRSDTGuLmwDCkJUY9GyJX0uY2NIzAeexxx2Ea1PI//wup
	qS2tHheZ3M2XuOEvDPykbQY8B0XeF5schIeePcUhx9WDUg3jbmEHuRXOH+QijMbXZvAdDk08xnu
	hhowtNRDshhi4XogjkUrV27pj6cTn5g2RhZKqdmFAW+UIIppi5yKWRVOspVmi3RanT7Mex+T0yU
	K4lp42FeIJEnl4gCcoS4uscgN6eED+eGSeI5HvwiZQIeus6kXHxpRnwDqO6fTtlLCpkjE3Y+PkT
	hZzNbEe8LHWrIInOWp2D3XN0sHwf9i8ZzXLKdPuIIaN9imDY4EPURc4+XARGAt7QBJ+mPrYDjDZ
	TKO8G8/svpFmtNw9l63JUMImqQ6wtzSAtXt3TTSgnq6aPMjT4cXSfUE9x5B9ngCjYwUB5HaBZxT
	1jqJ+8MgXtSF4nb9u1jxSNuBFr3eVVUDgZ0GPzrbBY88Vs48cysUJh1NINibSIzj4bQ4BaB8crz
	ktEA1U0IZN9XXx7rpBADRBc3Lpcn6fu
X-Received: by 2002:ac8:7f93:0:b0:50e:a1ab:67ea with SMTP id d75a77b69052e-519c6f3dbc2mr27789611cf.40.1781751641662;
        Wed, 17 Jun 2026 20:00:41 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm183849021cf.4.2026.06.17.20.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:00:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: roccat: bound device-supplied profile index
Date: Wed, 17 Jun 2026 23:00:35 -0400
Message-ID: <20260618030036.1880139-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618030036.1880139-1-michael.bommarito@gmail.com>
References: <20260618030036.1880139-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

kone_keep_values_up_to_date() and kone_profile_activated() use an
8-bit, device-supplied profile value as an index into the 5-element
kone->profiles[] array without a range check. A malicious USB device
claiming the Roccat Kone id can send a switch-profile event (or a
startup_profile read at probe) with an out-of-range value and make the
driver read out of bounds; the result is exposed via the actual_dpi
sysfs attribute.

Reject out-of-range indices in both paths.

This was found with static analysis and confirmed with the KUnit test
added in the following patch (KASAN: slab-out-of-bounds).

Fixes: 14bf62cde7942 ("HID: add driver for Roccat Kone gaming mouse")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hid/hid-roccat-kone.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 58654cf78f0df..17495fcc8b7da 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -36,6 +36,8 @@ static uint profile_numbers[5] = {0, 1, 2, 3, 4};
 
 static void kone_profile_activated(struct kone_device *kone, uint new_profile)
 {
+	if (new_profile < 1 || new_profile > ARRAY_SIZE(kone->profiles))
+		new_profile = 1;
 	kone->actual_profile = new_profile;
 	kone->actual_dpi = kone->profiles[new_profile - 1].startup_dpi;
 }
@@ -793,8 +795,10 @@ static void kone_keep_values_up_to_date(struct kone_device *kone,
 {
 	switch (event->event) {
 	case kone_mouse_event_switch_profile:
-		kone->actual_dpi = kone->profiles[event->value - 1].
-				startup_dpi;
+		if (event->value >= 1 &&
+		    event->value <= ARRAY_SIZE(kone->profiles))
+			kone->actual_dpi =
+				kone->profiles[event->value - 1].startup_dpi;
 		fallthrough;
 	case kone_mouse_event_osd_profile:
 		kone->actual_profile = event->value;
-- 
2.53.0

