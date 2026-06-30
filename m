Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF22E7387;
	Tue, 30 Jun 2026 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804670; cv=none; b=k9Qc0vo9lXzaj3OitrbCMKKRfcy7nYsK0UCwfkzm5bQxcaqlTO5FMSE5jSsgdRlkMSRQ7ARxh1JBR3D8O9p9Zb7zeoVKSYZSG2tDidvDITPRIvI+efvjv53T0lVQSJ8Auvms/IxAH0hhaTudK2kWiULPeKtblFpnLB8Yxm0InfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804670; c=relaxed/simple;
	bh=jIaa5S3O1Yi+T7FJAJZqE2P04uSD7X8lxQPDrMVsGB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jz/FjAJz+5+L286tkiJaFIcBe+CZ19WB1+h1FcxmQuDMBurcGlNfS8ZDTgKCut2IbqjecDdUsZvoi80mOs0JnWZs4fsU80wSHOXHWqXSMsi9/XOJS5cdEE/svPl+weHGSBI/3ftfM1fsdCPBeKoyHDLFiMFLnMHdr8dA5fLmqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0047-Input-hynitron_cstxxx---validate-touch-count-against-buffer.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3fAC6cENqfK8kFg--.58042S2;
	Tue, 30 Jun 2026 15:31:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] Input: hynitron_cstxxx - validate touch count against buffer
Date: Tue, 30 Jun 2026 15:30:14 +0800
Message-ID: <2026063009041899.4-ccfa108-0047-Input-hynitron_cstxxx---val-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3fAC6cENqfK8kFg--.58042S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyUWw4kAr4rZFy7AF15twb_yoWkGrc_ur
	yUXFs3Ww1qkFWktrnrG3Z3ZrZ7Ka18Zrn3Z3yDt3yftr1xGwsayF9F9a1YyryUJFWUAw17
	CwsxWayFvw1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbFAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjTKZJUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

cst3xx_touch_report() uses the device-reported touch count to compute
the check-byte offset and to parse touch slots in a fixed 28-byte
buffer.

Bound the touch count against the chip limit and the buffer layout
before parsing.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/touchscreen/hynitron_cstxxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/touchscreen/hynitron_cstxxx.c
index 1d8ca90..6644272 100644
--- a/drivers/input/touchscreen/hynitron_cstxxx.c
+++ b/drivers/input/touchscreen/hynitron_cstxxx.c
@@ -313,6 +313,12 @@ static void cst3xx_touch_report(struct i2c_client *client)
 		return;
 
 	touch_cnt = buf[5] & CST3XX_TOUCH_COUNT_MASK;
+	if (touch_cnt > ts_data->chip->max_touch_num ||
+	    (touch_cnt > 1 && touch_cnt * 5 + 2 >= sizeof(buf))) {
+		dev_err(&client->dev, "cst3xx touch read failure\n");
+		return;
+	}
+
 	/*
 	 * Check the check bit of the last touch slot. The check bit is
 	 * always present after touch point 1 for valid data, and then

