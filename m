Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17121394492;
	Fri, 24 Jul 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885069; cv=none; b=ShmvdKH+d5pqYMH2D0MhoM1x9wgnqQ9N4yY5hjAGESWAPdJh8ptul+NhrWiwZ4d6GsF+RMd0glSGm/pEqveGYVKotkWS4dPUsIxlzeDIB8hJu68pE1Wamq0+nzcXE82+vOPUXbMon+hyU7VPj7vTobp0FB+1m8yxh065XfQpERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885069; c=relaxed/simple;
	bh=b+OIcDLdk8o57TP+rTxbw2kw5T70Jgx2V4nkkpBe1v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jyH4xYayi8jjLmkTcurJ6DMTAE6og/s1aH3GM1Djd2ieoR+vt10OLaguCOPDxmd5096wE9Vh0dpH/rg4cosPBvMJJGwTyB/y+oynzTjUirrZ06MnJtW/ohnIH3NPwaBqUGk6h2WlklZbKj7mwO8ikzBHMgQjjc4uHHKGDVEIY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ba2ba7ee874011f1aa26b74ffac11d73-20260724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ecb8103b-d1c1-491e-9c35-0cc8a9db6adc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8346bb12a24226b20e214d1f686305ee,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba2ba7ee874011f1aa26b74ffac11d73-20260724
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 709374669; Fri, 24 Jul 2026 17:19:09 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] HID: corsair: fix use-after-free by reordering remove sequence
Date: Fri, 24 Jul 2026 17:19:06 +0800
Message-Id: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On device removal corsair_remove() currently does:
    k90_cleanup_macro_functions()     ─┐
        kfree(k90)                     │  k90 freed, drvdata->k90
                                       │  is now a dangling pointer
    k90_cleanup_backlight()            │
    hid_hw_stop(dev)                  ─┘  HID I/O finally stopped
The problem is that kfree happens before hid_hw_stop.  Between them,
corsair_event() can still be invoked on another CPU:

    CPU 0 (remove path)                  CPU 1 (USB interrupt)
    ──────────────────                   ────────────────────
    kfree(k90)
                                          corsair_event()
    ↓                                      if (!drvdata->k90)
    ↓                                        return 0;   ← non-NULL!
    ↓                                      drvdata->k90->record_led
    ↓                                        .brightness = x;
    ↓                                      ^^^^^^^^^^^^^^^^^^^^^^^^
    ↓                                      UAF write into freed slab
    hid_hw_stop(dev)
      hid_disconnect()
        clear claimed flags
      usbhid_stop()
        kill URBs

The NULL check in corsair_event() is ineffective because
k90_cleanup_macro_functions() never clears drvdata->k90 after kfree.

Fix by reordering so hid_hw_stop() runs first, eliminating the window:
    hid_hw_stop(dev)                  ─┐  HID I/O stopped first,
    k90_cleanup_macro_functions()      │  no more events can arrive
    k90_cleanup_backlight()           ─┘

Set drvdata->k90 = NULL after kfree() as a defensive measure, matching
the existing pattern in k90_init_macro_functions()'s error path.

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/hid-corsair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 21cd8b12a757..ac12877a6db7 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -545,6 +545,7 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);
+		drvdata->k90 = NULL;
 	}
 }
 
@@ -596,10 +597,10 @@ static int corsair_probe(struct hid_device *dev, const struct hid_device_id *id)
 
 static void corsair_remove(struct hid_device *dev)
 {
+	hid_hw_stop(dev);
+
 	k90_cleanup_macro_functions(dev);
 	k90_cleanup_backlight(dev);
-
-	hid_hw_stop(dev);
 }
 
 static int corsair_event(struct hid_device *dev, struct hid_field *field,
-- 
2.25.1

