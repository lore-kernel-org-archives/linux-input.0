Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EB3BF695
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957209; cv=none; b=Yh7S4HNnbfrn/gVfvLbe4uOXu9mbQV9yJG/vEwTAXK6auJbvHmEYO5Sc0e3w56ZhoQ89oEBM0kydvhGuCbd40Mx9LRSTozZQmIke/R+RzYOxtGEUj5rHusAs4JyaSI83BI+woUs4UvegIo8TL5C6bVvDmhfzCUZ2iXa3NI6BENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957209; c=relaxed/simple;
	bh=sft4S321VXYeqpilqeEW/bXaAPzvEQnvHkltC7Lc9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L30kAZUmNIBIecl/dv5PEcWKWszDY+0jX9xMV2wAaO231E6GIDnuqKPFCy+MZxH3s0TcIaHGtJs2b2jdHzbiQ+q8XH+dmYQDoUTE34Dh7tYgSEpkMbinKiqhrjG6GMY0dxojxIdBab/AWxfsnfNEnTY2NIRFLBm9SCUrXDRDWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS/YzVQ3; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS/YzVQ3"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12e332315a8so6951138c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957206; x=1778562006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfrP/YM0+QiNPfuc4aJ75FAml9M4/b1GGe/ogCrwC90=;
        b=TS/YzVQ3KQggpsfMRejtSuYZZ4MdWX1978dKyKjVmjBuKAPo5fBzw8L1gASukjooep
         sCITxThjCXQj2RFkRsB0QzaofpSGu0s4n/qLO4ZCNO3BvnQBfy4Aib8ou/uOraHCyeNT
         eogFOIAo88vqjXVbeVQl7zg4WV8RZIbNZVKRZmxaOjZzSY36HbdrqZfFVLBlAC1nTPpP
         UQdbMhXv4+ejW46ya8YJ9QZ/KKXV5lxWRsP97o1YQ1tZdLJNicpTLBXGc15bI7emyn/7
         DdLGt3RsShJ21nJJYrZm3CNFCd+UxUHIpEb73Jw5I+JkXI0KBFSvFuJxgil1AwBwcDwq
         SxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957206; x=1778562006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfrP/YM0+QiNPfuc4aJ75FAml9M4/b1GGe/ogCrwC90=;
        b=soNKIpLiSbApkZE385+ix6tOzHSuPB95qTeTdK1c10kr3jLEJkG9aP3ZcYETjQboUv
         DSiJQq8e+gx52T+JF9NCndYdJR1m6HgM6Fr9Rzveu61sTDInqp/qQUfpBiwNOtpRgaji
         sT6C5VltbnaAqYnVgLJhzbYteUH7RMKVNH5h2gatWLaZI4dNZo7nn/mIGGOydAV69t9S
         0UHcQ5Ymw9KA7ahsrgLs9TBcuBqxNSuVutS3StRDDDHHr5Riz4aKIwnj1+dPg1VQFuBE
         +El4l5ODjlodRnwIguyr3J0Fxmvzm+WkndEnbOO4hIJORDQZEeNw/ioIF6hNGa235s4Y
         Y7IQ==
X-Gm-Message-State: AOJu0Yx4T8pTQNT62iRuwFMeKkhYPEXsLR2GEhi7iMadby1WrnKRmf4M
	xLOkz74wbptllU+UDCryR38bihb03Jf5Jl+qjceecwbKe+Gr6ERguaWpnqVoEA==
X-Gm-Gg: AeBDieuQ6gM1FSIibUUs4dTQ0u1JobbS/Ln8upJ0wsbnLaU+4XB1CwfOcHgoleNeiXA
	ro40z5gJhQO3L/z6pLE0AnF9CIrKtzofiTEZC8BIsrRHtscidPGU08NfOvU4Hc3tV79MVH2Y6FC
	NMkT+zhLmCLk4+ZFZ/D1Ywd4QPWohBzC2w5LfKT+4THp7zfb4/HXLzWDZbUHudw15d4PP49joU3
	zwyp1CUu/TKXfkjnm57FbG1Mr3DZEZWtV+v2zSewTBoeS01gnE8ctUkImA8EclA43n/T8UBRIRq
	TLOwBaRKtxmmrchYdt5lhz90dLcQQqbsXslZgR2VOS7n2un5l+Or3wxBHWfW0YXrJZKkGPbF+f4
	xjxBxs9ibOeeAs1HyOimel1dc9zsImPaNukdK3Ppep5Ec9JCabC8f8B8l/+3nLfkaTgAqS1KOX4
	7q6HNxBw8WzjzR2X9Qiei45GgAonRa5F7Eeu0kLwLH5bgdJyhrO2Zn/i4mTSCv8QL+D8cFqHvlM
	Pn3xsy2zrnP9aPTo61heZ8yb9ek9xyJFpZe
X-Received: by 2002:a05:7022:404:b0:12d:b7e5:a67b with SMTP id a92af1059eb24-12dfd7ca694mr6147437c88.14.1777957206409;
        Mon, 04 May 2026 22:00:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 06/20] Input: rmi4 - iterative IRQ handler
Date: Mon,  4 May 2026 21:59:36 -0700
Message-ID: <20260505045952.1570713-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current IRQ handler uses recursion to drain the attention FIFO,
which can lead to stack overflow on deep queues. Convert it to a
loop.

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index d873c7f08e42..c2843c21f0b9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -198,24 +198,24 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
 	struct rmi4_attn_data attn_data = {0};
 	int ret, count;
 
-	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
-	if (count) {
-		*(drvdata->irq_status) = attn_data.irq_status;
-		drvdata->attn_data = attn_data;
-	}
-
-	ret = rmi_process_interrupt_requests(rmi_dev);
-	if (ret)
-		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
-			"Failed to process interrupt request: %d\n", ret);
+	do {
+		count = kfifo_get(&drvdata->attn_fifo, &attn_data);
+		if (count) {
+			*drvdata->irq_status = attn_data.irq_status;
+			drvdata->attn_data = attn_data;
+		}
 
-	if (count) {
-		kfree(attn_data.data);
-		drvdata->attn_data.data = NULL;
-	}
+		ret = rmi_process_interrupt_requests(rmi_dev);
+		if (ret)
+			rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
+				"Failed to process interrupt request: %d\n",
+				ret);
 
-	if (!kfifo_is_empty(&drvdata->attn_fifo))
-		return rmi_irq_fn(irq, dev_id);
+		if (count) {
+			kfree(attn_data.data);
+			drvdata->attn_data.data = NULL;
+		}
+	} while (!kfifo_is_empty(&drvdata->attn_fifo));
 
 	return IRQ_HANDLED;
 }
-- 
2.54.0.545.g6539524ca2-goog

