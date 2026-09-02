Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CF326939;
	Wed,  2 Sep 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338937; cv=none; b=Hwy8sBt0vSwzS9aBVMcv38Jb5MnMyJtbFGNiJMxWq+82wqKqx6VW2vEPIjQGpZG+0LxCIMG9RfFlKTRQEXeQX8L4vn73C25gk/ANamiwD7r2PJSMkWJZMSFcGihYa38aJNIPJovijZ2hZE94wQqdlfS5AEKO15k9FNOBcKTvS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338937; c=relaxed/simple;
	bh=XcX6RoQsxLhi/vMravhensPRZs1yNCYjPjC6XWpk2BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V0oSfjG5aJOSfj6OIn3VJpNqdL6aweuSRy4C7vcx7x1autyEvBOPQ2SSSWv1W/R67jOtMr8Ncnf0UHVCxC3BIMyX2Nl5fL5zsrwsXjzLZvfmytUmLDI+N/qyW2LgwFm2WNrntXF96P5y+lurQY9fhI07W3rVBg//Ir1/a5YxNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d0a4feea6ab11f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:933b90b0-bd4a-48b3-8dba-bc5f98f8ccfc,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:0ab97c0f6fb818826c370bb1e51b71dd,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d0a4feea6ab11f19a56ed5b684f684d-20260902
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1860067746; Wed, 02 Sep 2026 16:48:48 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] Input: hycon-hy46xx - bound the checksum length
Date: Wed,  2 Sep 2026 16:48:42 +0800
Message-Id: <20260902084842.1999180-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checksum loop uses a length byte from the report as the
upper bound. The report buffer is only HY46XX_REPORT_PKT_LEN
bytes.

Fixes: aa2f62cf211a ("Input: add driver for the Hycon HY46XX touchpanel series")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/input/touchscreen/hycon-hy46xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/hycon-hy46xx.c b/drivers/input/touchscreen/hycon-hy46xx.c
index 1513f20cbf51..bb8b82b11301 100644
--- a/drivers/input/touchscreen/hycon-hy46xx.c
+++ b/drivers/input/touchscreen/hycon-hy46xx.c
@@ -84,7 +84,7 @@ static bool hycon_hy46xx_check_checksum(struct hycon_hy46xx_data *tsdata, u8 *bu
 	u8 chksum = 0;
 	int i;
 
-	for (i = 2; i < buf[HY46XX_CHKSUM_LEN]; i++)
+	for (i = 2; i < min_t(int, buf[HY46XX_CHKSUM_LEN], HY46XX_REPORT_PKT_LEN); i++)
 		chksum += buf[i];
 
 	if (chksum == buf[HY46XX_CHKSUM_CODE])
-- 
2.25.1

