Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF54F3934
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164747; cv=none; b=klwTvBgrNPSK3f9x4CnN/NgxuKvTiRV2dlgKcQokTROwYs722HG50vyEieo5KrH6D4s7IhqS6Y0VH3WlEC1L0py4pV3t4nOxLo/tgOAaD1oXyoVLaLrw0SkvQXdS5G6XOXCn8IlV3ly6ppcjYRYxNofKWIE6okgPOj1TegfEj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164747; c=relaxed/simple;
	bh=KD5UKoJaOq3FT40v3/WBlUvawNQHI1nDshyUaAxqyEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUTeil+rL1pWpohMdC4PG5q7A3haxqpAYLMzjSI6wj9m8Bs0jGKxfMYgAGfSAhgVvU/qMOx3PKSNLe3AD0hkZ1rIB6Z9w2HwLvN10rPaqcT9FyD+Fwvw9ZRE8lzCsopWXOEgAjywCK9iPKSvcKmCf2va+ChepKmvL+a1qKrHoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXhewbrj; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXhewbrj"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so341249e0c.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164737; x=1790769537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oU/hNcBHQpDscJy30gAuiISdS9B0i44/hUOZz7OtGDM=;
        b=BXhewbrjJuAcGZKGaUor9tyUDnkKAN8KIY24hW2yAdptutOBQxEewPnoU+PE0n8maB
         ECKLsMx+jzzfdj3Gpnm8bTfn4FY0rpoVgQwlHq84DQS/nrKC84F0h9Y5cvp0ERFDgoPE
         HLZf3pcmUei6yWqsZXXVMXBZT+9W9WbbnDFEboZOGut1kdk7TWk2XCweZCNoT4UM14K+
         IMs5mxTI309+fH6gd+Wcvn33fc3SmRg20iLqJguvdcp3IhAVKYg3ConcfOyT7NOinpj3
         A4MAmRCvKnHVVq3rQSpXvrmW5NHmRJ55FRr81oVpjdfyvMYjMn4DWhccCTbsymsYJ7r/
         LYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164737; x=1790769537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oU/hNcBHQpDscJy30gAuiISdS9B0i44/hUOZz7OtGDM=;
        b=mwYuKAwVwY21CUTxc5CWkdUdXC2KS1pkvfeaKxCERuoP0y3DHr5CAznsTBDF3hJN7V
         /ntoLR2u0OSGzFHDWeVLm+SgAPVWG9wKpJF4t+vSNOpCLbpNBboJF3rP4YnB2BsD6Y+P
         X2iVHDQXc09M2vbJL5Ii4NtpREgZK2lfx+4PoGfsce984CnmJvVwdMvKBKP/mjPcinbT
         xZJnKIVXVXLb0mqM6UQKj9bVcGw3eA0MkD5yFmkHY6tNfR/heUqT1xwsmoq6imOTk92a
         CbbrkecTvOp0PdVjG7lI0HucKHCEmo7XPxiz6j10Ux2wKdCjs7hBLsIPIZR8uPjmbgIn
         ybIw==
X-Gm-Message-State: AFuF++m/58OabT8ooIk2qSsl7E5muCaoQnC/zzGLiZZcAC1ujyhe2Zqe
	gy4IMPFETEpfuPoTGZRA3sxc/OGU7uyXYICePQgfzogzDJxUMxg4cvrr
X-Gm-Gg: AYBFou13lYqn9thII+03vxuD+KFaBUF1Tsy/BVYn5qQOgXxaBdYbasX6wSNp0k5U4is
	/6RsX3vOigfPIDboIFMmfcrr2OyUmBmLNpg3RxPSoVR+OAjIwKSZLtEMBltfePjs80rTu3ilx/Y
	alhzQfDDzOgqXCKI5Hzj5ckKOrwuMI0F67YuTDE1c9NJOTUMX+O2j6WeEnuiwBeN1rlKX/hiJ6J
	YBtWI4P6OCWaWnlN1WyqFxysQYHj66uHhHtA/SwBbIjJIZAXCAILqnGf3HrxTaO24z/tthJW3uK
	ZDMeR+8tfa49RWrDcZ/tPq0ozF+RfnYNqhIKhhAmD4vwR/6rH9lepav7c40kVWM84EVsee1QEYz
	qNXWnAAkIjkUDfg+BijD0cTLcghUOkVkGb8OW/pB9QD3db2hxv4cW0lzVmXmMYNqlbeK0O0Du22
	gqBhve2nzRPCqXlFKxXYvsFr3tYMBasYIKM2dPnR7c+k2ZFqesnTDRA5Axa7w4jMc=
X-Received: by 2002:a05:6102:290b:b0:7a7:198a:c2c5 with SMTP id ada2fe7eead31-7ac1ea9459cmr2190879137.35.1790164736650;
        Wed, 23 Sep 2026 04:58:56 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98516ab3fbasm3311403241.11.2026.09.23.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:58:56 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH RESEND] HID: multitouch: stop the release timer from being rearmed on remove
Date: Wed, 23 Sep 2026 08:58:47 -0300
Message-ID: <20260923115847.3396019-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_remove() quiesces the sticky-finger timer before stopping the
hardware:

    timer_delete_sync(&td->release_timer);

    sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
    hid_hw_stop(hdev);

timer_delete_sync() waits for a running callback and dequeues the timer,
but it does not stop the timer from being armed again. The transport is
still delivering reports at that point, and the report path rearms it:

    if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
        if (td->mt_io_flags & MT_IO_SLOTS_MASK)
            mod_timer(&td->release_timer,
                      jiffies + msecs_to_jiffies(100));

A report that arrives after timer_delete_sync() has returned therefore
leaves the timer queued. td is allocated with devm_kzalloc() against
hdev->dev, so it is freed when the driver is unbound, after mt_remove()
returns. When the timer fires afterwards, mt_expired_timeout()
dereferences the freed td:

    struct mt_device *td = timer_container_of(td, t, release_timer);
    struct hid_device *hdev = td->hdev;

    if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))

Simply moving the teardown after hid_hw_stop() does not fix this on its
own, because mt_expired_timeout() calls mt_release_contacts(), which
walks hdev->inputs; the timer still has to be quiesced before
hid_hw_stop() tears the input devices down.

Use timer_shutdown_sync() instead, which additionally makes any later
mod_timer() a no-op, so neither ordering constraint has to be traded off
against the other. This is the final-teardown pattern the function was
introduced for, and hid-wiimote already uses it for the same reason.

Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
---
Found by code inspection after Sashiko AI review flagged the teardown
ordering while reviewing an unrelated patch of mine. I have not
reproduced the use-after-free at runtime: it needs a report to land in
the window between timer_delete_sync() returning and the device being
unbound, which I have no way to drive reliably on the hardware I have.
The window and the rearm path are visible in the code, and the fix does
not depend on the race being hit.

 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0495152091e3..f25065b9ec66 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2233,7 +2233,7 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&td->release_timer);
+	timer_shutdown_sync(&td->release_timer);
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
-- 
2.43.0

