Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34399368D6F;
	Fri, 14 Aug 2026 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691202; cv=none; b=Ns0+S44qYu54XnTTcHgR4cj59YaQsQcfgshpqnvpxPCDMC4pMoj0S8LWt4dJc9Zn6PnAajQBnp/AhCKJL52OwQvxJh86QuftOBvmL5rpVmwbtvTxvvByc8pbQokQ+vbSZEWW6UKcF4QrdR+ZDNXqkKzY28UxUcOmTE6qQNnliQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691202; c=relaxed/simple;
	bh=asR3c59OoMq4DV47rbceQgVRlh5fkvWQ96ITbIMVTAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ER0Q2HWBiG7nR6pUZg8n2jMwuCQRjPBMfW4Hbk9kMlTgdAgiHC+GzREI2RleS6XVy9hrT+J2MH7Cj183/QDPci4vImAVpynqykYqL7Yqgk8pXcnpL1WaSfGJiGaIZIh+ea0su5YvRT9CcRvRsNfWGoPx9vjO7fTeEpbP9NuqAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad65053697ae11f1aa26b74ffac11d73-20260814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5b095424-5771-4cc0-8fe0-d22e8aa843e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:500b6cee41e127aa4c6e801983239be6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ad65053697ae11f1aa26b74ffac11d73-20260814
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1154151624; Fri, 14 Aug 2026 15:06:31 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccc194101@163.com,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH 0/2] HID: alps: fix DualPoint Stick input device lifecycle
Date: Fri, 14 Aug 2026 15:06:19 +0800
Message-Id: <20260814070621.68557-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the hid-alps driver related to the
separate input device ("DualPoint Stick", input2) that is allocated in
alps_input_configured() but not registered in hdev->inputs:

  Patch 1: input2 is never unregistered on remove.
           The driver struct has no .remove handler, and input2 is not
           tracked in hdev->inputs, so the default remove path
           (hid_hw_stop -> hidinput_disconnect) skips it.  Result: every
           device removal leaks one struct input_dev.

  Patch 2: data->input2 is stored before registration, and on
           registration failure the dangling pointer is read by
           u1_raw_event() (URBs are already active because
           alps_input_configured() calls hid_hw_open() before
           allocating input2) -> use-after-free.

Both patches apply against linux.git master at 7.2-rc7.

---
Chen Changcheng (2):
  HID: alps: unregister DualPoint Stick input device on remove
  HID: alps: fix use-after-free on input2 registration failure

 drivers/hid/hid-alps.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

Thanks,
Chen Changcheng
-- 
2.25.1

