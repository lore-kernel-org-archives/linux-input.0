Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E31FFC59;
	Wed, 15 Jul 2026 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104736; cv=none; b=UKnPTnHP+yoG5RIa82grQFbmt/x9jabLvQ977aDmXSuyHeXrER77h7XpACBaodZfn+TFwwZugdvU/OaHxqxWMwbAjkML0NMokT8crA6n58zLwjbCyMzmr6/h1eEQYCHI+Aw7snPuLSwqFIS5VI9EJsnSSAGplSEoLd0PPa+XR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104736; c=relaxed/simple;
	bh=G0OdTudThONEVq4z2Mu/i0wD2nslQVAfSPYjc8TUYfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpAgCvhn72Jx82kp5V7FeZ+XQnaUTTI8khVIdehkVAgwW9S+x9/z644q4ABw5ChdPuePLlDchbjDKFreuDgVYCEw+P39oZk4TYFgNOz/rmi0A+IBD3XZfJxCVs7gsW3PoQwxAdrpodwZcwQrXmpV6IjeLGQ3Y6UxzoLd2J/Jvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABHmcwaR1dqrVpHGA--.7399S2;
	Wed, 15 Jul 2026 16:38:51 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH] Input: iqs5xx: validate firmware record destination span
Date: Wed, 15 Jul 2026 16:38:50 +0800
Message-ID: <20260715083850.32155-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHmcwaR1dqrVpHGA--.7399S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1fKr43CFyrWFWfGw1UGFg_yoWktrcEkF
	W8uF97G34YkFZF9w1Dtr13Zr929r10vr97Za4qy393Aw15JrsxZ39rAF15ArWUGrWDWr17
	JrsxWFy09ay29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUezVbDU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The firmware record parser checks that the record address starts within
the programmable map, but does not check that the complete record data
fits in that map. A record near the end of the map can therefore make
the copy to pmap exceed its destination span.

Check the record length against the remaining programmable map range
before copying the record data.

Fixes: 7b5bb55d0dad ("Input: add support for Azoteq IQS550/572/525")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/touchscreen/iqs5xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
index c3cc37274335..88dcf72618df 100644
--- a/drivers/input/touchscreen/iqs5xx.c
+++ b/drivers/input/touchscreen/iqs5xx.c
@@ -785,7 +785,8 @@ static int iqs5xx_fw_file_parse(struct i2c_client *client,
 		switch (rec_type) {
 		case IQS5XX_REC_TYPE_DATA:
 			if (rec_addr < IQS5XX_CHKSM ||
-			    rec_addr > IQS5XX_PMAP_END) {
+			    rec_addr > IQS5XX_PMAP_END ||
+			    rec_len > IQS5XX_PMAP_END + 1 - rec_addr) {
 				dev_err(&client->dev,
 					"Invalid address at record %u\n",
 					rec_num);
-- 
2.43.0

