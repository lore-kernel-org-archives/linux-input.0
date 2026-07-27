Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECF30AACB;
	Mon, 27 Jul 2026 01:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116119; cv=none; b=sOYoC3U/8pk3S5gAdp06CN50WI4vxrm29mWsBbXI2ewMyICOZx3wuPbrkXTmWuYiwSZBJE2OGI2ME2EH8AP0FtFSDYPTNhF6bpI0tZU/ULsh7WN0HY0uaQNDYCagTq5m7RziyQiTH0+qViCF4rKDyNpX9CyliXzif08U6rGpzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116119; c=relaxed/simple;
	bh=xo7vOacbLXh/d2d6vmpJ+gqTCQjDUaohHfdSIMWP58E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ+wpLbsnu4zjVxUxM6rTlcnk1tvqzmvlqrBNbD7R5luutlRpOoY6Vbyl3Pz3CgdjdbcLDctLfcyRlQSOwui8jKCEA65/zqupAVRVR0qFbzPwlrJM4o6bNIvTBZwB8VfznkF7f8wnm09GAHD4UvxML3+S7C4opU8HVHfixGbhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 643d19ea895b11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2dffb22b-5e04-4018-9a90-ea8b3cce440f,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:a18cc97fea9539327f5514a025b397f9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 643d19ea895b11f1aa26b74ffac11d73-20260727
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1722596787; Mon, 27 Jul 2026 09:35:04 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH 1/2] HID: corsair: fix use-after-free by reordering remove sequence
Date: Mon, 27 Jul 2026 09:34:59 +0800
Message-Id: <20260727013500.23435-2-chenchangcheng@kylinos.cn>
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

The corsair_remove() function currently frees the k90 driver data before
calling hid_hw_stop().  Since hid_hw_stop() stops HID I/O, the event
callback corsair_event() can still be invoked between the kfree() and
hid_hw_stop(), and will dereference the freed drvdata->k90 pointer to
write record_led.brightness.

Reorder the remove sequence so that hid_hw_stop() is called first.
Once hid_hw_stop() completes, the HID device is disconnected and no
URBs are active, so corsair_event() cannot fire anymore.  The driver
data is freed only afterwards.

Additionally, set drvdata->k90 to NULL after kfree() as a defensive
measure, matching the existing pattern in the error path of
k90_init_macro_functions().

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

