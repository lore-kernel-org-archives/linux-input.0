Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2B3815E7;
	Thu,  3 Sep 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421846; cv=none; b=f+rr99fhdvbZMIxlLDzLZo+Z4cNsk2XJPUy/h5JIU3Xf/nh6ELVL6hwAE+FT7E88XcFB94WcfmpnLZBhuqBB1nb0Eq4HuuDX06B013qG1F63yPvVZdNI7O4SqXqGnETWaDXRXxUqM2jJSVrurgAaAaP4xtCvq8/iaw0XS7HqN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421846; c=relaxed/simple;
	bh=/zMQohXiALxYoyAjy5IJeu97MW9vocyA2OL/pwZ96Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0ogTz0h5LqvcaDqd5BAD+aikpfHZqwayKmGsmauKxHjp4T2yguskFe7/J/oOv9UfgIOycCWvG+GkPtivYKUowf4Kvkv2swVyNqCGN34++DjW+U/7+0GubMjS+O2iW7RWXNi8Pp4hSvpzoh7VAiXYgsAM4yGQxLa788VvvV/cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24054b84a76c11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:715a8c89-2863-4f8b-9414-26ef22cebb8e,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:b7d9a09e5bd8626671cc9019694c7eb6,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:5|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24054b84a76c11f19a56ed5b684f684d-20260903
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1717314045; Thu, 03 Sep 2026 15:50:32 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dudley Du <dudl@cypress.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] Input: cyapa - cap the PIP report length before the I2C read
Date: Thu,  3 Sep 2026 15:50:26 +0800
Message-Id: <20260903075026.1069672-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 16-bit PIP length is used as the i2c_master_recv() size
into a stack struct of 10 contacts. The 127-byte check runs
after that read. Also clamp the 5-bit contact count.

Fixes: 6972a859601a ("Input: cyapa - add gen5 trackpad device basic functions support")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/input/mouse/cyapa_gen5.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 59f6e97d5482..0c8bc37ab3fd 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2750,12 +2750,14 @@ static void cyapa_pip_report_touches(struct cyapa *cyapa,
 	struct input_dev *input = cyapa->input;
 	unsigned int touch_num;
 	int i;
 
 	touch_num = report_data->report_head[PIP_NUMBER_OF_TOUCH_OFFSET] &
 			PIP_NUMBER_OF_TOUCH_MASK;
+	if (touch_num > ARRAY_SIZE(report_data->touch_records))
+		touch_num = ARRAY_SIZE(report_data->touch_records);
 
 	for (i = 0; i < touch_num; i++)
 		cyapa_pip_report_slot_data(cyapa,
 			&report_data->touch_records[i]);
 
 	input_mt_sync_frame(input);
@@ -2781,13 +2783,14 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
 		dev_err(dev, "failed to read length bytes, (%d)\n", ret);
 		return -EINVAL;
 	}
 
 	report_len = get_unaligned_le16(
 			&report_data.report_head[PIP_RESP_LENGTH_OFFSET]);
-	if (report_len < PIP_RESP_LENGTH_SIZE) {
+	if (report_len < PIP_RESP_LENGTH_SIZE ||
+	    report_len > sizeof(report_data)) {
 		/* Invalid length or internal reset happened. */
 		dev_err(dev, "invalid report_len=%d. bytes: %02x %02x\n",
 			report_len, report_data.report_head[0],
 			report_data.report_head[1]);
 		return -EINVAL;
 	}
-- 
2.25.1
