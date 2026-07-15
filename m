Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F3352000;
	Wed, 15 Jul 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108800; cv=none; b=AeyctKiTuyi4XkDXJFrm7kpw7F9ktx/5cfuqRWEKfdck2IuYGPyTYWbGZ3SEAy5t4eTxrepwm6AXZT0XlXVGaf1fP+LH8/tBZLCl0jYUi4R3VkaZcM6KaCMWjallZDoDpfd7pSmGuoOst4QhTojAvfXnlnfkYAsSQ+B2AiFyt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108800; c=relaxed/simple;
	bh=wUGju0CGqHOiBcbkKyt1lkB2pHyMbjXx5bzt+sE8odo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQlA7ODB+Eumi/x9aO/zja1S0wXR/ROBiH01JFzzyFFJdScZvNZES/BR8ID49aMTvTpYlH2it33rsZr7A8I20L++Lh9HN54V2xG6xssc8ygSsPoSx1uGR6wFmqJuB25ZFahIHnK6ghgTtuf9JQchnYII4farfqZ6KTYEyUNH02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c5129a6803211f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5ebff115-794a-4407-9d9b-ba5ae3a28b8a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:77fb06c0b0823dae0bccd3e2438e27b0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c5129a6803211f1aa26b74ffac11d73-20260715
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 591348280; Wed, 15 Jul 2026 17:46:26 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: basavaraj.natikar@amd.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] HID: amd_sfh: clear hid_sensor_hubs entry on probe failure
Date: Wed, 15 Jul 2026 17:46:22 +0800
Message-Id: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In amdtp_hid_probe(), the newly allocated HID device is stored in
cli_data->hid_sensor_hubs[cur_hid_dev] before calling hid_add_device().
If hid_add_device() fails, the error path frees the HID device and its
driver_data but does not clear the array entry, leaving a dangling
pointer.

When the caller (amd_sfh_hid_client_init or
amd_sfh1_1_hid_client_init) detects the probe failure, it jumps to its
cleanup label, which unconditionally calls amd_sfh_hid_client_deinit()
and subsequently amdtp_hid_remove(). The latter iterates over all
hid_sensor_hubs[] entries and, upon encountering the non-NULL but freed
pointer, performs a use-after-free read followed by double-free of both
the HID device and its driver_data.

Clear the array entry in the error path of amdtp_hid_probe() so that
amdtp_hid_remove() skips the failed entry.

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
index b04f675d49b0..9eaa2785a9ac 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
@@ -162,6 +162,7 @@ int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
 	return 0;
 
 err_hid_device:
+	cli_data->hid_sensor_hubs[cur_hid_dev] = NULL;
 	kfree(hid_data);
 err_hid_data:
 	hid_destroy_device(hid);
-- 
2.25.1

