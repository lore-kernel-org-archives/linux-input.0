Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710873624BB;
	Mon, 23 Mar 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251946; cv=none; b=UxwE5T/10nGBnVeW3upd7uyhwoEgX1A8AkW8Mx0Qe9tvD1foVgYpT5cOXf3fWPbKpuiL6EepTnHdbZaYbBdr8HOlzeIe1cdllBCZxeXh77zDDxLuputXHTT3hGS0y6MG8d9QsPeCUzQ/X713i+ImXfhFrxoowP8heBs0WXQbq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251946; c=relaxed/simple;
	bh=sC7hITG8CLq34Yv9YQZTm3uA4luSk+JxONu7/oi9fpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/tsAuXzN6POa62tOyEJMNz8KORwQTx6jasLgwlh1vuyHStAKb0NZ6fxjV7FBQ/N3jZ7715891UmHadJGqPAZ6WeDysAVyTvQ3ZatBtsf2o+fPT+BJAF9+k8VQO9hFyQ4Y3ha4dXu6EHEd4VI/08GCyvrkhqsLtE03arRUxinII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAA3G+Kl78Bpir+GCw--.61302S2;
	Mon, 23 Mar 2026 15:45:41 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] Input: gf2k: clamp hat values to the lookup table
Date: Mon, 23 Mar 2026 15:45:41 +0800
Message-ID: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3G+Kl78Bpir+GCw--.61302S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy5Gw43Aw15WFyrGr4UArb_yoWDXwc_ur
	95Zwn3X3s8CFnFyF1qyF93Xryvyw1DZFyxArySqa4ay34DXF4Fq34DZrs5Ca15Krs5Ca45
	C3ZrGw1xZrWIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjO6pDUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

gf2k_read() decodes the hat position from a 4-bit field and uses it
directly to index gf2k_hat_to_axis[]. The lookup table only has nine
entries, so malformed packets can read past the end of the fixed table.

Clamp invalid hat values to the neutral position before indexing the
lookup table.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/joystick/gf2k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
index 5a1cdce0bc48..78fba36285dc 100644
--- a/drivers/input/joystick/gf2k.c
+++ b/drivers/input/joystick/gf2k.c
@@ -164,6 +164,8 @@ static void gf2k_read(struct gf2k *gf2k, unsigned char *data)
 		input_report_abs(dev, gf2k_abs[i], GB(i*9+60,8,0) | GB(i+54,1,9));
 
 	t = GB(40,4,0);
+	if (t >= ARRAY_SIZE(gf2k_hat_to_axis))
+		t = 0;
 
 	for (i = 0; i < gf2k_hats[gf2k->id]; i++)
 		input_report_abs(dev, ABS_HAT0X + i, gf2k_hat_to_axis[t][i]);
-- 
2.50.1 (Apple Git-155)

