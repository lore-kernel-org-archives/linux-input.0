Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C04305674;
	Tue, 28 Jul 2026 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207500; cv=none; b=DRc6iIauG+BuHTnYtW3LwX8Y2iwpYceZMu6sNUbZmEFgqKhqdJ6PGP4tT/CZvqBrw4KlsGbRjyW7FB6iZInOXMR7G+9equmoYdEKXjlYYlLuQOZqCT/eZuRucDRk00eXiFIPkjScN5sNlY8Re1LNiTbWorldyXVOpRd8nT6f7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207500; c=relaxed/simple;
	bh=1e9RcggzZftUlWWK++lkxAcGnrSm+FjBhN4SaWBUuno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFoZTjbOknrplENc5O46X8X7Wq6d/hEXJr21S/Yl1HkaDADdlQFK4SIhcJr7Lp4M/ERrSSiWUN0ED1EzfKAdNTfWFtR60K+HfIgt+iLgzt6TADaaYg9t69iT1KmQYXCo5KjVFXUwtDqIr5JJNIGv32t06n4PurMiVbD2ZwlHkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b71d7ba8a3011f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b897946e-41e1-4dd3-8607-8374afaa1d75,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:58232306a70a6860f786e7e8b8fb460a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b71d7ba8a3011f1aa26b74ffac11d73-20260728
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 843440955; Tue, 28 Jul 2026 10:58:11 +0800
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
Subject: [PATCH 3/4] HID: picolcd: Use min() macro to simplify code
Date: Tue, 28 Jul 2026 10:57:49 +0800
Message-Id: <20260728025750.48249-4-chenchangcheng@kylinos.cn>
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
in hid-picolcd_debugfs.c for limiting read size.

Detected by Coccinelle:
./hid-picolcd_debugfs.c:89:17-18: WARNING opportunity for min()

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/hid-picolcd_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 085847a92e07..c5e0e9076de9 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -86,7 +86,7 @@ static ssize_t picolcd_debug_eeprom_read(struct file *f, char __user *u,
 	/* prepare buffer with info about what we want to read (addr & len) */
 	raw_data[0] = *off & 0xff;
 	raw_data[1] = (*off >> 8) & 0xff;
-	raw_data[2] = s < 20 ? s : 20;
+	raw_data[2] = min(s, 20);
 	if (*off + raw_data[2] > 0xff)
 		raw_data[2] = 0x100 - *off;
 	resp = picolcd_send_and_wait(data->hdev, REPORT_EE_READ, raw_data,
-- 
2.25.1

