Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777217A2E8;
	Tue, 28 Jul 2026 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207496; cv=none; b=MemRgBvfE0NBFFXPuKGpuQwk+khitR+MaTlBMygCKS3xpzFeGSO8Q9nu7E9WUM2Jd2lVvFWzMhtZm/vxPkZDuBQmMASdQGS97wejTlYGJcMf8zzj3qNy69XPLNoWSq+t37yaubiYV3KVdPGUHo/0wAhQHLYaP4e67NdRCl8kPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207496; c=relaxed/simple;
	bh=VENf5A4f4PJsQMYuJhDws6pyO2Z9vdIutiIEeiBr/d4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jz5AqcK6w1sUlRSTkg4sKn2rkjdkA9vRL0h5fyX2x9Df2X1Z4rq2rmd2if/N0mK0q08NuqW/s0hAAIU7/mM7pn0wA/DCUUN0SofrRRnYG8YWSV0MyV/Ye+zPYV4gmx2WrswR49wbg4ICja8JG4NXTOeh06ic/ajlJ1rZJOiGWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 29e9c0888a3011f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6dcb2d85-c32c-4100-89bd-33aca40d5f88,IP:0,U
	RL:0,TC:0,Content:31,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:31
X-CID-META: VersionHash:e7bac3a,CLOUDID:0ec983d7fa59d76c326e7bc0b7208cf0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:4|15|
	16|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 29e9c0888a3011f1aa26b74ffac11d73-20260728
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1490066534; Tue, 28 Jul 2026 10:58:09 +0800
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
Subject: [PATCH 0/4] HID: Address Coccinelle warnings
Date: Tue, 28 Jul 2026 10:57:46 +0800
Message-Id: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses four Coccinelle-detected code style issues in
the HID subsystem:

- Replace open-coded min() logic with the standard min() macro (3 files)
- Use secs_to_jiffies() instead of msecs_to_jiffies(sec * MSEC_PER_SEC)

All changes are straightforward, no functional changes intended.

./hid-sony.c:970:21-23: WARNING opportunity for min()
./hid-picolcd_debugfs.c:89:17-18: WARNING opportunity for min()
./intel-thc-hid/intel-quicki2c/pci-quicki2c.c:213:22-24: WARNING opportunity for min()
./intel-thc-hid/intel-quicki2c/pci-quicki2c.c:218:22-24: WARNING opportunity for min()
./intel-ish-hid/ishtp/ishtp-dev.h:272:25-28: WARNING opportunity for secs_to_jiffies()

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
Chen Changcheng (4):
  HID: intel-quicki2c: Use min() macro to simplify code
  HID: sony: Use min() macro to simplify code
  HID: picolcd: Use min() macro to simplify code
  HID: intel-ish-hid: Use secs_to_jiffies() instead of
    msecs_to_jiffies(sec * MSEC_PER_SEC)

 drivers/hid/hid-picolcd_debugfs.c                     |  2 +-
 drivers/hid/hid-sony.c                                |  2 +-
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h           |  2 +-
 .../hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c   | 11 ++---------
 4 files changed, 5 insertions(+), 12 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.25.1

