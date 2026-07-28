Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC914301719;
	Tue, 28 Jul 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207500; cv=none; b=pZEnsYZNkeUjkQYednJ38jDhEwj9NiHeqPc/EcEeIVhe7rbhgRhmlfsAxHX0PRX19oIsLGc+YzhwiF9zCmMr6T5sWr7HVxx5zZa4+KeBbEMlaoEZqx85IykgMd9aa3lXxJ5m/sXpx8lbEER5xnjP7MsY6tWTR9wC8t0q+MVx8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207500; c=relaxed/simple;
	bh=K5adI/xx802MGKdOzo2IDB9VzrFGS+YyiP8o+6+zTK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUPSph5Ya1HKTuJhSUL9m7y8VCnTPbmG3jv4kNT7fHzFSzAv3b8WSXNiKWb4UcrkNolvXud/TQf6xiSrzQv5BOKAg/P+o/QJxwOprnsEXTkHBR/ibdp7HNOO6JKJ7U5k3/D4OGN/pCLLZpIhGvpegiJFKM6pfGK8Ewf9iIvpFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2a9b87d28a3011f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:73668b03-17df-42e6-8c09-d64dc3b80eff,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:de512647a4e0899ce31ce5611dc0de08,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2a9b87d28a3011f1aa26b74ffac11d73-20260728
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 298950751; Tue, 28 Jul 2026 10:58:10 +0800
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
Subject: [PATCH 1/4] HID: intel-quicki2c: Use min() macro to simplify code
Date: Tue, 28 Jul 2026 10:57:47 +0800
Message-Id: <20260728025750.48249-2-chenchangcheng@kylinos.cn>
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

Replace open-coded min() logic with the standard min() macro in
pci-quicki2c.c for setting i2c_max_frame_size and i2c_int_delay.
This improves code readability and is consistent with kernel coding
style.

Detected by Coccinelle:
./intel-thc-hid/intel-quicki2c/pci-quicki2c.c:213:22-24: WARNING opportunity for min()
./intel-thc-hid/intel-quicki2c/pci-quicki2c.c:218:22-24: WARNING opportunity for min()

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 .../hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c   | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..bd099600bb9f 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -210,15 +210,8 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 		qcdev->i2c_max_frame_size_enable = i2c_config.FSEN;
 		qcdev->i2c_int_delay_enable = i2c_config.INDE;
 
-		if (i2c_config.FSVL <= qcdev->ddata->max_detect_size)
-			qcdev->i2c_max_frame_size = i2c_config.FSVL;
-		else
-			qcdev->i2c_max_frame_size = qcdev->ddata->max_detect_size;
-
-		if (i2c_config.INDV <= qcdev->ddata->max_interrupt_delay)
-			qcdev->i2c_int_delay = i2c_config.INDV;
-		else
-			qcdev->i2c_int_delay = qcdev->ddata->max_interrupt_delay;
+		qcdev->i2c_max_frame_size = min(i2c_config.FSVL, qcdev->ddata->max_detect_size);
+		qcdev->i2c_int_delay = min(i2c_config.INDV, qcdev->ddata->max_interrupt_delay);
 	}
 
 	return 0;
-- 
2.25.1

