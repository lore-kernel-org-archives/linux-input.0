Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBB360ED6;
	Fri, 22 May 2026 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434851; cv=none; b=XXBe4pGW3TcHXSNiNwoITCXRmmDfKDyqCpA8Hus5vFJXPMqsdpnCcHVGAsgFYmCKlPGeJZRRagXCtKpfH/EJL/0oh0L94aC2HEtexEAo5uG9rt6Enyao+uQbZZJDWWqCz8kE3wTXQXuZgdZe3d7aTtt7K82JvGmyHujbmfStKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434851; c=relaxed/simple;
	bh=yQZodkXrK9Y7IwruKslbBJ7GjGtOUMOj/wgRpfUHRvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sBgTjFEsyS9krdJs3eZ4ojWfF9nTnaXd5fF5rvAPAQc6bkbrE/aonx2yDdWaJmJvGz7CWy1E6JeAqq1FtLQPFcIfB458PyVlqFy4OHjqkNP5R0Cjf2H0kMQTHYBWAhNOTBg+SevhjtbZvzoR9o1+7QZDU90eLiCejHaTWtIyf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ac661a6255af11f1aa26b74ffac11d73-20260522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e448061d-c7ff-41f3-a342-0199c48a08d3,IP:0,U
	RL:0,TC:0,Content:40,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:fd021f0ceefe3bba85436a022c5d2c4e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ac661a6255af11f1aa26b74ffac11d73-20260522
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1732570048; Fri, 22 May 2026 15:27:22 +0800
From: yaolu@kylinos.cn
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] HID: core: Fix bsize printk specifier in hid_report_raw_event()
Date: Fri, 22 May 2026 15:27:18 +0800
Message-Id: <20260522072718.186707-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lu Yao <yaolu@kylinos.cn>

Fix the following warning during build time:

  drivers/hid/hid-core.c:2053:43: error: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
  drivers/hid/hid-core.c:2075:43: error: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]

Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b3596851c719..c21c58d7bf02 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		return 0;
 
 	if (unlikely(bsize < csize)) {
-		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %u)\n",
 				     report->id, csize, bsize);
 		return -EINVAL;
 	}
@@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %u)\n",
 				     report->id, rsize, bsize);
 		return -EINVAL;
 	}
-- 
2.25.1

