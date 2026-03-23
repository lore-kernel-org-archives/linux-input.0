Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D0BA45;
	Mon, 23 Mar 2026 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249478; cv=none; b=CdI6ng/EoE6kXgX4SvVQ0cV/qQ6eCfvYRdlGKL/GqdV/zRhnUJezacP0rzAUwkHydVXVAgc+SeotYONmbCoJcvOFnJolQbfsbcg9gbLImAQYlvw++ghXdl3WbnmQkHTtuIelMgIKAHOsEiTFrLyveN4J1+Xb/8W8ttdrWztENYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249478; c=relaxed/simple;
	bh=lNCbe3K/YBLoLgjctlAHwbgNR/WJxUeabs538wx6zzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofRc3YRcPT+E2DmGNb2pW9HW6TK7ZUB8AtNMaFf8XsenhLQ7ldtpK6raRBUmZ6QUFecpL4s5Qmaz93vGZOVAAmRF/4qZdiZHRnblyuR2sSlEfvR6SAaOOB3Z5xyGZfnOS8K8uu61v2smHPuU+pHYJCcWrxBL72Zxx0ZcfKW1lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowADX8tmv5cBpSAWGCw--.12272S2;
	Mon, 23 Mar 2026 15:03:11 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 2/7] Input: aiptek: validate macro key indices
Date: Mon, 23 Mar 2026 15:03:11 +0800
Message-ID: <20260323070311.42849-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX8tmv5cBpSAWGCw--.12272S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWrAw13uryDKry3Gr1DGFg_yoW5WryUpF
	W5Jwn0yFWkAa17Xw12g3W7Zr9xtw42gwn5ZF13Jrs0gF1YqryxWw1DX39FvF95Zw1vy3sx
	Xrn7tr4kCr9FvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

aiptek_irq() derives macro key indices directly from tablet reports and
then uses them to index macroKeyEvents[]. Report types 4 and 5 use
(data[3] >> 1), while report type 6 reads a 16-bit macro number from the
packet body. None of those indices are checked against the array bounds
before input_report_key() dereferences them.

Reject out-of-range macro indices at each use site so malformed reports
cannot read past macroKeyEvents[].

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/tablet/aiptek.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 6df24cee3c9d..ab5886a9241d 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -676,12 +676,15 @@ static void aiptek_irq(struct urb *urb)
 			}
 		}
 
-		if (aiptek->lastMacro != -1 && aiptek->lastMacro != macro) {
+		if (aiptek->lastMacro >= 0 &&
+		    aiptek->lastMacro < ARRAY_SIZE(macroKeyEvents) &&
+		    aiptek->lastMacro != macro) {
 		        input_report_key(inputdev, macroKeyEvents[aiptek->lastMacro], 0);
 			aiptek->lastMacro = -1;
 		}
 
-		if (macro != -1 && macro != aiptek->lastMacro) {
+		if (macro >= 0 && macro < ARRAY_SIZE(macroKeyEvents) &&
+		    macro != aiptek->lastMacro) {
 			input_report_key(inputdev, macroKeyEvents[macro], 1);
 			aiptek->lastMacro = macro;
 		}
@@ -715,12 +718,15 @@ static void aiptek_irq(struct urb *urb)
 			}
 		}
 
-		if (aiptek->lastMacro != -1 && aiptek->lastMacro != macro) {
+		if (aiptek->lastMacro >= 0 &&
+		    aiptek->lastMacro < ARRAY_SIZE(macroKeyEvents) &&
+		    aiptek->lastMacro != macro) {
 		        input_report_key(inputdev, macroKeyEvents[aiptek->lastMacro], 0);
 			aiptek->lastMacro = -1;
 		}
 
-		if (macro != -1 && macro != aiptek->lastMacro) {
+		if (macro >= 0 && macro < ARRAY_SIZE(macroKeyEvents) &&
+		    macro != aiptek->lastMacro) {
 			input_report_key(inputdev, macroKeyEvents[macro], 1);
 			aiptek->lastMacro = macro;
 		}
@@ -737,11 +743,11 @@ static void aiptek_irq(struct urb *urb)
 	 */
 	else if (data[0] == 6) {
 		macro = get_unaligned_le16(data + 1);
-		if (macro > 0) {
+		if (macro > 0 && macro - 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro - 1],
 					 0);
 		}
-		if (macro < 25) {
+		if (macro + 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro + 1],
 					 0);
 		}
@@ -760,7 +766,8 @@ static void aiptek_irq(struct urb *urb)
 				aiptek->curSetting.toolMode;
 		}
 
-		input_report_key(inputdev, macroKeyEvents[macro], 1);
+		if (macro < ARRAY_SIZE(macroKeyEvents))
+			input_report_key(inputdev, macroKeyEvents[macro], 1);
 		input_report_abs(inputdev, ABS_MISC,
 				 1 | AIPTEK_REPORT_TOOL_UNKNOWN);
 		input_sync(inputdev);
-- 
2.50.1 (Apple Git-155)

