Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B41F09AD;
	Tue, 14 Jul 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034995; cv=none; b=T3kHsIypk1IwUQqrvhtMOKkXoyf0tDv5XoCGjcPMkVq2uZMVdI4a2byprD4OdpLqqXfZGaxkj6Yrzkhr5rhlGpzHVcedIBU8qMVjuBWrPm1/M5Gvn2kSbpNRr8LXxv68WQiWJnjAMMJpD9f+6+M6WlLIaDNkHGtWUbMYEKXfMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034995; c=relaxed/simple;
	bh=PO2aqXVHRnJwpcf6ZUi1sPXCitHKZGPiqVHwOpqzWDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trN/fb3thJZ2MxEd2KsHR6mm8LT35cqdFeTKtQB+d91O9AFd6M9Ox6yqtMSawVkIG3YwEXloCR9HbsdHPubJdPrvCpY8I1uqUORJijvFDcrITX+RPx5l7LTjEdMPxp+snXNKAuGQ33vCPIBMm2lPMDDEG1oSxBBOqNSxygBh178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TPafXyfk; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TPafXyfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oF
	rm7cAm5xgvpg1dCCfceT3xmdX/Suz6ym/HjL2f368=; b=TPafXyfkjhKUnUJMnq
	y/EmQlGgfQdOkanupQKyoleEEEcYHTcc37JRWmu1kUzl+UAsiZ+mz10RnhgtuLfA
	R/lYiyDX5Ghg4IQBZHfG7J0pcFu5cthcUCqbKtp6VhX1LRkNipTq3tL63+2Raovk
	ypwnMKfmIYb8octhgw9PeF59Y=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHhdSdNlZqMIoQJg--.20750S4;
	Tue, 14 Jul 2026 21:16:17 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 3/4] HID: mcp2221: fix out-of-bounds read in mcp2221_raw_event
Date: Tue, 14 Jul 2026 21:16:10 +0800
Message-Id: <20260714131611.269929-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714131611.269929-1-yaojiale02@163.com>
References: <20260714131611.269929-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHhdSdNlZqMIoQJg--.20750S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr13Zw45tF4rKr1xGFWfZrb_yoW5ZFW5pr
	Z8tFs0krWUJF13KF9xCr1DAr15Xrn2yFsrXFW2qa4UX3W8KFZ8JryvgFyFqr1fKFyDZr1S
	gFs5GrW8Ga4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRF4E_UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8ALlIGpWNqL2qwAA3C

The handler dispatches on data[0] without checking size >= 1.
Add a top-level guard and per-case minimum-size checks:
data[2] for the I2C_WR_DATA group, data[20] and
data[50+sizeof(adc_values)] for I2C_PARAM_OR_STATUS,
sizeof(struct mcp_get/set_gpio) for GPIO paths,
and 4+data[3] for the I2C_GET_DATA partial-read memcpy.

Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-mcp2221.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e9293b..0423b5affe8f 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -861,12 +861,17 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	if (size < 1)
+		return 1;
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
 	case MCP2221_I2C_WR_NO_STOP:
 	case MCP2221_I2C_RD_DATA:
 	case MCP2221_I2C_RD_RPT_START:
+		if (size < 3)
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			mcp->status = 0;
@@ -878,6 +883,12 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_I2C_PARAM_OR_STATUS:
+		if (size < 21)
+			return 1;
+#if IS_REACHABLE(CONFIG_IIO)
+		if (size < 50 + sizeof(mcp->adc_values))
+			return 1;
+#endif
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			if ((mcp->txbuf[3] == MCP2221_I2C_SET_SPEED) &&
@@ -901,6 +912,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_I2C_GET_DATA:
+		if (size < 4)
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			if (data[2] == MCP2221_I2C_ADDR_NACK) {
@@ -918,7 +931,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 			}
 			if (data[2] == MCP2221_I2C_READ_COMPL ||
 			    data[2] == MCP2221_I2C_READ_PARTIAL) {
-				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
+				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 ||
+				    data[3] > 60 || size < 4 + data[3]) {
 					mcp->status = -EINVAL;
 					break;
 				}
@@ -941,6 +955,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_GPIO_GET:
+		if (size < sizeof(struct mcp_get_gpio))
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			if ((data[mcp->gp_idx] == MCP2221_ALT_F_NOT_GPIOV) ||
@@ -958,6 +974,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_GPIO_SET:
+		if (size < sizeof(struct mcp_set_gpio))
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			if ((data[mcp->gp_idx] == MCP2221_ALT_F_NOT_GPIOV) ||
@@ -974,6 +992,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_SET_SRAM_SETTINGS:
+		if (size < 2)
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			mcp->status = 0;
@@ -985,6 +1005,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_GET_SRAM_SETTINGS:
+		if (size < 26)
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			memcpy(&mcp->mode, &data[22], 4);
@@ -1000,6 +1022,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		break;
 
 	case MCP2221_READ_FLASH_DATA:
+		if (size < 8)
+			return 1;
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			mcp->status = 0;
-- 
2.34.1

