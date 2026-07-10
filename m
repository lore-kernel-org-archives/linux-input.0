Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396E361DD2;
	Fri, 10 Jul 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665315; cv=none; b=AQSK8ehYYt57SV3UVSOditHUzzu/210BEDVfmNS9HlKg93jmJPNtyimasFbkJN2i4O3JZ+Y5IdI0V90F3HaSX/41JJjP2CtZ/c55RnzUgWmHSOYRV4DEV70m1a6iWDIYH4EWUUskWOy6Xp+XO2lJ+4kYPqJmd+Rra7bcQ9TeAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665315; c=relaxed/simple;
	bh=ELYbfcZO8ibtTCkagGe5JkbQA3pnZnQXkeCpWDC4owY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r0/ObkLiuUbA4iRFadir9HR7MbMOWI4UodL51UCApmHUPu9fSqd8tYqqVYhFHM0ZEEa8JjZZCls0M/eE7cp3/pfuUAx3e41d/iFWj5bKt3I+KCBTUmEZV24FmJH9Gse9u8ow3o9qHtsKRHu/FrJ51gSX2tXIyvB9QPQdL+o0Tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7cf3bd847c2911f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:40f17b8c-1981-42a0-a991-27af3e13b619,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:757b4a78d24abb9e093e2502cd8ae421,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-19|2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7cf3bd847c2911f1aa26b74ffac11d73-20260710
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 533094842; Fri, 10 Jul 2026 14:35:05 +0800
From: Ai Chao <aichao@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	dianders@chromium.org,
	treapking@chromium.org,
	kenkinming2002@gmail.com,
	raoxu@uniontech.com,
	superm1@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v3] HID: i2c-hid: Avoid "(null)" output when reading report descriptor fails
Date: Fri, 10 Jul 2026 14:35:01 +0800
Message-Id: <20260710063501.3963375-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When i2c-hid fails to read the HID report descriptor during device
initialization, the error message prints as:

  hid (null): reading report descriptor failed

The HID device name is set in hid_add_device() after calling
hdev->ll_driver->parse(), so when i2c_hid_parse() fails and calls
hid_err(), the device name has not been set yet, resulting in "(null)"
output.

Use dev_err(&client->dev, ...) instead of hid_err(hid, ...) because
the I2C client device is fully initialized with a proper name, providing
meaningful error messages for debugging.

Before: hid (null): reading report descriptor failed
After:  i2c_hid i2c-TPD0001:00: reading report descriptor failed

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
change for v3
- Update the patch subject.
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 3adb16366e93..0e725a0f0abe 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -792,7 +792,7 @@ static int i2c_hid_parse(struct hid_device *hid)
 					    ihid->hdesc.wReportDescRegister,
 					    rdesc, rsize);
 		if (ret) {
-			hid_err(hid, "reading report descriptor failed\n");
+			dev_err(&client->dev, "reading report descriptor failed\n");
 			goto out;
 		}
 	}
-- 
2.34.1

