Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B83D093C;
	Tue,  1 Sep 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265624; cv=none; b=EfFPkrjtMJgiOYet2UxKfvbHowc8K+FUSQfPTw5TBHuNrsLLgC89ABIuM7qsxQo1mBbM5Htt24LuTC/L8ntXpWbc1/HCt2rM1SFtH2WhwfAp746O+Jy/EyOsY4FI3z9akBTMIK31lnIDotHYaLy1cZnAHkn8DyrD8Es0Hell/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265624; c=relaxed/simple;
	bh=qBhEri4cxwIWuUFALDcnRzEwgAEawRKtw7c2WUfU9Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hu6uiNI+xvbK6I2y1D0vbbL7XPWp7gHsKkOstiANedk/O5y0nQM0VyoRTti/B0Vj++h9vNXmYVZKnRtbZqt1w78GJdVrVGFsfofkR3rHJpN2TtbW2GNMClNNlWzJ1uEOry8aWTns9fUrbxj2Nnb9tlSHK5A0T2Z3U1Pn5Gz7SBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6aefa46ca60011f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f73f9273-d360-47c4-8da4-f955dc7d0891,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3ef49f6b601165bbebf8127b412d9f1c,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|
	-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6aefa46ca60011f19a56ed5b684f684d-20260901
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 992133570; Tue, 01 Sep 2026 20:26:54 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] Input: cyttsp5 - clamp the HID report size before memcpy
Date: Tue,  1 Sep 2026 20:26:49 +0800
Message-Id: <20260901122649.1173066-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size field comes from the device and is used as the memcpy()
length into response_buf, which is CY_MAX_INPUT bytes.

Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5 touchscreen")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/input/touchscreen/cyttsp5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 9266c07314be..e878a02dc9b7 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -710,6 +710,7 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
 		size = 2;
 	} else {
 		report_id = ts->input_buf[2];
+		size = min(size, CY_MAX_INPUT);
 	}
 
 	switch (report_id) {
-- 
2.25.1

