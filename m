Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1D7080D;
	Sun, 17 May 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020522; cv=none; b=D1Pnv3DwO/uR23RUzdXR4Y9sv36rlzjyeNpar3Lc0x1rvLjyZ3NZ3jg+noYcPVN2teJtxAiYfPD5D8tMaL3GUOLp8+6rR/C321uv2UMJ3YerGkDtVHMoG09Y1ldJAK1EkWsRdHbFsD2ypuxWTAXloVkj6U7PmXyVHYIU9K7VVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020522; c=relaxed/simple;
	bh=vOuSKdcD1ykP32PdF4tiCcSWJl8h/NlnD5RcMK33hE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eMyJi1DM8gJDQBHaV2dlnI/ZDJdBdp/umZaPdxDwTr7NMuSvtRoL6QIPBl50yBP4S97ZtyNiG+x230NDfYKRVPBcCciMU7FT9C+OIS9NwgYYLBeTnbfaXQQcLTq6x175xdYCEhx+ho+YcKH0425vMNaZqVwOLOGH92p9slfBsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from nixos (77.37.240.142) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 17 May
 2026 15:06:44 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: <bonbons@linux-vserver.org>, <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <s.shtylyov@auroraos.dev>
Subject: [PATCH] HID: picolcd: prevent NULL pointer dereference in picolcd_send_and_wait()
Date: Sun, 17 May 2026 15:06:39 +0300
Message-ID: <20260517120639.38003-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

In picolcd_send_and_wait(), an integer overflow of the signed loop counter
'k' can theoretically lead to a NULL pointer dereference of 'raw_data'.
If the loop executes more than INT_MAX times, 'k' becomes negative,
making the condition 'k < size' true even when 'size' is 0.

Change the type of 'k' to 'unsigned int' to prevent the overflow and
eliminate the out-of-bounds access.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: fabdbf2 ("HID: picoLCD: split driver code")
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>

---
 drivers/hid/hid-picolcd_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index 2cc01e1bc1a8..d73e97c8b853 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -72,7 +72,8 @@ struct picolcd_pending *picolcd_send_and_wait(struct hid_device *hdev,
 	struct picolcd_pending *work;
 	struct hid_report *report = picolcd_out_report(report_id, hdev);
 	unsigned long flags;
-	int i, j, k;
+	int i, j;
+	unsigned int k;
 
 	if (!report || !data)
 		return NULL;
-- 
2.50.1

