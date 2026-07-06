Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288D42CAFE;
	Mon,  6 Jul 2026 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329119; cv=none; b=MAOAo6ayUms2+PapAP/yjrVS4gWJSafxJ2EC1Jl5OGpaNN7khST+kA/RHzDjpm8TJUOWChgaLLVMeTRfMC+U7GSrCtKufP+tzhH1m3gF4ctKKvoGkYCkMqNEGeQiFuNFfz08HifytywCkiySXY/HnVWc+fulflZPnKPVCQdiVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329119; c=relaxed/simple;
	bh=f1NkGXPSBDLT894xS2sI1MNT10rtGw5G/Re9IRgyHTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riI20O/xbI43og2LfIdWlfclmltzXa25ib/VrgnJFbvXSuIKWeJTZqzcIg0zsiW1kXCDTTlVy1m/1RD9fRBEgPnN3Kn6LDPMdgTqIfhoVhoA01b/7rRc4mZLmVYKtthOpTy5FMM7vf7vNJmmwIPtkIKQt64JSHqxtOn2O4DNCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAAHqtJScUtqffDwBA--.35378S2;
	Mon, 06 Jul 2026 17:11:46 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Nick Dyer <nick@shmanahar.org>
Cc: Pengpeng <pengpeng@iscas.ac.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: atmel_mxt_ts - validate firmware frame bounds
Date: Mon,  6 Jul 2026 17:11:44 +0800
Message-ID: <20260706091144.76132-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHqtJScUtqffDwBA--.35378S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17XFyfKFykurWUKw4fuFg_yoW8GF1rpF
	WYqasFkr4UXr4Iyw1IyFW7ZFyrZFZ5tFWakayjq3Wxur15AryrKFy3tr92gayFyan3tw43
	GF1DZFyxua4DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

From: Pengpeng <pengpeng@iscas.ac.cn>

mxt_flash_fw() walks a length-prefixed firmware image. The loop only
checks that the cursor is below fw->size before reading the two-byte
frame length and passing the declared frame to the bootloader write path.

Check that the length field and the complete frame, including CRC bytes,
fit in the remaining firmware image before reading or writing the frame.

Signed-off-by: Pengpeng <pengpeng@iscas.ac.cn>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2c0e5a67135b..2aa52b4e5ff5 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2927,10 +2927,19 @@ static int mxt_flash_fw(struct mxt_data *data, const struct firmware *fw)
 		if (error)
 			return error;
 
+		if (fw->size - pos < 2) {
+			dev_err(dev, "Truncated frame size in firmware\n");
+			return -EINVAL;
+		}
+
 		frame_size = ((*(fw->data + pos) << 8) | *(fw->data + pos + 1));
 
 		/* Take account of CRC bytes */
 		frame_size += 2;
+		if (frame_size > fw->size - pos) {
+			dev_err(dev, "Truncated frame in firmware\n");
+			return -EINVAL;
+		}
 
 		/* Write one frame to device */
 		error = mxt_bootloader_write(data, fw->data + pos, frame_size);
-- 
2.43.0

