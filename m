Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3C283FD4;
	Mon,  6 Jul 2026 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328988; cv=none; b=GBgoAOxwoWrBBCzOONUpARqMA23BAl07ZtXLMSUIk9wEE8rBBFuH0qW7QV7DcmpUmBUa4156aVjA2y7lLhDexCIeAcX1dhjoCuZFl0favqTPE1uYFS6TnJizv1DHDTLHl6WXxdALp1Hdze1p5Lqc+7cwSw/nKJ2fCQg2Ge1AYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328988; c=relaxed/simple;
	bh=6tc5bflsgfJipz3plyVnmzUQJ9XbI4NiPd/5cXKMC+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RC65q9vvbu+/saVKUXrGo4jzQT1bs6AZupxqQ48LlICIaOaQsmQ/gKIUoz1MRQz82sAPNEJjTpgdepGLIOY65rLEfllOf45h0yXlwr7SI6R0qXkLjdbsGMnwnekAIlCZ5HhHQd53THa/MJVE0+pz3b5ZPFnivVql6UlHnFW8E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAAnytLOcEtqUeHwBA--.1097S2;
	Mon, 06 Jul 2026 17:09:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jiri Kosina <jikos@kernel.org>
Cc: Pengpeng <pengpeng@iscas.ac.cn>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: mcp2200: validate input report length
Date: Mon,  6 Jul 2026 17:09:32 +0800
Message-ID: <20260706090932.75673-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnytLOcEtqUeHwBA--.1097S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww17Zw4DuryDGr4DGw4UJwb_yoW8Jw15pF
	y8JayYyrWDJr42gr12yFn8Za45ZF1kKFZ7uFZ7Ca47uwnIqry5AF9IvFy0qw45ZFW8G3s3
	Wrs5Kws8Ca1jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

From: Pengpeng <pengpeng@iscas.ac.cn>

mcp2200_raw_event() dispatches on the first byte of the HID input
report and overlays the READ_ALL response structure on the same buffer.
The HID core passes the actual report size to the callback, so validate
that the command byte and READ_ALL response fields are present before
reading them.

Reject truncated reports for the pending command instead of reading
beyond the current input report payload.

Signed-off-by: Pengpeng <pengpeng@iscas.ac.cn>
---
 drivers/hid/hid-mcp2200.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a079..d2f45892dc22 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -299,8 +299,19 @@ static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct mcp2200 *mcp = hid_get_drvdata(hdev);
 	struct mcp_read_all_resp *all_resp;
 
+	if (size < 1) {
+		mcp->status = -EINVAL;
+		complete(&mcp->wait_in_report);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case READ_ALL:
+		if (size < sizeof(*all_resp)) {
+			mcp->status = -EINVAL;
+			break;
+		}
+
 		all_resp = (struct mcp_read_all_resp *) data;
 		mcp->status = 0;
 		mcp->gpio_inval = all_resp->io_port_val_bmap;
-- 
2.43.0

