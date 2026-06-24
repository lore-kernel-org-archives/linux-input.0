Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645C3BC668;
	Wed, 24 Jun 2026 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311774; cv=none; b=PN+K/DyhALpTDy3S4zc/3FkSkYHCAWHf13H9ZSpHwYEbn6FKaizFQ6k07e/F6YDpLb26tQ8+ECQ+OMLJd6X9USAg6ptVNKxQliXHeWS/SmrvdRmLmiyXQvs90py0qAASmUAEUS+oDLjbjvkpk4X1KHnpvVgTUUIiBIc7tKrAlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311774; c=relaxed/simple;
	bh=48RgEi+/VPy1YDjuxa9C9bEu3f4ID2KyioL3ArBB3Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNNs8hZ8We07rCB0BS2McSKq6ElcJF9tX/P/Vci2sVKbcNX7Cdnw52qET2C8gKvQe9gSi7T/jNWm9W28K871QxyjZAWUfWNsnlYsg7MXlboo9FkpWGOlee7roCsTkCA/SDGdZQ68iaMCUHfZfjKKPFMF6cpMko6tEMBXHaReROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAXnP9Q6ztqR0cHFQ--.28246S2;
	Wed, 24 Jun 2026 22:36:00 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: amd_sfh: return an error when response wait times out
Date: Wed, 24 Jun 2026 22:35:58 +0800
Message-ID: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXnP9Q6ztqR0cHFQ--.28246S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJry7Kw48AFW3CFy7KFy3Arb_yoW8Gw1UpF
	WkKrWSyrZrXr1293yrJ398ta45Aa4xAFW7Za47Ca40vr90yrWDCr4xKr12qF13CFWqkr13
	urWktF4ruF1qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

amdtp_wait_for_response() waits for request_done before completing a
report request. wait_event_interruptible_timeout() returns 0 when the
wait expires, but the current code treats only negative values as errors
and returns success on timeout.

Return -ETIMEDOUT when the response wait expires while preserving the
existing success path when the response has already been observed.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
index b04f675d4..8f88f965f 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
@@ -87,16 +87,17 @@ static int amdtp_wait_for_response(struct hid_device *hid)
 			break;
 	}
 
-	if (!cli_data->request_done[i])
+	if (!cli_data->request_done[i]) {
 		ret = wait_event_interruptible_timeout(hid_data->hid_wait,
 						       cli_data->request_done[i],
 						       msecs_to_jiffies(AMD_SFH_RESPONSE_TIMEOUT));
-	if (ret == -ERESTARTSYS)
-		return -ERESTARTSYS;
-	else if (ret < 0)
-		return -ETIMEDOUT;
-	else
-		return 0;
+		if (ret == -ERESTARTSYS)
+			return -ERESTARTSYS;
+		if (ret <= 0)
+			return -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
 void amdtp_hid_wakeup(struct hid_device *hid)
-- 
2.50.1 (Apple Git-155)

