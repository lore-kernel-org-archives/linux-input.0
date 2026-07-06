Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C304DD6EB;
	Mon,  6 Jul 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329624; cv=none; b=YM/jD65UKmigneGA+W04X7KADPJRg1Xim2D0E1W4mO1jWr0YnkLj6cgk0RMO17D8BdjvyscJvupqHkZK/Q+BrGj/xMMV2d8HgeNHke5NI1E3iG9EWv2Ji6JiIpVN5y1xKPi3eyto3WDbnIvlDGc815X18gsIg9alY8bl5bNY95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329624; c=relaxed/simple;
	bh=UoxkMAkg+WaXl30c+KHXf2DxleznV6+5cLVY541vfs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o09xZl2ta6uLdkw7Ds2mfRMaPVfo/HAAJyIUTDHNf7lWUzFZCquImJ2DIJPkB4OnEz+ehpjKw36qfUJGFKDVZaHmEmAj0YjkD4xc/BFrJN1mc3JEk1TcJbGdvx5rVj7qbzdysWh0SQB0XFrdA13ccmjrjfvEbrgeaYopNCpc7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACnRc5Sc0tqci3xBA--.1243S2;
	Mon, 06 Jul 2026 17:20:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: iforce - validate packet lengths
Date: Mon,  6 Jul 2026 17:20:16 +0800
Message-ID: <20260706092016.78176-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnRc5Sc0tqci3xBA--.1243S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWkGr47Zw15GryUtrWfGrg_yoW8GFy7pa
	45Ca9Fgr18Kw4jqrnrt3Wfury5Ka97XFy5Ga4Yvw1qvrs8JrySyr9xtF1jvFWqy3Z5Jwsx
	tF1DtFs8GFn5Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-B_UU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

iforce_process_packet() decodes several packet formats from a
variable-length input buffer.

Add minimum length checks for joystick, wheel and status packets before
reading their fixed fields.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/joystick/iforce/iforce-packets.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index effa76bfd8f9..54697b252b84 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -155,6 +155,9 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
+		if (len < 5)
+			break;
+
 		input_report_abs(dev, ABS_X,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_Y,
@@ -170,6 +173,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
+		if (len < 4)
+			break;
+
 		input_report_abs(dev, ABS_WHEEL,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_GAS,   255 - data[2]);
@@ -181,6 +187,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x02:	/* status report */
+		if (len < 2)
+			break;
+
 		input_report_key(dev, BTN_DEAD, data[0] & 0x02);
 		input_sync(dev);
 
-- 
2.43.0

