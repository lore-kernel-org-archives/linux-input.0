Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E94AF15D;
	Wed,  9 Sep 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948471; cv=none; b=tbp44XS5H5FlHj4TPDAbvvVtf5nizQvWSjN1X3ttnh6voxmmjAt5zKrAJyC4J958qPXLeQvzqQrsbegNtCU2Bi4a0I2USHtGw7jKJSPkkkk+hASwW9BfAyFEHkE69bDv8MuEvTQtKVgAwDHZh4/fGa76k61jW8YsBudZa3rwGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948471; c=relaxed/simple;
	bh=fAwwlBkanBN9ZgOkTuhWirWjiQo/2ofcRrGcgQiq48I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bntMQyJrCkYZ0YchX0WaOqPau1Z3GF8Dy7p/xrXRMzOqanGy/2keCBdwcrEFztlLU4Fyf40ZKTAkg8ngBWbJo6XqB7kSUJuMV8RC9CS5gnd+NY0zy12HhBo8TaT0ytRRSk5LzxFx0EWqpOcMCCbcumXkQ7t6DS9qa+TGAPkdMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4cadc29aac3611f19a56ed5b684f684d-20260909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4fbc1c53-60a0-4df2-94eb-3480026c2f2d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:f0f7894325d2a424121c0ce0deb642ef,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4cadc29aac3611f19a56ed5b684f684d-20260909
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 638644255; Wed, 09 Sep 2026 18:07:43 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] Input: matrix-keymap - reject keycodes above KEY_MAX
Date: Wed,  9 Sep 2026 18:07:39 +0800
Message-Id: <20260909100739.3107556-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

matrix_keypad_map_key() validates the row and column of each entry before
using them to update the keymap. It does not validate the keycode before
using it as a bit number in input_dev->keybit, which only has KEY_CNT bits.
A malformed firmware or platform keymap can therefore write past the
bitmap.

Reject keycodes above KEY_MAX before updating the keymap or capability
bitmap.

Fixes: 77a53fd21870 ("Input: matrix-keypad - add function to build device keymap")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/input/matrix-keymap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 3bea3575a0a9..e4227e96aa4e 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -35,6 +35,13 @@ static bool matrix_keypad_map_key(struct input_dev *input_dev,
 		return false;
 	}
 
+	if (code > KEY_MAX) {
+		dev_err(input_dev->dev.parent,
+			"%s: invalid keycode %u in keymap entry 0x%x\n",
+			__func__, code, key);
+		return false;
+	}
+
 	keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
 	__set_bit(code, input_dev->keybit);
 

base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
-- 
2.25.1

