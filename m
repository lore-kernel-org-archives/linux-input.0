Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EE42BC31;
	Wed, 15 Jul 2026 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104681; cv=none; b=u26zAQkkO7caF8Rc1otbnGN81DYtTRrIXZwoHqiqVfv8ds3q8MReH/JZnXALBtKM24+C8D9aRyB6Z9F0LYfwq2WGmsvHcx5uiLVry8iBCrlb57YcAPwHqcru21q9wgO4kkkmkk0Z42pCYLAX2L9Pt/+JMNmmeGcLkm/lEnQwLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104681; c=relaxed/simple;
	bh=x2V74GwFV4oWQrLG9v54s8LtJx1hg9zc1oQefQ4YSgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txxNtV129/CzxcqJauWPKPrh31XjuYmorRF5VJaydNTqjkXL5Jyl39dJ032reQETSejFhVaO3targKYP1wHgHoUOopNBzEo9BRwYY6mYuG8OWVPUPqBM683T+5ridbGicCqyUgLknx9/Qe9tLNeeRgpbsbmdEw5hbiB6UjNJUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADnL8PiRldqg1ZHGA--.14945S2;
	Wed, 15 Jul 2026 16:37:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Rishi Gupta <gupt21@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: mcp2221: validate raw report length
Date: Wed, 15 Jul 2026 16:37:54 +0800
Message-ID: <20260715083754.31210-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnL8PiRldqg1ZHGA--.14945S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWUurW5ZrWrZrW3tFy7Jrb_yoW8XFyrpF
	Wqq390yryUtr42qwnxCw1DJa4Yq3WfJFsrCF9Fg3WUua15Kw15AryFgFyvvrW5ZF48Kr93
	XF4FqFZ3GFyjkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

HID calls a driver raw_event() callback before it performs the generic
report-length validation. mcp2221_raw_event() subsequently reads fixed
response fields up to byte 55 and can copy a response payload through byte
63.

A short input report can therefore be interpreted using bytes beyond the
current report length before the HID core rejects it. Validate the
descriptor-derived report length at the beginning of the driver callback.

Complete the pending command with -EINVAL for a truncated report so that a
malformed response does not turn into an unrelated timeout.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/hid/hid-mcp2221.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e9293b..67afef1a275f 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -861,6 +861,17 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	/*
+	 * HID invokes .raw_event() before its generic report-length check.
+	 * The response handlers below read fixed offsets from @data, so reject
+	 * a truncated current report before interpreting any of its fields.
+	 */
+	if (size < hid_report_len(report)) {
+		mcp->status = -EINVAL;
+		complete(&mcp->wait_in_report);
+		return 1;
+	}
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.43.0

