Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74F3F7AAE;
	Tue, 24 Mar 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358089; cv=none; b=I1nQ+PfxHUTmRyKOCE5/ZYDvw6x9myZaH3nP2CPbKlVtcxtM6ywOdNYSLDgcIpTShWdVVBczbaebBsQW3uWl5Vd/gbDK3n7WmzmlTi1yZcbEtrNG/kWR9G8Wzaq9XuLr35HWkfMvCHJjF8bGOJNN6YzbYY59g0LcheB0tXf+Py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358089; c=relaxed/simple;
	bh=+dM2lNuv2wsA7qramJDcF0xEWV/xVrPNwsSdGkLdbbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcZRtQiv6yHFcJNX7wy3ogEKx+Cna0d91PRENYqk+pzwvFbuyz3+sQtaDP3LKxzACA842KvvOtWh3GtXKhQDtV+4x4khHpc2LD4IvOOGMYMFWQAgn2KnU+uLveq9b7Aq43nMcM+irR4+QL/YCR3jCtZMuzbY/fEkdp+TxP0Nacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAC3m+JCjsJp2ruqCw--.32110S2;
	Tue, 24 Mar 2026 21:14:43 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: andriy.shevchenko@linux.intel.com,
	kees@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v2] Input: penmount: bound packet buffer indices in IRQ path
Date: Tue, 24 Mar 2026 21:14:42 +0800
Message-ID: <20260324131442.27632-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3m+JCjsJp2ruqCw--.32110S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18ArWkXFW7ZFWfKry8Xwb_yoW8Wr1xpa
	13Gr9I9r4DJa1Fya9Fya15ZFy5C3y3Ja43Krykuw409a1Yqryvv3Zaqay29Fy5trWkAw1r
	XFs5Z3yYyFyDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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

pm_interrupt() stores each incoming byte into pm->data[] before the
packet parser gets a chance to reset pm->idx. If the incoming serial
stream never matches one of the expected packet headers, pm->idx can
advance past the fixed receive buffer and the next IRQ will write beyond
PM_MAX_LENGTH.

Reset stale indices before storing the next byte. Once pm->idx has
already moved past the valid packet buffer state, the current partial
packet can no longer be trusted, so the smallest local recovery is to
drop that stale state and resynchronize from the current byte instead of
carrying the invalid index into the next interrupt.

Found by static code analysis.
Fixes: 98b013eb7a94 ("Input: penmount - rework handling of different protocols")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
v2:
- note that the issue was found by static code analysis
- explain why resetting the stale index is the preferred resynchronization path
- add a Fixes tag

 drivers/input/touchscreen/penmount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/penmount.c b/drivers/input/touchscreen/penmount.c
index 4b57b6664e37..ba09096c6573 100644
--- a/drivers/input/touchscreen/penmount.c
+++ b/drivers/input/touchscreen/penmount.c
@@ -163,6 +163,9 @@ static irqreturn_t pm_interrupt(struct serio *serio,
 {
 	struct pm *pm = serio_get_drvdata(serio);
 
+	if (pm->idx >= pm->packetsize || pm->idx >= PM_MAX_LENGTH)
+		pm->idx = 0;
+
 	pm->data[pm->idx] = data;
 
 	pm->parse_packet(pm);
-- 
2.50.1 (Apple Git-155)

