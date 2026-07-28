Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6F2FD694;
	Tue, 28 Jul 2026 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207498; cv=none; b=KEd0FZ9RN/vz+LGSbFz8zAdmA7j44/jeYP28ZJXsJ56auKcpjIOPR/isOuPm9FGCRcyuB10BiiiGEb87y2QSjDjFE1n924BJUsPomABxqAPQwwKsvxdgCIh4GHHNY5Q+fiqMPHWhBGYr6Y6gdaFeJ95VcSPdgvhttVa2oz/Ix4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207498; c=relaxed/simple;
	bh=jr94Gq//zpuXk+NwoFTJUMtlXBVhY4BCqI0CCfyW9l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gA0tIqN0IvF2WFpRrAD7zasFgXwPEAfzcy4K2as6d+JxOEH9JDnbf263HQrP4DODMl3ME3JgNOuS1RALv6LRp2sHQkK/3h5O5uo3VQkbK4FWZlPS0Z+A8/Tr2YFkpdHxtivOb7xqKKxcflpPePasZqiw4UmWhJlNGb9heu3A+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b181a188a3011f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cc950eae-5204-4cb8-b05a-192a2b5440ba,IP:0,U
	RL:0,TC:0,Content:36,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:36
X-CID-META: VersionHash:e7bac3a,CLOUDID:c7d5bc4d0e5c65f695078ff3aa24317d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:4|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b181a188a3011f1aa26b74ffac11d73-20260728
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2136250656; Tue, 28 Jul 2026 10:58:11 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: bonbons@linux-vserver.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	even.xu@intel.com,
	xinpeng.sun@intel.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccc194101@163.com,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH 2/4] HID: sony: Use min() macro to simplify code
Date: Tue, 28 Jul 2026 10:57:48 +0800
Message-Id: <20260728025750.48249-3-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
References: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded min() logic with the standard min() macro
in hid-sony.c for battery capacity index calculation.

Detected by Coccinelle:
./hid-sony.c:970:21-23: WARNING opportunity for min()

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e75246d29e16..cbc916989646 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -967,7 +967,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		battery_capacity = 100;
 		battery_status = (rd[offset] & 0x01) ? POWER_SUPPLY_STATUS_FULL : POWER_SUPPLY_STATUS_CHARGING;
 	} else {
-		index = rd[offset] <= 5 ? rd[offset] : 5;
+		index = min(rd[offset], 5);
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
-- 
2.25.1

