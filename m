Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B43C65E0;
	Mon, 31 Aug 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162105; cv=none; b=SsR48lRh6c4Lm+T9tHB20cw0Wo+icULKmtPF6tvyao7JD7Y7I3sPBLvqi5k0Qv1RDTjwOISNgq3ub6U5N3BXXqxVo5IH0Cc393iNqSr70eSwtkahWZy7qHjvxWi/4Vv5UoeZwN8DjUkVYE440N0TB/NWVlV2FckJoqtDcnToB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162105; c=relaxed/simple;
	bh=favQa28W965/UbJuTSYW6LF5r7h59Pg1wVk2SdSFKJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDv0ZO3WzlE9GIUy0HP1b73XGRkghz60sjDKw0/3Y6IfFgHIAJ441lX3pKg6BukmRJTYhbhsuVmk1rO3k0+Y7dwkAyziSFfdz9fkM/5FIhS/l4UEIzkEHbL3IUfY7SaaCOLeQL8nBSrTNfUO5tQxTOdouS6Q55jmU4NChYvIEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64546274a50f11f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:54a9cb8a-4bd5-41f9-ab00-c377a4c7f27a,IP:0,U
	RL:0,TC:0,Content:38,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:63
X-CID-META: VersionHash:7db8b62,CLOUDID:41c2e23df2eaaea67ccae2d8f40ac34d,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:4|15|50,EDM:5|-
	100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 64546274a50f11f19a56ed5b684f684d-20260831
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1111272247; Mon, 31 Aug 2026 15:41:35 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jeffin Philip <jeffinphilip14@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>,
	syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com,
	syzbot+0b8bff5929865345b29e@syzkaller.appspotmail.com
Subject: [PATCH] HID: corsair: do not re-schedule LED worker after it has been cancelled
Date: Mon, 31 Aug 2026 15:41:30 +0800
Message-Id: <20260831074130.71683-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering
LED to fix use-after-free") moved cancel_work_sync() ahead of
led_classdev_unregister() in k90_cleanup_backlight() and
k90_cleanup_macro_functions().  led_classdev_unregister() internally
calls led_set_brightness(LED_OFF), which reaches the driver's
k90_brightness_set() callback.  Since that callback schedules the worker
unconditionally, the worker was re-queued after cancel_work_sync() had
drained it, and the subsequent kfree() freed a still-active work_struct:

    ODEBUG: free active (active state 0) object type: work_struct
            hint: k90_record_led_work

The removed flag check inside the worker itself only stops it from
dereferencing freed memory once it runs; it cannot prevent the re-queue.

Fix this by making k90_brightness_set() a no-op once removed is set, so
the LED_OFF update issued from led_classdev_unregister() can no longer
re-schedule the worker after it has been cancelled.  Also apply the
cancel-before-unregister ordering to the probe error path
(k90_init_macro_functions() fail_sysfs) for consistency.

Fixes: eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com
Reported-by: syzbot+0b8bff5929865345b29e@syzkaller.appspotmail.com
https://lore.kernel.org/all/6a937393.1d9ded08.62e62.0113.GAE@google.com/
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/hid-corsair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb565d..73b3c1ff78c6 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -194,6 +194,9 @@ static void k90_brightness_set(struct led_classdev *led_cdev,
 {
 	struct k90_led *led = container_of(led_cdev, struct k90_led, cdev);
 
+	if (led->removed)
+		return;
+
 	led->brightness = brightness;
 	schedule_work(&led->work);
 }
@@ -507,8 +510,8 @@ static int k90_init_macro_functions(struct hid_device *dev)
 
 fail_sysfs:
 	k90->record_led.removed = true;
-	led_classdev_unregister(&k90->record_led.cdev);
 	cancel_work_sync(&k90->record_led.work);
+	led_classdev_unregister(&k90->record_led.cdev);
 fail_record_led:
 	kfree(k90->record_led.cdev.name);
 fail_record_led_alloc:
-- 
2.25.1

