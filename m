Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5D48C40C
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145563; cv=none; b=hfXDq4Z+ROtBZYNN2PeqE9qlSGPgP6+58BcBJk/e0KnuAzhlQE1CSTfMwpKjnzeRAZXYvWhm/gZc8lTSIClHpp+LGNQjIay1z2HTpxUSmb1seyuWV7F6UaBYto7E0LhOyj8rlNZ/VqzMElk6mOKrSfM+l7tud63gR8Qfs/OumLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145563; c=relaxed/simple;
	bh=XbyXdxPtzEzK35SBgl6Z8dxuUawkH7HDJP/Pnno1J6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dIMHse6S6bWlI4XEW0wErODIlVsdZA/skc4+Q88AOtHnJXucgSPsQ4afUsZckW9tk3HTSHc4dzr+724R3FBtQE8Xagnp9eE2XGRFxghbA6BgQVodD1WfI++gUb7MsymZpwr3kgETqUbru5TmKwooegu6/GNK8NFzmsGeTqkiKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCU8RplU; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCU8RplU"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43bf9548df4so2940134fac.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784145556; x=1784750356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjRo1qwaS6KgHldUrjOUU5P6LkI4d5qbPD0QlzsVVeA=;
        b=mCU8RplUv9NwA/HHT5N/PHfgvTsGKL0NmA6yk1t8kjqmuCOqIgKLN9N0CFrgmA+fQY
         Jsgcj3LbAWHTHjCG9ho2KhMSocCnlbEHEbLScABP3M+zU7+PRNq61goXbp+af3CVRkat
         bVO7kj3r4xOgx4TlKv0Cs2+Gq0e9jrmPR+PgHyIPGzbi10E7I1VAouTyJ2eSXhZhhcrN
         pYTN/WLsIYKdV621ct3SYowiYUsSJYJjPcFZ5amD+MF5bhWy6pxpyQhsvQN2qNJK+yOA
         bdOQbM66pA3eEQt3JfwVZmwBmqOhb/2tvQJlHdreHAds9/gRSeDCxidkIclWKLck1C7h
         O9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784145556; x=1784750356;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TjRo1qwaS6KgHldUrjOUU5P6LkI4d5qbPD0QlzsVVeA=;
        b=QDj5fDFpocClg66BG1sUFlHrwGi0zJxaPp0y3OiI6+V7FE2WmmrkUtv74ugvxkXiQV
         OY6BdmQ4ZUQ25zL5txTDJwWyA2YkEJZGET27jZqarGBwXPdnIlpu07wcr6rEHaXtwuc4
         SqjsEr0Yte9/ZdmtKhWFGWgpvAzDifEaZL9XMHYf93QRW+fTFT9Jw9yFkm8HuW7eV7pG
         luY2BvdRgsYbtrJ9s3ETmT4mpsVkn0jXy7qa7yiOyqz+0/kNJCgUZ5eK+4w3iGAWoj6j
         4R6WhQ9s8Sfis8D+l/K3tm3zvrcP1lBeF4Wb2pKoYu36YAjw8iqFMBGXLY4xebt8YHnx
         MlpQ==
X-Gm-Message-State: AOJu0Yz9xs8GD0l1cA7acdduJut/peUA2BPBQ1LKlpVhB87tkHUMmJCB
	43Q8oconKHb76vIo6kv/rafdgitMxzyInr+XElXc+TJtg8ahIr5AFvh/ccWJvu7b
X-Gm-Gg: AfdE7clOXXT4TuiRLNO/QF4t1EHfKZ49hPCmVG7A7AKyn1d5XIUHUFZQs+AVxSg6N+A
	C0BPcQxwaXLBOpqZHoE28F6KSNcDUECCnwuyWIVrEVUngCz9DRyu0KJYYgLthMToThdLalyXcMB
	mQVEsS+vGOnrcqOrymLc4v+t/JrmfCGnGDATTy/IBcOH0p3GVkAz1HFtnPhnSbNDkMmn1V8VZs/
	/paTEhYX0RyoziL6G8IPh+bJ+b3ZZYslBER4lIcypEHP5tkWShO4oNhD1EgUXhsAkSJXprLB1n6
	ZSNqeCQ+xt7vojpu12TKNk1UxzntoNSDnX01wNAf0iP+aPORjtIieoEZBaeVUvEpcwbTeHcsRNf
	mQnygzVcVdQhXtcUZZ0S/g+HMj/xya7yvhYNIlTA/adjxNEBOZw/wowKW5UNrgSU516iHTFlCUC
	YSffCoHA30Xt6O
X-Received: by 2002:a05:6870:350e:b0:448:549e:7dd4 with SMTP id 586e51a60fabf-4560b4b8e7fmr4034477fac.15.1784145556114;
        Wed, 15 Jul 2026 12:59:16 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14016799fac.10.2026.07.15.12.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:59:15 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: [PATCH] HID: magicmouse: reject devices that bind without an input device
Date: Wed, 15 Jul 2026 13:58:53 -0600
Message-ID: <20260715195853.1302765-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

magicmouse_raw_event() and magicmouse_event() dereference msc->input
(e.g. input->id.product, and via magicmouse_emit_touch() and
magicmouse_emit_buttons()) without checking it for NULL. hid-input only
sets msc->input when the device exposes a usable input device.

magicmouse_probe() guards against this with an "input not registered"
check that fails the probe when msc->input is NULL -- but the USB Magic
Mouse 2 / Magic Trackpad 2 path returns 0 before reaching that check.
A device that binds this driver on that path (for example a malicious
one spoofing an Apple VID/PID) with a report descriptor that does not
produce an input device therefore ends up bound with msc->input == NULL.
A subsequent input report then dereferences the NULL pointer in the
->raw_event / ->event callbacks and panics the kernel.

Move the msc->input check ahead of the early return so it covers every
bind path. Legitimate devices register an input during hid_hw_start()
and are unaffected.

Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
Link: https://lore.kernel.org/linux-input/20260714102540.3EB2E1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
---
Surfaced by an automated review of Alec Hall's parallel battery series
(the Link: above), independent of that work. This is a sibling hardening
fix to "HID: magicmouse: prevent unbounded recursion in
magicmouse_raw_event()" [1], which touches the same driver.

I went with fixing the probe path (rejecting a bind without an input)
rather than adding per-callback "if (!msc->input) return 0;" guards,
since a single check at probe covers both ->raw_event and ->event and
addresses the root asymmetry. Happy to switch to per-callback guards if
reviewers prefer that.

[1] https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/

 drivers/hid/hid-magicmouse.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 97562765a..bd6a12e40 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -923,17 +923,25 @@ static int magicmouse_probe(struct hid_device *hdev,
 		magicmouse_fetch_battery(hdev);
 	}
 
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    (is_usb_magictrackpad2(id->vendor, id->product) &&
-	     hdev->type != HID_TYPE_USBMOUSE))
-		return 0;
-
+	/*
+	 * The ->raw_event and ->event callbacks dereference msc->input, which
+	 * hid-input only populates when the device exposes a usable input.
+	 * Reject a device that bound without one -- including on the USB Magic
+	 * Mouse 2 / Trackpad 2 path that returns early below -- so a device
+	 * (e.g. one spoofing an Apple VID/PID) cannot drive those callbacks
+	 * into a NULL pointer dereference.
+	 */
 	if (!msc->input) {
 		hid_err(hdev, "magicmouse input not registered\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;
 	}
 
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    (is_usb_magictrackpad2(id->vendor, id->product) &&
+	     hdev->type != HID_TYPE_USBMOUSE))
+		return 0;
+
 	switch (id->product) {
 	case USB_DEVICE_ID_APPLE_MAGICMOUSE:
 		report = hid_register_report(hdev, HID_INPUT_REPORT, MOUSE_REPORT_ID, 0);
-- 
2.55.0

