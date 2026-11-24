Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795516540;
	b=vtFwcRD8T5HImPcnL0bxRcHBryU1c1etn4WaM0l64jfIB9nnNpNHA4tkvunmEArOGnbu
	 Z2AAHU9OvcCow5T3kSnEo64SJpPCqEdi7bK+xfpU/2Nao67oG8qvXLaVw8B9cDyL8eb+R
	 JdwInMpiil5ihLaSxlj3mRuAhnEfB9vwBlXfZ7Qaj4zx7XCmA1/mLj7loF0AJvhpzhIn6
	 5Pktb+GTkz7g+lJaKUWdPmJusIhSGB6DQX5eVBU+djppasxtM0IGGDDQHBIaAlo5a31/T
	 /ayMLeHLreLHxv6bAKadtwRdd5bTGLDeLMmSEPBsSEz5x5cuUzgUWTUfHdRXNOiPP6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516540;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lkwMDkfjgioryZCX49o7PXJCQBe/jrTnQPOOGXCjrUE=;
	b=Bp0My8Zg0L8AfYCto+6XGEEWsQ79EPWSnzFFK026Jdnbkc1WfvXW+PDpCxrp2J9zerUV
	 EwKI0U8hk8iBQTQ7RsJkN3Dp5XO4WIHayc0H7sRyRLMS7bn3UV1ouVjSlmfVoVGBGcWDN
	 JN+LiGR3bF3KbI4KMA7ThVH8bgZP3YnVivqWO3ie9RHWLv8PabRDZBx13lKPProFh89Pz
	 7uG7jJ2/xrkTLumVZ9I3QeiYzO13Fj9g1zx2AqRC2Fat/ECa6Gq/ji/GQODrHaxVsJoWZ
	 ju1ke2iHQRdL16h9d5Y+rE3KQ7rnvcPv+32AGVEbanECr3dxi18dm6SKQ0ms40R6vSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epOyB+CW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F3606A685;
	Tue, 24 Nov 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epOyB+CW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795516540;
	b=P8CEJmBT5M6fk2SVjjpbBC2sWFt2gAPcpIRwXLPmGIFENUaAMWjCkjZ6gtM8CKRUFAJl
	 hI22EhyoQZ7vckxQDPuoeFXTvVCZ2qD8HWeg6v4U5Xz4IZ4MnEblOUlqxdTunQnYCkSkw
	 xzyOy67FJCPbASTw9ZpAGCF6csdQX4ZGrNkd1pkwKplYG8Qce4shdzNkfCVbawCt4uyW9
	 /0G0jBERuk+ES71OAAyhS5sCfRDR4a9/mZgoxgG2QBIv4exE8S5VCBs6A5PV5hC9XAmGQ
	 704xQ5kNIHMgCCByQjd5k/8VIbWlg5OgZyN3Zy+X9+qoB6auL8OVemMMcTc1WufDO1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795516540;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lkwMDkfjgioryZCX49o7PXJCQBe/jrTnQPOOGXCjrUE=;
	b=EmHzvCcwSCwRB3zD07WS9xFfcNQ35iKnSV48ftfYqFbMJDcAUsiBExVSbmk8n0xONiXb
	 anxxJ62xFspl++PGG9wq6EAwoT5OOM0CTSjvgopQGEs0POZ1DLqESc/jTbbdSBMcjPEx2
	 zOVFBW9IkFYNeObo8p0VnxwU9jt7Fu6GQ/gBg8rRhs7UQT8VlEDdZcwOFh5rWX1Bt5dWT
	 tBD8OtKdEVctKjpXVVTcIrRgqX0BfKlTjdbybRXkk8mOqSS+S+04WFaIm1zb6HpCz7H1U
	 yc4S+UytqjSSVCmv0nmbWNV2DEEWe6rAzy0oq+MqKdn0EhiMGABmfQg73xUBfGQF7Qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFE651F000D1;
	Tue, 24 Nov 2026 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795516540;
	bh=lkwMDkfjgioryZCX49o7PXJCQBe/jrTnQPOOGXCjrUE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=epOyB+CWrXVIPZ8Z9XcQ0NQ0bAPmPFEkLeL3LFpJBZtQtpkID68eHL8AKBQqgatfR
	 b75EunZ8aw63oFHVot1wJGXXVIR4fuzQC8qyC5D1BbckhTD4Pww8PW/oilO0K2eNBn
	 0QoHJJdaCKuEk2EtzJqBlotT1VMbotJ4k5sUGcDt7KQ67/nFpVupAC9Z/4CQKCMXKq
	 t5xj3H0vruirBlkFRkX8BfOyJCVgw7k/45iuSp6goG6Y3wotQv9XULyXKFnJD3A45v
	 fe5tbgjBAlZDzhVd9SeTPZtdyaDl4wgvm0XdZLueoOp/YWQJg+X/vg6riefYvmP/00
	 xVcOVM+Q3AoWA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 545054C9A1;
	Tue, 24 Nov 2026 10:35:31 +0000 (UTC)
From: Andreas Claesson via B4 Relay <devnull+andreas.aclaesson.com@kernel.org>
Date: Tue, 24 Nov 2026 10:35:31 +0000
Subject: [PATCH] Revert "HID: corsair: cancel LED work again after
 unregistering the LED"
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-hid-corsair-revert-redundant-cancel-v1-1-ba4c1418cfa8@aclaesson.com>
X-B4-Tracking: v=1; b=H4sIAHJoBWsC/yWNQQrCMBBFr1Jm7YBJSi1eRVwkk9GOSCqTtAild
 3fU1ect/nsbVFbhCuduA+VVqszFwB06oCmWO6NkY/BHPzjne5wkI81aoyjagbXZ5KXkWBpSLMR
 PHMMpJDcm7sMAZnop3+T9q1yuf65LejC1rxr2/QMSB1rVhwAAAA==
X-Change-ID: 20261124-hid-corsair-revert-redundant-cancel-8373b18be436
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Danish Khateeb <danishkhateeb03@gmail.com>, linux-input@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795516530; l=2023;
 i=andreas@aclaesson.com; s=20261109; h=from:subject:message-id;
 bh=BJPb3ySj05euN2/xgTFuifJLkqlbmlH2K5dSAKbRMZA=;
 b=YGPG6bKX40TrHCZ1fi7j4asb2LuIQjbsfjOo8WdQ3Ipc4DIIoKkgYKec26pxdpfMFGf+rzD73
 Diy+ytSxsU9DSMCLHj4sUJDQ6gBa4FEmHft2W7p8uv0mU/YrGP2WfS+
X-Developer-Key: i=andreas@aclaesson.com; a=ed25519;
 pk=oC+38UX0rqcrEjNMgnKAF1zmrTUMbQ2aH/P5Z4TZOIQ=
X-Endpoint-Received: by B4 Relay for andreas@aclaesson.com/20261109 with
 auth_id=1465
X-Original-From: Andreas Claesson <andreas@aclaesson.com>
Reply-To: andreas@aclaesson.com
Content-Transfer-Encoding: 7bit

From: Andreas Claesson <andreas@aclaesson.com>

This reverts commit e624a56578e551b77ee66eef74dc2efcd42deb08.

It added a cancel_work_sync() after led_classdev_unregister()
in k90_cleanup_backlight() and k90_cleanup_macro_functions(), because
unregistering the LED turns it off and that used to queue the work
again.

Commit cc8d022e8679 ("HID: corsair: use disable_work_sync() to tear down
the LED workers") was applied to the same branch and fixes the same
problem differently: the work is disabled before the LED is
unregistered, so the LED-off request can no longer queue it. The added
cancel_work_sync() calls therefore do nothing, and the comment above
them is no longer true.

No functional change.

Assisted-by: Claude:claude-mythos-5-2
Signed-off-by: Andreas Claesson <andreas@aclaesson.com>
---
 drivers/hid/hid-corsair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index a9f2a0447f2d..f966005d69dd 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -526,8 +526,6 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 		drvdata->backlight->removed = true;
 		disable_work_sync(&drvdata->backlight->work);
 		led_classdev_unregister(&drvdata->backlight->cdev);
-		/* unregister turns the LED off, which re-queues the work */
-		cancel_work_sync(&drvdata->backlight->work);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
 	}
@@ -544,8 +542,6 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		k90->record_led.removed = true;
 		disable_work_sync(&k90->record_led.work);
 		led_classdev_unregister(&k90->record_led.cdev);
-		/* unregister turns the LED off, which re-queues the work */
-		cancel_work_sync(&k90->record_led.work);
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);

---
base-commit: 10bc1d627c297097cfdc099377f8a13efdfffd86
change-id: 20261124-hid-corsair-revert-redundant-cancel-8373b18be436

Best regards,
--  
Andreas Claesson <andreas@aclaesson.com>


