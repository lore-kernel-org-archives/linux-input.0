Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB43D813D;
	Mon, 20 Jul 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548223; cv=none; b=I4CHJwhojt1DIATULNPTTuSqYRlKMbOewej09Pg+zh875v9y1xlVPJ/W/DD+6xff5+CYeVJkXle9XYELo9JncP3XVcnooUgRHrLJy9p2+2tzBH552U4Q0iF2sYEsYVsWyKugPeaeca0Fsq4Wao1VHH+2RI+HyQ+yYnTXdBHewYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548223; c=relaxed/simple;
	bh=ZPrhE9OKhbVqIC2QkIsyQQ/f7ortPnqTAyCbQohYMaE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rqb5HaeOleGhZaHo6KZRWwg28aWB2XmLsdduQScE+M8ye0N3bZxQ9IpozmqFtzVutl5nNsWZanYZbWGQKSBiynVWkZhvbab93Df5vhe4r4W/eY4kiZV1SHToD92doKXnzW5xINMtSjheABenIv5/y+CPSNxh50n3o8SSV7YT2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowACXBUB6C15q7b2IAA--.63418S2;
	Mon, 20 Jul 2026 19:50:19 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] Input: iforce - validate input packet lengths
Date: Mon, 20 Jul 2026 19:50:18 +0800
Message-ID: <20260720115018.75045-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXBUB6C15q7b2IAA--.63418S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW5KrW5tw1DKw4UKF15urg_yoW5Ww1Upa
	yYkFW29r1DKF4jqwnrt3Wfury5Ka97XFy5GFy5Aw10vws8Jry2yr9xtFy0qFyjyw1kJw4a
	q3WqqF4DCF1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6v38UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

iforce_process_packet() reads fixed fields from joystick, wheel and status
packets without first checking their lengths. In particular, the shared
hats-and-buttons helper unconditionally reads data[6]. The status tail is
a sequence of 16-bit effect addresses, but an incomplete final address is
also consumed. A successful zero-length USB URB additionally reads the
packet ID before the common parser is called.

Reject the zero-length USB transfer, require the seven-byte joystick and
wheel prefixes and the two-byte status prefix, and consume only complete
status-tail addresses.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260706092016.78176-1-pengpeng@iscas.ac.cn/
- cover the data[6] access in the shared hats-and-buttons helper
- cover zero-length USB completions and incomplete status-tail u16 values
- rebase onto v7.2-rc4

 drivers/input/joystick/iforce/iforce-packets.c | 11 ++++++++++-
 drivers/input/joystick/iforce/iforce-usb.c     |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index effa76bfd8f9..e8a34d68a51f 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -155,6 +155,9 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_X,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_Y,
@@ -170,6 +173,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
+		if (len < 7)
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
 
@@ -200,7 +209,7 @@ void iforce_process_packet(struct iforce *iforce,
 			}
 		}
 
-		for (j = 3; j < len; j += 2)
+		for (j = 3; j + sizeof(u16) <= len; j += 2)
 			mark_core_as_ready(iforce, get_unaligned_le16(data + j));
 
 		break;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 0482eaaecf39..f04370e4191e 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -158,6 +158,9 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
+	if (!urb->actual_length)
+		goto exit;
+
 	iforce_process_packet(iforce, iforce_usb->data_in[0],
 			      iforce_usb->data_in + 1, urb->actual_length - 1);
 

