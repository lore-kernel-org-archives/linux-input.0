Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85121258EF9;
	Wed, 15 Jul 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124947; cv=none; b=thRvd0od/dHhYH1Q0q5yzD+2YWvrmwOo+6QqeTEwsU+Qk0mf9+nuAsaDiTvkQkhwH7HJWmq7+92P9iWIcALyv/ppYHV9AAJUREN1UUd/THen0Vxe7i+tqLOqQBIa65q/ajlggyBd32K6Z096K82qSVBdiwH+/BG+rPYdi8qXEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124947; c=relaxed/simple;
	bh=PENOZ6FphCYgMbjpsrelueN4Zv2luKiJc8peJ0gADA0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S+42N5IC0otw3hrBChplP+6NT2EVrcMS9LSEHsYLxMLXlvRvbpzxNFfIk4WUkHdtUSyQThIx7eVNq0wNHNd9U6x1P9F9lnqeYgBjL5DmITNaH53K/64sFirvIkE/g8PpqDyRqdUzOYECERnFKlv6+WZ5BiXgLyyucZYqbow5Qno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0005-mcp2221-v2.eml (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABXYkAOlldqSUICAA--.2564S2;
	Wed, 15 Jul 2026 22:15:42 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Rishi Gupta <gupt21@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-i2c@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: mcp2221: validate raw report length
Date: Wed, 15 Jul 2026 21:57:50 +0800
Message-ID: <20260715135916.24417-5-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowABXYkAOlldqSUICAA--.2564S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4kZrWUArW5WF15Cw4fGrg_yoW5CrWxpF
	ZFg3909ryUtw1FgryDCa1DC3WYqF1IyasrGFWxGa4UW3Z8JF1YyFyFgFyvqr48WFykAr1x
	Xan5Krs8uFyqk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The MCP2221A data sheet specifies 64-byte HID command and response
reports. mcp2221_raw_event() reads fixed response fields up to byte 55
and can copy a 60-byte I2C payload from byte 4 through byte 63 without
first checking the received size.

HID invokes raw_event() before generic report validation. A short report
can therefore be interpreted beyond its received length. Reject reports
shorter than the fixed protocol size before reading any response fields.

Complete the pending command with -EINVAL for a truncated report so that
a malformed response does not turn into an unrelated timeout.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260715083754.31210-1-pengpeng@iscas.ac.cn/
- validate the fixed 64-byte protocol size instead of the
  descriptor-derived report length
- use a named report-size constant and remove matching magic lengths
---
 drivers/hid/hid-mcp2221.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e..c910f66 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -90,7 +90,8 @@ enum {
 	MCP2221_DIR_IN = 0x01,
 };
 
-#define MCP_NGPIO	4
+#define MCP2221_REPORT_SIZE	64
+#define MCP_NGPIO		4
 
 /* MCP GPIO set command layout */
 struct mcp_set_gpio {
@@ -126,7 +127,7 @@ struct mcp2221 {
 	struct completion wait_in_report;
 	struct delayed_work init_work;
 	u8 *rxbuf;
-	u8 txbuf[64];
+	u8 txbuf[MCP2221_REPORT_SIZE];
 	int rxbuf_idx;
 	int rxbuf_size;
 	int status;
@@ -639,11 +640,11 @@ static int mcp_gpio_read_sram(struct mcp2221 *mcp)
 {
 	int ret;
 
-	memset(mcp->txbuf, 0, 64);
+	memset(mcp->txbuf, 0, sizeof(mcp->txbuf));
 	mcp->txbuf[0] = MCP2221_GET_SRAM_SETTINGS;
 
 	mutex_lock(&mcp->lock);
-	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 64);
+	ret = mcp_send_data_req_status(mcp, mcp->txbuf, sizeof(mcp->txbuf));
 	mutex_unlock(&mcp->lock);
 
 	return ret;
@@ -682,7 +683,7 @@ static int mcp2221_check_gpio_pinfunc(struct mcp2221 *mcp)
 	 * Set all bytes to 0, so Bit 7 is not set. The chip
 	 * only changes content of a register when bit 7 is set.
 	 */
-	memset(mcp->txbuf, 0, 64);
+	memset(mcp->txbuf, 0, sizeof(mcp->txbuf));
 	mcp->txbuf[0] = MCP2221_SET_SRAM_SETTINGS;
 
 	/*
@@ -703,7 +704,7 @@ static int mcp2221_check_gpio_pinfunc(struct mcp2221 *mcp)
 	}
 
 	mutex_lock(&mcp->lock);
-	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 64);
+	ret = mcp_send_data_req_status(mcp, mcp->txbuf, sizeof(mcp->txbuf));
 	mutex_unlock(&mcp->lock);
 
 	return ret;
@@ -861,6 +862,12 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	if (size < MCP2221_REPORT_SIZE) {
+		mcp->status = -EINVAL;
+		complete(&mcp->wait_in_report);
+		return 1;
+	}
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.50.1 (Apple Git-155)


