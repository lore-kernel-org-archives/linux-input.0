Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351A30BB91;
	Mon, 27 Jul 2026 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116120; cv=none; b=r5KCxb9bfS2S3Ik4OJqwAfVMeTpL0AJVVZAjPeX2+M4DuGYUvNMS3nNxhfV6rEATLU0Yeqd9DFyU78Qg5lKDIAGd5dPDkxHcuih1QSoCUkZb7NEcbo8gj9ZYXKuSRrmeQBGHmgdKJS4LqhJiJuWQi3DAIdwfQkRNP1KFWQYyBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116120; c=relaxed/simple;
	bh=XbLpkp5j59tTfumwGlSLX+bH9fL8TcdHoc1OBUYJpX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENmpSBUQXhECMpC7EchBkUdz3n/Wh6/LdqfAMqzUZ07XE3rSoEf/SWtsjCsNWz1vyEkNLOiKXgVOfxmQmyKadfSdqCvpv6NKS6LvaOi0oi+2JhKOZblTJ26D61qPv27gCMhTi5M+Ehc6QcRDB9kt0l+SqPhj/AEMr7n9CXiE/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 646798a0895b11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c41296c7-ea72-427b-82c7-47c31552cb9f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:024ba80f794cddec34eeaaba3255c2b0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 646798a0895b11f1aa26b74ffac11d73-20260727
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 147191893; Mon, 27 Jul 2026 09:35:04 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] HID: corsair: cancel worker before unregistering LED to fix use-after-free
Date: Mon, 27 Jul 2026 09:35:00 +0800
Message-Id: <20260727013500.23435-3-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260727013500.23435-1-chenchangcheng@kylinos.cn>
References: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
 <20260727013500.23435-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cleanup functions k90_cleanup_backlight() and
k90_cleanup_macro_functions() call led_classdev_unregister() before
cancel_work_sync():

    led_classdev_unregister()     <-- may free led->cdev.dev
    cancel_work_sync()            <-- wait for worker

If the LED worker (k90_backlight_work / k90_record_led_work) is
already running on another CPU, the following race can occur:

    CPU 1 (worker)               CPU 2 (remove)
    ---------------------         --------------------
    if (led->removed) -> false
    (passed the guard, about to read led->cdev.dev)
    * preempted
                                   removed = true
                                   led_classdev_unregister()
                                     -> led->cdev.dev freed
                                   cancel_work_sync()
                                     -> waits for worker
    * resumes
    dev = led->cdev.dev->parent   <-- UAF!

Fix by swapping the order so that the worker is cancelled first:

    cancel_work_sync()            <-- wait for worker first
    led_classdev_unregister()     <-- then safe to unregister

The removed flag is set before cancel_work_sync() so that if
led_classdev_unregister() internally triggers another brightness
update (which re-schedules the work), the worker will see the flag
and return immediately.

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
---
 drivers/hid/hid-corsair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index ac12877a6db7..278c6efb565d 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -524,8 +524,8 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 
 	if (drvdata->backlight) {
 		drvdata->backlight->removed = true;
-		led_classdev_unregister(&drvdata->backlight->cdev);
 		cancel_work_sync(&drvdata->backlight->work);
+		led_classdev_unregister(&drvdata->backlight->cdev);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
 	}
@@ -540,8 +540,8 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
 
 		k90->record_led.removed = true;
-		led_classdev_unregister(&k90->record_led.cdev);
 		cancel_work_sync(&k90->record_led.work);
+		led_classdev_unregister(&k90->record_led.cdev);
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);
-- 
2.25.1

